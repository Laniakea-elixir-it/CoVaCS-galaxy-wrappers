#!/usr/bin/perl -w
#
$f=shift;
$out=shift;
open(IN,$f);
open(OUT,">$out");
while(<IN>)
{
	if ($_=~/^#/)
	{
		print OUT;
		next;
	}else{
		$vl=(split())[5];
		$gt=(split())[-1];
		$gt=(split(/\:/,$gt))[0];
		next if $gt eq "0/0";
		print OUT  if $vl>20;
	}
}
close(OUT);
