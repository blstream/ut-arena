from rest_framework import serializers

from apps.utarena.models import PlayerGame


class PlayerGameSerializer(serializers.ModelSerializer):
    class Meta:
        model = PlayerGame
