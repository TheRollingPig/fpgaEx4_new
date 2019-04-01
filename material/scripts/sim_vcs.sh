# setup environment
export DEBUSSY_HOME=/opt/synopsys/Verdi3_L-2016.06-SP1-1
export DEBUSSY_LIB=$DEBUSSY_HOME/share/PLI/VCS/linux64
export LD_LIBRARY_PATH=${DEBUSSY_HOME}/share/PLI/lib/linux64:$DEBUSSY_LIB:$LD_LIBRARY_PATH

mkdir ../sim/sim_vcs
cd ../sim/sim_vcs

vlogan -full64 -timescale=1ns/1ps -f ../../rtl/rtl.f
vlogan -full64 +v2k -timescale=1ns/1ps -f ../../sim/sim.f

vcs +notimingchecks +nospecify -debug_access+all -fsdb -P $DEBUSSY_LIB/novas.tab $DEBUSSY_LIB/pli.a -full64 tbench
