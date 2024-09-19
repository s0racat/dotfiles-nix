{ ... }:
{
  programs.aria2 = {
    enable = true;
    settings = {
      continue = true;
      "file-allocation" = "none";
      "max-concurrent-downloads" = 5;
      "max-connection-per-server" = 5;
      useragent = "Wget";
    };
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
      style = "numbers";
    };
  };
  programs.htop = {
    enable = true;
    settings = {
      tree_view = 1;
      tree_view_always_by_pid = 1;
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
    };
  };
}
