#!/usr/bin/perl -w
$f=shift;
$outfile=shift;
open(OUT,">$outfile");	
open(IN,$f);
$head=<IN>;
print OUT $head;
while(<IN>)
{
	if ($_=~/^\#/)
	{
		print OUT;
		next;
	}
	$v=(split())[-1];
	@vl=(split(/\:/,$v));
	$vt=$vl[2];
	if ($vt>=10)
	{
		print OUT;
	}
}
