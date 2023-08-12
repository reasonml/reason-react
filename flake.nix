{
  description = "Reason React Nix Flake";

  inputs = {
    nix-filter.url = "github:numtide/nix-filter";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs = {
      url = "github:nix-ocaml/nix-overlays";
      inputs.flake-utils.follows = "flake-utils";
    };
    melange = {
      url = "github:melange-re/melange";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nix-filter.follows = "nix-filter";
    };
  };

  outputs = { self, nixpkgs, flake-utils, melange, nix-filter }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}".appendOverlays [
          (self: super: { ocamlPackages = super.ocaml-ng.ocamlPackages_4_14; })
          melange.overlays.default
        ];
      in

      rec {
        packages = with pkgs.ocamlPackages; rec {
          reason-react-ppx = buildDunePackage {
            pname = "reason-react-ppx";
            version = "n/a";
            src = with nix-filter.lib; filter {
              root = ./.;
              include = [
                "dune-project"
                "dune"
                "reason-react-ppx.opam"
                "ppx"
              ];
            };
            # Due to a Reason version mismatch, the generated OCaml PPX diff
            # looks different
            doCheck = false;
            nativeCheckInputs = [ reason ];
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
                "src"
                "test"
              ];
            };
            doCheck = true;
            nativeBuildInputs = [ pkgs.ocamlPackages.melange reason ];
            propagatedBuildInputs = [
              pkgs.ocamlPackages.melange
              reason-react-ppx
            ];
          };
        } // { default = packages.reason-react; };

        devShells = {
          default = pkgs.mkShell {
            dontDetectOcamlConflicts = true;
            inputsFrom = pkgs.lib.attrValues packages;
            nativeBuildInputs = with pkgs.ocamlPackages; [ ocamlformat ];
            propagatedBuildInputs = with pkgs.ocamlPackages; [ merlin ];
          };
        };
      });
}
