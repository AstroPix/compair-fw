pushd $(dirname "$(readlink -f ${BASH_SOURCE[0]})")
if [[ ! -f .venv/bin/cocotb-config ]]
then
    make cocotb
fi
source .venv/bin/activate
popd