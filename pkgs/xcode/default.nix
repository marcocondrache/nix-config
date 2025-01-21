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

  # Xcode needs to be installed before we can build anything that requires it
  phases = [ "installPhase" ];

  # TODO: understand if we need to purchase Xcode
  installPhase = ''
    # Install Xcode
    mas install 497799835 || true  # true because mas exits with error if already installed

    # Accept license
    sudo xcodebuild -license accept

    # Create the derivation output directory
    mkdir -p $out
  '';

  meta = {
    description = "Apple's IDE for macOS";
    homepage = "https://developer.apple.com/xcode/";
    platforms = [
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  };
}
