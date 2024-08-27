# Generated by Django 5.0.7 on 2024-07-18 17:51

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_product_available_sizes'),
    ]

    operations = [
        migrations.CreateModel(
            name='Size',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('size', models.CharField(max_length=10)),
            ],
        ),
        migrations.RemoveField(
            model_name='product',
            name='available_sizes',
        ),
        migrations.AlterField(
            model_name='product',
            name='badge',
            field=models.CharField(default='default_badge', max_length=50),
        ),
        migrations.AlterField(
            model_name='product',
            name='imagePath',
            field=models.CharField(max_length=255),
        ),
        migrations.AlterField(
            model_name='productsize',
            name='product',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='product_sizes', to='api.product'),
        ),
        migrations.AlterField(
            model_name='productsize',
            name='size',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.size'),
        ),
    ]
