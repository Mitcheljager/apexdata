const isDark = window.matchMedia("(prefers-color-scheme: dark)")

const lightSchemeIcons = document.querySelectorAll("link#light-theme-icon")
const darkSchemeIcons = document.querySelectorAll("link#dark-theme-icon")

if (isDark.matches) {
  lightSchemeIcons.forEach(icon => icon.remove())
} else {
  darkSchemeIcons.forEach(icon => icon.remove())
}
