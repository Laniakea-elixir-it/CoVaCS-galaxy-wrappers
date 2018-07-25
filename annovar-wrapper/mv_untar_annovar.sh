#!/bin/bash
#if the symbolic link is not present in the conda env of annovar the script search the tar.gz in the _conda prefix of the vm untar 
#the archive and make a symbolic link of the directory in the conda env
if [[ ! -d $CONDA_PREFIX/annovar ]] ; then
	tar -zxvf $CONDA_PREFIX/../../annovar.latest.tar.gz -C $CONDA_PREFIX/../../ &&
	echo start untar &&
	ln -s $CONDA_PREFIX/../../annovar $CONDA_PREFIX &&
	echo all done
else
	echo annovar was present
fi
