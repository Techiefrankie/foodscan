from django.urls import path
from .views import upload_photo, recommend

urlpatterns = [
    path('upload_photo/', upload_photo, name='upload_photo'),
    path('recommend/', recommend, name='recommend'),
]
