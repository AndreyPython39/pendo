import random
import string

class PasswordService:
    def __init__(self):
        self.lowercase = string.ascii_lowercase
        self.uppercase = string.ascii_uppercase
        self.digits = string.digits
        self.special = '!@#$%^&*()'
        
    def generate_password(self, length: int = 12) -> str:
        """
        Генерирует надежный пароль заданной длины
        """
        if length < 8:
            length = 8  # Минимальная длина для безопасности

        # Гарантируем наличие всех типов символов
        password = [
            random.choice(self.lowercase),
            random.choice(self.uppercase),
            random.choice(self.digits),
            random.choice(self.special)
        ]

        # Добавляем остальные символы
        remaining_length = length - len(password)
        all_chars = self.lowercase + self.uppercase + self.digits + self.special
        
        for _ in range(remaining_length):
            password.append(random.choice(all_chars))

        # Перемешиваем пароль
        random.shuffle(password)
        
        return ''.join(password)

    def generate_memorable_password(self) -> str:
        """
        Генерирует запоминающийся пароль в формате: Слово + Число + Символ
        Например: Butterfly42!
        """
        words = [
            "Butterfly", "Dolphin", "Rainbow", "Sunset", "Mountain",
            "Ocean", "Forest", "Galaxy", "Phoenix", "Dragon",
            "Tiger", "Eagle", "Panda", "Turtle", "Penguin"
        ]
        
        password = [
            random.choice(words),
            str(random.randint(10, 99)),
            random.choice(self.special)
        ]
        
        return ''.join(password)

    def is_strong_password(self, password: str) -> bool:
        """
        Проверяет, является ли пароль надежным
        """
        if len(password) < 8:
            return False
            
        has_lower = any(c in self.lowercase for c in password)
        has_upper = any(c in self.uppercase for c in password)
        has_digit = any(c in self.digits for c in password)
        has_special = any(c in self.special for c in password)
        
        return all([has_lower, has_upper, has_digit, has_special])
