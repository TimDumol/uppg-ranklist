from pyramid.response import Response
from pyramid.view import view_config

from sqlalchemy.exc import DBAPIError

import json

from .models import (
    DBSession,
    Rank,
)
from .encoder import (
    Encoder
)


@view_config(route_name='home', renderer='templates/index.pt')
def home(request):
    return {}


@view_config(route_name='get_ranks', request_method='GET')
def get_ranks(request):
    return Response(Encoder().encode(DBSession.query(Rank).all()))


@view_config(route_name='post_rank', request_method='POST')
def post_rank(request):
    d = json.loads(request.body)
    rank = Rank(d['name'], d.get('uva_id', None),
                d.get('euler_id', None),
                d.get('cf_id', None))
    DBSession.add(rank)
    return Response(Encoder().encode(rank))


@view_config(route_name='put_rank', request_method='PUT')
def put_rank(request):
    id = request.matchdict['id']
    rank = DBSession.query(Rank).get(id)
    d = json.loads(request.body)
    for key, val in d.items():
        setattr(rank, key, val)
    rank = DBSession.merge(rank)
    DBSession.commit()
    return Response(Encoder().encode(rank))


@view_config(route_name='delete_rank', request_method='DELETE')
def delete_rank(request):
    id = request.matchdict['id']
    DBSession.query(Rank).filter(Rank.id == id).delete()
    DBSession.commit()
