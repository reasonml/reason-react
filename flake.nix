{
  description = "Reason React Nix Flake";

  inputs = {
    nixpkgs.url = "github:nix-ocaml/nix-overlays";
  };

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system:
          let
            pkgs = nixpkgs.legacyPackages.${system}.extend (
              self: super: {
                ocamlPackages = super.ocaml-ng.ocamlPackages_5_4;
              }
            );
          in
          f pkgs
        );
    in
    {
      packages = forAllSystems (
        pkgs:
        let
          inherit (pkgs.ocamlPackages)
            buildDunePackage
            melange
            merlin
            ppxlib_gt_0_37
            reason
            ;
          packages = rec {
            reason-react-ppx = buildDunePackage {
              pname = "reason-react-ppx";
              version = "n/a";

              src =
                let
                  fs = pkgs.lib.fileset;
                in
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
              propagatedBuildInputs = [ ppxlib_gt_0_37 ];
            };

            reason-react = buildDunePackage {
              pname = "reason-react";
              version = "n/a";

              src =
                let
                  fs = pkgs.lib.fileset;
                in
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
              nativeBuildInputs = [
                melange
                reason
              ];
              propagatedBuildInputs = [
                melange
                reason-react-ppx
              ];
            };
          };
        in
        packages // { default = packages.reason-react; }
      );

      devShells = forAllSystems (
        pkgs:
        let
          makeDevShell =
            {
              packages,
              release-mode ? false,
            }:
            pkgs.mkShell {
              dontDetectOcamlConflicts = true;
              inputsFrom = pkgs.lib.attrValues packages;
              nativeBuildInputs =
                with pkgs.ocamlPackages;
                [
                  ocamlformat
                  pkgs.nodejs_24
                ]
                ++ pkgs.lib.optionals release-mode (
                  with pkgs;
                  [
                    cacert
                    curl
                    ocamlPackages.dune-release
                    ocamlPackages.odoc
                    git
                  ]
                );
              propagatedBuildInputs = with pkgs.ocamlPackages; [ merlin ];
            };
          packages = self.packages.${pkgs.stdenv.hostPlatform.system};
        in
        {
          default = makeDevShell { inherit packages; };
          release = makeDevShell {
            inherit packages;
            release-mode = true;
          };
        }
      );
    };
}
