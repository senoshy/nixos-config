{inputs, ...}: final: prev: {
  sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation {
    pname = "sf-mono-liga-bin";
    version = "dev";
    src = inputs.sf-mono-liga-src;
    dontConfigure = true;
    installPhase = ''
      mkdir -p $out/share/fonts/opentype
      cp -R $src/*.otf $out/share/fonts/opentype/
    '';
  };

  macos-tahoe-cursors = prev.stdenvNoCC.mkDerivation {
    pname = "macos-tahoe-cursors";
    version = "1.1";

    src = prev.fetchzip {
      url = "https://raw.githubusercontent.com/csabika98/macos-tahome-cursors-snap/721ae1ab7d93378afc9e4a96092d456b208b0a83/MacOS-Tahoe-Cursor.zip";
      hash = "sha256-Aze8NHhHb4dYilZkpydwH5HEqFnpwoYnX8tbGwdmW7g=";
    };

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/icons
      cp -r $src $out/share/icons/MacOS-Tahoe-Cursor
    '';
  };

  thunar = prev.thunar.overrideAttrs (old: {
    patches = (old.patches or []) ++ [./thunar-icon-view-ellipsize.patch];
  });

  instaloader = prev.instaloader.overrideAttrs (old: {
    version = "4.15.3";
    src = prev.fetchFromGitHub {
      owner = "alimony";
      repo = "instaloader";
      rev = "83ddd40d40925b98571e18dbd2c582ff0b905e1e";
      hash = "sha256-E0uOd90X/akHgQwAt5N/FlfNWXA6Nr7b7Mhlx+SQ2A0=";
    };
    patches = (old.patches or []) ++ [./instaloader-feed-first.patch];
  });

  tamzen-ttf = prev.stdenvNoCC.mkDerivation {
    pname = "tamzen-ttf";
    version = "1.11.6";
    src = prev.fetchurl {
      url = "https://github.com/sunaku/tamzen-font/archive/refs/tags/Tamzen-1.11.6.tar.gz";
      hash = "sha256-81FzF3+UB7t45IqTFp8Zga5clF1R/vbk7q6FwckZJXc=";
      name = "tamzen-1.11.6.tar.gz";
    };
    dontConfigure = true;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp ttf/*.ttf $out/share/fonts/truetype/
    '';
  };

  dosega = prev.stdenvNoCC.mkDerivation {
    pname = "dosega";
    version = "20150901";
    src = prev.fetchurl {
      url = "https://sourceforge.net/projects/dosega/files/DOSEGA-20150901.zip/download";
      hash = "sha256-eTAwKvSU8yURozKlQnLSuT2+LMvUCeSrMWgwOAVakWk=";
      name = "DOSEGA-20150901.zip";
    };
    nativeBuildInputs = [prev.unzip];
    dontConfigure = true;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      unzip -j $src DOSEGA.ttf -d $out/share/fonts/truetype
    '';
  };

  discord = prev.discord.override {
    withVencord = true;
    commandLineArgs = "--enable-features=AcceleratedVideoEncoder,AcceleratedVideoDecodeLinuxGL,WaylandWindowDecorations --ignore-gpu-blocklist";
  };

  intel-compute-runtime-legacy1 = prev.intel-compute-runtime-legacy1.overrideAttrs (
    old: {
      CXXFLAGS = (old.CXXFLAGS or "") + " -Wno-error=sfinae-incomplete";
    }
  );
}
