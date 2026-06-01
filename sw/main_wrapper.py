import subprocess
import os

## injection runs over all pixels
# for chip in [0,1,2,3]:
#     for row in range(35):
#         for col in range(35):
#             subprocess.run([
#                 'python', 'main.py',
#                 '-y', 'quadchip_1px_all_on_mask_hot_copy',
#                 '-c', '4',
#                 '-l', '13',
#                 '-T', '0.25',
#                 '-i', '13', f'{chip}', f'{row}', f'{col}',
#                 '-o', f'{os.getcwd()}{os.path.sep}data{os.path.sep}Grant_Scan_4-15-26{os.path.sep}c{chip}_r{row}_c{col}'
#             ])


## noise run over all rows and all columns seperately
for chip in [0]:
    for row in range(35):
        subprocess.run([
            'python', 'main.py',
            '-y', 'quadchip_1px_all_on_mask_hot_copy',
            '-c', '4',
            '-l', '13',
            '-T', '5',
            '-er', '13', f'{chip}', f'{row}',
            '-o', f'{os.getcwd()}{os.path.sep}data{os.path.sep}Grant_Noise_Scan_4-29-26{os.path.sep}r{row}'
        ])

for chip in [0]:
    for col in range(3,35):
        subprocess.run([
            'python', 'main.py',
            '-y', 'quadchip_1px_all_on_mask_hot_copy',
            '-c', '4',
            '-l', '13',
            '-T', '5',
            '-er', '13', f'{chip}', f'{col}',
            '-o', f'{os.getcwd()}{os.path.sep}data{os.path.sep}Grant_Noise_Scan_4-29-26{os.path.sep}c{col}'
        ])