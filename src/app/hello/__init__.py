from config import Config

from flask import Flask
from flask_cors import CORS


def create_app(config_class=None):
    # create the app
    app = Flask(__name__)

    # configure the app
    app.config.from_object(config_class or Config)

    # Add CORS to api endpoints
    CORS(app, resources={r"/*": {"origins": "*"}})

    @app.after_request
    def after_request(response):
        """
        Add CORS headers after each request.
        """
        response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization,true')
        response.headers.add('Access-Control-Allow-Methods', 'GET,POST,PATCH,DELETE,OPTIONS')
        return response

    @app.route('/')
    def index():
        return 'Hello World!!!'
    return app
