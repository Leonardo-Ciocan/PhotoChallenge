import uuid
from PhotoChallengeCore.utils import get_file_path
from django.contrib.auth.models import User
from django.db import models
import os


class Category(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.TextField()


class Challenge(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.TextField()
    category = models.ForeignKey(Category)


class Submission(models.Model):
    id = models.AutoField(primary_key=True)
    file = models.FileField(upload_to=get_file_path,
                            null=True, blank=True, default=None)
    user = models.ForeignKey(User)