{pkgs}: {
  enable = true;
  keyMode = "vi";
  clock24 = true;
  historyLimit = 5000;
  terminal = "screen-256color";
  shell = "${pkgs.zsh}/bin/zsh";
  extraConfig = ''
    set -g default-command "${pkgs.zsh}/bin/zsh"
  '';
}
