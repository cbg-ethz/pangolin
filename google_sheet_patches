#!/usr/bin/env python3

import pickle
import os.path
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from googleapiclient.discovery import build
import pandas as pd
import re

# login using token, or generate token out of credential json
# NOTE token generation requires browsing to an URL
# HACK if used on a headless computer:
#  - exit links (if that text-mode browser was started)
#  - copy the link from the terminal and open it in a desktop browser
#  - log into google and authorize the app with the desktop browser
#  - copy the last "localhost:nnnnn" link from the desktop browser
#  - open the link localy on the headless computer (e.g.: using curl)
def gsheet_api_check(SCOPES):
	creds = None
	if os.path.exists('token.pickle'):
		with open('token.pickle', 'rb') as token:
			creds = pickle.load(token)

	if not creds or not creds.valid:
		if creds and creds.expired and creds.refresh_token:
			creds.refresh(Request())
		else:
			flow = InstalledAppFlow.from_client_secrets_file(
				'credentials.json', SCOPES)
			creds = flow.run_local_server(port=0, open_browser=False)

	with open('token.pickle', 'wb') as token:
			pickle.dump(creds, token)

	return creds

# fetch a specific spread sheet
def pull_sheet_data(SCOPES,SPREADSHEET_ID,DATA_TO_PULL):
	creds = gsheet_api_check(SCOPES)
	service = build('sheets', 'v4', credentials=creds)
	sheet = service.spreadsheets()
	result = sheet.values().get(
		spreadsheetId=SPREADSHEET_ID,
		range=DATA_TO_PULL).execute()
	values = result.get('values', [])

	if not values:
		print('No data found.')
	else:
		rows = sheet.values().get(spreadsheetId=SPREADSHEET_ID,
			range=DATA_TO_PULL).execute()
		data = rows.get('values')
		print("COMPLETE: Data copied")
		return data


# TODO convert those to command line option and conf files
SCOPES = ['https://www.googleapis.com/auth/spreadsheets']
# from the URL:
SPREADSHEET_ID = '1FUibobIHYsw1thYIbyHBZsmm2zyGStqKlMpdWNBxLxU'
# from the Tab name (+ optional '!' cell range):
DATA_TO_PULL = 'Samples'
# 0-based position of the header line
header=1
# how patchable samples look
filter='^\d+$'
# Batch to project+order pairs regex
rxbatch=re.compile('p?(?P<proj>\d+)_o?(?P<order>\d+)')

# fetch data
data = pull_sheet_data(SCOPES,SPREADSHEET_ID,DATA_TO_PULL)
df_full = pd.DataFrame(data[(header+1):], columns=data[header])
filter_df=df_full[df_full['Sample_Name_FGCZ'].str.contains(filter)]
print(f"{len(filter_df.index)} entries")

# generate patch lists
for batch in filter_df['Batch'].unique():
	m = rxbatch.match(batch)
	if not m:
		print (f"cannot parse <{batch}>")
		continue
	d=m.groupdict()
	out_df=filter_df[filter_df['Batch'] == batch][["Sample_Name_FGCZ","Sample_Name_COWWID-19"]]
	print(f"generating patch for p{d['proj']} o{d['order']}: {len(out_df.index)} entries")
	out_df.to_csv(f"sampleset/patch.{d['proj']}.{d['order']}.tsv", header=False, index=False, sep="\t", compression={'method':'infer'})
