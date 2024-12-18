# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  hlchunk = {
    pname = "hlchunk";
    version = "5465dd33ade8676d63f6e8493252283060cd72ca";
    src = fetchFromGitHub {
      owner = "shellRaining";
      repo = "hlchunk.nvim";
      rev = "5465dd33ade8676d63f6e8493252283060cd72ca";
      fetchSubmodules = false;
      sha256 = "sha256-f5VVfpfVZk6ULBWVSVEzXBN9F4ROTzhomV1F2mKIem4=";
    };
    date = "2024-11-23";
  };
  skkeleton = {
    pname = "skkeleton";
    version = "b86773f1a0d312f6ce9cb16996fdcebde8473680";
    src = fetchFromGitHub {
      owner = "vim-skk";
      repo = "skkeleton";
      rev = "b86773f1a0d312f6ce9cb16996fdcebde8473680";
      fetchSubmodules = false;
      sha256 = "sha256-8dYw+26FCIpA6DnshiJFuHwJbWDxWwirUgttUPPcUaQ=";
    };
    date = "2024-12-17";
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
    version = "d35bacb19b773f109d2580848915eabfc53f9cbc";
    src = fetchFromGitHub {
      owner = "vim-jp";
      repo = "vimdoc-ja";
      rev = "d35bacb19b773f109d2580848915eabfc53f9cbc";
      fetchSubmodules = false;
      sha256 = "sha256-I5ken6PCQ1OhXIVtCvmExl0TmAHmycIQTgJBUiuhKHc=";
    };
    date = "2024-12-18";
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
