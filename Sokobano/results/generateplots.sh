#!/bin/bash
for i in $*; do 
    gpf=$(echo $i | sed -e 's/\.dat$/.gp/');
    output=$(echo $i | sed -e 's/\.dat/.ps/');
    name="Level $( echo $i | sed -e 's/^level//'| sed -e 's/-.*\.dat$//' )"

    echo $name

    echo "" > $gpf
    echo set terminal postscript color solid >> $gpf
    echo set xlabel \"Depth\" >> $gpf
    echo set ylabel \"States\" >> $gpf
    echo set title \"$name\" >> $gpf
    echo set output \"${output}\" >> $gpf
    echo plot \\ >> $gpf
    echo "\"$i\" using (\$1):(\$2>0 ? \$2 : 1/0) title \"BFSolver\" with lines lw 3, "\\>> $gpf
    echo "\"$i\" using (\$1):(\$3>0 ? \$3 : 1/0) title \"A(i)\" with lines lw 3, " \\>> $gpf
    echo "\"$i\" using (\$1):(\$4>0 ? \$4 : 1/0) title \"A(+{c,i})\" with lines lw 3, " \\>> $gpf
    echo "\"$i\" using (\$1):(\$5>0 ? \$5 : 1/0) title \"A(+{c,i,4})\" with lines lw 3, " \\>> $gpf
    echo "\"$i\" using (\$1):(\$6>0 ? \$6 : 1/0) title \"A(+{*{i,i},c,4})\" with lines lw 3, " \\>> $gpf
    echo "\"$i\" using (\$1):(\$7>0 ? \$7 : 1/0) title \"A(+{*{s,s},c,4})\" with lines lw 3, " \\>> $gpf
    echo "\"$i\" using (\$1):(\$8>0 ? \$8 : 1/0) title \"A(+{*{B,B,s,s},c,4})\" with lines lw 3, "  \\>> $gpf
    echo "\"$i\" using (\$1):(\$9>0 ? \$9 : 1/0) title \"A(+{*{B,B,a,a},c,4})\" with lines lw 3, " \\>> $gpf
    echo "\"$i\" using (\$1):(\$10>0 ? \$10 : 1/0) title \"A(rand)\" with lines lw 3" >> $gpf
    echo reset >> $gpf

    gnuplot $gpf

done

