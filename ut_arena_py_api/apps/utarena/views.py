from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView

from apps.games.models import Player
from serializers import UserSerializer


class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Users to be viewed or edited.
    """
    permission_classes = ()
    authentication_classes = ()
    queryset = User.objects.all()
    serializer_class = UserSerializer


class SignUpView(APIView):
    """ API endpoint that allows new user to sign up.
    """
    permission_classes = ()
    authentication_classes = ()

    def post(self, request):
        serialized = UserSerializer(data=request.data)
        if serialized.is_valid():
            serialized.save()
            Player.objects.create(user_id=serialized.data['id'])
            return Response(serialized.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serialized._errors, status=status.HTTP_400_BAD_REQUEST)
