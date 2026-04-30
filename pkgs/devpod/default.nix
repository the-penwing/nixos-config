{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  testers,
}:

let
  version = "0.6.15";

  src = fetchFromGitHub {
    owner = "skevetter";
    repo = "devpod";
    rev = "v${version}";
  hash = "sha256-fLUJeEwNDyzMYUEYVQL9XGQv/VAxjH4IZ1SJa6jx4Mw=";
  };

  meta = {
    description = "Codespaces but open-source, client-only and unopinionated: Works with any IDE and lets you use any cloud, kubernetes or just localhost docker";
    mainProgram = "devpod";
    homepage = "https://devpod.sh";
    license = lib.licenses.mpl20;
    maintainers = [ lib.maintainers.tomasajt ];
  };

  devpod = buildGoModule (finalAttrs: {
    pname = "devpod";
    inherit version src meta;

    vendorHash = null;

    env.CGO_ENABLED = 0;

    ldflags = [
      "-X github.com/loft-sh/devpod/pkg/version.version=v${version}"
    ];

    excludedPackages = [ "./e2e" ];

    nativeBuildInputs = [ installShellFiles ];

    postInstall = ''
      $out/bin/devpod completion bash >devpod.bash
      $out/bin/devpod completion fish >devpod.fish
      $out/bin/devpod completion zsh >devpod.zsh
      installShellCompletion devpod.{bash,fish,zsh}
    '';

    passthru.tests.version = testers.testVersion {
      package = finalAttrs.finalPackage;
      command = "devpod version";
      version = "v${version}";
    };
  });

in
{
  inherit devpod;
}
