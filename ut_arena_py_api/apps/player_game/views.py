from rest_framework import viewsets
from serializers import PlayerGameSerializer
from apps.utarena.models import PlayerGame


class PlayerGameViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Player Games to be viewed or edited.
    """
    queryset = PlayerGame.objects.all()
    serializer_class = PlayerGameSerializer
