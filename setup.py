from setuptools import setup, find_packages

setup(
    name="pendo",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        "fastapi",
        "uvicorn",
        "sqlalchemy",
        "alembic",
    ],
)
