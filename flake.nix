{
  description = "Paper Fabric: the toolchain comes from h0ffmann/picasso's paper lab";

  # Until h0ffmann/picasso#114 merges, the lab lives on its branch (ref=labs/paper). After the
  # merge, drop `&ref=labs/paper` and run `nix flake update paper`.
  inputs.paper.url = "github:h0ffmann/picasso?dir=labs/paper&ref=labs/paper";

  outputs = { paper, ... }: {
    devShells = builtins.mapAttrs (_: shells: { inherit (shells) default; }) paper.devShells;
  };
}
