from tkinter import CASCADE
from django.db import models
from django.contrib.auth.models import AbstractUser

#Models for Base User
class User(AbstractUser):
    pass

##Models for Patients
class Patient(models.Model):
    patient = models.OneToOneField(User, on_delete=models.CASCADE)
    def __str__(self):
        return f"{self.patient.first_name} {self.patient.last_name}"

#Models for Physicin
class Physician(models.Model):
    physician = models.OneToOneField(User, on_delete=models.CASCADE)
    def __str__(self):
        return f"{self.physician.first_name} {self.physician.last_name}"

#Models for Staff
class Admin(models.Model):
    admin = models.OneToOneField(User, on_delete=models.CASCADE)
    def __str__(self):
        return f"{self.admin.first_name} {self.admin.last_name}"

class Appointment(models.Model):
    patient = models.ForeignKey("Patient", on_delete=models.CASCADE)
    physician = models.ForeignKey("Physician", on_delete=models.CASCADE)
    time_start = models.DateTimeField()
    time_end = models.DateTimeField()
    next_appointment = models.DateTimeField()
