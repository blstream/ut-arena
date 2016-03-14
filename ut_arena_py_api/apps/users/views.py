from django.contrib.auth.models import User
from rest_framework import viewsets

from serializers import UserSerializer
from permissions import UserPermission

class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Users to be viewed or edited.
    """
    permission_classes = (UserPermission)
    queryset = User.objects.all()
    serializer_class = UserSerializer