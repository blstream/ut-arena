from copy import copy
from rest_framework import status
from rest_framework.response import Response
from apps.utarena.models import Game
from rest_framework import viewsets
from rest_framework.views import APIView

from serializers import GameSerializer
from apps.player_game.serializers import PlayerGameSerializer


class GameViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows games to be viewed or edited.
    """
    queryset = Game.objects.all()
    serializer_class = GameSerializer

    def create(self, request, *args, **kwargs):
        data = copy(request.data)
        data['created_by'] = request.user.pk
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


class GameJoinView(APIView):
    def post(self, request, *args, **kwargs):
        data = {'player': request.user.pk, 'game': kwargs['pk']}
        serialized = PlayerGameSerializer(data=data)
        if serialized.is_valid():
            serialized.save()
            return Response(serialized.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serialized._errors, status=status.HTTP_400_BAD_REQUEST)
