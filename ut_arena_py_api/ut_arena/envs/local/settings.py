from ut_arena.settings import *


# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []

DATABASES = {
  'default': {
  'ENGINE': 'django.db.backends.postgresql_psycopg2',
  'NAME': 'ut-arena',
  'USER': 'utarena',
  'PASSWORD': 'utarena1234',
  'HOST': 'localhost',
  'PORT': '',
  }
}

STATIC_ROOT = os.path.join(BASE_DIR, "static")