from rest_framework import serializers
from .models import Item    # here the 'Item' means the model name

class ItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item         # The model to serialize
        fields = '__all__'   # All fields in the Item model will be included
        
    

#--- if the field is this:
# fields = ['id', 'title', 'author', 'published_date']  # Specifies which fields to include
