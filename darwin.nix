{pkgs, ...}: {
  ids.gids.nixbld = 350;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix = {
    settings.experimental-features = "nix-command flakes impure-derivations ca-derivations";
    gc.automatic = true;
    configureBuildUsers = true;
  };
  users.users.jcarter = {
    home = "/Users/jcarter";
    shell = pkgs.zsh;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.trackpad.Clicking = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.screensaver.askForPassword = true;
  system.defaults.screensaver.askForPasswordDelay = 0;
  system.defaults.dock.wvous-tl-corner = 13;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.etc = {
    "sudoers.d/10-nix-commands".text = let
      commands = [
        "/run/current-system/sw/bin/darwin-rebuild"
        "/run/current-system/sw/bin/nix*"
        "/nix/var/nix/profiles/default/bin/nix*"
        "/run/current-system/sw/bin/ln"
        "/nix/store/*/activate"
        "/bin/launchctl"
      ];
      commandsString = builtins.concatStringsSep ", " commands;
    in ''
      %admin ALL=(ALL:ALL) NOPASSWD: ${commandsString}
    '';
  };
}
