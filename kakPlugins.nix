{ fetchFromGitHub, ... }:
[
  {
    pname = "smarttab-kak";
    version = "2022-04-26";
    src = fetchFromGitHub {
      owner = "andreyorst";
      repo = "smarttab.kak";
      rev = "86ac6599b13617ff938905ba4cdd8225d7eb6a2e";
      sha256 = "STLZSwQPM+gTnkA+FQOF4I0ifPTjQWpEc/95JRzvIqU=";
    };
    meta.homepage = "https://github.com/andreyorst/smarttab.kak/";
  }
]
