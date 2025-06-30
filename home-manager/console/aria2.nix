{
  programs.aria2 = {
    enable = true;
    settings = {
      continue = true;
      "file-allocation" = "none";
      "max-concurrent-downloads" = 5;
      "max-connection-per-server" = 5;
      user-agent = "Wget";
    };
  };
}
