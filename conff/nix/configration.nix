# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../impermanence/nixos.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/vda1"; # or "nodev" for efi only


  boot.supportedFilesystems = [ "zfs" ];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;



  networking.hostId = "6b29221b";
  networking = {
          networkmanager.enable = false;
          useDHCP = false;

          interfaces.ens3 = {
                  useDHCP = false;

                  ipv4.addresses = [{
                          address = "5.255.125.211";
                          prefixLength = 24;
                  }];

                  ipv6.addresses = [{
                          address = "fe80::216:3eff:fe62:c04a";
                          prefixLength = 64;
                  }];
          };

          defaultGateway = "5.255.125.1";
  };

boot = {

kernelParams = [ "ip=5.255.125.211::5.255.125.1:255.255.255.0:ens3:none"];

initrd = {
  kernelModules = [ "virtio_pci"];
  availableKernelModules = [ "virtio_pci"];

  network = {
    enable = true;
    ssh = {
      enable = true;
      port = 2222;
      hostKeys = [ /initrd/keys/ed ];
      authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKgtiyDGe+vYeazvXepFiKgOqL1KbDdHAmffPe9Lu+uZ radbellatrix@gmail.com" ];
     };

    postCommands = ''
    cat <<EOF > /root/.profile
    if pgrep -x "zfs" > /dev/null
    then
      zfs load-key -a
      killall zfs
    else
      echo "zfs not running -- maybe the pool is taking some time to load for some unforseen reason."
    fi
    EOF
    '';
};

};

};

environment.persistence."/persist" = {
  hideMounts = true;
  files = [
    "/etc/machine-id"
  ];

  directories = [
    "/var/log"
  ];
};



  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;




  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
users.users.root.initialPassword = "xer";
users.mutableUsers = false;


# enabling memory swap in the ZRAM not in the disk
zramSwap.enable = true;

  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     thunderbird
  #   ];
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };



  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
services.openssh = {
        enable = true;
        openFirewall = true;
        passwordAuthentication = true;
        kbdInteractiveAuthentication = true;
};


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
