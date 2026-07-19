-- Default prefix is '\'
require("matcha").setup({
	prefix = [[<leader>\]],
	-- No keys are set by default
	keys = {
		f = "FormatOnSave",
		b = "background",
		n = "number",
		d = "matcha_diagnostics",
	}
})
