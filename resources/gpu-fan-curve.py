#!/usr/bin/env python3
"""
GPU Fan Curve Daemon for NVIDIA GPUs
Automatically adjusts fan speed based on GPU temperature.
Edit the FAN_CURVE below to customize your curve.
"""

import sys
import time
import logging
import signal

sys.path.insert(0, '/home/flamy/.local/lib/python3.12/site-packages')
import pynvml

# ─────────────────────────────────────────────
#  FAN CURVE — edit these to your liking
#  Format: (temperature_celsius, fan_speed_percent)
#  Must be sorted by temperature ascending.
# ─────────────────────────────────────────────
FAN_CURVE = [
    (0,   30),   # below 40°C  → 30%
    (40,  35),   # 40°C        → 35%
    (50,  45),   # 50°C        → 45%
    (60,  60),   # 60°C        → 60%
    (70,  75),   # 70°C        → 75%
    (80,  90),   # 80°C        → 90%
    (90, 100),   # 90°C+       → 100%
]

# ─────────────────────────────────────────────
#  Settings
# ─────────────────────────────────────────────
GPU_INDEX     = 0       # GPU index (0 = first GPU)
FAN_INDEX     = 0       # Fan index (0 = first fan)
POLL_INTERVAL = 3       # Seconds between temperature checks
HYSTERESIS    = 2       # °C — prevents fan speed flickering

# ─────────────────────────────────────────────
#  Logging
# ─────────────────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler('/var/log/gpu-fan-curve.log'),
    ]
)
log = logging.getLogger(__name__)


def interpolate_fan_speed(temp: int) -> int:
    """Linearly interpolate fan speed from the curve for a given temperature."""
    if temp <= FAN_CURVE[0][0]:
        return FAN_CURVE[0][1]
    if temp >= FAN_CURVE[-1][0]:
        return FAN_CURVE[-1][1]
    for i in range(len(FAN_CURVE) - 1):
        t0, s0 = FAN_CURVE[i]
        t1, s1 = FAN_CURVE[i + 1]
        if t0 <= temp <= t1:
            ratio = (temp - t0) / (t1 - t0)
            return round(s0 + ratio * (s1 - s0))
    return FAN_CURVE[-1][1]


def main():
    pynvml.nvmlInit()
    handle = pynvml.nvmlDeviceGetHandleByIndex(GPU_INDEX)
    gpu_name = pynvml.nvmlDeviceGetName(handle)
    log.info(f"GPU fan curve daemon started for: {gpu_name}")
    log.info(f"Fan curve: {FAN_CURVE}")

    # Enable manual fan control
    pynvml.nvmlDeviceSetFanControlPolicy(handle, FAN_INDEX, pynvml.NVML_FAN_POLICY_MANUAL)
    log.info("Manual fan control enabled.")

    current_speed = -1

    def shutdown(signum, frame):
        log.info("Shutting down — restoring automatic fan control.")
        try:
            pynvml.nvmlDeviceSetFanControlPolicy(handle, FAN_INDEX, pynvml.NVML_FAN_POLICY_TEMPERATURE_CONTINOUS_SW)
        except Exception:
            pass
        pynvml.nvmlShutdown()
        sys.exit(0)

    signal.signal(signal.SIGTERM, shutdown)
    signal.signal(signal.SIGINT, shutdown)

    while True:
        try:
            temp = pynvml.nvmlDeviceGetTemperature(handle, pynvml.NVML_TEMPERATURE_GPU)
            target = interpolate_fan_speed(temp)

            # Only update if speed changed by more than hysteresis
            if abs(target - current_speed) >= HYSTERESIS or current_speed == -1:
                pynvml.nvmlDeviceSetFanSpeed_v2(handle, FAN_INDEX, target)
                log.info(f"Temp: {temp}°C → Fan: {target}%")
                current_speed = target

        except pynvml.NVMLError as e:
            log.error(f"NVML error: {e}")

        time.sleep(POLL_INTERVAL)


if __name__ == '__main__':
    main()
