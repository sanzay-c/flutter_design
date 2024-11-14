from django.urls import path, include

# ---- DefaultRouter(): This is a DRF class that automatically 
#   generates URL patterns for all the standard actions of a 
#   viewset (such as list(), create(), retrieve(), etc.). --------
from rest_framework.routers import DefaultRouter
from .views import ItemViewSet

# Create a router and register the viewset
router = DefaultRouter()
router.register(r'items', ItemViewSet)

# Include the router URLs in the main URL patterns
urlpatterns = [
    path('api/', include(router.urls)),  # This will automatically generate the URLs for the viewset
]