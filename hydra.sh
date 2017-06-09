./compile_of_crap Tests/mytest.min > thang.mil
for ((i = 1; i <= $1; i++));
do
	cp thang.mil $ithang$i.mil
done
git add -f *.mil*
git commit -m 'Hail fucking hydra!'
git push
