from django.conf.urls import include, url

urlpatterns = [
    url(r'^', include('apps.api_test.urls')),
    url(r'^', include('apps.games.urls')),
    url(r'^', include('apps.users.urls')),
]
