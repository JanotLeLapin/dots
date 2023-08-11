return function ()
  local is_tokyonight, tokyonight = pcall(require, "tokyonight")
  local is_onedark, onedark = pcall(require, "onedark")
  local is_catppuccin, catppuccin = pcall(require, "catppuccin")

  if is_tokyonight then
    return "tokyonight", tokyonight
  elseif is_onedark then
    return "onedark", onedark
  elseif is_catppuccin then
    return "catppuccin", catppuccin
  else
    return "none", nil
  end
end
