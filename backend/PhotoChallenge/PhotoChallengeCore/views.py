import json
from django.contrib.auth import authenticate
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from PhotoChallengeCore.forms import SignupForm
from PhotoChallengeCore.models import Category, Challenge, Submission, Friendship, Notification, NotificationType
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
        challenges = [c.to_json() for c in Challenge.objects.filter(category__id=category_id)]
        for c in challenges:
            hasSub = Submission.objects.filter(challenge__id = c["id"] , user=request.user).count() > 0
            c["hasSubmission"] = hasSub
        return HttpResponse(json.dumps(challenges), status=200)

    def post(self, request, challenge_id):
        file = request.FILES["file"]
        sub, created = Submission.objects.get_or_create(challenge=Challenge.objects.get(id=challenge_id),user=request.user)
        if sub.file is not None:
            sub.file.delete()
        sub.file = file
        sub.save()
        for user in [f.fromUser for f in Friendship.objects.filter(toUser=request.user)]:
            Notification.objects.create(user=user, type = NotificationType.uploaded, payload=str(sub.id))
        return HttpResponse(status=200)


class SubmissionImage(APIView):
    authentication_classes = (TokenAuthentication,)
    permission_classes = (IsAuthenticated,)

    def get(self, request, challenge_id):
        sub = Submission.objects.filter(challenge=Challenge.objects.get(id=challenge_id),user=request.user)
        if sub.count() > 0:
            response = HttpResponse(sub[0].file , content_type="image/jpeg")
            return response
        return HttpResponse(status=404)


class FriendshipView(APIView):
    authentication_classes = (TokenAuthentication,)
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        friendships = Friendship.objects.filter(fromUser=request.user)
        friends = [{
                        "name" : f.toUser.username,
                        "stars" : Submission.objects.filter(user=f.toUser).count()
                   } for f in friendships]
        friends.append({
            "name": request.user.username,
            "stars": Submission.objects.filter(user=request.user).count()
        })
        return HttpResponse(json.dumps(friends))

    def post(self, request):
        username = request.POST["username"]
        person = User.objects.filter(username=username)
        if person.count() > 0:
            p = person[0]
            Friendship.objects.get_or_create(fromUser=request.user , toUser=p)
            f = {
                        "name" : p.username,
                        "stars" : Submission.objects.filter(user=p).count()
                   }
            Notification.objects.create(user=p, type=NotificationType.follow, payload=request.user.username)
            return HttpResponse(json.dumps(f) , status=200)
        else:
            return HttpResponse(status=404)


class NotificationView(APIView):
    authentication_classes = (TokenAuthentication,)
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        subs = [{
                    "type" : s.type,
                    "payload" : s.payload
                } for s in Notification.objects.filter(user=request.user)]
        return HttpResponse(json.dumps(subs), status=200)

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