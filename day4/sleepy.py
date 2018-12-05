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
#print(table)
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


guardlist = list(curs.execute("SELECT DISTINCT guardid FROM guards;"))

for g in guardlist:
    s = "SELECT " + ",".join(["sum(`"+str(x)+"`)" for x in range(60)]) + " FROM guards where `guardid` = " + str(g[0]) + " GrOUp By `guardid`;"
    
    #print("guard: " + str(g[0]),end=" ")
    for m in list(curs.execute(s)):
        print(s)
        #print(m,end="")
    #print()



#for g in guardlist:
#    s = "SELECT MAX(" + ",".join(["sum(`"+str(x)+"`)" for x in range(60)]) + ") FROM guards where `guardid` = " + str(g[0]) + " GROUP BY `guardid`;"
#    
#    print("guard: " + str(g[0]),end=" ")
#    for m in list(curs.execute(s)):
#        print(m,end="")
#    print()
#
#  python sleepy.py  | grep 947  | tr "," "\n" | grep -En "."
