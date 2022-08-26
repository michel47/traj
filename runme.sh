#
snlog=$HOME/.local/share/mutables/sname.log
tail -4096 $snlog > sname4096.log
ots stamp sname4096.log
otid=$(openssl sha256 -r sname4096.log| cut -c-12)
tic=$(date +%s)
yest=$(echo  "scale=0; $tic - 3600 * 24 * 4/3" | bc -q)
echo yest: $yest
perl -S sname2dot.pl sname4096.log $yest;
dot -Tsvg sname.dot -o sname.svg
date=$(date -d @$yest);
git add sname4096.log sname4096.log.ots sname.svg
git commit -a -m "$otid: sname cd'd from $date on"
cp -p sname.svg $HOME/knowledge/public/
