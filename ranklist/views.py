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
    users = DBSession.query(Rank)
    return {'user_json': Encoder().encode(users.all())}


@view_config(route_name='add_user', renderer='templates/add_user.pt')
def add_user(request):
    return {}
