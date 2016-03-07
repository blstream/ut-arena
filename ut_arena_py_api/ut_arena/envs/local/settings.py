from ut_arena.settings import *


# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []

DATABASES = {
  'default': {
  'ENGINE': 'django.db.backends.postgresql_psycopg2',
  'NAME': 'ut-arena',
  'USER': 'krzysztof',
  'PASSWORD': 'test',
  'HOST': 'localhost',
  'PORT': '',
  }
}

STATIC_ROOT = '/opt/envs/local/ut-arena/ut_arena_py_api/static'