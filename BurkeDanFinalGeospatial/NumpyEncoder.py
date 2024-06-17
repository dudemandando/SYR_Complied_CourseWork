import numpy as np
import pickle
import codecs
def EncodeNpArrayBase64(obj):
    obj_base64string = codecs.encode(pickle.dumps(obj,
                                    protocol=pickle.HIGHEST_PROTOCOL),
                                     "base64").decode()
    return obj_base64string

def DecodeNpArrayBase64(obj_base64string):
    obj_reconstituted = pickle.loads(codecs.decode(obj_base64string.encode(),
                                                   "base64"))
    return obj_reconstituted