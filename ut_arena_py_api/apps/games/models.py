from __future__ import unicode_literals

from django.contrib.auth.models import User
from django.db import models

# Create your models here.
from rest_framework.exceptions import ValidationError
from rest_framework.generics import get_object_or_404


class Player(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)


class Game(models.Model):
    MATCH_TYPE_FREE_FOR_ALL = 1
    MATCH_TYPE_CAPTURE_THE_FLAG = 2
    MATCH_TYPES = (
        (MATCH_TYPE_FREE_FOR_ALL, 'Free for all'),
        (MATCH_TYPE_CAPTURE_THE_FLAG, 'Capture the Flag')
    )

    start_date = models.DateTimeField()
    time_limit = models.IntegerField()
    map_name = models.CharField(max_length=64)
    match_type = models.IntegerField(choices=MATCH_TYPES)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    created_by = models.ForeignKey(User, null=False, related_name='created_games')

    def join(self, player):
        if self.players.filter(player=player).exists():
            raise ValidationError("Player has already joined the game")
        self.players.add(PlayerGame(game=self, player=player), bulk=False)

    def add_user_score(self, instance, **validated_data):
        instance.score = validated_data['score']
        instance.team = validated_data.get('team', instance.team)
        instance.save()


class PlayerGame(models.Model):
    NO_TEAM = None
    TEAM_RED = 1
    TEAM_BLUE = 2
    TEAMS = (
        (NO_TEAM, 'No Team'),
        (TEAM_RED, 'Red'),
        (TEAM_BLUE, 'Blue')
    )

    score = models.IntegerField(null=True)
    team = models.IntegerField(choices=TEAMS, null=True)
    player = models.ForeignKey(Player, related_name='games')
    game = models.ForeignKey(Game, related_name='players')

    class Meta:
        unique_together = ('player', 'game')
