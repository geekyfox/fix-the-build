BEGIN {
	MXLEN = 71
}

END {
	flush()
}

/^[-=#]+$/ {
	flush()
	print
	next
}

/^(\w*)$/ {
	flush()
	print
	next
}

{
	if (accum) {
		accum = accum " "
	}
	accum = accum $0
	next
}

function flush() {
	gsub(/^[ ]+/, "", accum)
	while (accum) {
		len = length(accum)

		if (len <= MXLEN) {
			print accum
			accum = ""
			return
		}

		ix = MXLEN + 1
		while (substr(accum, ix, 1) != " ") {
			ix--
		}

		print substr(accum, 1, ix - 1)
		accum = substr(accum, ix + 1)
		gsub(/^[ ]+/, "", accum)
	}
}
