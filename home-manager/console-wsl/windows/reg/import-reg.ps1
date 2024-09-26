$files = Get-Childitem *.reg | where {! $_.PSIsContainer}
foreach ($a in $files) {
	sudo reg import $a
}
