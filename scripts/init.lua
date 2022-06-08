local function init(self)
  require(self.scriptPath.."science_confuse_change")
end

local function load(self, options, version)
end

return {
  id = "Better Confuse Shot",
  name = "Better Confuse Shot",
  description = "Confuse Shot now works on Firefly Leader (flips it 90°).",
  version = "1.0",
  icon= "img/mod_icon.png",
  init = init,
  load = load
}