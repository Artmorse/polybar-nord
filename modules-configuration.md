# Modules configuration

## [module/battery]

Update the [`battery-bat`, `battery-adp` values](config) with yours.

```bash
upower --enumerate
upower -i /org/freedesktop/UPower/devices/line_power_AC
```

## [module/network]

Update the [`interface` value](config) with yours.

```bash
ip link show
```

```bash
ip a
```

## [module/temperature]

Update the [`thermal-zone` value](config) with yours.

```bash
for i in /sys/class/thermal/thermal_zone*; do echo "$i: $(<$i/type)"; done
```

```bash
sensors
```