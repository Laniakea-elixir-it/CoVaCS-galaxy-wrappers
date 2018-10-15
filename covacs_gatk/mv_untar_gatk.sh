#!/bin/bash
#if the .jar file is not present in the conda_prefix the script search the tar.gz in the conda_prefix of the vm
#and untar the archive
if [[ ! -f $CONDA_PREFIX/../../GenomeAnalysisTK.jar ]] ; then
	tar -zxvf $CONDA_PREFIX/../../GenomeAnalysis*.tar.gz -C $CONDA_PREFIX/../../ 
	
else
	echo GATK is present
fi
