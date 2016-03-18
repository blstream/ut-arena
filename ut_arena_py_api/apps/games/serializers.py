from rest_framework import serializers

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

    def validate(self, attrs):
        if 'score' in attrs and attrs['score'] is None and self.instance is not None:
            raise serializers.ValidationError("Score value cannot be Null")
        if self.instance is None and PlayerGame.objects.filter(player_id=attrs['player_id'], game_id=attrs['game_id']).exists():
            raise serializers.ValidationError("Player has already joined the game")
        return attrs

    def create(self, validated_data):
        return PlayerGame.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.score = validated_data.get('score', instance.score)
        instance.team = validated_data.get('team', instance.team)
        instance.save()
        return instance
