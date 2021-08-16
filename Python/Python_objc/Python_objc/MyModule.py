import sys
print('import sys module.....')


def my_func():
    print("====")
    print(sys.path)
    return "embedding?hello"

def my_func2(a,b):
    print("====",a)
    print("=====",b)

    return str(int(a) + int(b))


def my_func3(a,b,c,d):
    print("====",a)
    print("=====",b)
    print("=====",c)
    print("=====",d)
    return str(a) + str(b) + str(c) + str(d)
  
