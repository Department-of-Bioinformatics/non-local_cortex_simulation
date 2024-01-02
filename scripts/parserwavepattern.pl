#!/usr/bin/perl
use warnings; 
use strict; 


my @data=("wavepattern00.csv","wavepattern11.csv","wavepattern22.csv","wavepattern33.csv","wavepattern44.csv","wavepattern55.csv","eegsignal.csv","eegsignal2.csv","eegsignal3.csv","eegsignal4.csv","eegsignal5.csv","eegsignal6.csv");
my @wave=("wavepattern00.txt","wavepattern01.txt","wavepattern02.txt","wavepattern03.txt","wavepattern04.txt","wavepattern05.txt","eegsignal.txt","eegsignal2.txt","eegsignal3.txt","eegsignal4.txt","eegsignal5.txt","eegsignal6.txt");
my $zahl=0; 
my $count=0;
my $count2 = 0;
foreach (@data)
{
	open (F1,"$_")||die "require a filename:$!";
	open (my $wavepattern, ">$wave[$zahl]")||die "cannot open wavepattern:$!";
	print "$wave[$zahl]\n";
	while (my $line=<F1>)
	{
		chomp $line;
		$line=~s/,/\t/g;
		$line=~s/"//g;
		my @t=split("\t",$line);
		if ($count2 >= 2)
		{
			my @ar;
			for my $a (@t)
  			{
				if ($a=~/^-?(0|([1-9][0-9]*))(\.[0-9]*)?([eE][-+]?[0-9]*)?$/)
				{
					if ($a eq '') { push(@ar, "0"); }
					else { push(@ar, "$a"); }
				}
			}
			my $xaxis = shift(@ar);
			my $yaxis = shift(@ar);
			print $wavepattern "$xaxis;$yaxis\n";
			$count++;
		}
		if ( $line =~ /pen down/) { $count2++; }
	}
	$count2 = 0;
	print "$count\n"; 
	close F1;
	close $wavepattern;
	$zahl++;
}



