return function ()
  local is_tokyonight, tokyonight = pcall(require, "tokyonight")
  local is_onedark, onedark = pcall(require, "onedark")

  if is_tokyonight then
    return "tokyonight", tokyonight
  elseif is_onedark then
    return "onedark", onedark
  else
    return "none", nil
  end
end
