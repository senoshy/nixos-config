{browserVersion}: let
  createChromiumExtensionFor = version: {
    id,
    sha256,
    version,
  }: {
    inherit id;
    crxPath = builtins.fetchurl {
      url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
      name = "${id}.crx";
      inherit sha256;
    };
    inherit version;
  };
  createChromiumExtension = createChromiumExtensionFor browserVersion;
in [
  (createChromiumExtension {
    id = "ddkjiahejlhfcafbddmgiahcphecmpfh";
    sha256 = "0xjs8z4l7rwsxm873k2d11yf9bcm15k0qjifnn8lx1p6p6g5b1q8";
    version = "2026.1021.1354";
  })
  (createChromiumExtension {
    id = "nngceckbapebfimnlniiiahkandclblb";
    sha256 = "0sggjs94vhbfw6fmyr27m686p8mfb31irbv9kgphnmfj8vybgzpj";
    version = "2026.10.0";
  })
  (createChromiumExtension {
    id = "dhdgffkkebhmkfjojejmpbldmpobfkfo";
    sha256 = "0wp8bxjqwkxaqspsjy4gi3103zrjkfzxjbj6pbg6lqvyh4vpj5mm";
    version = "5.5.1";
  })
]
