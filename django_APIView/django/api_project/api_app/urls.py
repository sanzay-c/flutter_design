from django.urls import path
from .views import BlogPostApiView, CommentAPIView, BlogPostUpdateApiView

urlpatterns = [
    path('blog_post', BlogPostApiView.as_view(), name='blog_post_list'),
    path('blog_post/<int:blog_post_id>/comments', CommentAPIView.as_view(), name='commebt-list-create'),

    path('blog_post/<int:blog_post_id>', BlogPostApiView.as_view(), name='blog_post_detail'),  # For DELETE Blog
    path('blog_post/<int:blog_post_id>/comments/<int:comment_id>', CommentAPIView.as_view(), name='comment-detail'),  # For DELETE comment

    path('blog_post/<int:blog_post_id>/update', BlogPostUpdateApiView.as_view(), name='blog_post_update'),  # For PUT (full update)
    path('blog_post/<int:blog_post_id>/partial_update', BlogPostUpdateApiView.as_view(), name='blog_post_partial_update'),  # For PATCH (partial update)
]