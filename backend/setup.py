"""api python package configuration."""

from setuptools import setup

setup(
    name='api',
    version='1.0.0',
    packages=['api'],
    include_package_data=True,
    install_requires=[
        'Flask==0.12.2',
        'arrow==0.10.0',
        'sh==1.12.14',
    ],
)
