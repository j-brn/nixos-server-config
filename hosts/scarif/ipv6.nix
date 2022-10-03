{
  networking = {
    interfaces.ens3.ipv6.addresses = [{
      address = "2a01:4f8:c2c:2bca::1";
      prefixLength = 64;
    }];

    defaultGateway6 = {
      address = "fe80::1";
      interface = "ens3";
    };
  };
}
