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
    id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
    sha256 = "14c32zm8nzi4i58v6r9p04khqj98i08wrnnm13831cdb7j442vva";
    version = "1.73.0";
  })
  (createChromiumExtension {
    id = "nngceckbapebfimnlniiiahkandclblb";
    sha256 = "17ymclqqc34layqwjb53wym4q1jm429pk4m95lw06k93khnr99fi";
    version = "2026.8.0";
  })
  (createChromiumExtension {
    id = "dhdgffkkebhmkfjojejmpbldmpobfkfo";
    sha256 = "1m8mmiyrfbs5bcfbjwhx4lwl8gdcx43kvx43yr6irq9rqj1c1bmw";
    version = "5.5.0";
  })
]
