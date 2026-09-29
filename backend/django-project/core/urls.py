from django.contrib import admin
from django.http import HttpResponse
from django.urls import path


def home_view(request):
    return HttpResponse(
        "<h1>Infrastruktur Django 5 Berjalan Sempurna! (Upwork Project)</h1>"
    )


urlpatterns = [
    path("admin/", admin.site.urls),
    path("", home_view),
]
