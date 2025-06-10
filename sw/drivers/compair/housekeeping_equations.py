import math

def convert(adc_num,channel,adc_code):
    value = hk_converter_list[adc_num][channel][3](adc_code)
    return value

def get_info(adc_num,channel):
    units = hk_converter_list[adc_num][channel][2]
    shortname = hk_converter_list[adc_num][channel][1]
    return (units, shortname)

# [nominal, shortname, units, conversion(x)]
#Compute scaler once not every call
# HK Vmon standard = 47.5k / 2.7k voltage div into non inverting opamp Rg=14.7k, Rf=47.5k
# HK Vmon 12vin = 243k / 2.7k voltage div into non inverting opamp Rg=14.7k, Rf=47.5k
# All imon parts have gain of 200
# HV vmon is 10G / 1M voltage div into 10x diffamp to reference voltage 0 or 1.8
#temp mon ics = LM94021 with G00 , #solve for T, x = 870.6e-3 - 5.506e-3 * (T - 30) - 0.00176e-3 * (T-30)**2
hk_vmon_scale_standard = (3.3/4095) * 1/(2.7/(2.7+47.5) * (1 + 47.5/14.7))
hk_vmon_scale_12vin    = (3.3/4095) * 1/(2.7/(2.7+243) * (1 + 47.5/14.7))
hk_imon_scale_3mohm = (3.3/4095) * 1/(3e-3*200)
hk_imon_scale_5mohm = (3.3/4095) * 1/(5e-3*200)
hk_vmon_scale_hvbias = (3.3/4095) * 1/(1e6/(1e6+10e9)*10)
hk_imon_scale_hvbias = (3.3/4095) * 1/(49.9*200)


hk_converter_list = [                                           
    [1.8,	    "vmon_D1p8",    "V", lambda x:(x * hk_vmon_scale_standard)   ],  
    [1, 	    "vmon_D1p0",    "V", lambda x:(x * hk_vmon_scale_standard)   ],  
    [1.2,  	    "vmon_A1p2",    "V", lambda x:(x * hk_vmon_scale_standard)  ],  
    [1.8,  	    "vmon_A1p8",    "V", lambda x:(x * hk_vmon_scale_standard)  ],  
    [3,  	    "imon_D1p8",    "A", lambda x:(x * hk_imon_scale_3mohm) ],  
    [1,  	    "imon_A1p2",    "A", lambda x:(x * hk_imon_scale_5mohm  ) ],  
    [1,  	    "imon_A1p8",    "A", lambda x:(x * hk_imon_scale_5mohm  ) ],  
    [.5,  	    "imon_D1p0",    "A", lambda x:(x * hk_imon_scale_5mohm  ) ],  
],[
    [12,	    "vmon_in",      "V", lambda x:(x * hk_vmon_scale_12vin)   ],  
    [1, 	    "imon_in",      "A", lambda x:(x * hk_imon_scale_3mohm) ],  
    [5,	        "vmon_5p0",     "V", lambda x:(x * hk_vmon_scale_standard)    ],  
    [2,	        "imon_5p0",     "A", lambda x:(x * hk_imon_scale_5mohm ) ],  
    [3.3,	    "vmon_D3p3",    "V", lambda x:(x * hk_vmon_scale_standard)   ],  
    [.5,	    "imon_D3p3",    "A", lambda x:(x * hk_imon_scale_5mohm  ) ],  
    [350,	    "bias_vmon",    "V", lambda x:(x * hk_vmon_scale_hvbias)    ],  
    [4e-9,	    "bias_imon",    "A", lambda x:(x * hk_imon_scale_hvbias ) ]

],[   
    [25,	    "THERM_A1",     "C", lambda x:(-1)],   
    [25,	    "THERM_A2",     "C", lambda x:(-1)],   
    [25,	    "w1_testpoint",   "V", lambda x:(3.3/4095 * x)],    
    [25,	    "tmon_fee_top_left",        "C", lambda x:(5/44 * (-13501 + 5 * math.sqrt(9111265 - 1760000*x*3.3/4095)))],    
    [25,	    "tmon_fee_bottom_left",        "C", lambda x:(5/44 * (-13501 + 5 * math.sqrt(9111265 - 1760000*x*3.3/4095)))],
    [25,	    "THERM_A3",     "C", lambda x:(-1)],   
    [25,	    "THERM_A4",     "C", lambda x:(-1)],   
    [25,	    "THERM_A5",     "C", lambda x:(-1)]   
]