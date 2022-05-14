import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Fullscreen
import XMonad.Util.Loggers
import XMonad.Util.EZConfig

main =
  xmonad .
  fullscreenSupportBorder . ewmh . -- These work together to give desired full-screen window behavior.
  withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey . -- Run xmobar.
  id
  $
  def {
    borderWidth = 4,
    normalBorderColor = "#330055",
    focusedBorderColor = "#ff8800",
    modMask = mod4Mask,
    focusFollowsMouse = False,
    clickJustFocuses = False,
    terminal = "alacritty"
  }
  `additionalKeysP`
  [
  ]

myXmobarPP :: PP
myXmobarPP =
  def {
    ppSep = magenta " | ",
    ppTitleSanitize = xmobarStrip,
    ppCurrent = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2,
    ppHidden = white . wrap " " "",
    ppHiddenNoWindows = lowWhite . wrap " " "",
    ppUrgent = red . wrap (yellow "!") (yellow "!"),
    ppOrder = \[ws, l, _, wins] -> [ws, l, wins],
    ppExtras = [logTitles formatFocused formatUnfocused]
  }
  where
    formatFocused = wrap (white "[") (white "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow

    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    magenta = xmobarColor "#ff79c6" ""
    blue = xmobarColor "#bd93f9" ""
    white = xmobarColor "#f8f8f2" ""
    yellow = xmobarColor "#f1fa8c" ""
    red = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
