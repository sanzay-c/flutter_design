from django.urls import path
from .views import BlogPostApiView, CommentAPIView

urlpatterns = [
    path('blog_post', BlogPostApiView.as_view(), name='blog_post_list'),
    path('blog_post/<int:blog_post_id>/comments', CommentAPIView.as_view(), name='commebt-list-create'),

    path('blog_post/<int:blog_post_id>', BlogPostApiView.as_view(), name='blog_post_detail'),  # For DELETE Blog
    path('blog_post/<int:blog_post_id>/comments/<int:comment_id>', CommentAPIView.as_view(), name='comment-detail'),  # For DELETE comment
]