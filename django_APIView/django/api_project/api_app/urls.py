from django.urls import path
from .views import BlogPostApiView, CommentAPIView

urlpatterns = [
    path('blog_post', BlogPostApiView.as_view(), name='blog_post_list'),
    path('blog_post/<int:blog_post_id>/comments', CommentAPIView.as_view(), name='commebt-list-create')
]