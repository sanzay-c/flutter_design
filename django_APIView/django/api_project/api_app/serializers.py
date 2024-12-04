from rest_framework import serializers
from .models import BlogPost, Comment

# creata a serializer
class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'

class BlogPostSerializer(serializers.ModelSerializer):
    comment = CommentSerializer(many=True, read_only=True) # nested comment for get request

    class Meta:
        model = BlogPost
        fields = '__all__'
        
