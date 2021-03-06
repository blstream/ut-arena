from django.conf.urls import url, include
from rest_framework import routers

import views

router = routers.DefaultRouter()
router.register(r'games', views.GameViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
]
