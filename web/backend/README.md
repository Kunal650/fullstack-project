# Django Backend Documentation

This directory contains the Django REST API backend for the full-stack project.

## Structure

```
backend/
├── manage.py                 # Django management script
├── requirements.txt          # Python dependencies
├── env.example              # Environment variables template
├── config/                  # Django settings
│   ├── __init__.py
│   ├── settings.py          # Main settings file
│   ├── urls.py              # URL configuration
│   ├── wsgi.py              # WSGI configuration
│   └── asgi.py              # ASGI configuration
├── apps/                    # Django applications
│   ├── __init__.py
│   ├── core/                # Core utilities
│   ├── users/               # User management
│   └── api/                 # API endpoints
└── logs/                    # Application logs
```

## Features

- **Django REST Framework**: Powerful API framework
- **JWT Authentication**: Secure token-based authentication
- **PostgreSQL Database**: Robust database support
- **CORS Support**: Cross-origin resource sharing
- **API Documentation**: Auto-generated API docs
- **User Management**: Custom user model with profile features
- **Security**: Production-ready security configurations

## Technology Stack

- **Framework**: Django 4.2+
- **API**: Django REST Framework
- **Database**: PostgreSQL
- **Authentication**: JWT (Simple JWT)
- **Documentation**: drf-spectacular
- **CORS**: django-cors-headers
- **Environment**: python-decouple

## Getting Started

### Prerequisites

- Python 3.9+
- PostgreSQL 12+
- pip (Python package manager)

### Installation

1. **Clone and navigate to the backend directory:**
   ```bash
   cd web/backend
   ```

2. **Create a virtual environment:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Set up environment variables:**
   ```bash
   cp env.example .env
   # Edit .env with your configuration
   ```

5. **Set up the database:**
   ```bash
   # Create PostgreSQL database
   createdb project_db
   
   # Run migrations
   python manage.py migrate
   ```

6. **Create a superuser:**
   ```bash
   python manage.py createsuperuser
   ```

7. **Run the development server:**
   ```bash
   python manage.py runserver
   ```

The API will be available at `http://localhost:8000/`

## Environment Configuration

Create a `.env` file with the following variables:

```env
# Django Settings
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

# Database Configuration
DB_NAME=project_db
DB_USER=postgres
DB_PASSWORD=your-password
DB_HOST=localhost
DB_PORT=5432

# Redis Configuration (for Celery)
REDIS_URL=redis://localhost:6379/0

# Email Configuration
EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-password

# JWT Settings
JWT_ACCESS_TOKEN_LIFETIME=60
JWT_REFRESH_TOKEN_LIFETIME=10080
```

## API Endpoints

### Authentication
- `POST /api/v1/auth/register/` - User registration
- `POST /api/v1/auth/login/` - User login
- `POST /api/v1/auth/token/refresh/` - Refresh JWT token
- `GET /api/v1/auth/profile/` - Get user profile
- `PUT /api/v1/auth/update/` - Update user profile

### General
- `GET /api/v1/health/` - Health check endpoint

### API Documentation
- `GET /api/docs/` - Swagger UI documentation
- `GET /api/redoc/` - ReDoc documentation
- `GET /api/schema/` - OpenAPI schema

## Database Models

### User Model
```python
class User(AbstractUser, TimeStampedModel):
    email = models.EmailField(unique=True)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    profile_picture = models.ImageField(upload_to='profile_pictures/', blank=True, null=True)
    is_verified = models.BooleanField(default=False)
```

## Development

### Adding New Apps

1. Create a new Django app:
   ```bash
   python manage.py startapp your_app_name
   ```

2. Add the app to `INSTALLED_APPS` in `settings.py`

3. Create models, serializers, and views

4. Add URL patterns to the main `urls.py`

### API Development

1. **Models**: Define your data models in `models.py`
2. **Serializers**: Create serializers in `serializers.py`
3. **Views**: Implement API views in `views.py`
4. **URLs**: Add URL patterns in `urls.py`

Example:
```python
# models.py
class YourModel(TimeStampedModel):
    name = models.CharField(max_length=100)
    description = models.TextField()

# serializers.py
class YourModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = YourModel
        fields = '__all__'

# views.py
class YourModelViewSet(viewsets.ModelViewSet):
    queryset = YourModel.objects.all()
    serializer_class = YourModelSerializer
    permission_classes = [permissions.IsAuthenticated]
```

### Testing

Run tests using:
```bash
python manage.py test
```

### Database Operations

```bash
# Create migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Load sample data
python manage.py loaddata fixtures/sample_data.json
```

## Production Deployment

### Environment Setup

1. Set `DEBUG=False` in production
2. Use a production database (PostgreSQL)
3. Set up proper `ALLOWED_HOSTS`
4. Use environment variables for sensitive data
5. Set up SSL/HTTPS

### Static Files

```bash
python manage.py collectstatic
```

### Database

Use a production PostgreSQL database with proper backup strategies.

### Security

- Use strong secret keys
- Enable HTTPS
- Set up proper CORS policies
- Use environment variables for sensitive data
- Regular security updates

## Monitoring and Logging

- Logs are stored in the `logs/` directory
- Use Django's built-in logging configuration
- Consider adding external monitoring services

## Performance

- Use database indexing
- Implement caching with Redis
- Use database connection pooling
- Optimize queries with `select_related` and `prefetch_related`

## Troubleshooting

### Common Issues

1. **Database Connection**: Check PostgreSQL service and credentials
2. **Migration Errors**: Ensure all migrations are applied
3. **CORS Issues**: Check CORS settings for frontend domains
4. **Authentication**: Verify JWT token configuration

### Debug Mode

Enable debug mode for development:
```python
DEBUG = True
```

### Logs

Check application logs in the `logs/` directory for error details.
