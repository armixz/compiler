JAVA=java
JAVAC=javac
JFLEX=$(JAVA) -jar lib/jflex-full-1.8.2.jar
CUPJAR=./lib/java-cup-11b.jar
CUP=$(JAVA) -jar $(CUPJAR)
CP=.:$(CUPJAR)
TEST=tests

default: run

run: test 

.SUFFIXES: $(SUFFIXES) .class .java

.java.class:
		$(JAVAC) -cp $(CP) $*.java

FILE= Lexer.java Parser.java sym.java LexerTest.java ScannerTest.java \
		Token.java Program.java \
		StatementList.java Statement.java IfStatement.java WhileStatement.java ReturnStatement.java \
		AssignmentStatement.java LibraryFunctionStatement.java CallStatement.java SuffixStatement.java ScopeStatement.java \
		FunctionList.java ArgumentList.java ReadList.java PrintList.java \
		Expression.java BinaryExpression.java UnaryExpression.java ParenExpression.java CastExpression.java \
		OperandExpression.java CallExpression.java TernaryExpression.java \
		Type.java Name.java ElseClause.java 

all: Lexer.java Parser.java $(FILE:java=class)

test: all
		$(JAVA) -cp $(CP) ScannerTest tests/$(TEST).txt > tests/$(TEST)-output.txt
		cat tests/$(TEST).txt
		cat -n tests/$(TEST)-output.txt

lex-test: all
		$(JAVA) -cp $(CP) LexerTest tests/$(TEST).txt > tests/$(TEST)-output.txt
		cat tests/$(TEST).txt
		cat -n tests/$(TEST)-output.txt

clean:
		rm -f *.class *~ *.bak Lexer.java Parser.java sym.java

Lexer.java: tokens.jflex
		$(JFLEX) tokens.jflex

Parser.java: grammar.cup
		$(CUP) -parser Parser -interface < grammar.cup
