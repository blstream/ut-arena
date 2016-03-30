from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from django.test import TestCase
from rest_framework import status
from rest_framework.test import APITestCase
from apps.games.models import Game, PlayerGame, Player

game_data = {'map_name': 'Prague v2', 'match_type': 2, 'time_limit': 10, 'start_date': '2016-04-10 10:00'}
score_data = {'score': 45, 'team': 1}
user_data = {'username': 'test', 'password': 'test1234'}


class GamesViewTest(APITestCase):
    def setUp(self):
        """
        Create user and login
        """
        create_user_url = reverse('signup')
        create_user = self.client.post(create_user_url, user_data, format='json')
        self.user = User.objects.get(id=create_user.data['id'], username=create_user.data['username'])
        login_url = reverse('login')
        login_user = self.client.post(login_url, user_data, format='json')
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + login_user.data['token'])

    def test_create_game(self):
        """
        Ensure we can create game with token authentication
        """
        url = reverse('game-list')
        response = self.client.post(url, game_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        game = Game.objects.get(
            id=response.data['id'],
            map_name=response.data['map_name'],
            match_type=response.data['match_type'],
            time_limit=response.data['time_limit'],
            start_date=response.data['start_date']
        )
        self.assertEqual(game.map_name, game_data['map_name'])
        self.assertEqual(game.match_type, game_data['match_type'])
        self.assertEqual(game.time_limit, game_data['time_limit'])
        self.assertEqual(game.start_date.strftime("%Y-%m-%d %H:%M"), game_data['start_date'])
        return game

    def test_create_game_without_authentication(self):
        """
        Ensure we can't create game without token authentication
        """
        self.client.credentials(HTTP_AUTHORIZATION='')
        url = reverse('game-list')
        response = self.client.post(url, game_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
        self.assertFalse(Game.objects.filter(
            map_name=game_data['map_name'],
            match_type=game_data['match_type'],
            time_limit=game_data['time_limit'],
            start_date=game_data['start_date']
        ).exists())

    def test_join_game(self):
        """
        Ensure we can join game a valid logged user
        """
        game = self.test_create_game()
        url = reverse('game-join', args=(1,))
        response = self.client.post(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue(PlayerGame.objects.filter(player_id=1, game=game).exists())

    def test_player_score(self):
        """
        Ensure we can add score to existing game as a valid logged user
        """
        self.test_join_game()
        url = reverse('game-player-score', args=(1,))
        response = self.client.post(url, score_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        player_game = PlayerGame.objects.get(player=self.user.player, game_id=1)
        self.assertIsNotNone(player_game)
        self.assertEqual(player_game.score, score_data['score'])
        self.assertEqual(player_game.team, score_data['team'])


class GameTest(TestCase):
    def setUp(self):
        self.create_user_player_and_game()

    def create_user(self):
        return User.objects.create(**user_data)

    def create_player(self, user):
        player = Player.objects.create(user=user)
        return player

    def create_game(self, user):
        game = Game.objects.create(created_by=user, **game_data)
        return game

    def create_user_player_and_game(self):
        self.user = self.create_user()
        self.player = self.create_player(self.user)
        self.game = self.create_game(self.user)

    def test_join(self):
        """
        Test for join method as valid player, for exisitng game
        """
        player = self.player
        game = self.game
        game.join(player=player)
        self.assertTrue(PlayerGame.objects.filter(player=player, game=game).exists())

    def test_add_player_score(self):
        self.test_join()
        game = self.game
        player = self.player
        game.add_player_score(player=player, **score_data)
        self.assertTrue(PlayerGame.objects.filter(player=player, game=game, **score_data).exists())
