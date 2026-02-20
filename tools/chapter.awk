BEGIN {
	PAR = 0
}

/^## (.+)$/ {
	# chapters/00.md -> chapter00
	id = "chapter" substr(FILENAME, 10, 2)
	title = substr($0, 4)

	print "<a name=\"" id "\"></a>"
	print "<h2><a href=\"#" id "\">" title "</a></h2>"
	next
}

/^(w*)$/ {
	if (PAR) {
		print "</p>"
		PAR = 0
	}
	print
	next
}

{
	if (! PAR) {
		print "<p>"
		PAR = 1
	}

    gsub(/",/, ",\"")
    gsub(/"\./, ".\"")

    gsub(/^"/, "\\&#8220;")
    gsub(/ "/, " \\&#8220;")
    gsub(/"/,  "\\&#8221;")

	print
}

END {
	if (PAR) {
		print "</p>"
	}
}

