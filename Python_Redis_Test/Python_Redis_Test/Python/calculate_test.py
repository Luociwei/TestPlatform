# coding=utf-8

import sys
import os
current_dir = os.path.dirname(os.path.realpath(__file__))
print('====>>>>',current_dir+'/site-packages')
sys.path.append(current_dir)

import time
import threading
import zmq
import redis



r = redis.Redis(host='localhost', port=6379, db=0)
context = zmq.Context()
socket = context.socket(zmq.REP)

socket.bind("tcp://127.0.0.1:3120")

def calculate_value(message):
    print("this function is calculate_value......")
    val = r.get(message)   # 注意 等到的都是字符串
    if val:
        val = float(val)*200   # 数学运算
        val = str(val).encode('utf-8')
        return val
    else:
        return b'0'

def run(n):
    while True:
        try:
            print("wait for  client ...")
            message = socket.recv()
            print("message from cpk client:", message.decode('utf-8'))
            ret = calculate_value(message)
            socket.send(ret.decode('utf-8').encode('ascii'))
        except Exception as e:
            print('error:',e)

if __name__ == '__main__':
    t1 = threading.Thread(target=run, args=("<<calculate>>",))
    t1.start()
    
    




