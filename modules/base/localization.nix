{ ... }: {
  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "de_DE.UTF-8";

    supportedLocales = [ "en_US.UTF-8/UTF-8" "de_DE.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_COLLATE = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };
}
