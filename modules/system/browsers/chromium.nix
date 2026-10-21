{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.system.browsers.chromium;

  search = {
    default = "ddg";
    engines = [
      {
        name = "Nix Packages";
        shortcut = "np";
        url = "https://search.nixos.org/packages?type=packages&query={searchTerms}";
        featured = true;
      }
      {
        name = "Nix Options";
        shortcut = "no";
        url = "https://search.nixos.org/options?type=options&query={searchTerms}";
        featured = false;
      }
      {
        name = "NixOS Wiki";
        shortcut = "nw";
        url = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
        featured = false;
      }
      {
        name = "Google";
        shortcut = "gg";
        url = "https://www.google.com/search?q={searchTerms}";
        featured = true;
      }
      {
        name = "Home-manager options";
        shortcut = "hm";
        url = "https://home-manager-options.extranix.com/?query={searchTerms}";
        featured = true;
      }
    ];
  };

  bookmarks = [
    {
      name = "Nix";
      children = [
        {
          name = "Homepage";
          url = "https://nixos.org/";
        }
        {
          name = "Nix Manual";
          url = "https://nix.dev/manual/nix/2.28/";
        }
        {
          name = "Nix First Steps";
          url = "https://nix.dev/tutorials/first-steps/";
        }
        {
          name = "Nixpkgs Manual";
          url = "https://nixos.org/manual/nixpkgs/stable/";
        }
        {
          name = "NixOS Manual";
          url = "https://nixos.org/manual/nixos/stable/";
        }
        {
          name = "Nixvim Manual";
          url = "https://nix-community.github.io/nixvim/";
        }
      ];
    }
    {
      name = "Dictionary";
      children = [
        {
          name = "english dictionary";
          url = "https://dictionary.cambridge.org/dictionary/english/";
        }
        {
          name = "dicionário de português";
          url = "https://www.dicio.com.br/";
        }
      ];
    }
    {
      name = "Wiki";
      children = [
        {
          name = "Wikipedia";
          url = "https://wikipedia.org/";
        }
        {
          name = "Arch Wiki";
          url = "https://wiki.archlinux.org/";
        }
        {
          name = "Hypr Wiki";
          url = "https://wiki.hypr.land/";
        }
      ];
    }
  ];
in {
  options.system.browsers.chromium = {
    enable = lib.mkEnableOption "enable ungoogled-chromium policies module";
  };

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;

      homepageLocation = "https://duckduckgo.com";
      defaultSearchProviderEnabled = true;
      defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
      defaultSearchProviderSuggestURL = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";

      extraOpts = {
        BrowserSignin = 0;
        SyncDisabled = true;

        PasswordManagerEnabled = false;

        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;

        TranslateEnabled = false;

        MetricsReportingEnabled = false;

        SearchSuggestEnabled = false;

        DoNotTrackEnabled = true;

        BlockThirdPartyCookies = true;

        NetworkPredictionOptions = 2;

        DnsOverHttpsMode = "off";

        DefaultBrowserSettingEnabled = false;

        PromptForDownloadLocation = true;

        HomepageIsNewTabPage = false;
        ShowHomeButton = true;

        WebRtcIPHandlingPolicy = 2;

        ChromeVariations = 2;

        URLBlocklist = [
          "platform.twitter.com/*"
          "platform.instagram.com/*"
          "embed.reddit.com/*"
          "www.tiktok.com/embed/*"
        ];

        SiteSearchSettings = search.engines;

        ManagedBookmarks = bookmarks;
      };

      initialPrefs = {
        homepage_is_newtabpage = false;
        homepage = "https://duckduckgo.com";
        "browser.show_home_button" = true;
      };
    };

    environment.systemPackages = [pkgs.brave];
  };
}
