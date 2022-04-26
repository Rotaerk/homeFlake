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
