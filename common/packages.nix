{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
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
