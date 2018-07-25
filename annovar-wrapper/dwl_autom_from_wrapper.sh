#/bin/bash
#bash script to download autamatically from the wrapper the database of annovar
echo start &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar gnomad_genome $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar exac03 $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar 1000g2015aug $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar avsnp150 $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar clinvar_20170905 $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar cosmic70 $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar dbnsfp33a $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar esp6500_all $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar kaviar_20150923 $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar knownGene $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar mitimpact2 $CONDA_PREFIX/../../annovar/humandb &&
perl $CONDA_PREFIX/../../annovar/annotate_variation.pl  -downdb -buildver hg19 -webfrom annovar refGene $CONDA_PREFIX/../../annovar/humandb &&
echo end
