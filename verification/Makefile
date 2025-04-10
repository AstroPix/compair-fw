

## Cocotb + python setup
cocotb: .venv/bin/cocotb-config
.venv/bin/cocotb-config: .venv/bin/activate
	@.venv/bin/pip3 install -r requirements.txt
.venv/bin/activate:
	@python3.12 -m venv .venv

## Linting
export BASE=$(PWD)/../
lint:
	rm -Rf xcelium.d
	xrun -sv -hal -gui +define+RFG_FW_ID=1 +define+RFG_FW_BUILD=1 -timescale 1ns/10ps -f $(BASE)/rtl/top/astep24_3l_top.f -rulefile $(BASE)/verification/lint/cadence.lint.rules \
							-XMB_Filter tag=DLNCML \
							-XMB_Filter tag=SPDUSD \
							-XMB_Filter tag=DSEMEL \
							-XMB_Filter tag=MACCDF \
							-XMB_Sortby severity -TOP astep24_3l_top
