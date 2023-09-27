{nixpkgs, system}:

let
  pkgs = nixpkgs.legacyPackages.${system};
  #hpkgs = pkgs.haskellPackages;
  hpkgs = pkgs.haskell.packages.ghc94;
  hsDevTools = [
    (
      #ghcWithPackages add hackage to default libraries which is visible to ghci
      hpkgs.ghcWithPackages (ps: [ ps.deriving-aeson ps.aeson ps.pandoc ps.shake ps.shake-plus])
    )
    hpkgs.haskell-language-server
    hpkgs.cabal-fmt
    hpkgs.cabal-install
    hpkgs.cabal2nix
  ];
in
  pkgs.mkShell {
    buildInputs = hsDevTools ++ [ pkgs.zlib ];
  }
