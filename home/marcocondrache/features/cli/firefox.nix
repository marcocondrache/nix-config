{
  programs.firefox = {
    enable = true;

    profiles.personal = {
      id = 0;
      isDefault = true;
      name = "Personal";

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
      };

      bookmarks = {
        force = true;
        settings = [ ];
      };

      settings = {
        "gfx.canvas.accelerated.cache-size" = 256;
        "gfx.webrender.layer-compositor" = true;

        ## Tracking protection
        "browser.contentblocking.category" = "strict";
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.uitour.enabled" = false;
        "privacy.globalprivacycontrol.enabled" = true;

        ## OCSP & certs / HPKP
        "security.OCSP.enabled" = 0;
        "privacy.antitracking.isolateContentScriptResources" = true;
        "security.csp.reporting.enabled" = false;
        "security.cert_pinning.enforcement_level" = 2;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.pki.crlite_mode" = 2;

        ## SSL / TLS
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "security.tls.enable_0rtt_data" = false;

        ## Disk avoidance
        "browser.cache.disk.enable" = false;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "media.memory_cache_max_size" = 65536;
        "browser.sessionstore.interval" = 60000;

        ## Shutdown & sanitizing
        "privacy.history.custom" = true;
        "browser.privatebrowsing.resetPBM.enabled" = true;

        ## Search / URL bar
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
        "browser.search.separatePrivateDefault.ui.enabled" = true;
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.addons.featureGate" = false;
        "browser.urlbar.amp.featureGate" = false;
        "browser.urlbar.fakespot.featureGate" = false;
        "browser.urlbar.mdn.featureGate" = false;
        "browser.urlbar.weather.featureGate" = false;
        "browser.urlbar.wikipedia.featureGate" = false;
        "browser.urlbar.yelp.featureGate" = false;
        "browser.urlbar.showSearchTerms.enabled" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.formfill.enable" = false;
        "network.IDN_show_punycode" = true;

        ## HTTPS-only mode
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_error_page_user_suggestions" = true;
        "dom.security.https_only_mode_send_http_background_request" = false;

        ## Passwords
        "signon.rememberSignons" = false;
        "signon.formlessCapture.enabled" = false;
        "signon.privateBrowsingCapture.enabled" = false;
        "signon.autofillForms" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "editor.truncate_user_pastes" = false;

        ## Firefox accounts
        "identity.fxaccounts.enabled" = false;

        ## Extensions
        "extensions.enabledScopes" = 5;
        "extensions.postDownloadThirdPartyPrompt" = false;

        ## Headers / referers
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        ## Containers
        "privacy.userContext.ui.enabled" = true;
        "privacy.userContext.enabled" = true;

        ## Various
        "pdfjs.enableScripting" = false;

        ## Safe browsing
        "browser.safebrowsing.downloads.remote.enabled" = false;

        ## Geolocation
        "permissions.default.geo" = 2;
        "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
        "geo.provider.use_corelocation" = false;

        ## Mozilla
        "permissions.default.desktop-notification" = 2;
        "browser.search.update" = false;
        "permissions.manager.defaultsUrl" = "";
        "extensions.getAddons.cache.enabled" = false;

        ## Telemetry
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "datareporting.usage.uploadEnabled" = false;

        ## Experiments
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";

        ## Crash reports
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

        ## Network hardening
        "network.proxy.socks_remote_dns" = true;
        "network.file.disable_unc_paths" = true;
        "network.gio.supported-protocols" = "";

        ## First run / welcome
        "browser.disableResetPrompt" = true;
        "browser.aboutwelcome.enabled" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.rights.3.shown" = true;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.couldRestoreSession.count" = -1;
        "browser.toolbars.bookmarks.visibility" = "never";
        "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;

        ## Mozilla UI
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.shortcutFavicons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.profiles.enabled" = true;

        ## Theme adjustments
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;
        "browser.privateWindowSeparation.enabled" = false;

        ## AI
        "browser.ai.control.default" = "blocked";
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.menu" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.ml.linkPreview.enabled" = false;

        ## Fullscreen notice
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.timeout" = 0;

        ## URL bar
        "browser.urlbar.trending.featureGate" = false;
        "browser.shopping.experience2023.enabled" = false;

        ## New tab page
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;

        ## Downloads
        "browser.download.manager.addToRecentDocs" = false;
        "browser.download.useDownloadDir" = false;
        "browser.download.always_ask_before_handling_new_types" = true;

        ## PDF
        "browser.download.open_pdf_attachments_inline" = true;

        ## Tab behavior
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.menu.showViewImageInfo" = true;
        "findbar.highlightAll" = true;
        "layout.word_select.eat_space_to_next_word" = false;
        "browser.tabs.searchclipboardfor.middleclick" = false;

        ## DOM
        "dom.disable_window_move_resize" = true;

        ## Miscellaneous
        "browser.helperApps.deleteTempFileOnExit" = true;
        "devtools.debugger.remote-enabled" = false;
        "browser.contentanalysis.enabled" = false;
        "browser.contentanalysis.default_result" = 0;

        ## WebRTC
        "media.peerconnection.ice.default_address_only" = true;
        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
      };
    };
  };
}
