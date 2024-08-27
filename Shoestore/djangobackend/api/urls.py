from django.urls import path
from .views import (
    CreateOrderView, FavoriteDeleteView, FavoriteListCreateView, LoginAPI, NotificationListView, OrderCreateAPI, OrderDetailView, 
    RegisterAPI, UserListAPI, ProductListCreateAPI, ProductDetailAPI, 
    OrderDetailAPI, NotificationListCreateAPI, NotificationDetailAPI, UserProfileDetailView, create_payment, execute_payment
)

urlpatterns = [
    path('login/', LoginAPI.as_view(), name='login'),
    path('register/', RegisterAPI.as_view(), name='register'),
    path('users/', UserListAPI.as_view(), name='user-list'),
    path('products/', ProductListCreateAPI.as_view(), name='product-list-create'),
    path('products/<int:pk>/', ProductDetailAPI.as_view(), name='product-detail'),
    path('orders/', OrderCreateAPI.as_view(), name='order-create'),
    path('orders/<int:id>/', OrderDetailAPI.as_view(), name='order-detail'),
    path('favorites/', FavoriteListCreateView.as_view(), name='favorite-list-create'),
    path('favorites/<int:pk>/', FavoriteDeleteView.as_view(), name='favorite-delete'),
    path('api/notifications/', NotificationListView.as_view(), name='notification-list'),
    path('notifications/<int:pk>/', NotificationDetailAPI.as_view(), name='notification-detail'),
    path('profile/', UserProfileDetailView.as_view(), name='user-profile-detail'),
    path('paypal/create-payment', create_payment, name='create-payment'),
    path('paypal/execute-payment', execute_payment, name='execute-payment'),
    path('create-order/', CreateOrderView.as_view(), name='create-order'),
    path('order/<int:order_id>/', OrderDetailView.as_view(), name='order-detail'),
]