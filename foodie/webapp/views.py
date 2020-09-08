from django.shortcuts import render

import os
import random

from .models import Photo


def home(request):
    return render(request, 'webapp/home.html')


def recommend(request):
    if request.method == 'POST':
        image = request.FILES.get('photo')
        photo = Photo.objects.create(img=image)
        pred = get_random_img()
        recommendation = {"photo": photo, "recommendation": pred, "before": "Uploaded Image", "after": "Recommendation"}

        return render(request, 'webapp/home.html', recommendation)


def get_random_img():
    num = random.randint(1, 148)
    if num < 10:
        return f'000{num}.jpg'
    elif num < 100:
        return f'00{num}.jpg'
