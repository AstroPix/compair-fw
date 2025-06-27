def convert(adc_num,channel,adc_code):
    value = hk_converter_list[adc_num][channel][3](adc_code)
    return value

def get_info(adc_num,channel):
    units = hk_converter_list[adc_num][channel][2]
    shortname = hk_converter_list[adc_num][channel][1]
    return (units, shortname)

# [nominal, shortname, units, conversion(x)]
hk_converter_list = [
    [1.8,	    "vmon_D1p8",    "V", lambda x:(x* (3.3/4095) * 1/(2.7/(2.7+47.5) * (1 + 47.5/14.7)))   ],  
    [1, 	    "vmon_D1p0",    "V", lambda x:(x* (3.3/4095) * 1/(2.7/(2.7+47.5) * (1 + 47.5/14.7)))   ],  
    [1.2,  	    "vmon_A1p2",    "V", lambda x:(x* (3.3/4095) * 1/(2.7/(2.7+47.5) * (1 + 47.5/14.7)))   ],  
    [1.8,  	    "vmon_A1p8",    "V", lambda x:(x* (3.3/4095) * 1/(2.7/(2.7+47.5) * (1 + 47.5/14.7)))   ],  
    [3,  	    "imon_D1p8",    "A", lambda x:(x* (3.3/4095) * 1/(3e-3*200)  ) ],  
    [1,  	    "imon_A1p2",    "A", lambda x:(x* (3.3/4095) * 1/(5e-3*200)  ) ],  
    [1,  	    "imon_A1p8",    "A", lambda x:(x* (3.3/4095) * 1/(5e-3*200)  ) ],  
    [.5,  	    "imon_D1p0",    "A", lambda x:(x* (3.3/4095) * 1/(5e-3*200)  ) ],  
],[
    [12,	    "vmon_in",      "V", lambda x:(x* (3.3/4095) * 1/(2.7/(2.7+243) * (1 + 47.5/14.7)))   ],  
    [1, 	    "imon_in",      "A", lambda x:(x* (3.3/4095) * 1/(3e-3*200)  ) ],  
    [5,	        "vmon_5p0",     "V", lambda x:(x* (3.3/4095) * 1/(2.7/(2.7+47.5) * (1 + 47.5/14.7)))   ],  
    [2,	        "imon_5p0",     "A", lambda x:(x* (3.3/4095) * 1/(5e-3*200)  ) ],  
    [3.3,	    "vmon_D3p3",    "V", lambda x:(x* (3.3/4095) * 1/(2.7/(2.7+47.5) * (1 + 47.5/14.7)))   ],  
    [.5,	    "imon_D3p3",    "A", lambda x:(x* (3.3/4095) * 1/(5e-3*200)  ) ],  
    [350,	    "bias_vmon",    "V", lambda x:(x* (3.3/4095) * 1/(1000000/(1000000+10000000000)*10))   ],  
    [4e-9,	    "bias_imon",    "A", lambda x:(x* (3.3/4095) * 1/(49.9*200)  ) ]

],[   
    [25,	    "THERM_A1",     "C", lambda x:(-1)],   
    [25,	    "THERM_A2",     "C", lambda x:(-1)],   
    [25,	    "thermistor",   "C", lambda x:(-1)],    
    [25,	    "temp2",        "C", lambda x:(-1)],    
    [25,	    "temp3",        "C", lambda x:(-1)],    
    [25,	    "THERM_A3",     "C", lambda x:(-1)],   
    [25,	    "THERM_A4",     "C", lambda x:(-1)],   
    [25,	    "THERM_A5",     "C", lambda x:(-1)]   
]