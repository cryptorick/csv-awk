# csv2.awk: convert csv data to tab-separated

BEGIN {
    rc = getline
    while (rc > 0) {
	if (eat(" +")) {                   # leading blanks
	    /* just strip, no output */
	} else if (eat(",")) {             # a comma 
	    printf("\t")
	} else if (eat("\"[^\"]*\""))  {   # a quoted string
	    printf("%s", substr(eaten, 2, length(eaten)-2))
	    # possibly with an embedded "", representing a single "
	    while (eat("\"[^\"]*\"")) 
		printf("\"%s", substr(eaten, 2, length(eaten)-2))
	} else if (eat("[^,]+")) {         # a non-quoted string
	    sub(/ +$/, "", eaten)  # strip any trailing blanks
	    printf("%s", eaten)
	} else if ($0 == "") {             # end of line
	    printf("\n")
	    rc = getline
	}
    }
}
# eat: try to remove match of regular expression re at start of $0
# If a match, save the matched string in global variable "eaten" and return 1
# otherwise return 0
function eat(re) {
    if (match($0, "^" re)) {
	eaten = substr($0, 1, RLENGTH)
	$0 = substr($0, RLENGTH+1)
	return 1
    } else {
	return 0
    }
}
