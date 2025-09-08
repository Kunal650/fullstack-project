# Project Setup Guide

This guide will help you set up and run the full-stack project with web frontend/backend, Android, and iOS applications.

## Prerequisites

### General Requirements
- Git
- Node.js 16+ (for frontend development)
- Python 3.9+ (for backend)
- PostgreSQL 12+ (for database)

### Web Development
- Modern web browser
- Code editor (VS Code recommended)

### Android Development
- Android Studio Arctic Fox or later
- JDK 8 or later
- Android SDK 24+ (minimum), 34 (target)

### iOS Development
- macOS 13.0 or later
- Xcode 15.0 or later
- iOS 17.0+ device or simulator

## Quick Start with Docker

The easiest way to get started is using Docker Compose:

```bash
# Clone the repository
git clone <repository-url>
cd project-directory

# Start all services
docker-compose up -d

# The backend will be available at http://localhost:8000
# API documentation at http://localhost:8000/api/docs/
```

## Manual Setup

### 1. Backend Setup (Django)

```bash
# Navigate to backend directory
cd web/backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Set up environment variables
cp env.example .env
# Edit .env with your configuration

# Set up database
createdb project_db  # PostgreSQL command

# Run migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Start development server
python manage.py runserver
```

The backend will be available at `http://localhost:8000`

### 2. Frontend Setup (HTML/CSS/JS)

```bash
# Navigate to frontend directory
cd web/frontend

# Serve the frontend (choose one method)

# Method 1: Python HTTP server
python -m http.server 8001

# Method 2: Node.js http-server
npx http-server -p 8001

# Method 3: PHP server
php -S localhost:8001
```

The frontend will be available at `http://localhost:8001`

### 3. Android Setup

```bash
# Navigate to Android directory
cd android

# Open in Android Studio
# File -> Open -> Select the 'android' folder

# Or use command line
./gradlew build
```

### 4. iOS Setup

```bash
# Navigate to iOS directory
cd ios

# Open in Xcode
open ProjectApp.xcodeproj

# Or use command line
xcodebuild -project ProjectApp.xcodeproj -scheme ProjectApp build
```

## Configuration

### Backend Configuration

1. **Database Setup:**
   - Install PostgreSQL
   - Create database: `createdb project_db`
   - Update `.env` file with database credentials

2. **Environment Variables:**
   ```env
   SECRET_KEY=your-secret-key-here
   DEBUG=True
   DB_NAME=project_db
   DB_USER=postgres
   DB_PASSWORD=your-password
   ```

3. **API Configuration:**
   - Update `ALLOWED_HOSTS` for production
   - Configure CORS settings for frontend domains
   - Set up email configuration for user verification

### Frontend Configuration

1. **API Endpoints:**
   - Update API base URL in `js/app.js`
   - Configure authentication endpoints
   - Set up error handling

2. **Styling:**
   - Customize CSS variables in `css/styles.css`
   - Update color scheme and branding
   - Modify responsive breakpoints

### Mobile Configuration

1. **Android:**
   - Update `build.gradle` with your package name
   - Configure signing keys for release builds
   - Update API endpoints in network configuration

2. **iOS:**
   - Update bundle identifier in Xcode project
   - Configure development team for code signing
   - Update API endpoints in networking code

## Development Workflow

### 1. Backend Development

```bash
# Start development server
python manage.py runserver

# Run tests
python manage.py test

# Create migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser
```

### 2. Frontend Development

```bash
# Serve frontend
python -m http.server 8001

# Open browser to http://localhost:8001
# Make changes to HTML, CSS, or JS files
# Refresh browser to see changes
```

### 3. Mobile Development

**Android:**
- Open project in Android Studio
- Use emulator or physical device
- Build and run (Shift+F10)

**iOS:**
- Open project in Xcode
- Select simulator or device
- Build and run (⌘+R)

## API Testing

### Using the API Documentation

1. Visit `http://localhost:8000/api/docs/` for Swagger UI
2. Visit `http://localhost:8000/api/redoc/` for ReDoc
3. Test endpoints directly in the browser

### Using curl

```bash
# Health check
curl http://localhost:8000/api/v1/health/

# User registration
curl -X POST http://localhost:8000/api/v1/auth/register/ \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","username":"testuser","first_name":"Test","last_name":"User","password":"testpass123","password_confirm":"testpass123"}'

# User login
curl -X POST http://localhost:8000/api/v1/auth/login/ \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"testpass123"}'
```

## Troubleshooting

### Common Issues

1. **Database Connection Error:**
   - Ensure PostgreSQL is running
   - Check database credentials in `.env`
   - Verify database exists

2. **Port Already in Use:**
   - Change port in settings or kill existing process
   - Use `lsof -i :8000` to find process using port

3. **CORS Errors:**
   - Check CORS settings in Django
   - Ensure frontend URL is in `CORS_ALLOWED_ORIGINS`

4. **Mobile Build Errors:**
   - Check Android SDK installation
   - Verify Xcode and iOS SDK versions
   - Update dependencies

### Getting Help

1. Check the individual README files in each directory
2. Review error logs in the backend `logs/` directory
3. Check browser console for frontend errors
4. Review Xcode/Android Studio build logs

## Production Deployment

### Backend Deployment

1. Set up production database
2. Configure environment variables
3. Set `DEBUG=False`
4. Use production WSGI server (Gunicorn)
5. Set up reverse proxy (Nginx)
6. Configure SSL/HTTPS

### Frontend Deployment

1. Optimize assets
2. Deploy to static hosting (Netlify, Vercel, etc.)
3. Configure custom domain
4. Set up CDN if needed

### Mobile Deployment

1. **Android:**
   - Generate signed APK/AAB
   - Upload to Google Play Store
   - Configure app signing

2. **iOS:**
   - Archive app in Xcode
   - Upload to App Store Connect
   - Submit for review

## Next Steps

1. **Customize the project** to your specific needs
2. **Add new features** following the established patterns
3. **Set up CI/CD** for automated testing and deployment
4. **Add monitoring** and logging for production
5. **Implement additional security** measures
6. **Add comprehensive testing** coverage

## Support

For questions and support:
- Check the documentation in each directory
- Review the code comments and examples
- Create issues in the project repository
