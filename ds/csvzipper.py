import csv

data_sam = []
with open("sam_house2_hw4.csv", 'rU') as csvfile:
	reader = csv.reader(csvfile, dialect = csv.excel_tab)
	for row in reader:
		st = str(row)
		x = st.split(',')
		data_sam.append(x)
data_matt = []
with open("Matt_house2_hw4.csv", 'rU') as csvfile:
	reader = csv.reader(csvfile, dialect = csv.excel_tab)
	for row in reader:
		st = str(row)
		x = st.split(',')
		data_matt.append(x)


counter = 1
for sam, matt in zip(data_sam,data_matt):
	if(sam[9] != matt[9]):
		print(counter)
	counter+=1