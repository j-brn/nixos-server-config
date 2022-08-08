{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
    ripgrep
    fd
    curl
    htop
    nmap
    sudo
    bottom
    wrk2
  ];
}
