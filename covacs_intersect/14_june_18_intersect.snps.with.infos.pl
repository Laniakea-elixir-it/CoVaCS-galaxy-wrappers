#!/usr/bin/perl -w
#

use strict;


my $f1=shift; #varscan
my $f2=shift; #freebayes
my $f3=shift; #GATK
my $fout=shift;
my %ALL=();
my %L=();
my %H=();

die("non trovo il file $f1") unless -e $f1;
die("non trovo il file $f2") unless -e $f2;
die("non trovo il file $f2") unless -e $f3;

die ("non specificato il file di output") unless $fout;


open(OUT,">$fout.common.snps.vcf");
open(UN,">$fout.unique.snps.vcf");

open(IN,$f1);
while(<IN>)
{
	next if $_=~/^\#/;
	my ($chr,$st,$b1,$b2)=(split())[0,1,3,4];
	my @all_vl=(split(/\t/));
	next unless (length($b1)==length($b2));
	next if ($b1=~/\./ || $b1=~/\-/  || $b2=~/\./ || $b2=~/\-/);
	my @b1=(split('',$b1));
	my @b2=(split('',$b2));
	for (my $i=0;$i<=$#b1;$i++)
	{
		my $lb1=$b1[$i];
                my $lb2=$b2[$i];
		next if $lb1 eq $lb2;
		next if ($lb1=~/\./ || $lb1=~/\-/  || $lb2=~/\./ || $lb2=~/\-/ || $lb2=~/\,/);
                my $lst=$st+$i;
		$all_vl[1]=$lst;
                $all_vl[3]=$lb1;
                $all_vl[4]=$lb2;
                my $J=join("\t",@all_vl);
                $H{$chr}{$lst}{$lb1}{$lb2}++;
                $ALL{$chr}{$lst}{$lb1}{$lb2}=$J;
                push(@{$L{$chr}{$lst}{$lb1}{$lb2}},"VS");
	}
}
close(IN);

open(IN,$f2);
while(<IN>)
{
	next if $_=~/^\#/;
        my ($chr,$st,$b1,$b2)=(split())[0,1,3,4];
	my @all_vl=(split(/\t/));
	next unless (length($b1)==length($b2));
	next if ($b1=~/\./ || $b1=~/\-/  || $b2=~/\./ || $b2=~/\-/);
	my @b1=(split('',$b1));
        my @b2=(split('',$b2));

        for (my $i=0;$i<=$#b1;$i++)
        {
                my $lb1=$b1[$i];
                my $lb2=$b2[$i];
		next if $lb1 eq $lb2;
		next if ($lb1=~/\./ || $lb1=~/\-/  || $lb2=~/\./ || $lb2=~/\-/ || $lb2=~/\,/);
		my $lst=$st+$i;
		$all_vl[1]=$lst;
                $all_vl[3]=$lb1;
                $all_vl[4]=$lb2;
                my $J=join("\t",@all_vl);
                $H{$chr}{$lst}{$lb1}{$lb2}++;
                $ALL{$chr}{$lst}{$lb1}{$lb2}=$J;
                push(@{$L{$chr}{$lst}{$lb1}{$lb2}},"FB");
        }

}
close(IN);

open(IN,$f3);
while(<IN>)
{
        if ($_=~/^\#/)
	{
		print OUT if $_=~/fileformat/;
                print OUT if $_=~/contig/;
                print OUT if $_=~/CHROM/;
                print UN if  $_=~/fileformat/;
                print UN if  $_=~/contig/;
                print UN if  $_=~/CHROM/;
		next;
	}
	my ($chr,$st,$b1,$b2)=(split())[0,1,3,4];
	my @all_vl=(split(/\t/));
	next unless (length($b1)==length($b2));
	next if ($b1=~/\./ || $b1=~/\-/  || $b2=~/\./ || $b2=~/\-/);
	my @b1=(split('',$b1));
        my @b2=(split('',$b2));

        for (my $i=0;$i<=$#b1;$i++)
        {
		my $lb1=$b1[$i];
                my $lb2=$b2[$i];
		next if $lb1 eq $lb2;
	        next if ($lb1=~/\./ || $lb1=~/\-/  || $lb2=~/\./ || $lb2=~/\-/ || $lb2=~/\,/);
                my $lst=$st+$i;
		$all_vl[1]=$lst;
		$all_vl[3]=$lb1;
		$all_vl[4]=$lb2;
		my $J=join("\t",@all_vl);
                $H{$chr}{$lst}{$lb1}{$lb2}++;
                $ALL{$chr}{$lst}{$lb1}{$lb2}=$J;
                push(@{$L{$chr}{$lst}{$lb1}{$lb2}},"GA");
        }
}
close(IN);

foreach my $chr (sort keys %H)
{
	foreach my $s (sort{$a<=>$b} keys %{$H{$chr}})
	{
		foreach my $b1 (keys %{$H{$chr}{$s}})
		{
			foreach my $b2 (keys %{$H{$chr}{$s}{$b1}})
			{
					
				my $vl=$H{$chr}{$s}{$b1}{$b2};
				unless ($H{$chr}{$s}{$b1}{$b2})
				{
					warn("non trovo il numero di occorrenze di $chr $s $b1 $b2\n");
					next;
				}
				my $out_vl=$ALL{$chr}{$s}{$b1}{$b2};
				
				unless ($ALL{$chr}{$s}{$b1}{$b2})
                                {
                                        warn("non trovo le info di $chr $s $b1 $b2\n");
                                        next;
                                }
				my @vls=(split(/\s+/,$out_vl));				
				my $comm=$vls[7];

				if ($vl>=2)
				{
					my $mm=join("_",@{$L{$chr}{$s}{$b1}{$b2}});
                                	my $comm2=$comm;
                                	$comm2.=";NM=$vl;LM=$mm";
                                	$vls[7]=$comm2;
                                	my $out_vl=join("\t",@vls);
                                	print OUT "$out_vl\n";

				}else{
                                        my $mm=$L{$chr}{$s}{$b1}{$b2}[0];
                                	my $comm2=$comm;
                                	$comm2.=";NM=$vl;LM=$mm";
                                	$vls[7]=$comm2;
                                	my $out_vl=join("\t",@vls);
                                	print UN "$out_vl\n";

				}
			}
		}
	}
}

#foreach $V (keys %V)
#{
#	print "$V $V{$V}\n";
#}
