final: prev:
let
  fetchSKKDict =
    { name, sha256 }:
    prev.fetchurl {
      url = "https://github.com/skk-dev/dict/raw/4eb91a3bbfef70bde940668ec60f3beae291e971/${name}";
      inherit sha256;
    };
in
{
  skk-dicts = prev.skk-dicts.overrideAttrs {
    version = "rev-4eb91a3";
    srcs = [
      (fetchSKKDict {
        name = "SKK-JISYO.S";
        sha256 = "sha256-mJnVogS/1ehNS/PVLVK86nJNrep/W0FvJxKmVBHLkoU=";
      })
      (fetchSKKDict {
        name = "SKK-JISYO.M";
        sha256 = "sha256-t3WMHY+J7j3ZigWVQqxcTbB2qBjGTMC+wTrZKnG6kl8=";
      })
      (fetchSKKDict {
        name = "SKK-JISYO.L";
        sha256 = "sha256-6Jb8ReQYWgvGIWz05L5BXLwBKBcdPsQryWxvWPehDyQ=";
      })
      (fetchSKKDict {
        name = "SKK-JISYO.edict";
        sha256 = "sha256-kYY10BbJWIGaIg0p0QRAIz1so+PG0iWjDcbKvQG2PO8=";
      })
      (fetchSKKDict {
        name = "SKK-JISYO.assoc";
        sha256 = "sha256-JRtgf800X0OOESsuxPd4NfT75yiGSvTcr43zpbpVK10=";
      })
    ];
  };
}
