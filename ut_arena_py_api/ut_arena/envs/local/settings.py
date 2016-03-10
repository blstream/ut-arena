from ut_arena.settings import *


# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []

DATABASES = {
  'default': {
  'ENGINE': 'django.db.backends.postgresql_psycopg2',
  'NAME': 'utarena',
  'USER': 'utarena',
  'PASSWORD': 'ut1234',
  'HOST': 'localhost',
  'PORT': '5432',
  }
}

STATIC_ROOT = os.path.join(BASE_DIR, "static")