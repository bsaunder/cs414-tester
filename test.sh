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

exit

echo "Using $archive";

mkdir -p test
cp assignments/$archive test/
chdir test
echo "Extracting .jar"
jar xvf $archive
chdir ..

echo "Compiling"
javac -cp 'libs;tests/cs414/a$assignmentNumber/$eID/' \
  tests/cs414/a$assignmentNumber/$eID/*.java

echo "Running JUnit..."
java -cp 'libs;tests/cs414/a$assignmentNumber/$eID/' \
  org.junit.runner.JUnitCore \
  cs414.a$assignmentNumber.$eID.TestAll \
  > results.txt

echo "Results:"
cat results.txt

echo "Cleanup..."
rm -rf test/cs414

