tell application "BBEdit"
	activate
	replace " ... " using "\\r" searching in text 1 of text document 1 options {search mode:literal, starting at top:true, wrap around:false, backwards:false, case sensitive:false, match words:false, extend selection:false}
	replace "..." using "" searching in text 1 of text document 1 options {search mode:literal, starting at top:true, wrap around:false, backwards:false, case sensitive:false, match words:false, extend selection:false}
	replace "-\\r" using "\\r" searching in text 1 of text document 1 options {search mode:literal, starting at top:true, wrap around:false, backwards:false, case sensitive:false, match words:false, extend selection:false}
	replace ", " using "\\r" searching in text 1 of text document 1 options {search mode:literal, starting at top:true, wrap around:false, backwards:false, case sensitive:false, match words:false, extend selection:false}
	replace "[" using "" searching in text 1 of text document 1 options {search mode:literal, starting at top:true, wrap around:false, backwards:false, case sensitive:false, match words:false, extend selection:false}
	replace "]" using "" searching in text 1 of text document 1 options {search mode:literal, starting at top:true, wrap around:false, backwards:false, case sensitive:false, match words:false, extend selection:false}
	replace "(.*)\\r" using "\\t\\t<string>\\1</string>\\r" searching in text 1 of text document 1 options {search mode:grep, starting at top:true, wrap around:false, backwards:false, case sensitive:false, match words:false, extend selection:false}
end tell
