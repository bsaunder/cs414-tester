@echo off
set /p assignmentNumber=What is the Assignment Number (1-99)? 
set /p eID=What is your eID? 

echo Testing Archive A%assignmentNumber%-%eID%.jar...

echo Making test Directory...
mkdir test

echo Copying Jar...
copy assignments\A%assignmentNumber%-%eID%.jar test\test.jar

echo Extracting Test Jar...
cd test
jar xvf test.jar
cd ..\

echo Compiling Source...
cd test\cs414\a%assignmentNumber%\%eID%
javac -cp ../../../../libs/junit-4.10.jar;. *.java
cd ..\..\..\..\

echo Running JUnit...
java -cp libs\junit-4.10.jar;test\;. org.junit.runner.JUnitCore cs414.a%assignmentNumber%.%eID%.TestAll > results.txt

echo Results:
type results.txt

echo Cleaning Up...
rmdir /S/Q test

echo Done
