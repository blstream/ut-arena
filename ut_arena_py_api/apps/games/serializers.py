from rest_framework import serializers

from apps.games.models import Game, PlayerGame


class GameSerializer(serializers.ModelSerializer):
    class Meta:
        model = Game


class PlayerGameSerializer(serializers.ModelSerializer):
    class Meta:
        model = PlayerGame
