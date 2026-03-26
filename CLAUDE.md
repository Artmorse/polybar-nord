# Polybar Nord Configuration - Claude Guidelines

## Repository Overview

This repository contains a polybar configuration using the Nord color scheme, designed for multi-monitor setups with the i3 window manager. It features dual bars (top and bottom) with various system monitoring modules and custom scripts.

## File Structure

### Core Configuration Files
- **bars-config** - Main bar configuration that includes all other files
- **config** - Global settings (DPI, dimensions, module layout, interface names)
- **colors** - Nord color scheme definitions
- **top-bar** - Top bar module definitions
- **bottom-bar** - Bottom bar module definitions
- **launch.sh** - Multi-monitor launcher script

### Scripts Directory
All scripts in `scripts/` should be executable and follow bash conventions:
- **get_weather.sh** - OpenWeatherMap integration (requires API key)
- **battery-notifier.sh** - Low battery notifications
- **count-pacman-and-yay-updates.sh** - System update counter
- **upgrade-pacman-and-yay-packages.sh** - Package upgrade trigger

## Configuration Patterns

### Module Configuration
1. Modules are defined in `top-bar` or `bottom-bar` files
2. Module options are configured in the `config` file under `[config]` section
3. Each module follows polybar's INI-style format with `[module/name]` sections
4. Module layout is defined by `top-left`, `top-center`, `top-right`, `bottom-left`, `bottom-center`, `bottom-right` in the config

### Color Usage
Colors are defined in the `colors` file following Nord theme:
- Use `${colors.background}`, `${colors.foreground}`, etc.
- Nord colors: nord0-15 available as variables
- Maintain consistency with the Nord theme palette

### Variable Substitution
Configuration uses polybar's variable substitution:
- `${config.option}` - References config file settings
- `${colors.name}` - References color definitions
- `${env:VARIABLE:default}` - Environment variables with defaults

## Making Changes

### Adding a New Module
1. Define the module in `top-bar` or `bottom-bar` file
2. Add module name to the appropriate layout line in `config` (e.g., `top-right = ... newmodule`)
3. If module needs configuration, add options under `[config]` section
4. Test with `polybar -c bars-config <bar-name>` before committing

### Modifying Monitor Setup
- The `launch.sh` script accepts monitor names as arguments (from `xrandr`)
- Primary monitor gets both bars (`nord-top` and `nord-down`)
- Secondary monitors get only top bar (`little-nord-top`)
- To change monitor detection, modify the `launch.sh` script

### Adding Custom Scripts
1. Create executable script in `scripts/` directory
2. Use `#!/bin/bash` or `#!/bin/sh` shebang consistently
3. Handle errors gracefully (scripts are called repeatedly by polybar)
4. Suppress unnecessary output - polybar modules capture stdout
5. Consider adding error suppression (2>/dev/null) for expected failures
6. Document any required environment variables or API keys

## System-Specific Configuration

### Required Adjustments
Users typically need to configure these in the `config` file:
- **wifi-interface** - Check with `ip link show`
- **eth-interface** - Check with `ip link show`
- **battery-bat** - Check with `ls /sys/class/power_supply/`
- **battery-adp** - Check with `ls /sys/class/power_supply/`
- **thermal-zone** - Check with `ls /sys/class/thermal/thermal_zone*/type`
- **dpi** - Adjust for HiDPI displays

### External Dependencies
- Weather module requires `OPENWEATHER_API_KEY` set in `get_weather.sh`
- Update modules require `yay` AUR helper (Arch Linux)
- Docker module requires docker-polybar-script
- Various modules need specific system tools (acpi, sensors, etc.)

## Code Conventions

### Shell Scripts
- Use bash for complex scripts, sh for simple ones
- Suppress stderr for expected failures: `2>/dev/null`
- Use meaningful variable names in UPPERCASE for constants
- Include comments for non-obvious logic
- Ensure scripts are executable: `chmod +x scripts/*.sh`

### Polybar Configuration
- Use semicolons (;) for comments
- Maintain consistent indentation (no tabs in INI files)
- Group related settings together
- Document any non-standard settings with comments

## Testing Changes

### Local Testing
```bash
# Kill existing instances
killall -q polybar

# Test specific bar
polybar -c bars-config nord-top

# Test with your monitor setup
./launch.sh $(xrandr --query | grep " connected" | cut -d" " -f1)
```

### Validation Checklist
- [ ] Polybar starts without errors
- [ ] All modules display correctly
- [ ] Colors match Nord theme
- [ ] Multi-monitor setup works as expected
- [ ] Custom scripts execute without errors
- [ ] System tray appears in correct location

## Common Tasks

### Changing Module Order
Edit the layout lines in `config`:
```ini
top-right = module1 module2 module3
```

### Adjusting Bar Height/Position
Modify values in `config` under `[config]`:
- `width`, `height`, `offset-x`, `offset-y`, `radius`

### Disabling a Module
Remove module name from the layout line, but keep the module definition for easy re-enabling.

### Changing Fonts
Modify font-N lines in `bars-config` under `[bar/base]`:
```ini
font-0 = FontName:size=5
```

## Important Notes

- **Launch script**: Always pass monitor names as arguments to `launch.sh`
- **Git commits**: Use conventional commit messages with emoji (see git log for examples)
- **File permissions**: Launch script and all scripts must be executable
- **Error suppression**: The launch script suppresses stderr (2>/dev/null) to avoid console spam
- **Module reload**: Use polybar IPC (`polybar-msg cmd restart`) to reload after config changes
- **Theme consistency**: Maintain Nord color scheme - don't introduce random colors

## Troubleshooting

### Bars Don't Appear
- Check `xrandr` output for correct monitor names
- Verify polybar is installed (>= 3.6.0)
- Check for error messages without stderr suppression
- Ensure config file paths are correct

### Module Not Working
- Check if required system tool is installed
- Verify interface/device names in config match your system
- Test module script directly: `bash scripts/script-name.sh`
- Check polybar logs: `journalctl -f | grep polybar`

### Performance Issues
- Reduce module update intervals
- Disable unused modules
- Check if custom scripts are hanging or slow

## Resources

- [Polybar Wiki](https://github.com/polybar/polybar/wiki)
- [Nord Color Scheme](https://www.nordtheme.com/)
- [Original Inspiration](https://github.com/Yucklys/polybar-nord-theme)
- Module documentation linked in README.md
