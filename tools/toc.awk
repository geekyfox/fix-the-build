BEGIN {
	print "<h2>Table of Contents</h2>"
	print ""
	print "<p>"
	
	FIRST = 1
}

/^## (.+)$/ {
	# chapters/00.md -> chapter00
	id = "chapter" substr(FILENAME, 10, 2)
	title = substr($0, 4)

	if (FIRST) {
		FIRST = 0
	} else {
		print "<br />"
	}

	print "<a href=\"#" id "\">" title "</a>"

	nextfile
}

END {
	print "</p>"
	print ""
}

