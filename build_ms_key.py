import os
import json

rawdir = '/idia/projects/llus/raw/SCI-20251201-DP-01/'
projkey = 'SCI-20251201-DP-01'
for dirpath, dirnames, filenames in os.walk(rawdir):
    for thisfile in filenames:
        if thisfile == 'complete.json':
            with open(dirpath + '/' + thisfile,'r') as f:
                result = json.load(f)
                msfilename = result['meerkat_metadata']['MVF2MS_arguments']['-o']
                msdir = msfilename.split('-')[0]
                try:
                    targstr = result['meerkat_metadata']['MVF2MS_arguments']['--target']
                except KeyError:
                    targstr = ('NOTARGET')
                targstr = targstr.replace("'","").replace(" ","").lower()
                ms = f'raw/SCI-20251201-DP-01/{msdir}/{msfilename}'
                print(f'{targstr}   {projkey}   all  meerkat  1   {ms}')
