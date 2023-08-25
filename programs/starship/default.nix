{}:
{
  enable = true;
  enableZshIntegration = true;
  settings = {
    scan_timeout = 10;
    format = "$directory$git_branch$line_break$status$character";
    character = {
      success_symbol = "[\\$](bold #00e600)";
      error_symbol = "[\\$](bold #d33682)";
    };
    directory = {
      truncation_length = 3;
      style	 = "bold #268bd2";
    };
    status = {
      disabled = false;
      format = "[\\($status\\) ](bold #839496)";
    };
    git_branch = {
      format = "[$branch*]($style) ";
      style = "#839496";
    };
  };
}
