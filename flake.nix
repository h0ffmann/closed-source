{
  description = "Paper Fabric: the toolchains come from h0ffmann/picasso's paper and gleam-website labs";

  # `nix flake update` picks up new revisions of the labs.
  inputs.paper.url = "github:h0ffmann/picasso/labs/paper-rsvg?dir=labs/paper";
  inputs.gleam-website.url = "github:h0ffmann/picasso?dir=labs/gleam-website";

  outputs = { paper, gleam-website, ... }: {
    # default: the PDF and arXiv toolchain; site: the toolchain of site/.
    devShells = builtins.mapAttrs
      (system: shells: {
        inherit (shells) default;
        site = gleam-website.devShells.${system}.default;
      })
      paper.devShells;
  };
}
