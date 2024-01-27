{
  description = "My Android project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: 
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.android_sdk.accept_license = true;
      config.allowUnfree = true;
    };
  in {
    devShell.x86_64-linux = (pkgs.buildFHSUserEnv {
      name = "android-sdk-env";
      targetPkgs = pkgs: (with pkgs; [
        android-tools
        gradle
        androidenv.androidPkgs_9_0.androidsdk
        xorg.libX11
        libpulseaudio
        flutter
        zlib
        glibc
        fish
        kotlin
        cmake
        libglvnd
        nss
        nspr
        expat
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXtst
        xorg.libXrender
        alsaLib
        libuuid
      ]);
    }).env;
  };
}
