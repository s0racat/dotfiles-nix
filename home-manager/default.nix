{ username, ...}:
{
home.username = username;
home.homeDirectory = "/home/${username}";
}
