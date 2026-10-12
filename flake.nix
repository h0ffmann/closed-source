{
  description = "Paper Fabric: the toolchain comes from h0ffmann/picasso's paper lab";

  # `nix flake update paper` picks up a new revision of the lab.
  inputs.paper.url = "github:h0ffmann/picasso?dir=labs/paper";

  outputs = { paper, ... }: {
    devShells = builtins.mapAttrs (_: shells: { inherit (shells) default; }) paper.devShells;
  };
}
