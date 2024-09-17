final: prev:
let
  commit = "4eb91a3bbfef70bde940668ec60f3beae291e971";
  # kana to kanji
  small = prev.fetchurl {
    url = "https://raw.githubusercontent.com/skk-dev/dict/${commit}/SKK-JISYO.S";
    sha256 = "sha256-mJnVogS/1ehNS/PVLVK86nJNrep/W0FvJxKmVBHLkoU=";
  };
  medium = prev.fetchurl {
    url = "https://raw.githubusercontent.com/skk-dev/dict/${commit}/SKK-JISYO.M";
    sha256 = "sha256-t3WMHY+J7j3ZigWVQqxcTbB2qBjGTMC+wTrZKnG6kl8=";
  };
  large = prev.fetchurl {
    url = "https://raw.githubusercontent.com/skk-dev/dict/${commit}/SKK-JISYO.L";
    sha256 = "sha256-6Jb8ReQYWgvGIWz05L5BXLwBKBcdPsQryWxvWPehDyQ=";
  };

  # english to japanese
  edict = prev.fetchurl {
    url = "https://raw.githubusercontent.com/skk-dev/dict/${commit}/SKK-JISYO.edict";
    sha256 = "sha256-kYY10BbJWIGaIg0p0QRAIz1so+PG0iWjDcbKvQG2PO8=";
  };
  # misc
  assoc = prev.fetchurl {
    url = "https://raw.githubusercontent.com/skk-dev/dict/${commit}/SKK-JISYO.assoc";
    sha256 = "sha256-JRtgf800X0OOESsuxPd4NfT75yiGSvTcr43zpbpVK10=";
  };
in
{
  skk-dicts-latest = prev.skk-dicts.overrideAttrs {
    version = "rev-4eb91a3";
    srcs = [
      small
      medium
      large
      edict
      assoc
    ];
  };
}
