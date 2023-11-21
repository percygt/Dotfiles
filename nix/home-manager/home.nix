{
  config,
  pkgs,
  ...
}: {
  home = {
    homeDirectory = "/home/vlad";

    packages = with pkgs; [
		htop
    ];

    stateVersion = "23.05";
    username = "percygt";
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs.home-manager.enable = true;
}
