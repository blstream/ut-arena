from django.conf.urls import url, include
from rest_framework import routers
from rest_framework.authtoken import views as auth_views
import views

router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)

urlpatterns = [
    url(r'^login/', auth_views.obtain_auth_token, name='login'),
    url(r'^', include(router.urls)),
    url(r'^signup', 'apps.users.views.create_auth', name='signup'),
]
