# NoMachine Enterprise Client for the SCU ECC Linux cluster (nx.engr.scu.edu).
# nixpkgs' nomachine-client 9.5.7 is broken because NoMachine removed that
# download, so this points it at the current Enterprise Client release.
{ pkgs, ... }:

let
  nomachine-client = pkgs.nomachine-client.overrideAttrs (old: rec {
    version = "10.1.7";
    src = pkgs.fetchurl {
      url = "https://download.nomachine.com/download/10.1/Linux/nomachine-enterprise-client_${version}_1_x86_64.tar.gz";
      hash = "sha256-qvScbUV1Tt7LxYgrNpcdsRjjAippdZ/L1nrteqekC8Q=";
    };
    postUnpack = ''
      mv $(find . -type f -name nxrunner.tar.gz) .
      mv $(find . -type f -name nxplayer.tar.gz) .
      rm -r NX/
      tar xf nxrunner.tar.gz
      tar xf nxplayer.tar.gz
      rm $(find . -maxdepth 1 -type f)
      rm -rf NX/share/src/nxusb-legacy
      rm -f NX/bin/nxusbd-legacy NX/lib/libnxusb-legacy.so
    '';
  });
in
{
  environment.systemPackages = [ nomachine-client ];
}
