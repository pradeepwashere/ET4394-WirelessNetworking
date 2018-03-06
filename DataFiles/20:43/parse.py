import os
f = open('finaldatamrt_05_2018.txt', 'r')
x = f.readlines()
#print len(x[1])
parsed = [''];
parsed2=[''];
# x[4] = 0
#print x
#print "\n".join(parsed)

for i in range(0,len(x)):
#	if(x[i]!='0'):
		for j in range(i+1,len(x)):
				temp = os.path.commonprefix([x[i],x[j]])
				# parsed.append(temp)
				# if ((len(temp)>4)&(len(temp)<10)):
				if (len(temp)>4):
					if temp not in parsed:
						
						parsed.append(temp)
					# x[j]='0'

parsed = sorted(parsed)
#parsed.reverse()
#print parsed
#	if(parsed[i]!='0'):


for i in range(0,len(parsed)):
 		for j in range(i+1,len(parsed)):
 				temp2 = os.path.commonprefix([parsed[i],parsed[j]])
				if (len(temp2)>4):
					if(len(parsed[i])<len(parsed[j])):
						parsed[j]='0'
parsed[:] = (value for value in parsed if value != '0')

					# 	del parsed[j]
					# lengthcheck =min(len(parsed[i]),parsed[j])
					# if (len(temp2)==lengthcheck): 
					# 	parsed2.append(temp2)


#					parsed[j]='0'
#				if ((len(temp)>4)&(len(temp)<10)):
#				if (len(temp2)>4):
# 					parsed2.append(temp2)

# for i in range(0,len(parsed)):
# 	if(parsed[i]!=0):
# 		for j in range(i,len(parsed)):
# 			temp2 = os.path.commonprefix([parsed[i],parsed[j]])
# 			if (len(temp2)>4):
# 				parsed2.append(temp2)
# 				parsed[j]=0

#print sorted([10,3,2])
#print parsed
#print parsed
print "\n".join(parsed)
#print os.path.commonprefix(["C_Frack79", "C_Frack799"])
