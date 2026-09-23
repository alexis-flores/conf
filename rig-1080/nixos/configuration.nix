# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./dms-package.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Default (LTS) kernel: the GTX 1080 is pinned to the nvidia 580 LTSB branch,
  # which may lag behind linuxPackages_latest.
  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "rig-1080"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."alex" = {
    isNormalUser = true;
    description = "alex";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  security.rtkit.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
     ghostty
     neovim
     tree-sitter
     git
     rofi
     nautilus
     vivaldi
     vivaldi-ffmpeg-codecs
     hyprpolkitagent
     grim
     slurp
     wl-clipboard
     playerctl
     ripgrep
     fzf
     bat
     glow
     fd
     btop
     zip
     unzip
     wget
     man-pages
     claude-code
     gcc
     gnumake
     clang-tools
     rust-analyzer
     pyright
     lua-language-server
     neocmakelsp
     stylua
     black
     isort
     ruff
     mypy
     vscode-extensions.vadimcn.vscode-lldb.adapter
     rustfmt
     glib
     papirus-icon-theme
     adwaita-icon-theme
     bibata-cursors
     tor-browser
     moonlight-qt
     ares
     dolphin-emu
     pcsx2
     ppsspp-sdl
     melonds
     mgba
  ];
  environment.variables.EDITOR = "nvim";
  environment.variables.BAT_THEME = "ansi";

  programs.nix-ld.enable = true;

  programs.bash.shellAliases = {
  	".." = "cd ..";
	"..." = "cd ../..";
	"cat" = "bat";
  };

  programs.bash.interactiveShellInit = ''
  	open() { (nautilus "''${1:-.}" >/dev/null 2>&1 &) }
  '';

  programs.hyprland = {
  	enable = true;
	withUWSM = true;
  };

  programs.dms-shell.enable = true;

  programs.starship.enable = true;

  programs.steam = {
  	enable = true;
	remotePlay.openFirewall = true;
  };

  services.pipewire = {
  	enable = true;
	pulse.enable = true;
  };
  services.upower.enable = true;
  services.gvfs.enable = true;

  hardware.bluetooth.enable = true;

  services.greetd = {
  	enable = true;
	settings = {
		default_session = {
			command = "${pkgs.tuigreet}/bin/tuigreet --time --greeting '*·*·*·*·*·*·*·*·*·*·*·*·*·*·*· rig-1080 ·*·*·*·*·*·*·*·*·*·*·*·*·*·*·*' --theme 'container=black;text=white;border=blue;title=blue;greet=yellow;prompt=red;input=white;action=cyan;button=yellow;time=white' --cmd ${pkgs.writeShellScript "hyprland-quiet" ''
  exec uwsm start -e -D Hyprland hyprland.desktop >/dev/null 2>&1
			''}";
			user = "alex";
		};
	};
  };
  services.fwupd.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
  	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 14d";
  };

  hardware.graphics.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  # GTX 1080 (Pascal): needs the proprietary module (no GSP firmware, so the
  # open module is unsupported) and the 580 LTSB branch — 26.05's default 595
  # driver dropped Pascal. 580 is maintained until Aug 2028.
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
  	modesetting.enable = true;
	open = false;
	package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
	nvidiaSettings = true;
  };

  xdg.portal = {
  	enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  boot.blacklistedKernelModules = [
  	"sp5100_tco"
  ];
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 3;
  boot.plymouth.enable = true;
  boot.kernelParams = [
  	"quiet"
	"splash"
	"boot.shell_on_fail"
  	"udev.log_level=3"
  	"rd.udev.log_level=3"
  	"systemd.show_status=auto"
  	"nmi_watchdog=0"
	"fbcon=nodefer"
	"vt.global_cursor_default=0"
  ];

  systemd.services.quiet-shutdown = {
  	description = "Reduce PID 1 log level to crit during shutdown";
  	wantedBy = [ "multi-user.target" ];
  	serviceConfig = {
    		Type = "oneshot";
    		RemainAfterExit = true;
    		ExecStart = "${pkgs.coreutils}/bin/true";
    		ExecStop = "${pkgs.systemd}/bin/systemd-analyze log-level crit";
    	};
  };

  console.colors = [
    "cdb27b"
    "a94a38"
    "66702f"
    "8a6a14"
    "7a5230"
    "8c5a79"
    "4a7660"
    "332812"
    "8f7c52"
    "c25a42"
    "7d8a3a"
    "a5811c"
    "96683f"
    "a06b8d"
    "5c8a72"
    "20180c"
  ];

  # List services that you want to enable:
  services.flatpak.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
