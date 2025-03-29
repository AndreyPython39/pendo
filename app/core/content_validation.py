import magic
import re
from typing import List, Optional, Set
from fastapi import HTTPException, UploadFile
from app.core.config import settings

class ContentValidator:
    # Запрещенные слова (можно расширить)
    FORBIDDEN_WORDS: Set[str] = {
        "spam", "scam", "hack", "crack",
        # Добавьте другие запрещенные слова
    }

    # Регулярные выражения для проверки
    PHONE_PATTERN = re.compile(r'\+?[\d\-\(\)\s]{10,}')
    EMAIL_PATTERN = re.compile(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')
    URL_PATTERN = re.compile(r'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+')

    @classmethod
    def validate_text_content(
        cls,
        text: str,
        check_contacts: bool = True,
        check_urls: bool = True,
        check_forbidden: bool = True,
        max_length: Optional[int] = None
    ) -> List[str]:
        """
        Validates text content and returns list of validation errors
        """
        errors = []

        # Check length
        if max_length and len(text) > max_length:
            errors.append(f"Text exceeds maximum length of {max_length} characters")

        # Check for forbidden words
        if check_forbidden:
            found_words = [word for word in cls.FORBIDDEN_WORDS if word.lower() in text.lower()]
            if found_words:
                errors.append(f"Text contains forbidden words: {', '.join(found_words)}")

        # Check for contact information
        if check_contacts:
            if cls.PHONE_PATTERN.search(text):
                errors.append("Text contains phone number")
            if cls.EMAIL_PATTERN.search(text):
                errors.append("Text contains email address")

        # Check for URLs
        if check_urls and cls.URL_PATTERN.search(text):
            errors.append("Text contains URLs")

        return errors

    @classmethod
    async def validate_image(cls, file: UploadFile) -> None:
        """
        Validates image file
        Raises HTTPException if validation fails
        """
        # Check file size
        content = await file.read()
        await file.seek(0)  # Reset file pointer
        
        if len(content) > settings.MAX_UPLOAD_SIZE:
            raise HTTPException(
                status_code=400,
                detail=f"File size exceeds maximum limit of {settings.MAX_UPLOAD_SIZE/1024/1024}MB"
            )

        # Check file type using python-magic
        mime_type = magic.from_buffer(content, mime=True)
        if mime_type not in settings.ALLOWED_IMAGE_TYPES:
            raise HTTPException(
                status_code=400,
                detail=f"File type {mime_type} not allowed. Allowed types: {', '.join(settings.ALLOWED_IMAGE_TYPES)}"
            )

    @classmethod
    def validate_profile_data(cls, data: dict) -> List[str]:
        """
        Validates user profile data
        """
        errors = []

        # Validate bio
        if "bio" in data:
            bio_errors = cls.validate_text_content(
                data["bio"],
                check_contacts=True,
                check_urls=True,
                max_length=500
            )
            errors.extend([f"Bio: {error}" for error in bio_errors])

        # Validate interests
        if "interests" in data and isinstance(data["interests"], list):
            for interest in data["interests"]:
                interest_errors = cls.validate_text_content(
                    interest,
                    check_contacts=True,
                    check_urls=True,
                    max_length=50
                )
                errors.extend([f"Interest '{interest}': {error}" for error in interest_errors])

        return errors

    @classmethod
    def validate_tribe_data(cls, data: dict) -> List[str]:
        """
        Validates tribe data
        """
        errors = []

        # Validate name
        if "name" in data:
            name_errors = cls.validate_text_content(
                data["name"],
                check_contacts=True,
                check_urls=True,
                max_length=100
            )
            errors.extend([f"Name: {error}" for error in name_errors])

        # Validate description
        if "description" in data:
            desc_errors = cls.validate_text_content(
                data["description"],
                check_contacts=True,
                check_urls=True,
                max_length=1000
            )
            errors.extend([f"Description: {error}" for error in desc_errors])

        return errors

    @classmethod
    def validate_message(cls, content: str) -> List[str]:
        """
        Validates chat message content
        """
        return cls.validate_text_content(
            content,
            check_contacts=True,
            check_urls=False,  # Allow URLs in messages
            max_length=2000
        )
