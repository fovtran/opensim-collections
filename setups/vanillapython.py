from collections import defaultdict 
header_skipped = False 
sales = defaultdict(lambda: 0) 
with open(filename, 'r') as f: 
	for line in f: 
		if not header_skipped: 
			header_skipped = True 
			continue 
		line = line.split(",") 
		product = line[0] 
		num_sales = int(line[1]) 
		sales[product] += num_sales 
		top10 = sorted(sales.items(), key=lambda x:x[1], reverse=True)[:10]

import pandas as pd 
data = pd.read_csv(filename) # header is conveniently inferred by default 
top10 = data.groupby("Product")["ItemsSold"].sum().order(ascending=False)[:10]

%%cython 
def sum_cythonized(): 
	cdef long a = 0 
	# this directive defines a type for the variable 
	cdef int i = 0 
	for i in range(100000): 
		a += i 
	return a
