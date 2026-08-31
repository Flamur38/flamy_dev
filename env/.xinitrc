xrdb -merge ~/.Xresources
xrandr \
  --output DP-3 --primary --mode 3840x2560 --rotate normal --pos 0x0 \
  --output HDMI-1 --mode 1920x1080 --rotate left --scale 2x2 --pos 3840x0
picom &
