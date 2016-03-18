from rest_framework import serializers
from rest_framework.exceptions import NotAcceptable

from apps.games.models import Game, Player, PlayerGame


class GameSerializer(serializers.ModelSerializer):
    class Meta:
        model = Game


class PlayerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Player


class PlayerGameSerializer(serializers.Serializer):
    player_id = serializers.IntegerField()
    game_id = serializers.IntegerField()
    score = serializers.IntegerField(default=None)
    team = serializers.IntegerField(default=None)

    def create(self, validated_data):
        return PlayerGame(**validated_data)

    def update(self, instance, validated_data):
        if validated_data['score'] is None:
            raise NotAcceptable(detail='Score cannot be null')
        instance.score = validated_data.get('score', instance.score)
        instance.team = validated_data.get('team', instance.team)
        return instance
