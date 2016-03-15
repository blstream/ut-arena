from django.core.urlresolvers import reverse
from rest_framework import status
from rest_framework.test import APITestCase


class UserTests(APITestCase):
    data = {'map_name':'Prague v2', 'match_type':'Team Deathmatch', 'time_limit': 10, 'start_date': '2016-04-10 10:00'}
    # def create_user(self):
    #     """
    #     Create user
    #     """
    #     data = {'username': 'test', 'password':'test1234'}
    #     create_user_url = reverse('signup')
    #     create_user = self.client.post(create_user_url, data, format='json')

    def test_create_game_without_authentication(self):
        """
        Ensure we can't create game without token authentication
        """
        url = reverse('game-list')
        response = self.client.post(url, self.data, format='json')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    # def test_create_game_with_authentication(self):
    #     self.create_user()
    #     """
    #     Ensure we can create game with token authentication
    #     """
    #     url = reverse('game-list')
    #     response = self.client.post(url, self.data, format='json')
    #     self.assertEqual(response.status_code, status.HTTP_200_OK)