# -*- coding: utf-8 -*-
# Generated by Django 1.9.7 on 2016-06-13 13:42
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('PhotoChallengeCore', '0007_notification'),
    ]

    operations = [
        migrations.AddField(
            model_name='notification',
            name='timestamp',
            field=models.DateTimeField(auto_now_add=True, null=True),
        ),
    ]