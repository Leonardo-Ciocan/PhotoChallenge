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

    def get(self, request):
        return HttpResponse(json.dumps([c.to_json() for c in Category.objects.all()]), status=200)


class ChallengeView(APIView):
    authentication_classes = (TokenAuthentication,)
    permission_classes = (IsAuthenticated,)

    def get(self, request, category_id):
        return HttpResponse(json.dumps([c.to_json() for c in Challenge.objects.filter(category__id=category_id)]), status=200)

def reset_data():
    Category.objects.all().delete()
    Challenge.objects.all().delete()

    animals = Category.objects.create(id=0, name="Animals", color="0,186,0")
    Challenge.objects.create(id=0, name="Cat", category=animals , tag="Easy")
    Challenge.objects.create(id=1, name="Dog", category=animals, tag="Easy")
    Challenge.objects.create(id=2, name="Squirrel", category=animals, tag="Easy")
    Challenge.objects.create(id=3, name="Fish", category=animals, tag="Easy")
    Challenge.objects.create(id=4, name="Fox", category=animals, tag="Medium")
    Challenge.objects.create(id=5, name="Snake", category=animals, tag="Medium")
    Challenge.objects.create(id=6, name="Snail", category=animals, tag="Medium")
    Challenge.objects.create(id=7, name="Elephant", category=animals, tag="Hard")
    Challenge.objects.create(id=8, name="Hawk", category=animals, tag="Hard")
    Challenge.objects.create(id=9, name="Gorilla", category=animals, tag="Hard")
    Challenge.objects.create(id=10, name="Penguin", category=animals, tag="Hardest")
    Challenge.objects.create(id=11, name="Whale", category=animals, tag="Hardest")
    Challenge.objects.create(id=12, name="Tarantula", category=animals, tag="Hardest")

    buildings = Category.objects.create(id=1, name="Places", color="3,163,243")
    Challenge.objects.create(id=13, name="Church", category=buildings,tag="")
    Challenge.objects.create(id=14, name="Statue of Liberty", category=buildings,tag="")
    Challenge.objects.create(id=15, name="Eiffel tower", category=buildings,tag="")