from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.test import APITestCase


class UserTests(APITestCase):
    data = {'username': 'test', 'password':'test1234'}
    def test_create_user(self):
        """
        Ensure that we can create new User object.
        """
        url = reverse('signup')
        response = self.client.post(url, self.data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(User.objects.count(), 1)
        self.assertEqual(User.objects.get().username, self.data['username'])

    def test_login_to_account_valid_credentials(self):
        self.test_create_user()
        """
        Ensure we can login to the account with valid credentials.
        """
        url = reverse('login')
        response = self.client.post(url, self.data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['token'], Token.objects.get(user=User.objects.get()).key)

    def test_login_to_account_invalid_credentials(self):
        self.test_create_user()
        """
        Ensure we can't login to the account with invalid credentials.
        """
        url = reverse('login')
        data = {'username': 'test', 'password':'1234'}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)