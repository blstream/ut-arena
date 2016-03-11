from django.conf.urls import include, url
from rest_framework.authtoken import views

urlpatterns = [
  url(r'^', include('apps.api_test.urls')),
  url(r'^api-token-auth/', views.obtain_auth_token),
]