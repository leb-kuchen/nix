# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

  { config, pkgs, ... }:

  { imports =
      [ # Include the results of the hardware scan.
        ./hardware-configuration.nix 
      ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.allowed-users = ["lebkuchen"];
    # Bootloader.

    boot.loader.systemd-boot.enable = true; boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary networking.proxy.default = "http://user:password@proxy:port/"; networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "de_DE.UTF-8";

    i18n.extraLocaleSettings = { LC_ADDRESS = "de_DE.UTF-8"; LC_IDENTIFICATION = "de_DE.UTF-8"; LC_MEASUREMENT = "de_DE.UTF-8"; LC_MONETARY = "de_DE.UTF-8"; LC_NAME = "de_DE.UTF-8"; LC_NUMERIC = "de_DE.UTF-8"; LC_PAPER = 
      "de_DE.UTF-8"; LC_TELEPHONE = "de_DE.UTF-8"; LC_TIME = "de_DE.UTF-8";
    };

programs.hyprland = {
  enable = true;
  nvidiaPatches = true;
  xwayland.enable = true;
};


hardware = {
    opengl.enable = true;

 #Most wayland compositors need this
    nvidia.modesetting.enable = true;
};
environment.sessionVariables = {
 # If your cursor becomes invisible
  WLR_NO_HARDWARE_CURSORS = "1";
 # Hint electron apps to use wayland
  NIXOS_OZONE_WL = "1";
};
#waybar
(pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  })
)
#XDG portal
xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];


    # Configure keymap in X11
    services.xserver = {
       # Enable the X11 windowing system.
      enable = true;

      layout = "us, de"; xkbVariant = "";

      libinput.enable = true;
 
      
      desktopManager = { cinnamon.enable = true;
      #plasma5.enable = true; gnome.enable = true;
		};
    displayManager = { lightdm.enable = true; defaultSession = "cinnamon";
      #gdm.enable = true; sddm.enable = true;
    };
    };

    # Configure console keymap
    console.keyMap = "us";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    sound.enable = true; hardware.pulseaudio.enable = false; security.rtkit.enable = true; services.pipewire = {
      enable = true; alsa.enable = true; alsa.support32Bit = true; pulse.enable = true;
      # If you want to use JACK applications, uncomment this jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default, no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager). services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.lebkuchen = { isNormalUser = true; description = "Dominic"; extraGroups = [ "networkmanager" "wheel" ]; packages = with pkgs; [
        firefox kate
      #  thunderbird
      ];
	
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		neovim
    vim
		powershell
		go 
		git
		vscode
    gnumake
    fd
    ripgrep
    gotools
    gh
    alacritty
    wget
    zellij
    chromium
    libreoffice
    psmisc
    minikube
    gcc
  procps
  dart-sass
  nodejs
   nodePackages.postcss
   nodePackages.postcss-cli
   
   rustup
   ocaml
   opam

  dune_3
  tree
  evcxr
  nushell
  kitty
  waybar
  dunst
  libnotify
  swww
  rofi-wayland
	];



    # List packages installed in system profile. To search, run: $ nix search wget
  users.defaultUserShell = pkgs.powershell; environment.shells = with pkgs; [ powershell ]; virtualisation.docker.enable = true;

  
  # Some programs need SUID wrappers, can be configured further or are started in user sessions. programs.mtr.enable = true; programs.gnupg.agent = {
  #   enable = true; enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon. services.openssh.enable = true;

  # Open ports in the firewall. networking.firewall.allowedTCPPorts = [ ... ]; networking.firewall.allowedUDPPorts = [ ... ]; Or disable the firewall altogether. networking.firewall.enable = false;

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken. It‘s perfectly fine and recommended to leave this value at the 
  # release version of the first install of this system. Before changing this value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

