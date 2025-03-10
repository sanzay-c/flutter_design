from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import BlogPost, Comment
from .serializers import BlogPostSerializer, CommentSerializer
from django.shortcuts import get_object_or_404

# Create your views here.
class BlogPostApiView(APIView):
    # GET request to fetch all blog posts
    def get(self, request):
        Blog_Posts = BlogPost.objects.all()
        serializer = BlogPostSerializer(Blog_Posts, many=True)
        return Response(serializer.data)
    
    # POST request to create a new blog post
    def post(self, request):
        serializer = BlogPostSerializer(data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errror, status=status.HTTP_400_BAD_REQUEST)
    
     # DELETE request to delete a specific blog post
    def delete(self, request, blog_post_id):
        # Fetch the blog post or return a 404 error if it doesn't exist
        blog_post = get_object_or_404(BlogPost, id=blog_post_id)
        
        # Delete the blog post
        blog_post.delete()
        
        # Return a success response
        return Response({"message": "Blog post deleted successfully"}, status=status.HTTP_204_NO_CONTENT)


class BlogPostUpdateApiView(APIView):
    # PUT request to fully update a blog post
    def put(self, request, blog_post_id):
        blog_post = get_object_or_404(BlogPost, id=blog_post_id)
        serializer = BlogPostSerializer(blog_post, data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # PATCH request to partially update a blog post
    def patch(self, request, blog_post_id):
        blog_post = get_object_or_404(BlogPost, id=blog_post_id)
        serializer = BlogPostSerializer(blog_post, data=request.data, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

class CommentAPIView(APIView):
    # GET request to fetch all the data 
    def get(self, request, blog_post_id):
        try:
            blog_post = BlogPost.objects.get(id=blog_post_id)
        except BlogPost.DoesNotExist:
            return Response({"Error": "Blog post not found"}, status=status.HTTP_404_NOT_FOUND)
        
        # Get all the comments fromt the blog post
        comments = blog_post.comments.all()
        serializer = CommentSerializer(comments, many=True)
        return Response(serializer.data)
    
    # POST request
    def post(self, request, blog_post_id):
        try:
            blog_post = BlogPost.objects.get(id=blog_post_id)
        except blog_post.DoesNotExist:
            return Response({"Error": "Blog post not found"}, status=status.HTTP_404_NOT_FOUND)
        
        # Add the blog_post ID to the comment data and create a comment
        data = request.data
        data['blog_post'] = blog_post.id
        serializer = CommentSerializer(data=data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    # DELETE request to delete a specific comment
    def delete(self, request, blog_post_id, comment_id):
        try:
            # Fetch the comment or return a 404 error if it doesn't exist
            comment = Comment.objects.get(id=comment_id, blog_post_id=blog_post_id)
        except Comment.DoesNotExist:
            return Response({"Error": "Comment not found"}, status=status.HTTP_404_NOT_FOUND)
        
        # Delete the comment
        comment.delete()
        
        # Return a success response
        return Response({"message": "Comment deleted successfully"}, status=status.HTTP_204_NO_CONTENT)

'''
The post Method (POST Request)
This method is used to create a new comment for a specific blog post.

Input: It receives a blog_post_id (the ID of the blog post) and some comment data in the request body.

Process:

It first tries to find the blog post by the blog_post_id. If it doesn't exist, it returns an error.
It then adds the blog post ID to the comment data (so the comment can be related to the correct blog post).
After that, the comment data is validated using the CommentSerializer (checking if the data is correct, like if the text is valid).
Output:

If the comment data is valid, it saves the comment to the database and returns the created comment's data with a 201 Created status.
If the comment data is invalid (e.g., missing required fields), it returns the errors with a 400 Bad Request status.
Error handling: If the blog post doesn't exist, it returns a 404 Not Found error.
'''