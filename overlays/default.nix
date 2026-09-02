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

  doto = prev.stdenvNoCC.mkDerivation {
    pname = "doto";
    version = "1.0";
    src = prev.fetchurl {
      url = "https://raw.githubusercontent.com/google/fonts/main/ofl/doto/Doto%5BROND%2Cwght%5D.ttf";
      hash = "sha256-b0/n03hTuR3zaY2qhM3i2+HJaV2IyYbmUQE0kQM31CY=";
      name = "Doto.ttf";
    };
    dontConfigure = true;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype/Doto.ttf
    '';
  };

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
}
