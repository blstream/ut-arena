from django.conf.urls import url, include
from rest_framework import routers
import views

router = routers.DefaultRouter()
router.register(r'player_games', views.PlayerGameViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
]
