from django.shortcuts import render

# Create your views here.
def home_page(request):
    return render(request, "Hospital/home_page.html")

def appointment(request):
    return render(request, "Hospital/appointment.html")

def ambulance(request):
    return render(request, "Hospital/ambulance.html")

def registration(request):
    return render(request, "Hospital/registration.html")

def payment(request):
    return render(request, "Hospital/payment.html")

def login(request):
    return render(request, "Hospital/login.html")

def drug(request):
    return render(request, "Hospital/drug.html")