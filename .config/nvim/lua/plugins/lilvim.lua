return {
	"mvllow/lilvim",
	-- TODO: Remove once merged into main
	branch = "feat/install-as-plugin",
	config = function()
		require("lil-quickfix")
	end
}
