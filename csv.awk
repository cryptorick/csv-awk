BEGIN {
    rc = getline
    while (rc > 0) {
	if (match($0, /^ +/)) {
	    $0 = substr($0, RLENGTH+1)
	} else if (substr($0, 1, 1) == ",") {
	    printf("\t")
	    $0 = substr($0, 2)
	} else if (match($0, /^"[^"]*"/)) {
	    do {
		printf("%s", substr($0, 2, RLENGTH-2))
		$0 = substr($0, RLENGTH+1)
		if (substr($0, 1, 1) == "\"")
		    printf("\"")
	    } while (match($0, /^"[^"]*"/))
	} else if (match($0, /^[^ ,]+/)) {
	    printf("%s", substr($0, 1, RLENGTH))
	    $0 = substr($0, RLENGTH+1)
	} else if ($0 == "") {
	    printf("\n")
	    rc = getline
	}
    }
}
