import json
from django.contrib.auth import authenticate
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from PhotoChallengeCore.forms import SignupForm
from PhotoChallengeCore.models import Category, Challenge
from django.contrib.auth.models import User
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view

__author__ = 'leo'


@csrf_exempt
@api_view(['POST'])
def signup(request):
    form = SignupForm(data=request.POST)
    if not form.is_valid():
        return HttpResponse(json.dumps(form.errors), status=403)
    username = form.cleaned_data["username"]
    password = form.cleaned_data["password"]
    email = form.cleaned_data["email"]
    User.objects.create_user(username=username,
                             email=email,
                             password=password)
    return HttpResponse(status=200)


def all_users(request):
    return HttpResponse(json.dumps(User.objects.all()))

class CategoryView(APIView):
    authentication_classes = (TokenAuthentication,)
    permission_classes = (IsAuthenticated,)

    def get(self, request, thread_id):
        return HttpResponse("", status=200)


Category.objects.all().delete()
Category.objects.all().delete()

animals = Category.objects.create(id=0, name="Animals")
Challenge.objects.create(id=0, name="Cat", category=animals)
Challenge.objects.create(id=1, name="Squirrel", category=animals)
Challenge.objects.create(id=2, name="Eel", category=animals)

buildings = Category.objects.create(id=1, name="Buildings")
Challenge.objects.create(id=3, name="Cat", category=buildings)
Challenge.objects.create(id=4, name="Squirrel", category=buildings)
Challenge.objects.create(id=5, name="Eel", category=buildings)