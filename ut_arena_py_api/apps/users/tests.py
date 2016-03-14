from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from rest_framework import status
from rest_framework.test import APITestCase


class UserTests(APITestCase):
    def test_create_user(self):
        """
        Ensure that we can create new User object.
        """
        url = reverse('signup')
        data = {'username': 'test', 'password':'test1234'}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(User.objects.count(), 1)
        self.assertEqual(User.objects.get().name, data['username'])

    def test_login_to_account(self):
        """
        Ensure we can login to the account.
        """
        url = reverse('login')
        data = {'username': 'test', 'password':'test1234'}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)