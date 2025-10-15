if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "wsl",
		copy = {
			["+"] = "win32yank.exe -i",
			["*"] = "win32yank.exe -i",
		},
		paste = {
			["+"] = "win32yank.exe -o",
			["*"] = "win32yank.exe -o",
		},
		cache_enabled = false,
	}
end
