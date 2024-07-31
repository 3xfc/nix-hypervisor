{
  description = "My NixOS hypervisor config";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-24.05;
    srv = {
      url = "github:3xfc/srv.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, srv }: let
    baseUpdateUrl = "https://github.com/3xfc/nixlet/releases/latest/download";
    relInfo = {
      version = "0.3.0";
    };
  in {
    nixosConfigurations.hypervisor = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/hypervisor/configuration.nix
        srv.nixosModules.minimal-efi-bundle
        {
          system.image.version = relInfo.version;
          efi-bundle.updater.url = "${baseUpdateUrl}";
          nixpkgs.buildPlatform = {
            system = "x86_64-linux";
          };
        }
      ];
    };
    packages.x86_64-linux.hypervisor = self.nixosConfigurations.hypervisor.config.system.build.efi;
  };
}
