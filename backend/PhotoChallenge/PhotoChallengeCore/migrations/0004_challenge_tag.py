# -*- coding: utf-8 -*-
# Generated by Django 1.9.7 on 2016-06-12 05:37
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('PhotoChallengeCore', '0003_auto_20160612_0443'),
    ]

    operations = [
        migrations.AddField(
            model_name='challenge',
            name='tag',
            field=models.TextField(default=''),
        ),
    ]
