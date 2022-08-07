{
  networking = {
    interfaces.enp1s0.ipv6.addresses = [{
      address = "2a01:4f8:c0c:367e::1";
      prefixLength = 64;
    }];

    defaultGateway6 = {
      address = "fe80::1";
      interface = "enp1s0";
    };
  };
}
