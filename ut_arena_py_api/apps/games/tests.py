from django.core.urlresolvers import reverse
from rest_framework import status
from rest_framework.test import APITestCase

from apps.games.models import Game, PlayerGame, Player


class GamesViewTest(APITestCase):
    game_data = {'map_name': 'Prague v2', 'match_type':2, 'time_limit': 10, 'start_date': '2016-04-10 10:00'}
    score_data = {'score': 45, 'team':1}
    def setUp(self):
        """
        Create user and login
        """
        data = {'username': 'test', 'password':'test1234'}
        create_user_url = reverse('signup')
        create_user = self.client.post(create_user_url, data, format='json')
        login_url = reverse('login')
        login_user = self.client.post(login_url, data, format='json')
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + login_user.data['token'])

    def test_create_game(self):
        """
        Ensure we can create game with token authentication
        """
        url = reverse('game-list')
        response = self.client.post(url, self.game_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Game.objects.get().map_name, self.game_data['map_name'])

    def test_create_game_without_authentication(self):
        """
        Ensure we can't create game without token authentication
        """
        self.client.credentials(HTTP_AUTHORIZATION='')
        url = reverse('game-list')
        response = self.client.post(url, self.game_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
        self.assertFalse(Game.objects.filter(id=1).exists())

    def test_join_game(self):
        """
        Ensure we can join game (with id = 1) as a valid logged user
        """
        self.test_create_game()
        url = reverse('game-join', args=(1,))
        response = self.client.post(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue(PlayerGame.objects.filter(player_id=1, game_id=1).exists())

    def test_join(self):
        """
        Test for join method as valid player, for exisitng game
        """
        self.test_create_game()
        player = Player.objects.get(id=1)
        game = Game.objects.get(id=1)
        game.join(player=player)
        self.assertTrue(PlayerGame.objects.filter(player_id=1, game_id=1).exists())

    def test_add_player_score(self):
        self.test_join()
        game = Game.objects.get(id=1)
        player = Player.objects.get(id=1)
        game.add_player_score(player=player, score=30, team=1)
        self.assertTrue(PlayerGame.objects.filter(player_id=1, game_id=1, score=30, team=1).exists())

    def test_player_score(self):
        """
        Ensure we can add score to existing game as a valid logged user
        """
        self.test_join_game()
        url = reverse('game-player-score', args=(1,))
        response = self.client.post(url, self.score_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        player_game = PlayerGame.objects.get(player_id=1, game_id=1)
        self.assertIsNotNone(player_game)
        self.assertEqual(player_game.score, self.score_data['score'])
        self.assertEqual(player_game.team, self.score_data['team'])
