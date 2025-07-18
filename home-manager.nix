{
  config,
  pkgs,
  ...
}: {
  home-manager = {
    useUserPackages = false;
    useGlobalPkgs = true;
    users.jcarter = {
      programs.home-manager.enable = true;
      home.username = "jcarter";
      home.homeDirectory = "/Users/jcarter";
      home.packages = [
        pkgs.silver-searcher
        pkgs.karabiner-elements
        pkgs.alejandra
        pkgs.tree

        (pkgs.claude-code.overrideAttrs (oldAttrs: rec {
          version = "1.0.51";
          src = pkgs.fetchzip {
            url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
            hash = "sha256-sAILRsi8ZViMfcpqykfnFQzHTJHRwRSZz45otMqa4U0=";
          };
          npmDepsHash = "";
        }))

        pkgs.ffmpeg
        pkgs.yt-dlp

        pkgs.jq
        pkgs.ripgrep

        # for docker pull
        # pkgs.docker-credential-gcr
        (pkgs.google-cloud-sdk.withExtraComponents [
          pkgs.google-cloud-sdk.components.docker-credential-gcr
        ])


        pkgs.fly91

        pkgs.gnupg
      ];
      programs.git = {
        enable = true;
        userName = "bodymindarts";
        userEmail = "justin@galoy.io";
        extraConfig = {
          init = {defaultBranch = "main";};
          core = {editor = "vim";};
          "url \"ssh://git@github.com:\"" = {insteadOf = "https://github.com";};
          "url \"https://github.com/rust-lang/crates.io-index\"" = {insteadOf = "https://github.com/rust-lang/crates.io-index";};
          "url \"https://github.com/RustSec/advisory-db\"" = {insteadOf = "https://github.com/RustSec/advisory-db";};
          credential = {
            helper = "osxkeychain";
          };
          alias = {
            ci = "commit";
            dc = "diff --cached";
            b = "branch";
            amend = "commit --amend";
          };
        };
        ignores = ["*~"];
        lfs.enable = true;
      };
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv = {
          enable = true;
        };
      };
      programs.ssh = {
        enable = true;
        compression = true;
        forwardAgent = false;
      };
      programs.starship = import ./programs/starship/default.nix {};
      programs.skim = {
        enable = true;
        enableZshIntegration = true;
      };
      programs.zsh = import ./programs/zsh/default.nix {config = config;};
      programs.tmux = import ./programs/tmux/default.nix {pkgs = pkgs;};
      programs.neovim = import ./programs/neovim/default.nix {pkgs = pkgs;};

      home.stateVersion = "23.11";
    };
  };
}
