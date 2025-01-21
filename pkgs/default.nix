{
  stdenvNoCC,
  mas,
}:

stdenvNoCC.mkDerivation {
  pname = "xcode";
  version = "16.2";

  buildInputs = [
    mas
  ];

  preInstall = ''
    mas purchase 497799835
  '';

  installPhase = ''
    runHook preInstall

    mas install 497799835

    runHook postInstall
  '';
}
