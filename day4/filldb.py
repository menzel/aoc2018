#!/usr/bin/env python3

import sqlite3
from datetime import datetime,timedelta

conn= sqlite3.connect("guard.db")
curs = conn.cursor()

try:
    curs.execute("DROP TABLE guards;")
except:
    pass

table = "CREATE TABLE `guards` (`guardid` INTEGER, `date` DATE," + ",".join(["`" + str(i) + "`	INTEGER" for i in range(60)]) + ");"
print(table)
curs.execute(table)

insert = "INSERT INTO guards VALUES ('" 
update = "UPDATE guards SET " 

with open("input.txt") as fp:
    lastguard = -1
    start = -1 # start of sleep 

    for line in sorted(fp,key=lambda x: x[:17]): 
        ts = datetime.strptime(line.split("]")[0],"[%Y-%m-%d %H:%M") 


        if "Guard" in line: 
            lastguard = int(line.split()[3][1:])

            if ts.hour == 23:
                ts += timedelta(days=1)

            foo = insert + str(lastguard) + "','" + ts.strftime("%Y-%m-%d")+ "',"  + ",".join(["0" for _ in range(60)])  + ");"
            print(foo)
            curs.execute(foo)

        elif "wakes" in line:
                cmd = ",".join(["`"+str(x)+"`=1" for x in range(start.minute,ts.minute)])
                foo = update + cmd + " WHERE `guardid` = " + str(lastguard) + " AND `date` = '" + ts.strftime("%Y-%m-%d") + "';"
                print(foo)
                curs.execute(foo)

        elif "falls" in line:
            start = ts

    conn.commit()

s1 = "(SELECT guardid FROM (SELECT guardid," + "+".join(["sum(`"+str(x)+"`)" for x in range(60)]) + " as c FROM guards GROUP BY guardid ORDER BY (c) DESC LIMIT 1))"
#print(s1)

getguard = s1[1:-1]
print(getguard+";")
guardid = list(curs.execute(getguard))[0]
#print("#id: " + str(guardid))

#s = "SELECT * FROM guards where `guardid` = " + s1 + ";"
s = "SELECT " + ",".join(["sum(`"+str(x)+"`) as `" + str(x)  + "`" for x in range(60)]) + " FROM guards where `guardid` = " + s1 + ";"


print(s)
#s = "SELECT * FROM guards where `guardid` = " + id + ";"

#print(s)
#print("".join([" "]*18), end="")

#for i in range(60):
#    print("%3d"%i,end="")
#
#print()
#
f = list(curs.execute(s))

#for m in f:
#    print(m)

import numpy as np 

n = np.argmax([sum([f[j][i] for j in range(len(f))]) for i in  range(2,len(f[0]))])
#print(n)
#print(guardid)
#print(int(guardid[0]) * n) 
