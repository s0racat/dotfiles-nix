# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  hlchunk = {
    pname = "hlchunk";
    version = "19bf4090ab8619fffe07b73a4f92348324f35c98";
    src = fetchFromGitHub {
      owner = "shellRaining";
      repo = "hlchunk.nvim";
      rev = "19bf4090ab8619fffe07b73a4f92348324f35c98";
      fetchSubmodules = false;
      sha256 = "sha256-d4bGGQ27Tc5fJ6lzmL5nd/+TSWWWE1xJ707Pz+wcY3o=";
    };
    date = "2025-04-05";
  };
  skkeleton = {
    pname = "skkeleton";
    version = "cf385775279c0c7eed3fbebfac1022f1f05ea292";
    src = fetchFromGitHub {
      owner = "vim-skk";
      repo = "skkeleton";
      rev = "cf385775279c0c7eed3fbebfac1022f1f05ea292";
      fetchSubmodules = false;
      sha256 = "sha256-DA/k2KxGqxYtyJcnV1g2lLbMtNKBXpPGje5WeYYnbtQ=";
    };
    date = "2025-03-30";
  };
  skkeleton_indicator = {
    pname = "skkeleton_indicator";
    version = "d9b649d734ca7d3871c4f124004771d0213dc747";
    src = fetchFromGitHub {
      owner = "delphinus";
      repo = "skkeleton_indicator.nvim";
      rev = "d9b649d734ca7d3871c4f124004771d0213dc747";
      fetchSubmodules = false;
      sha256 = "sha256-xr2yTHsGclLvXPpRNYBFS+dIB0+RNUb27TlGq5apBig=";
    };
    date = "2024-06-04";
  };
  vimdoc-ja = {
    pname = "vimdoc-ja";
    version = "3d2db8d052181c6f3e39dfdbe5003a1bbda6b3e9";
    src = fetchFromGitHub {
      owner = "vim-jp";
      repo = "vimdoc-ja";
      rev = "3d2db8d052181c6f3e39dfdbe5003a1bbda6b3e9";
      fetchSubmodules = false;
      sha256 = "sha256-rHiQ8yaLw6Yx/R20fsE98/nOZXNkXj8wZJJAg2r4lxk=";
    };
    date = "2025-04-07";
  };
  winresizer = {
    pname = "winresizer";
    version = "9bd559a03ccec98a458e60c705547119eb5350f3";
    src = fetchFromGitHub {
      owner = "simeji";
      repo = "winresizer";
      rev = "9bd559a03ccec98a458e60c705547119eb5350f3";
      fetchSubmodules = false;
      sha256 = "sha256-5LR9A23BvpCBY9QVSF9PadRuDSBjv+knHSmdQn/3mH0=";
    };
    date = "2022-08-15";
  };
}
