#!/bin/bash
#if the symbolic link is not present in the conda env of annovar the script search the tar.gz in the _conda prefix of the vm untar 
#the archive and make a symbolic link of the directory in the conda env
if [[ ! -d $CONDA_PREFIX/GATK* ]] ; then
	tar -zxvf $CONDA_PREFIX/../../GenomeAnalysis*.tar.gz -C $CONDA_PREFIX/../../ &&
	ln -s $CONDA_PREFIX/../../GA* $CONDA_PREFIX 
	
else
	echo annovar was present
fi