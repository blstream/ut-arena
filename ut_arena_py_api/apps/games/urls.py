from django.conf.urls import url, include
from rest_framework import routers

import views

router = routers.DefaultRouter()
router.register(r'games', views.GameViewSet)

urlpatterns = [
    url(r'^games/(?P<pk>[^/.]+)/join/$', views.GameJoinView.as_view(), name='join_game'),
    url(r'^', include(router.urls)),
]
