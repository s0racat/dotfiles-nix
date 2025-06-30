{
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
