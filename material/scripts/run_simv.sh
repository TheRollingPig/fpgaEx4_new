# setup environment
export DEBUSSY_HOME=/opt/synopsys/Verdi3_L-2016.06-SP1-1
export DEBUSSY_LIB=$DEBUSSY_HOME/share/PLI/VCS/linux64
export LD_LIBRARY_PATH=${DEBUSSY_HOME}/share/PLI/lib/linux64:$DEBUSSY_LIB:$LD_LIBRARY_PATH

cd ../sim/sim_vcs

./ simv
