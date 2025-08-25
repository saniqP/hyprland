{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Включить драйверы NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];

  # Конфигурация NVIDIA для RTX 4060 Ti
  hardware.nvidia = {
    # Для RTX 4060 Ti используем открытые драйверы
    open = true;
    
    # Использовать стабильные драйверы
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    # Включить modesetting
    modesetting.enable = true;
  };

  # Разрешить несвободные пакеты (обязательно для NVIDIA)
  nixpkgs.config.allowUnfree = true;

  # Использовать последнее ядро для лучшей совместимости
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Сетевое
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Время и язык
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";

  # X11 и GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Звук
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Печать
  services.printing.enable = true;

  # Пользователь
  users.users.myva = {
    isNormalUser = true;
    description = "myva";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Автологин
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "myva";

  # Браузер
  programs.firefox.enable = true;

  system.stateVersion = "25.05";
}
