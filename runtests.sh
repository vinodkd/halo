if [[ -e testoutput.log ]]; then
	rm testoutput.log
fi
touch testoutput.log
echo "Starting test run at `date`."
for f in test/*; do
	echo $f : test started.
	halo $f >> testoutput.log
	ret=$?
	# echo $ret
	if [[ $ret != 0 ]]; then
		echo $f : test failed. Error code = $ret.
	else
		echo $f : test succeeded.
	fi
done
echo "Ending test run at `date`."
