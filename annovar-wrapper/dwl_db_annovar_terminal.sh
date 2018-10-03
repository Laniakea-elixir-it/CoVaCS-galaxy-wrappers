#/bin/bash
#bash script to download  from the terminal the database of annovar launch in /annovar
echo start &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar gnomad_genome humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar exac03 humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar 1000g2015aug humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar avsnp150 humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar clinvar_20180603 humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar cosmic70 humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar dbnsfp33a humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar esp6500_all humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar kaviar_20150923 humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar knownGene humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar mitimpact2 humandb &&
perl annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar refGene humandb &&
echo end
