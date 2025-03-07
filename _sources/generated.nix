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
    version = "f1f0586c69d84c6ee5f3e5a4ca76cc188161b944";
    src = fetchFromGitHub {
      owner = "vim-skk";
      repo = "skkeleton";
      rev = "f1f0586c69d84c6ee5f3e5a4ca76cc188161b944";
      fetchSubmodules = false;
      sha256 = "sha256-egAD1VDmoks9WwsEMOgyJmiMRV+p4f6S4sWOMKAew48=";
    };
    date = "2025-02-09";
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
    version = "8ac97aab866087dce2f21a369b7b2dc8fe1c0188";
    src = fetchFromGitHub {
      owner = "vim-jp";
      repo = "vimdoc-ja";
      rev = "8ac97aab866087dce2f21a369b7b2dc8fe1c0188";
      fetchSubmodules = false;
      sha256 = "sha256-V6URmHQehtsNaGeers6FiLoA42ulXUPW53tGvEKMU/I=";
    };
    date = "2025-03-07";
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
