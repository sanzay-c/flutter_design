from django.shortcuts import render

# ---- A viewset in DRF is essentially a class 
#   that combines logic for handling HTTP requests
#   (such as GET, POST, PUT, DELETE) ------ 
from rest_framework import viewsets
from .models import Item
from .serializers import ItemSerializer

# Create your views here.
class ItemViewSet(viewsets.ModelViewSet):
    queryset = Item.objects.all() # Get all Item objects
    serializer_class = ItemSerializer  # Use the ItemSerializer to convert the model data into JSON

