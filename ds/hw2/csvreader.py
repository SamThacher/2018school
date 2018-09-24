import csv
import json
with open('p.csv', 'r', encoding='utf-8') as f:
    reader = csv.reader(f)
    your_list = list(reader)

newlist = [y[1] for y in your_list]
# print(newlist)
newlist2 = [y[7] for y in your_list]
n = list(map(list,zip(newlist,newlist2)))
# print(json.dumps(n))
newset = []
newmap = []
for i in range(0,1000):
	newset.append(newlist[i])
	newmap.append(n[i])

print(json.dumps(n))



# with open('recipes.map', 'w') as f:
#     for item in n:
#         f.write("%s\n" % item)

# # with open('foods.set', 'w') as z:
# # 	for item in newlist:
# # 		z.write("%s\n" %)