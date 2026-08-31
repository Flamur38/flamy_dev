#!/usr/bin/env bash
# ==========================================================
# thermal.sh — MS01 system thermal status
# Shows: CPU, GPU, NVMe, fans
# Usage: ./thermal.sh        → pretty terminal output
#        ./thermal.sh notify → dunst notification summary
# ==========================================================

# --- Colors ---
red='\e[38;2;236;95;102m'
yellow='\e[38;2;249;174;88m'
green='\e[38;2;153;199;148m'
blue='\e[38;2;149;178;214m'
muted='\e[38;2;70;82;92m'
bold='\e[1m'
reset='\e[0m'

# --- Thresholds (°C) ---
WARN=75
CRIT=85

color_temp() {
    local val="${1%°C}"
    val="${val%.*}"
    if   [ "$val" -ge "$CRIT" ] 2>/dev/null; then printf "%b" "$red"
    elif [ "$val" -ge "$WARN" ] 2>/dev/null; then printf "%b" "$yellow"
    else printf "%b" "$green"
    fi
}

# --- Gather data ---
CPU_PKG="$(sensors 2>/dev/null | grep 'Package id 0' | awk '{print $4}')"
CPU_TIN="$(sensors 2>/dev/null | grep 'CPUTIN' | awk '{print $2}')"
FAN1="$(sensors 2>/dev/null | grep '^fan1' | awk '{print $2, $3}')"
FAN2="$(sensors 2>/dev/null | grep '^fan2' | awk '{print $2, $3}')"
NVME1="$(sensors 2>/dev/null | grep -A2 'nvme-pci-0200' | grep 'Composite' | awk '{print $2}')"
NVME2="$(sensors 2>/dev/null | grep -A2 'nvme-pci-5900' | grep 'Composite' | awk '{print $2}')"

GPU_TEMP="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)°C"
GPU_FAN="$(nvidia-smi --query-gpu=fan.speed --format=csv,noheader 2>/dev/null)"
GPU_PWR="$(nvidia-smi --query-gpu=power.draw --format=csv,noheader 2>/dev/null)"
GPU_MEM="$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader 2>/dev/null | tr ',' '/')"
GPU_UTIL="$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader 2>/dev/null)"

# --- Notify mode (for i3 dunst binding) ---
if [ "$1" = "notify" ]; then
    notify-send -t 8000 -h string:x-dunst-stack-tag:thermal \
        "Thermal status" \
"CPU pkg: $CPU_PKG
Fan1: $FAN1 | Fan2: $FAN2
GPU: $GPU_TEMP | Fan: $GPU_FAN
GPU power: $GPU_PWR | Util: $GPU_UTIL
GPU mem: $GPU_MEM
NVMe0: $NVME1 | NVMe1: $NVME2"
    exit 0
fi

# --- Terminal mode ---
echo
printf "%b===========================================================%b\n" "$muted" "$reset"
printf "%b  MS01 Thermal Status%b\n" "$bold" "$reset"
printf "%b===========================================================%b\n" "$muted" "$reset"

printf "\n%b  CPU%b\n" "$blue" "$reset"
printf "%b  ├─%b Package    $(color_temp $CPU_PKG)%s%b\n" "$muted" "$reset" "$CPU_PKG" "$reset"
printf "%b  └─%b CPUTIN     $(color_temp $CPU_TIN)%s%b\n" "$muted" "$reset" "$CPU_TIN" "$reset"

printf "\n%b  FANS%b\n" "$blue" "$reset"
printf "%b  ├─%b Fan 1      %b%s%b\n" "$muted" "$reset" "$green" "$FAN1" "$reset"
printf "%b  └─%b Fan 2      %b%s%b\n" "$muted" "$reset" "$green" "$FAN2" "$reset"

printf "\n%b  GPU — RTX A2000 12GB%b\n" "$blue" "$reset"
printf "%b  ├─%b Temp       $(color_temp $GPU_TEMP)%s%b\n" "$muted" "$reset" "$GPU_TEMP" "$reset"
printf "%b  ├─%b Fan        %b%s%b\n" "$muted" "$reset" "$green" "$GPU_FAN" "$reset"
printf "%b  ├─%b Power      %b%s%b\n" "$muted" "$reset" "$yellow" "$GPU_PWR" "$reset"
printf "%b  ├─%b GPU util   %b%s%b\n" "$muted" "$reset" "$green" "$GPU_UTIL" "$reset"
printf "%b  └─%b VRAM       %b%s%b\n" "$muted" "$reset" "$blue" "$GPU_MEM" "$reset"

printf "\n%b  NVMe%b\n" "$blue" "$reset"
printf "%b  ├─%b NVMe 0     $(color_temp $NVME1)%s%b\n" "$muted" "$reset" "$NVME1" "$reset"
printf "%b  └─%b NVMe 1     $(color_temp $NVME2)%s%b\n" "$muted" "$reset" "$NVME2" "$reset"

printf "\n%b===========================================================%b\n\n" "$muted" "$reset"

# --- Warnings ---
GPU_VAL="${GPU_TEMP%°C}"
if [ "$GPU_VAL" -ge "$CRIT" ] 2>/dev/null; then
    printf "%b  ⚠  GPU critical: %s — check airflow!%b\n\n" "$red" "$GPU_TEMP" "$reset"
elif [ "$GPU_VAL" -ge "$WARN" ] 2>/dev/null; then
    printf "%b  ⚠  GPU warm: %s — monitor under load%b\n\n" "$yellow" "$GPU_TEMP" "$reset"
fi
