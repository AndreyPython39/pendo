from typing import List, Optional
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig
from pydantic import EmailStr
from jinja2 import Environment, PackageLoader, select_autoescape
import aiosmtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import asyncio

from app.core.config import settings

class EmailService:
    def __init__(self):
        self.config = {
            'username': settings.SMTP_USER,
            'password': settings.SMTP_PASSWORD,
            'server': settings.SMTP_HOST,
            'port': settings.SMTP_PORT,
            'from_email': settings.MAIL_FROM,
            'from_name': settings.MAIL_FROM_NAME,
            'use_tls': settings.MAIL_TLS,
            'use_ssl': settings.MAIL_SSL,
        }
        
        self.jinja_env = Environment(
            loader=PackageLoader('app', 'templates/email'),
            autoescape=select_autoescape(['html', 'xml'])
        )

    async def send_email(
        self,
        email_to: str,
        subject: str,
        template_name: str,
        template_data: dict,
    ) -> None:
        """
        Send email using template
        """
        template = self.jinja_env.get_template(f"{template_name}.html")
        html = template.render(**template_data)

        message = MIMEMultipart('alternative')
        message['Subject'] = subject
        message['From'] = f"{self.config['from_name']} <{self.config['from_email']}>"
        message['To'] = email_to

        html_part = MIMEText(html, 'html')
        message.attach(html_part)

        if self.config['use_ssl']:
            smtp = aiosmtplib.SMTP(
                hostname=self.config['server'],
                port=self.config['port'],
                use_tls=True,
            )
        else:
            smtp = aiosmtplib.SMTP(
                hostname=self.config['server'],
                port=self.config['port'],
            )

        try:
            await smtp.connect()
            if self.config['use_tls'] and not self.config['use_ssl']:
                await smtp.starttls()
            await smtp.login(self.config['username'], self.config['password'])
            await smtp.send_message(message)
        finally:
            await smtp.quit()

    async def send_verification_code(
        self,
        email_to: str,
        code: str,
    ) -> None:
        """
        Send verification code email
        """
        await self.send_email(
            email_to=email_to,
            subject="Подтвердите ваш email",
            template_name="verification_code",
            template_data={
                "code": code,
                "app_name": settings.PROJECT_NAME,
                "app_logo_url": "https://pendo.ru/logo.png",  # Замените на реальный URL
                "current_year": "2025"
            }
        )

    async def send_welcome_email(
        self,
        email_to: str,
        user_name: str,
    ) -> None:
        """
        Send welcome email
        """
        await self.send_email(
            email_to=email_to,
            subject=f"Добро пожаловать в {settings.PROJECT_NAME}!",
            template_name="welcome",
            template_data={
                "user_name": user_name,
                "app_name": settings.PROJECT_NAME,
                "app_logo_url": "https://pendo.ru/logo.png",  # Замените на реальный URL
                "app_url": "https://pendo.ru",  # Замените на реальный URL
                "help_url": "https://pendo.ru/help",  # Замените на реальный URL
                "current_year": "2025"
            }
        )

    async def send_login_code(
        self,
        email_to: str,
        code: str,
    ) -> None:
        """
        Send login code email
        """
        await self.send_email(
            email_to=email_to,
            subject="Ваш код для входа",
            template_name="login_code",
            template_data={
                "code": code,
                "app_name": settings.PROJECT_NAME,
                "app_logo_url": "https://pendo.ru/logo.png",  # Замените на реальный URL
                "current_year": "2025"
            }
        )

    async def send_match_notification(
        self,
        email_to: str,
        match_name: str,
        match_photo: Optional[str] = None,
    ) -> None:
        """
        Send match notification email
        """
        await self.send_email(
            email_to=email_to,
            subject="У вас новая пара!",
            template_name="match_notification",
            template_data={
                "match_name": match_name,
                "match_photo": match_photo,
                "app_name": settings.PROJECT_NAME,
                "app_logo_url": "https://pendo.ru/logo.png",  # Замените на реальный URL
                "chat_url": "https://pendo.ru/chat",  # Замените на реальный URL
                "current_year": "2025"
            }
        )
