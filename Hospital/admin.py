from django.contrib import admin

from .models import User, Patient, Physician, Admin

admin.site.register(User)
admin.site.register(Admin)
admin.site.register(Physician)
admin.site.register(Patient)