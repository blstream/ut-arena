from django.core.urlresolvers import reverse
from rest_framework import status
from rest_framework.test import APITestCase

class GamesViewTest(APITestCase):
    data = {'map_name':'Prague v2', 'match_type':1, 'time_limit': 10, 'start_date': '2016-04-10 10:00'}
    def create_user_and_login(self):
        """
        Create user and login
        :return user token
        """
        data = {'username': 'test', 'password':'test1234'}
        create_user_url = reverse('signup')
        create_user = self.client.post(create_user_url, data, format='json')
        url = reverse('login')
        login_user = self.client.post(url, data, format='json')
        return login_user.data['token']

    def test_create_game_with_authentication(self):
        """
        Ensure we can create game with token authentication
        """
        token = self.create_user_and_login()
        url = reverse('game-list')
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + token)
        response = self.client.post(url, self.data, format='json')
        print(response)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_create_game_without_authentication(self):
        """
        Ensure we can't create game without token authentication
        """
        url = reverse('game-list')
        response = self.client.post(url, self.data, format='json')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)