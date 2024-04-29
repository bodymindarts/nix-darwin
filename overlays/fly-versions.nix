self: super: let
  fly = versionArg: sha256Arg: vendorSha256Arg: (
    super.buildGoModule rec {
      pname = "fly";
      version = versionArg;

      src = super.fetchFromGitHub {
        owner = "concourse";
        repo = "concourse";
        rev = "v${version}";
        sha256 = sha256Arg;
      };

      vendorHash = vendorSha256Arg;

      doCheck = false;

      subPackages = ["fly"];

      buildFlagsArray = ''
        -ldflags=
          -X github.com/concourse/concourse.Version=${version}
      '';

      postInstall = super.lib.optionalString (super.stdenv.hostPlatform == super.stdenv.buildPlatform) ''
        mkdir -p $out/share/{bash-completion/completions,zsh/site-functions}
        $out/bin/fly completion --shell bash > $out/share/bash-completion/completions/fly
        $out/bin/fly completion --shell zsh > $out/share/zsh/site-functions/_fly
      '';

      meta = with super.lib; {
        description = "A command line interface to Concourse CI";
        homepage = "https://concourse-ci.org";
        license = licenses.asl20;
        maintainers = with maintainers; [rkoster];
      };
    }
  );
in {
  # fly60 = fly "6.0.0" "0chavwymyh5kv4fkvdjvf3p5jjx4yn9aavq66333xnsl5pn7q9dq" super.lib.fakeSha256;
  # nix-build '<nixpkgs>' -A fly60 # will get you the real sha
  fly90 = fly "7.9.0" "sha256-YatN0VG3oEUK+vzJzthRnX+EkvUgKq2uIunAoPMoRag=" "sha256-nX0r/7V+rgJb3/9O91QskYzBpWXIca7m3Do1QtGuHgg=";
  fly91 = fly "7.9.1" "sha256-ySyarky92+VSo/KzQFrWeh35KDMTQDV34F5iFrARHJs=" "sha256-Oy1wP82ZhdpGHs/gpfdveOK/jI9yuo0D3JtxjLg+W/w=";
}
