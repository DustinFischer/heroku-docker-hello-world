from setuptools import find_packages, setup

setup(
    name='heroku-docker-hello-world',
    version='1.0',
    author='Dustin Fischer',
    author_email='duasfi@gmail.com',
    package_dir={'': 'src'},
    packages=find_packages('src'),
    include_package_data=True,
    install_requires=[
        'flask',
    ]
)
