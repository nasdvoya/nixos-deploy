{
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  programs.nix-ld.enable = true;
  services.openssh.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
    pkgs.cowsay
    pkgs.tailscale
    pkgs.cowsay
    pkgs.neovim
    pkgs.git
  ];

  users.users.root.initialPassword = "coreflux";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjD/KFYzdDNjuUrtUvhY9Adbr7aJRXrVEaJGurnBFyL37W/k6fbEDOsJzmZHpdRxz4lhGSoBEy1zap0+L5q8DmFJ4+ZbYhZ31HKq8Rp/gaYpkuzNNfCMmd1aXcv2Hf7WRFAl9AJ88nm5kQ/xeR/vcHUcRgdBmsCOVOyWIZkSTcYY/X0pjuOKkm2on3Wl88Oi0FQMRtRh1iuDlHH35sZc2ASkdmdG8R2Chgcrl5BzahH5Ui/+bJup8pTbD6d2u+j2uF22hzj13ijkjA8GLBApbn2s00JyGbKUh307NGaxMZyiN3yyvhc00MamULitcmBRfEO0CeP7uNYNOtlOXxNK4+x6PJKQw9jx36n/+V2vTo7njjZr0CGDU17kKGPh2KWSFlhuQCjQk87ChR4haNkXA5m98T6EsHdP6okQ/bCnZEQ/GfGik31Hf8GP6BoNBVVIQ8hWtUfFb5Pz7tUM8nH3FiRtUpHbwEtba2VApL6Q9V6Gjkb1GTWNOworvTI0c1rkZbaDSdJU1E7AAPxVPEIMNOPxNKzsKktIDvaXGGPiINXLf9EjcjLlB2nLwjr75PhDid5iXqCXSILD1f2W/fBVAvummEsxuLTwOD6iD9C26/15xdck3oav54XbYja69XkXCw4O0sA4f7Amxr2Qj29lfBAiZ4bWaAVI51iL/rQ1ERLQ== alexandr.baranovschi@coreflux.org"
  ];
  users.users.coreflux = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "coreflux";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjD/KFYzdDNjuUrtUvhY9Adbr7aJRXrVEaJGurnBFyL37W/k6fbEDOsJzmZHpdRxz4lhGSoBEy1zap0+L5q8DmFJ4+ZbYhZ31HKq8Rp/gaYpkuzNNfCMmd1aXcv2Hf7WRFAl9AJ88nm5kQ/xeR/vcHUcRgdBmsCOVOyWIZkSTcYY/X0pjuOKkm2on3Wl88Oi0FQMRtRh1iuDlHH35sZc2ASkdmdG8R2Chgcrl5BzahH5Ui/+bJup8pTbD6d2u+j2uF22hzj13ijkjA8GLBApbn2s00JyGbKUh307NGaxMZyiN3yyvhc00MamULitcmBRfEO0CeP7uNYNOtlOXxNK4+x6PJKQw9jx36n/+V2vTo7njjZr0CGDU17kKGPh2KWSFlhuQCjQk87ChR4haNkXA5m98T6EsHdP6okQ/bCnZEQ/GfGik31Hf8GP6BoNBVVIQ8hWtUfFb5Pz7tUM8nH3FiRtUpHbwEtba2VApL6Q9V6Gjkb1GTWNOworvTI0c1rkZbaDSdJU1E7AAPxVPEIMNOPxNKzsKktIDvaXGGPiINXLf9EjcjLlB2nLwjr75PhDid5iXqCXSILD1f2W/fBVAvummEsxuLTwOD6iD9C26/15xdck3oav54XbYja69XkXCw4O0sA4f7Amxr2Qj29lfBAiZ4bWaAVI51iL/rQ1ERLQ== alexandr.baranovschi@coreflux.org"
    ];
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "pt";
    xkb.variant = "nodeadkeys";
  };
  console.keyMap = "pt-latin1";
  # Select internationalisation properties.
  time.timeZone = "Europe/Lisbon";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  networking.hostName = "nixos"; # Define your hostname.

  system.stateVersion = "24.05";
}
