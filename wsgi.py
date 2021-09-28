# ----------------------------------------------------------------------------#
# Launch.
# ----------------------------------------------------------------------------#
import os

from dotenv import load_dotenv

from src.app.hello import create_app

basedir = os.path.abspath(os.path.dirname(__file__))
load_dotenv(os.path.join(basedir, os.getenv('DOT_ENV', '.env')))

app = create_app(os.getenv('FLASK_CONFIG', 'dev'))

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)
