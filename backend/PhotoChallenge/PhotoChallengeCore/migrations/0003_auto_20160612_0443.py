# -*- coding: utf-8 -*-
# Generated by Django 1.9.7 on 2016-06-12 04:43
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('PhotoChallengeCore', '0002_remove_category_color'),
    ]

    operations = [
        migrations.AddField(
            model_name='category',
            name='color',
            field=models.TextField(default=''),
        ),
        migrations.AlterField(
            model_name='category',
            name='name',
            field=models.TextField(default=''),
        ),
        migrations.AlterField(
            model_name='challenge',
            name='name',
            field=models.TextField(default=''),
        ),
    ]
