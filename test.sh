#!/bin/bash

assignmentNumber=$1
eID=$2

if [[ ! (-n "$assignmentNumber" && -n "$eID") ]] ; then
  echo "What is the Assignment Number (1-99)?"
  read assignmentNumber
  echo "What is your eID?"
  read eID
fi

archive="A$assignmentNumber-$eID.jar"

if [[ ! -e "assignments/$archive" ]] ; then
  echo "Error: $archive not found"
  exit
fi

echo "Using $archive";

mkdir -p test
cp assignments/$archive test/
cd test
echo "Extracting .jar"
jar xvf $archive
cd ..

echo "Compiling"
cd test/cs414/a$assignmentNumber/$eID/
javac -cp ../../../../libs/junit-4.10.jar *.java
cd ../../../../

echo "Running JUnit..."
export CLASSPATH=libs/junit-4.10.jar:test
java org.junit.runner.JUnitCore cs414.a$assignmentNumber.$eID.TestAll > results.txt

echo "Results:"
cat results.txt

echo "Cleanup..."
rm -rf test/

