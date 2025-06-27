import smtplib
import RPi.GPIO as GPIO
import time

# SMTP configuration
smtp_username = "2310-111572@elizabethschool.com"
smtp_password = "eli!zaw37On"
smtp_host = "smtp.office365.com"
smtp_port = 587

smtp_sender = "2310-111572@elizabethschool.com"
smtp_receivers = ["2310-111572@elizabethschool.com"]

# Email messages
message_dead = """From: Moisture Sensor <2310-111572@elizabethschool.com>
To: User <2310-111572@elizabethschool.com>
Subject: Moisture Sensor Notification

Warning, no moisture detected! Plant death imminent!!! :'(
"""

message_alive = """From: Moisture Sensor <2310-111572@elizabethschool.com>
To: User <2310-111572@elizabethschool.com>
Subject: Moisture Sensor Notification

Panic over! Plant has water again :)
"""

# Function to send email
def send_email(smtp_message):
    try:
        with smtplib.SMTP(smtp_host, smtp_port) as smtpObj:
            smtpObj.starttls()
            smtpObj.login(smtp_username, smtp_password)
            smtpObj.sendmail(smtp_sender, smtp_receivers, smtp_message)
        print("Successfully sent email")
    except smtplib.SMTPException as e:
        print(f"Error: unable to send email - {e}")

# Callback function for GPIO event
def callback(channel):
    if GPIO.input(channel):
        print("LED off")
        send_email(message_dead)
    else:
        print("LED on")
        send_email(message_alive)

# GPIO setup
GPIO.setmode(GPIO.BCM)
channel = 17
GPIO.setup(channel, GPIO.IN)

GPIO.add_event_detect(channel, GPIO.BOTH, bouncetime=300)
GPIO.add_event_callback(channel, callback)

# Keep the script running
try:
    while True:
        time.sleep(0.1)
except KeyboardInterrupt:
    GPIO.cleanup()
