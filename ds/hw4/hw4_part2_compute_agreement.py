import xlrd
from sklearn.metrics import confusion_matrix
import imp
import argparse
import sys

def calc_agreement(sheet1, sheet2):
    agreement_counter = 0

    for i in range(sheet1.nrows):
        #print(sheet1.cell_value(i,9) + ", " + sheet2.cell_value(i,9))
        if (str(sheet1.cell_value(i,9) ) == str(sheet2.cell_value(i,9) ) ):
            agreement_counter += 1

    print(str(round( ((agreement_counter/sheet1.nrows) * 100), 2) ) + "% agreement")


def calc_confusion(sh1, sh2):
    sh1_rows = []
    sh2_rows = []
    for i in range(sh1.nrows):
        sh1_rows.append(sh1.cell_value(i,9))

    for i in range(sh1.nrows):
        sh2_rows.append(sh2.cell_value(i,9))

    conf_matrix = confusion_matrix(sh1_rows, sh2_rows,)
    return conf_matrix

def calc_kappa(conf_matrix):
    # count the total entries
    total_entries = 0

    for i in range(len(conf_matrix)):
        for j in range (len(conf_matrix[i])):
            total_entries += conf_matrix[i][j]

    #calculate th
    po = 0
    for i in range (len(conf_matrix)):
        po += conf_matrix[i][i]

    po = po/total_entries

    #calculate percentages horizontally
    pe_horiz = []
    for i in range(len(conf_matrix)):
        temp_sum = 0
        for j in range (len(conf_matrix[i])):
            temp_sum += conf_matrix[i][j]
        pe_horiz.append(temp_sum/total_entries)

    #calculate percentages vertically
    pe_vert = []
    for i in range (len(conf_matrix[i])):
        temp_sum = 0
        for j in range (len(conf_matrix)):
            temp_sum += conf_matrix[j][i]
        pe_vert.append(temp_sum/total_entries)

    #multiply them together to calculate pe
    total_pe = 0
    for i in range (len(pe_horiz)):
        total_pe += pe_horiz[i] * pe_vert[i]


    kappa = po - total_pe / (1 - total_pe)
    return(kappa)



if __name__ == '__main__':


    file1 = ("hw4_part1_shanahan/Matt_house1_hw4.xlsx")
    file2 = ("hw4_part1_thacher/sam_house1_hw4.xlsx")

    #file1 = sys.argv[1]
    #file2 = sys.argv[2]

    book1 = xlrd.open_workbook(file1)
    sheet1 = book1.sheet_by_index(0)

    book2 = xlrd.open_workbook(file2)
    sheet2 = book2.sheet_by_index(0)

    calc_agreement(sheet1, sheet2)
    conf_matrix = calc_confusion(sheet1, sheet2)
    print (conf_matrix)

    print (calc_kappa(conf_matrix))
