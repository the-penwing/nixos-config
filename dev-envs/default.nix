{ pkgs }:
let
  pawn = import ./pawn-appetit.nix { inherit pkgs; };
  bash = import ./bash-scripting.nix { inherit pkgs; };
  rust = import ./rust.nix { inherit pkgs; };
in
{
  "pawn-appetit" = { buildInputs = pawn.packages; shellHook = pawn.shellHook; };
  "bash-scripting" = { buildInputs = bash.packages; shellHook = bash.shellHook; };
  rust = { buildInputs = rust.packages; shellHook = rust.shellHook; };
}
