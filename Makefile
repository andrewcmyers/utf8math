default: utf8.sty testutf8.pdf
clean:
	rm -f utf8.sty testutf8.pdf testutf8.dvi

makeutf8/Main.class: makeutf8/Main.java
	javac makeutf8/Main.java
utf8.sty: utf8.table makeutf8/Main.class
	java -cp . makeutf8.Main
testutf8.pdf: utf8.sty testutf8.tex
	pdflatex testutf8.tex
