# My unix home rc's files

## Automated configuration for "vanilla" linux installations:
## Usage

```bash
# The only requirement
sudo apt install git

# Clone this repo
git clone https://github.com/shaggyz/home-scripts.git

# Move to bin directory
cd home-scripts/bin

# Run the installation script (always inside bin/)
./home-scripts
```

## Installation script

This script will ask you from some installation options. Note when bash asks for yes/no it doesn't wait for an intro keytroke as other scripts.

All this actions will be prompted to user:

- Install basic linux (install -y vim curl git build-essential htop lsb-release colordiff)
- Configures X11 (xterm, xsession)
- Install linux headers
- Configures vim (editor settings plus molokai theme)
- Configures bash (env vars, PS1, common paths, etc)



