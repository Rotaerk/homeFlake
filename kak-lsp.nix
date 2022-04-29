{ stdenv, lib, fetchFromGitHub, rustPlatform, Security, SystemConfiguration }:

rustPlatform.buildRustPackage rec {
  pname = "kak-lsp";
  version = "2022-04-28";

  src = fetchFromGitHub {
    owner = "kak-lsp";
    repo = "kak-lsp";
    rev = "d7fb3b56a85c21299838c414d2379fa6ad28ed1c";
    sha256 = "Nt0tkBsjhFgYWqdZ8P5dgol/OrPLs+AKjvMjwSI/Q3g=";
  };

  cargoSha256 = "sha256-mPRClXDbkpXqlsq7hSfXuLRl9NrHZia16krx0WrNJNM=";

  buildInputs = lib.optionals stdenv.isDarwin [ Security SystemConfiguration ];

  meta = with lib; {
    description = "Kakoune Language Server Protocol Client";
    homepage = "https://github.com/kak-lsp/kak-lsp";
    license = with licenses; [ unlicense /* or */ mit ];
    maintainers = [ maintainers.spacekookie ];
  };
}
