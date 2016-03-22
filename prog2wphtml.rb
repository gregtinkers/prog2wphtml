# the constants
ANNOTATED_INPUT_FILE = "myprogram.py"
PROGRAM_OUT = 'myprogram_code.py'
HTML_CODE_OUT = 'myprogram_wphtml.txt'
INLINE_CODE_TITLE = "\"Myprogram Heading\""
LANGUAGE = "\"python\""

#- Enter appropriate values for your program. These are constants because you will be running the program multiple times and it is a pain to have to enter command line options that are complex.

def adj_lineno(line,in_no,out_no)
	line.gsub!(/\b(line|Line)s?\b\s*(\d*)/) { |line_and_no|  # matches in the format "line 999"
		num = line_and_no.match(/(\d+)/)  # extracts the line number
		num.pre_match <<(num[1].to_i - (in_no - out_no)).to_s unless num.nil?
	}
	line
end

#- this method adjusts any line numbers in the annotation to match the lines in the program_out file 

# open the files
annotated_source = File.open(ANNOTATED_INPUT_FILE)
# open a file for writing the program
prog_out = File.open(PROGRAM_OUT,'w')
# open a file for writing the html code
wphtml_out = File.open(HTML_CODE_OUT,'w')

in_line_no = 0
out_line_no = 1
note_line = 0

#start the code output
wphtml_out.print("[sourcecode language=#{LANGUAGE} title=#{INLINE_CODE_TITLE} firstline=#{out_line_no}]\n")
annotating = false
removing_blank_lines = false
annotated_source.readlines.each do |line|
	in_line_no += 1
	if ln = line.match(/^(#-|\/\/-) /) # is it a notation?
		# complete the html 
		wphtml_out.print("[/sourcecode]\n") unless (out_line_no == 1) or (annotating)
		#write the notation
		wphtml_out.print adj_lineno(ln.post_match,in_line_no - note_line,out_line_no)<<' '
		#remember that annotating has started
		annotating = true
		note_line += 1
	else
		note_line = 0
		if (line.chomp.strip == '')   #only put one blank line out between code segments
			if !removing_blank_lines
				removing_blank_lines = true
				# write a blank line to both files
				prog_out.print line
				wphtml_out.print line
				out_line_no += 1
			end
		else
			removing_blank_lines = false
			prog_out.print line
			wphtml_out.print line
			out_line_no += 1
		end
		# are we back to program code?
		if annotating 
			wphtml_out.print("<hr>\n\n[sourcecode language=#{LANGUAGE} title=#{INLINE_CODE_TITLE} firstline=#{out_line_no}]\n")
			annotating = false
		end
	end
end

wphtml_out.print("[/sourcecode]") unless (out_line_no == 1) or (annotating)
wphtml_out.print("\n<hr>") unless (out_line_no == 1)

annotated_source.close
prog_out.close
wphtml_out.close			
