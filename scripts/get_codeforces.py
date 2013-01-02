#!/usr/bin/env python2

from urllib2 import urlopen
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import json
from schema import Rank
from lxml.html import parse

with open('build/config.json', 'r') as f:
    config = json.load(f)

engine = create_engine('{db_driver}://{db_user}:{db_password}@{db_host}/{db_name}'.format(**config))
Session = sessionmaker(bind=engine)
session = Session()

users = session.query(Rank)
for user in users:
    if user.cf_id:
        page = parse(urlopen('http://codeforces.com/profile/{0}'.format(user.cf_id)))
        try:
            rating_el = page.xpath('//div[@class="userbox"]/div[@class="info"]/ul/li[contains(.,"Contest rating")]')
            if rating_el:
                rating = int(rating_el[0].xpath('span/text()')[0])
            else:
                rating = None
            user.cf_rating = rating
        except IndexError:
            pass
session.commit()
