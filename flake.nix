{
  description = "MS Queue to Distributed Memory - Semester Project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        gcc13
        cmake
        pkg-config
        git
        openmpi
        gnumake
      ];

      shellHook = ''
        export OMPI_MCA_btl_vader_single_copy_mechanism=none
        export OMPI_MCA_hwloc_base_binding_policy=none
        echo "✓ MS Queue DMM Development Environment"
        echo "  MPI: $(mpirun --version | head -n1)"
        echo "  GCC: $(gcc --version | head -n1)"
        echo ""
        echo "Test MPI: mpirun -np 4 hostname"
      '';
    };
  };
}
