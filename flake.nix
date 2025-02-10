{
  description = "Reason React Nix Flake";

  inputs = {
    nix-filter.url = "github:numtide/nix-filter";
    nixpkgs.url = "github:nix-ocaml/nix-overlays";
  };

  outputs = { self, nixpkgs, nix-filter }:
    let
      forAllSystems = f: nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system:
        let
          pkgs = nixpkgs.legacyPackages.${system}.extend (self: super: {
            ocamlPackages = super.ocaml-ng.ocamlPackages_5_2.overrideScope (oself: osuper: {
              ppxlib = osuper.ppxlib.overrideAttrs (o: {
                propagatedBuildInputs = o.propagatedBuildInputs ++ [ osuper.stdio ];
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
              src = with nix-filter.lib; filter {
                root = ./.;
                include = [
                  "dune-project"
                  "dune"
                  "reason-react-ppx.opam"
                  "reason-react.opam"
                  "ppx"
                ];
              };
              # Due to a Reason version mismatch, the generated OCaml PPX diff
              # looks different
              doCheck = false;
              checkInputs = [ ];
              checkPhase = "dune build @runtest -p reason-react,reason-react-ppx";
              nativeCheckInputs = [ reason merlin pkgs.jq ];
              propagatedBuildInputs = [ ppxlib ];
            };

            reason-react = buildDunePackage {
              pname = "reason-react";
              version = "n/a";
              src = with nix-filter.lib; filter {
                root = ./.;
                include = [
                  "dune-project"
                  "dune"
                  "reason-react-ppx.opam"
                  "reason-react.opam"
                  "src"
                  "test"
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
