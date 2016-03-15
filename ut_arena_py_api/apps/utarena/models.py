from __future__ import unicode_literals

from django.contrib.auth.models import User
from django.db import models


# Create your models here.


class Player(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    games = models.ManyToManyField('Game', through='PlayerGame', related_name='joined_games')


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


class PlayerGame(models.Model):
    TEAM_RED = 1
    TEAM_BLUE = 2
    TEAMS = (
        (TEAM_RED, 'Red'),
        (TEAM_BLUE, 'Blue')
    )

    score = models.IntegerField()
    team = models.IntegerField(choices=TEAMS)
    player = models.ForeignKey(Player)
    game = models.ForeignKey(Game)
