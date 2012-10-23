#!/usr/bin/env python2

from urllib2 import urlopen
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import sqlalchemy as sa
import json
from schema import Rank

with open('build/config.json', 'r') as f:
    config = json.load(f)

engine = create_engine('{db_driver}://{db_user}:{db_password}@{db_host}/{db_name}'.format(**config));
Session = sessionmaker(bind=engine)
session = Session()

users = session.query(Rank)
for user in users:
    if user.euler_id:
        txt = urlopen('http://projecteuler.net/profile/{0}.txt'.format(user.euler_id)).read()
        try:
            n_solved = int(txt.split(',')[3].split(' ')[1])
            user.euler_solved = n_solved
        except IndexError:
            pass
session.commit()
