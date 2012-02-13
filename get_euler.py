#!/usr/bin/env python2

from urllib2 import urlopen
import json

f = open('js/site/users.json', 'r')
users = json.load(f)
f.close()

for user in users:
    if 'euler' in user and 'id' in user['euler']:
        id = user['euler']['id']
        txt = urlopen('http://projecteuler.net/profile/{0}.txt'.format(id)).read()
        try:
            n_solved = int(txt.split(',')[3].split(' ')[1])
            user['euler']['solved'] = n_solved
        except IndexError:
            pass

f = open('js/site/users.json', 'w')
json.dump(users, f, indent=4)
f.close()
