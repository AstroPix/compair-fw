
if [[ ! -f .venv/bin/activate ]]
then
    python3 -m venv .venv
fi
source .venv/bin/activate
.venv/bin/pip3 install -r requirements.txt

export PYTHONPATH=$(readlink -e ../):$(readlink -e ../../vendor/icflow_hdl_240807/hdl_rfg_v1/python):$(readlink -e ../../rtl/top):$PYTHONPATH
