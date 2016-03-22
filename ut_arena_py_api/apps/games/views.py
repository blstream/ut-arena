from copy import copy
from rest_framework import status
from rest_framework.decorators import detail_route
from rest_framework.generics import get_object_or_404
from rest_framework.response import Response
from rest_framework import viewsets

from apps.games.models import Game, Player
from serializers import GameSerializer, PlayerSerializer, PlayerGameSerializer


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

    @detail_route(methods=['post'])
    def join(self, request, pk=None):
        game = get_object_or_404(Game, pk=pk)
        game.join(player=self.request.user.player)
        return Response(status=status.HTTP_200_OK)

    @detail_route(methods=['post'])
    def player_score(self, request, pk=None):
        data = copy(request.data)
        game = get_object_or_404(Game, id=pk)
        serialized = PlayerGameSerializer(data=data)
        if serialized.is_valid():
            game.add_player_score(
                player=self.request.user.player,
                score=serialized.validated_data['score'],
                team=serialized.validated_data['team']
            )
            return Response(status=status.HTTP_200_OK)
        else:
            return Response(serialized._errors, status=status.HTTP_400_BAD_REQUEST)


class PlayerViewSet(viewsets.ModelViewSet):
    queryset = Player.objects.all()
    serializer_class = PlayerSerializer
