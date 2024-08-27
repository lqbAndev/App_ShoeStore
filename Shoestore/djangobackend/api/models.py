from django.conf import settings
from django.db import models
from django.contrib.auth.models import User


class Student(models.Model):
    stuname = models.CharField(max_length=100)
    email = models.CharField(max_length=100)

class Product(models.Model):
    title = models.CharField(max_length=100)
    imagePath = models.ImageField(upload_to='products/')
    price = models.DecimalField(max_digits=10, decimal_places=2)
    old_price = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    badge = models.CharField(max_length=50, blank=True, null=True)
    description = models.TextField()
    colors = models.JSONField(default=list)  # Danh sách các màu
    sizes = models.JSONField(default=list)   # Danh sách các kích thước
    brand = models.CharField(max_length=50, blank=True, null=True)
    notification = models.CharField(max_length=20, default='Không thông báo')

    def __str__(self):
        return self.title

class Order(models.Model):
    uyser = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, default=1)
    created_at = models.DateTimeField(auto_now_add=True)
    address = models.CharField(max_length=255)
    payment_method = models.CharField(max_length=50)
    total = models.DecimalField(max_digits=10, decimal_places=2)
    
    # other fields


class OrderItem(models.Model):
    order = models.ForeignKey(Order, related_name='items', on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE, default=1) 
    quantity = models.PositiveIntegerField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    # other fields

class Favorite(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    added_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'product')

    def __str__(self):
        return f"{self.user.username} - {self.product.title}"

class Notification(models.Model):
    product = models.ForeignKey(Product, related_name='product_notifications', on_delete=models.CASCADE)
    message = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.message
    
class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    gender = models.CharField(max_length=10, blank=True, null=True)
    birthdate = models.DateField(blank=True, null=True)
    address = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.user.username