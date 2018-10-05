#!/usr/bin/perl -w
#
use strict;

my $f1=shift;	#vcf di varscan
my $f2=shift;   #vcf di freebayes
my $f3=shift;   #vcf di GATK
my $fout=shift;

die("non trovo il file $f1") unless -e $f1;
die("non trovo il file $f2") unless -e $f2;
die("non trovo il file $f2") unless -e $f3;

die ("non specificato il file di output") unless $fout;

my %ALL=();
my %L=();
my %H=();

open(OUT,">$fout.common.indels.vcf");
open(UN,">$fout.unique.indels.vcf");

open(IN,$f1);
while(<IN>)
{
	next if $_=~/^\#/;
	my ($chr,$st,$b1,$b2)=(split())[0,1,3,4];
	my $sum=length($b1)+length($b2);
	next if $sum<=2;
	next if (length($b1)==length($b2) && !($b1=~/\-/ || $b2=~/\-/ || $b1=~/\./ || $b2=~/\./) );
	$H{$chr}{$st}++;
	$ALL{$chr}{$st}=$_;
	push(@{$L{$chr}{$st}},"VS");
}
close(IN);

open(IN,$f2);
while(<IN>)
{
	next if $_=~/^\#/;
        my ($chr,$st,$b1,$b2)=(split())[0,1,3,4];
	my $sum=length($b1)+length($b2);
        next if $sum<=2;
        next if (length($b1)==length($b2) && !($b1=~/\-/ || $b2=~/\-/ || $b1=~/\./ || $b2=~/\./) );
       	$H{$chr}{$st}++;
	$ALL{$chr}{$st}=$_;
	push(@{$L{$chr}{$st}},"FB");
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
        my $sum=length($b1)+length($b2);
        next if $sum<=2;
	next if (length($b1)==length($b2) && !($b1=~/\-/ || $b2=~/\-/ || $b1=~/\./ || $b2=~/\./) );
        $H{$chr}{$st}++;
        $ALL{$chr}{$st}=$_;
	push(@{$L{$chr}{$st}},"GA");
}
close(IN);


foreach my $chr (sort keys %H)
{
	foreach my $s (sort{$a<=>$b} keys %{$H{$chr}})
	{
			my $vl=$H{$chr}{$s};
			unless ($vl)
			{
				warn("non so contare le occorrenze di $chr $s\n");
				next;
			}
			my $out_vl=$ALL{$chr}{$s};
			unless ($out_vl)
			{
				warn("non so trovare le info di $chr $s\n");
				next;
			}
			my @outs=(split(/\t/,$out_vl));
			my $comm=$outs[7];
			if ($vl>=2)
			{
				my $mm=$L{$chr}{$s} ? join("_",@{$L{$chr}{$s}}) : "NA";
				my $comm2=$comm;
				$comm2.=";NM=$vl;LM=$mm";
				$outs[7]=$comm2;
				$out_vl=join("\t",@outs);
				print OUT $out_vl;
			}else{
                                my $mm=$L{$chr}{$s} ? $L{$chr}{$s}[0] : "NA";
                                my $comm2=$comm;
                                $comm2.=";NM=$vl;LM=$mm";
                                $outs[7]=$comm2;
                                $out_vl=join("\t",@outs);
                                print UN $out_vl;
			}
	}
}
