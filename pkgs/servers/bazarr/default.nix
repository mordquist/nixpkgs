{ stdenv, lib, fetchurl, makeWrapper, unzip, python3, unrar, ffmpeg, nixosTests }:

stdenv.mkDerivation rec {
  pname = "bazarr";
  version = "1.1.2";

  sourceRoot = ".";

  src = fetchurl {
    url = "https://github.com/morpheus65535/bazarr/releases/download/v${version}/bazarr.zip";
    sha256 = "sha256-cTSRfnMYAyoOoTy0wx8sxqyS92zP6GZu8aH5hRRTxU4=";
  };

  nativeBuildInputs = [ unzip makeWrapper ];

  installPhase = ''
    mkdir -p $out/{bin,share/${pname}-${version}}
    cp -r * $out/share/${pname}-${version}
    makeWrapper "${
      (python3.withPackages
        (ps: [ ps.lxml ps.numpy ps.gevent ps.gevent-websocket ])).interpreter
    }" \
      $out/bin/bazarr \
      --add-flags "$out/share/${pname}-${version}/bazarr.py" \
      --suffix PATH : ${lib.makeBinPath [ unrar ffmpeg ]}
  '';

  passthru.tests = {
    smoke-test = nixosTests.bazarr;
  };

  meta = with lib; {
    description = "Subtitle manager for Sonarr and Radarr";
    homepage = "https://www.bazarr.media/";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ d-xo ];
    platforms = platforms.all;
  };
}
