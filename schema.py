# -*- coding: utf-8 -*-
## File autogenerated by SQLAutoCode
## see http://code.google.com/p/sqlautocode/

from sqlalchemy import *
from sqlalchemy.orm import mapper

metadata = MetaData()


ranks =  Table('ranks', metadata,
    Column(u'id', INTEGER(), primary_key=True, nullable=False),
            Column(u'name', VARCHAR(length=64), primary_key=False, nullable=False),
            Column(u'uva_id', INTEGER(), primary_key=False),
            Column(u'euler_id', VARCHAR(length=64), primary_key=False),
            Column(u'retired', Integer(), primary_key=False, nullable=False),
            Column(u'probie', Integer(), primary_key=False, nullable=False),
            Column(u'euler_solved', INTEGER(), primary_key=False),
    
    
    )
Index(u'euler_id', ranks.c.euler_id, unique=True)
Index(u'uva_id', ranks.c.uva_id, unique=True)

class Rank(object):
    pass

mapper(Rank, ranks)
