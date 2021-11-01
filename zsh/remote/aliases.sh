# Quick navigation add more here
alias cda="cd ~/git/aladdin"
alias cda2="cd ~/git/aladdin2"
alias cdh="cd ~/git/hydra"
alias cdvad="cd /perish_aml02/$(whoami)/vad_workspace"
alias cde="cd /exp/$(whoami)"
alias cdco="cd /perish_aml02/$(whoami)/coreasr"
alias cdt="cd ~/tb"
alias cdn="cd ~/notebooks"

# Perish machines
alias p1="cd /perish_aml01"
alias p2="cd /perish_aml02"
alias p3="cd /perish_aml03"
alias p4="cd /perish_aml04"
alias p5="cd /perish_aml05"
alias g1="cd /perish_g01"
alias g2="cd /perish_g02"
alias g3="cd /perish_g03"

alias b1="ssh b1"
alias b2="ssh b2"
alias b3="ssh b3"
alias b4="ssh b4"
alias b5="ssh b5"

# Change to aladdin directory and activate SIF
alias msa="make -C /home/$(whoami)/git/aladdin/ shell"
alias msa2="make -C /home/$(whoami)/git/aladdin2/ shell"
# Activate aladdin SIF in current directory
alias msad="/home/$(whoami)/git/aladdin/env/singularity.sh -c "$SHELL""
alias msad2="/home/$(whoami)/git/aladdin2/env/singularity.sh -c "$SHELL""
