"""PhotoChallenge URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add an import:  from blog import urls as blog_urls
    2. Add a URL to urlpatterns:  url(r'^blog/', include(blog_urls))
"""
from PhotoChallengeCore import views
from django.conf.urls import include, url
from django.contrib import admin
from rest_framework.authtoken import views
import PhotoChallengeCore

urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),
    url(r'^signup/', PhotoChallengeCore.views.signup),
    url(r'^token/', views.obtain_auth_token),
    url(r'^categories/', PhotoChallengeCore.views.CategoryView.as_view()),
    url(r'^notifications/', PhotoChallengeCore.views.NotificationView.as_view()),
    url(r'^me/', PhotoChallengeCore.views.MeView.as_view()),
    url(r'^friends/', PhotoChallengeCore.views.FriendshipView.as_view()),
    url(r'^challenges/([0-9]+)', PhotoChallengeCore.views.ChallengeView.as_view()),
    url(r'^image/([0-9]+)', PhotoChallengeCore.views.SubmissionImage.as_view()),
]