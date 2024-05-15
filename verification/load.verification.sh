pushd $(dirname "$(readlink -f ${BASH_SOURCE[0]})")
icf_venv
source .venv/bin/activate
popd