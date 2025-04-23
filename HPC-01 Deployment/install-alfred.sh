#!/bin/bash

mkdir -p ~/install_dir
install_dir=~/install_dir
installation_test_file="$install_dir/installation_test.txt"
cd "$install_dir"

# Install Anaconda
echo
echo -e "${GRN}Installing Anaconda${RST}"
wget https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh 
chmod +x Anaconda3-2024.10-1-Linux-x86_64.sh
./Anaconda3-2024.10-1-Linux-x86_64.sh
echo "Anaconda install completed."

# Install R in Anaconda
echo
echo -e "${GRN}Installing R in Anaconda${RST}"
conda create --name r_env r-essentials r-base
echo "R in Anaconda install completed."

# Install Fastp
echo
echo -e "${GRN}Installing Fastp${RST}"
conda create –name fastp
conda activate fastp
conda install -c bioconda fastpconda install
conda deactivate
echo "Fastp install completed."

# Install Biobakery
echo
echo -e "${GRN}Installing Biobakery${RST}"
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --add channels biobakery
conda create --name biobakery3 python=3.7
echo "Biobakery install completed."

# Install Humann and Metaphlan
echo
echo -e "${GRN}Installing Humann and Metaphlan${RST}"
conda activate biobakery3
conda install -c biobakery humann
conda deactivate
echo "Humann and Metaphlan install completed."

# Install Bracken
echo
echo -e "${GRN}Installing Bracken${RST}"
conda create -n bracken
conda activate bracken
conda install bioconda::bracken
conda deactivate
echo "Bracken install completed."

# Install Kraken2
echo
echo -e "${GRN}Installing Kraken2${RST}"
conda create -n kraken2
conda activate kraken2
conda install bioconda::kraken2
conda deactivate
echo "Kraken2 install completed."

# Install MPA
echo
echo -e "${GRN}Installing MPA${RST}"
conda create -n mpa 
conda activate mpa
conda install mpa-portable -c bioconda
conda deactivate
echo "MPA install completed."

# Install Picrust1
echo
echo -e "${GRN}Installing Picrust1${RST}"
conda create -n picrust1
conda activate picrust1
conda install sjanssen2::picrust1
conda deactivate
echo "Picrust1 install completed."

# Install Picrust2
echo
echo -e "${GRN}Installing Picrust2${RST}"
conda create -n picrust2
conda activate picrust2
conda install bioconda::picrust2

echo
echo "Cleaning up..."
cd ..
rm -rf $install_dir

echo "To test installations:

Biobakery/Humann/Metaphlan:
conda activate biobakery3
humann --help
metaphlan --help

Fastp:
conda activate fastp
fastp --help

Bracken:
conda activate bracken
bracken --help

Kraken2:
conda activate kraken2
kraken2 --help

MPA:
conda activate mpa
mpa-portable 
(should start with "--exec-dir=PATH")

Picrust1:
conda activate picrust1
evalutate_test_datasets.py --help

Picrust2:
conda activate picrust2
picrust2_pipeline.py --help
" > "$installation_test_file"

echo -e "${GRN}Installation test instructions saved to "$installation_test_file"${RST}