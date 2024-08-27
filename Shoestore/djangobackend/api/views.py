from rest_framework import generics, status
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from django.contrib.auth.models import User
from .serializers import FavoriteSerializer, NotificationSerializer, UserSerializer, RegisterSerializer
from rest_framework.decorators import api_view
from rest_framework.permissions import AllowAny
from rest_framework import generics
from .models import Favorite, Notification, OrderItem, Product, Order
from .serializers import ProductSerializer, OrderSerializer
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework import generics, permissions
from rest_framework.views import APIView
from django.shortcuts import render
from django.http import JsonResponse
import paypalrestsdk

class LoginAPI(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        try:
            response = super(LoginAPI, self).post(request, *args, **kwargs)
            token = Token.objects.get(key=response.data['token'])
            return Response({
                'token': token.key, 
                'user_id': token.user_id, 
                'username': token.user.username
            })
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)

class RegisterAPI(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
    permission_classes = [AllowAny]

class UserListAPI(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    
class ProductListCreateAPI(generics.ListCreateAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

class ProductDetailAPI(generics.RetrieveUpdateDestroyAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    @action(detail=True, methods=['put'])
    def update_product(self, request, pk=None):
        product = self.get_object()
        serializer = ProductSerializer(product, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=400)
    
class OrderCreateAPI(generics.CreateAPIView):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            order = serializer.save()
            # Giả sử bạn có một trường 'items' trong dữ liệu gửi lên
            items_data = request.data.get('items', [])
            for item_data in items_data:
                OrderItem.objects.create(
                    order=order,
                    product_id=item_data['product'],
                    quantity=item_data['quantity'],
                    price=item_data['price'],
                )
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CreateOrderView(APIView):
    def post(self, request, *args, **kwargs):
        serializer = OrderSerializer(data=request.data)
        if serializer.is_valid():
            order = serializer.save()
            return Response({'order_id': order.id}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
     
class OrderDetailAPI(generics.RetrieveDestroyAPIView):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    lookup_field = 'id'
class OrderDetailView(APIView):
    def get(self, request, order_id, *args, **kwargs):
        try:
            order = Order.objects.get(id=order_id)
            serializer = OrderSerializer(order)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Order.DoesNotExist:
            return Response({"error": "Order not found"}, status=status.HTTP_404_NOT_FOUND)
        
class FavoriteListCreateView(generics.ListCreateAPIView):
    permission_classes = [permissions.IsAuthenticated] # type: ignore
    serializer_class = FavoriteSerializer

    def get_queryset(self):
        return Favorite.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        product_id = self.request.data.get('product_id')
        product = Product.objects.get(id=product_id)
        serializer.save(user=self.request.user, product=product)

class FavoriteDeleteView(APIView): 
    permission_classes = [permissions.IsAuthenticated] 

    def delete(self, request, pk, format=None):
        favorite = Favorite.objects.get(pk=pk, user=request.user)
        favorite.delete()
        return Response(status=204)
    
class NotificationListCreateAPI(generics.ListCreateAPIView):
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer

    def get_queryset(self):
        # Lọc thông báo dựa trên trạng thái sản phẩm
        return Notification.objects.filter(product__notification='Thông báo')

class NotificationDetailAPI(generics.RetrieveUpdateDestroyAPIView):
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer

class NotificationListView(generics.ListAPIView):
    serializer_class = ProductSerializer

    def get_queryset(self):
        return Product.objects.filter(notification='Thông báo')
    
class UserProfileDetailView(generics.RetrieveUpdateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_object(self):
        return self.request.user
    
# views.py
from django.shortcuts import render
from django.http import JsonResponse
import paypalrestsdk

paypalrestsdk.configure({
    "mode": "sandbox",  # or "live"
    "client_id": "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
    "client_secret": "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
})

def create_payment(request):
    total = request.POST.get('total')
    payment = paypalrestsdk.Payment({
        "intent": "sale",
        "payer": {
            "payment_method": "paypal"
        },
        "redirect_urls": {
            "return_url": "http://your-django-api-url/paypal/execute-payment",
            "cancel_url": "http://your-django-api-url/paypal/cancel"
        },
        "transactions": [{
            "amount": {
                "total": total,
                "currency": "USD"
            },
            "description": "Your order description"
        }]
    })

    if payment.create():
        approval_url = [link['href'] for link in payment['links'] if link['rel'] == 'approval_url'][0]
        return JsonResponse({'approval_url': approval_url, 'payment_id': payment.id})
    else:
        return JsonResponse({'error': 'Payment creation failed'}, status=500)

def execute_payment(request):
    payment_id = request.POST.get('payment_id')
    payer_id = request.POST.get('payer_id')

    payment = paypalrestsdk.Payment.find(payment_id)
    if payment.execute({"payer_id": payer_id}):
        return JsonResponse({'status': 'Payment executed'})
    else:
        return JsonResponse({'error': 'Payment execution failed'}, status=500)