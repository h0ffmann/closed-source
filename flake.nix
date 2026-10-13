{
  description = "Paper Fabric: the toolchains come from h0ffmann/picasso's paper and gleam-website labs";

  # `nix flake update` picks up new revisions of the labs.
  inputs.paper.url = "github:h0ffmann/picasso?dir=labs/paper";
  inputs.gleam-website.url = "github:h0ffmann/picasso?dir=labs/gleam-website";

  outputs = { paper, gleam-website, ... }: {
    # default: the PDF and arXiv toolchain, plus Gleam on Erlang for tools/ (the checks and the
    # release tooling); site: the toolchain of site/; md: the Markdown analysers. Gleam and Erlang come from the paper lab's
    # own nixpkgs, so the lock pins them with everything else.
    devShells = builtins.mapAttrs
      (system: shells:
        let pkgs = paper.inputs.nixpkgs.legacyPackages.${system}; in {
          default = pkgs.mkShell {
            inputsFrom = [ shells.default ];
            packages = [ pkgs.gleam pkgs.beamPackages.erlang pkgs.beamPackages.rebar3 ];
          };
          site = gleam-website.devShells.${system}.default;
          # md: the three Markdown analysers of `just md-quality` (.github/workflows/md.yml).
          md = pkgs.mkShell { packages = [ pkgs.markdownlint-cli2 pkgs.vale pkgs.lychee ]; };
        })
      paper.devShells;
  };
}
