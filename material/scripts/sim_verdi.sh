# setup environment
export DEBUSSY_HOME=/opt/synopsys/Verdi3_L-2016.06-SP1-1
export DEBUSSY_LIB=$DEBUSSY_HOME/share/PLI/VCS/linux64
export LD_LIBRARY_PATH=${DEBUSSY_HOME}/share/PLI/lib/LINUX:$DEBUSSY_LIB:$LD_LIBRARY_PATH

mkdir ../sim/sim_verdi
cd ../sim/sim_verdi

vericom -f ../../rtl/rtl.f
vericom +v2k -f ../../sim/sim.f

verdi -top tbench -lib work -L work -workMode testbenchDebug -ssf ../sim_vcs/baxi.fsdb -logfile log.txt

