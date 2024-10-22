# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  hlchunk = {
    pname = "hlchunk";
    version = "ba6e2347177fec8ec6af4ae26d11a468c9e0ca72";
    src = fetchFromGitHub {
      owner = "shellRaining";
      repo = "hlchunk.nvim";
      rev = "ba6e2347177fec8ec6af4ae26d11a468c9e0ca72";
      fetchSubmodules = false;
      sha256 = "sha256-Rx5kpjfpiH9i/IvOXx+wEWSO4gdfmXdhULDxbcBJQAY=";
    };
    date = "2024-10-02";
  };
  skkeleton = {
    pname = "skkeleton";
    version = "2cdd414c1bfa8c363505b8dfc9f50ef2f446ea61";
    src = fetchFromGitHub {
      owner = "vim-skk";
      repo = "skkeleton";
      rev = "2cdd414c1bfa8c363505b8dfc9f50ef2f446ea61";
      fetchSubmodules = false;
      sha256 = "sha256-7oTJGGkUb3K8nzcPqlJrm316ECmgswy/+N8cTQghv3k=";
    };
    date = "2024-10-14";
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
    version = "1289c70b9ea264b304ee14744ae36c7ed57f2db5";
    src = fetchFromGitHub {
      owner = "vim-jp";
      repo = "vimdoc-ja";
      rev = "1289c70b9ea264b304ee14744ae36c7ed57f2db5";
      fetchSubmodules = false;
      sha256 = "sha256-aQPhEjCwsZaIizWPloXxfs8lLY5PLqOBbP1ClbkfcMg=";
    };
    date = "2024-10-22";
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
