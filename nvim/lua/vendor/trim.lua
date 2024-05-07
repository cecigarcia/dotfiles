function trim(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

return trim;
