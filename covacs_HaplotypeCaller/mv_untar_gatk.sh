#!/bin/bash
#if the .jar file is not present in the conda_prefix the script search the tar.gz in the conda_prefix of the vm
#and untar the archive
if [ ! -f $CONDA_PREFIX/../../GenomeAnalysisTK.jar ] ; then
        tar -jxvf $CONDA_PREFIX/../../GenomeAnalysis*.tar.bz2 --strip-components=1 -C $CONDA_PREFIX/../../ 2> log_tar

else
        echo GATK is present
fi

