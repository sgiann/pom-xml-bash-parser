#this script reads a pom.xml and retrieves the jar files listed in the xml.

#oriinal code taken from:
#http://stackoverflow.com/questions/893585/how-to-parse-xml-in-bash (thank you :)

# Okay so it defines a function called read_dom.
# The first line makes IFS (the input field separator) local to this function and changes it to >. 
# That means that when you read data instead of automatically being split on space, tab or newlines it gets split on '>'.
# The next line says to read input from stdin, and instead of stopping at a newline, stop when you see a '<' character (the -d for deliminator flag).
# What is read is then split using the IFS and assigned to the variable ENTITY and CONTENT. So take the following:

read_dom () {
  local IFS=\>
	read -d \< ENTITY CONTENT
	
}

#in jar-array, 1->groupId, 2->artifactId, 3->version
while read_dom; do
	if [ "$ENTITY" = "groupId" ]
	then
#		echo "groupId= " $CONTENT;
		#$CONTENT=${CONTENT//.//};
		#${CONTENT//.//};
		#echo $CONTENT;

    #turn name into directory (replace dots with /)
		jar[1]=${CONTENT//.//};
#		echo ${jar[1]};
	fi

	if [ "$ENTITY" = "artifactId" ]
	then
#		echo "artifactId= " $CONTENT;
		jar[2]=$CONTENT;
	fi

	if [ "$ENTITY" = "version" ]
	then
#		echo "version= " $CONTENT
#		echo ""
		if [ "$CONTENT" = "\${spring.version}" ]
		then
			CONTENT='3.0.3.RELEASE'
		fi
		jar[3]=$CONTENT;
		echo ${jar[*]};

    #		copy the jar files
    #   argument before "-exec" is the source directory
    #   argument after "-exec" is the destination, you will have to change them
    find /host/Users/Laptop/.m2/repository/${jar[1]} -name "*${jar[3]}*.jar" -exec cp {} /home/stelios/Έγγραφα/script_results \;
	fi

#after "<" is the input file
#run the script in the same directory with the file.
done <bemm20_pom.xml



