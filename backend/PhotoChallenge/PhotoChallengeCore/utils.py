import uuid
import os


def get_file_path(filename):
        ext = filename.split('.')[-1]
        filename = "%s.%s" % (uuid.uuid4(), ext)
        return os.path.join('submissions/', filename)