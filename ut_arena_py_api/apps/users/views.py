from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from serializers import UserSerializer

class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows Users to be viewed or edited.
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer


@api_view(['POST'])
@permission_classes(())
def create_auth(request):
   serialized = UserSerializer(data=request.data)
   if serialized.is_valid():
       serialized.save()
       return Response(serialized.data, status=status.HTTP_201_CREATED)
   else:
       return Response(serialized._errors, status=status.HTTP_400_BAD_REQUEST)
