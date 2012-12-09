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


@view_config(route_name='users', request_method='GET')
def get_users(request):
    return Encoder().encode(Rank.all())


@view_config(route_name='users', request_method='POST')
def post_user(request):
    pass


@view_config(route_name='users/{id}', request_method='PUT')
def put_user(request):
    id = request.matchdict['id']
    rank = DBSession.query(Rank).get(id)


@view_config(route_name='users/{id}', request_method='DELETE')
def delete_user(request):
    id = request.matchdict['id']
    DBSession.query(Rank).filter(Rank.id == id).delete()
