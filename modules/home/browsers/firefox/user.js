// i do prefer to use this as my "override preferences" than use betterfox.js file to do it, because if something changes, i just update the betterfox.js file without needed to keep my overrides manually

// fonts: proportional text uses Open Sans; mono stays JetBrains Mono.
// Open Sans installed via pkgs.open-sans; DejaVu kept as the generic fallback.
user_pref("font.name.sans-serif.x-western", "Open Sans");
user_pref("font.name.serif.x-western", "DejaVu Serif");
user_pref("font.name.monospace.x-western", "JetBrainsMono Nerd Font");

// load chrome/userChrome.css so the browser UI (sidebar, urlbar, tabs) can be styled
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

user_pref("sidebar.verticalTabs", true);
user_pref("sidebar.revamp", true);

user_pref("browser.download.start_downloads_in_tmp_dir", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.translations.alwaysTranslateLanguages", "");
user_pref("browser.translations.automaticallyPopup", false);

// acceleration / webrender
user_pref("layers.acceleration.enabled", true);
user_pref("layers.acceleration.force-enabled", false);
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.software", false);

// VA-API / Wayland DMABUF / WebGL
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.ffmpeg.vaapi.allow-dmabuf", true);
user_pref("widget.wayland-dmabuf-vaapi.enabled", true);
user_pref("widget.wayland-dmabuf-webgl.enabled", true);

// session / cache / processes
user_pref("browser.sessionstore.interval", 300000);
user_pref("browser.cache.disk.enable", true);

// memory management — reduce pressure on 19GB system
user_pref("browser.low_commit_space.threshold_mb", 1024);
user_pref("media.cache_readahead_limit", 4096);
user_pref("media.cache_resume_threshold", 1024);
user_pref("media.memory_cache_max_size", 32768);

// PREF: disable login manager
user_pref("signon.rememberSignons", false);

// PREF: disable address and credit card manager
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

// PREF: do not allow embedded tweets, Instagram, Reddit, and Tiktok posts
user_pref("urlclassifier.trackingSkipURLs", "");
user_pref("urlclassifier.features.socialtracking.skipURLs", "");

// PREF: disable captive portal detection
// [WARNING] Do NOT use for mobile devices!
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);
user_pref("network.connectivity-service.enabled", false);

// PREF: disable Firefox Sync
user_pref("identity.fxaccounts.enabled", false);

// PREF: disable the Firefox View tour from popping up
user_pref("browser.firefox-view.feature-tour", '{"screen":"","complete":true}');

// PREF: ask where to save every file
user_pref("browser.download.useDownloadDir", false);

// PREF: ask whether to open or save new file types
user_pref("browser.download.always_ask_before_handling_new_types", true);

// PREF: disable all DRM content
user_pref("media.eme.enabled", true);

// PREF: hide the UI setting; this also disables the DRM prompt (optional)
user_pref("browser.eme.ui.enabled", true);

// SMOOTHFOX
user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
user_pref("general.smoothScroll", true); // DEFAULT
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 600);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 650);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 25);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio", "2");
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 250);
user_pref("general.smoothScroll.currentVelocityWeighting", "1");
user_pref("general.smoothScroll.stopDecelerationWeighting", "1");
user_pref("mousewheel.default.delta_multiplier_y", 300); // 250-400; adjust this number to your liking

user_pref("browser.urlbar.trimHttps", true);
user_pref("browser.urlbar.trimURLs", true);
user_pref("browser.urlbar.formatting.enabled", true);

// override SECUREFOX prefetch/preconnect — Pinterest precisa disso
user_pref("network.http.speculative-parallel-limit", 6);
user_pref("network.dns.disablePrefetch", false);
user_pref("network.dns.disablePrefetchFromHTTPS", false);
user_pref("browser.urlbar.speculativeConnect.enabled", true);
user_pref("browser.places.speculativeConnect.enabled", true);
user_pref("network.prefetch-next", true);

// NEVER prompt for permissions, except camera and microphone (0=ask, 1=allow, 2=block)
// Only these types honor permissions.default.* in Firefox: camera, microphone, geo,
// desktop-notification, shortcuts, xr
user_pref("permissions.default.camera", 0);
user_pref("permissions.default.microphone", 0);
user_pref("permissions.default.geo", 2);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.shortcuts", 2);
user_pref("permissions.default.xr", 2);

// local network access: allow without prompting
user_pref("network.lna.blocking", false);
