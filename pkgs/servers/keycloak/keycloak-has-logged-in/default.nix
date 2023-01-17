{ stdenv
, lib
, fetchurl
}:

stdenv.mkDerivation rec {
  pname = "keycloak-slobo";
  version = "0.0.1";

  src = fetchurl {
    url = "https://m.slobo.org/repo/keycloak-slobo-0.0.1.jar";
    sha256 = "8ae54f38c676613f0a229d836b6f9c35a8bedd13fcb300166071ca8b068043a9";
  };

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p "$out"
    #install "$src" "$out/${pname}-ear-${version}.ear"
    install "$src" "$out/${pname}-${version}.jar"
  '';

  meta = with lib; {
    homepage = "https://slobo.org/repo/keycloak-slobo";
    description = "Keycloak Slobo Plugin";
    license = licenses.apsl20;
    maintainers = with maintainers; [ mordquist rer ];
  };
}
