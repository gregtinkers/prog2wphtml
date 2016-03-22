= prog2wphtml.rb

== Description

Wordpress.com has a rudimentary tool for publishing program code in a blog. If you want to divide your program into small segments and provide an explaination of the code's function, you can use the [sourcecode] tag for your code. The problem is that any change requires renumbering all the following [sourcecode] tags to match the new line numbering. 

The input to prog2wphtml.rb is a file of code that contains the annotations within. Start the annotation lines with a #- or //- . That is, your language's comment character(s) followed by a dash and and space.

== Usage

Copy prog2wphtml.rb into the same directory as your program and modify the first few lines to reflect your files, like this:
    ANNOTATED_INPUT_FILE = "myprogram.py"
    PROGRAM_OUT = 'myprogram_code.py'
    HTML_CODE_OUT = 'myprogram_wphtml.txt'
    INLINE_CODE_TITLE = "\"myprogram heading\""
    LANGUAGE = "\"python\""

When you run prog2wphtml.rb with ruby, the myprogram_code file will contain a *clean* version of your program without the annotation. The myprogram_wphtml.txt file will contain the html code to paste into WordPress. All of the line numbers in the Wordpress html will match the clean code. 


== Example:

The myprogram.py file with annotation:

    import time
    import math
    import datetime
    import cv2

    #- The program starts with the import of packages used.

    def my_method( var1, var2)
    ...
    end

    #- Define a method to do something

The myprogram_wphtml.txt file after running prog2wphtml.rb

    [sourcecode language="python" title="Myprogram Heading" firstline=1]
    import time
    import math
    import datetime
    import cv2
    
    [/sourcecode]
    The program starts with the import of packages used.
     <hr>
    
    [sourcecode language="python" title="Myprogram Heading" firstline=6]
    def my_method( var1, var2)
      ...
    end
    
    [/sourcecode]
    Define a method to do something 
    <hr>

The myprogram_code.py file after running prog2wphtml.rb

    import time
    import math
    import datetime
    import cv2
    
    def my_method( var1, var2)
      ...
    end

== Referencing line numbers

You can include references to lines with in your annotated code using *line * followed by a number. For example if a annotation referred to line 435 in the annotated file, something like: <i>Note that removing line 435 will cause the internet to crash.</i> the 435 would be adjusted to the correct line number in the myprogram_code file.

== License:

(The MIT License)

Copyright (c) 2016 Greg Barbu

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
