# Width of a tab character.  Setting it high so it's obvious when I have one.
set global tabstop 8
# Width of indentation using `>` and `<`.
set global indentwidth 2
# When saving, write to a new file, then replace the existing one with it.
set global writemethod replace

hook global ModuleLoaded smarttab %{
  set-option global softtabstop 4
}

hook global BufOpenFile .* expandtab
hook global BufNewFile .* expandtab

# Install plugin manager if missing.
# evaluate-commands %sh{
#   plugins="$kak_config/plugins"
#   mkdir -p "$plugins"
#   [ ! -e "$plugins/plug.kak" ] && \
#     git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
#   printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
# }
# plug "andreyorst/plug.kak" noload
# 
# # I want no tabs ever.
# plug "andreyorst/smarttab.kak" defer smarttab %{
#   set global softtabstop %opt{indentwidth}
# } config %{
#   hook global WinCreate .* expandtab
# }
# 
# plug "kak-lsp/kak-lsp" do %{
#   cargo install --locked --force --path .
# }
