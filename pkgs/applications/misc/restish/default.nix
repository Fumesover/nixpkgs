{ lib
, buildGoModule
, fetchFromGitHub
, testers
}:

buildGoModule rec {
  pname = "restish";
  version = "0.17.0";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "danielgtaylor";
    repo = pname;
    hash = "sha256-sXktiYCymoqZgEWQJHYn9KAUxtZYNCSyDyPC8D/X+Mw=";
  };

  vendorHash = "sha256-quDHEoHVAEAnw+M0xiAd07s/EOhVUgH0T1z8TaBcbj0=";

  ldflags = [ "-s" "-w" "-X=main.version=${version}" ];
  # passthru.tests.version = testers.testVersion {
  #   package = pkgs.restish;
  # };

  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  meta = with lib; {
    description = "CLI for interacting with REST-ish HTTP APIs with some nice features built-in";
    homepage = "https://rest.sh/";
    license = licenses.mit;
    maintainers = with maintainers; [ fumesover ];
    platforms = platforms.unix;
  };
}
