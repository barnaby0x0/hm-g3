{
  inputs = {
    nix-config.url = "github:barnaby0x0/nix-config/develop";
    home-manager.follows = "nix-config/home-manager";
  };

  outputs = { nix-config, home-manager, ... }: {
    homeConfigurations."user@g3" = home-manager.lib.homeManagerConfiguration {
      pkgs = nix-config.lib.commons.mkPkgs "x86_64-linux";
      extraSpecialArgs = {
        self = nix-config;
      };

      modules = [
        nix-config.homeModules.profiles.base
        nix-config.homeModules.nix-flatpak
        nix-config.homeModules.profiles.niri
        ./home.nix
      ];
    };
  };
}
