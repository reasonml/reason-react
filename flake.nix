{
  description = "Reason React Nix Flake";

  inputs = {
    nixpkgs.url = "github:nix-ocaml/nix-overlays";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = f: nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system:
        let
          pkgs = nixpkgs.legacyPackages.${system}.extend (self: super: {
            ocamlPackages = super.ocaml-ng.ocamlPackages_5_3.overrideScope (oself: osuper: {
              pp = osuper.pp.overrideAttrs (_: {
                doCheck = false;
              });
              reason = osuper.reason.overrideAttrs (_: {
                src = builtins.fetchurl {
                  url = "https://github.com/reasonml/reason/releases/download/3.16.0/reason-3.16.0.tbz";
                  sha256 = "0kinqmc1al8n30f8mv7k9zyvkfsgbbn4pasq0s2jm3ilglxf9c27";
                };
                doCheck = false;
                patches = [ ];
              });
              ppxlib = osuper.ppxlib.overrideAttrs (_: {
                src = builtins.fetchurl {
                  url = "https://github.com/ocaml-ppx/ppxlib/releases/download/0.36.0/ppxlib-0.36.0.tbz";
                  sha256 = "0d54j19vi1khzmw0ffngs8xzjjq07n20q49h85hhhcf52k71pfjs";
                };
              });

              melange = osuper.melange.overrideAttrs (_: {
                src = super.fetchFromGitHub {
                  owner = "melange-re";
                  repo = "melange";
                  rev = "70f9593acac50a60179ee963ae3dd57ec832e28c";
                  hash = "sha256-+cfxb1yolkhCJicGK5a/r3moLQ3lyAgh37SmpzLTqu4=";
                  fetchSubmodules = true;
                };
              });
            });
          });
        in
        f pkgs);
    in
    {
      packages = forAllSystems (pkgs:
        let
          inherit (pkgs.ocamlPackages)
            buildDunePackage melange merlin ppxlib reason;
          packages = rec {
            reason-react-ppx = buildDunePackage {
              pname = "reason-react-ppx";
              version = "n/a";

              src =
                let fs = pkgs.lib.fileset; in
                fs.toSource {
                  root = ./.;
                  fileset = fs.unions [
                    ./dune-project
                    ./dune
                    ./reason-react-ppx.opam
                    ./ppx
                  ];
                };

              # Due to a Reason version mismatch, the generated OCaml PPX diff
              # looks different
              doCheck = false;
              propagatedBuildInputs = [ ppxlib ];
            };

            reason-react = buildDunePackage {
              pname = "reason-react";
              version = "n/a";

              src =
                let fs = pkgs.lib.fileset; in
                fs.toSource {
                  root = ./.;
                  fileset = fs.unions [
                    ./dune-project
                    ./dune
                    ./reason-react.opam
                    ./src
                    ./test
                  ];
                };

              doCheck = true;
              nativeBuildInputs = [ melange reason ];
              propagatedBuildInputs = [ melange reason-react-ppx ];
            };
          };
        in
        packages // { default = packages.reason-react; });

      devShells = forAllSystems (pkgs:
        let
          makeDevShell = { packages, release-mode ? false }:
            pkgs.mkShell {
              # dontDetectOcamlConflicts = true;
              inputsFrom = pkgs.lib.attrValues packages;
              nativeBuildInputs =
                with pkgs.ocamlPackages; [ ocamlformat pkgs.nodejs_latest ]
                  ++ pkgs.lib.optionals release-mode (with pkgs; [
                  cacert
                  curl
                  ocamlPackages.dune-release
                  ocamlPackages.odoc
                  git
                ]);
              propagatedBuildInputs = with pkgs.ocamlPackages; [ merlin ];
            };
          packages = self.packages.${pkgs.system};
        in
        {
          default = makeDevShell { inherit packages; };
          release = makeDevShell {
            inherit packages;
            release-mode = true;
          };
        });
    };
}
