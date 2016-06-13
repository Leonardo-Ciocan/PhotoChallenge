import datetime
import uuid
from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token
from PhotoChallengeCore.utils import get_file_path
from django.contrib.auth.models import User
from django.db import models
import os

@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)


class Category(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.TextField(default="")
    color = models.TextField(default="")

    def to_json(self):
        return {
            "id": self.id,
            "name": self.name,
            "stars": 0,
            "color": self.color
        }


class Challenge(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.TextField(default="")
    category = models.ForeignKey(Category)
    tag = models.TextField(default="")

    def to_json(self):
        return {
            "id": self.id,
            "name": self.name,
            "tag": self.tag
        }


class Submission(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User)
    challenge = models.ForeignKey(Challenge , default=None)
    file = models.FileField(upload_to=get_file_path,
                            null=True, blank=True, default=None)


class Friendship(models.Model):
    id = models.AutoField(primary_key=True)
    fromUser = models.ForeignKey(User , related_name="friendship_from")
    toUser = models.ForeignKey(User , related_name="friendship_to")


class NotificationType:
    follow = 0
    uploaded = 1


class Notification(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User)
    type = models.IntegerField(default=0)
    payload = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True,null=True)