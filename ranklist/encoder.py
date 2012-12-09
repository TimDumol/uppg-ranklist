from json import JSONEncoder


class Encoder(JSONEncoder):
    """
    Custom JSON Encoder
    """
    def default(self, o):
        try:
            return o.to_dict()
        except TypeError:
            pass
        return JSONEncoder.default(o)
