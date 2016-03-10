from ut_arena.settings import *

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

DEBUG = False