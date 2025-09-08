# Frontend Documentation

This directory contains the frontend web application built with HTML, CSS, and JavaScript.

## Structure

```
frontend/
├── index.html          # Main HTML file
├── css/
│   ├── styles.css      # Main stylesheet
│   └── responsive.css  # Responsive design styles
├── js/
│   └── app.js         # Main JavaScript application
└── README.md          # This file
```

## Features

- **Responsive Design**: Mobile-first approach with breakpoints for all screen sizes
- **Modern UI**: Clean, professional design with CSS Grid and Flexbox
- **Interactive Elements**: Smooth animations, modals, and form handling
- **API Integration**: Ready to connect with Django REST API
- **Authentication**: Login/Register modals with JWT token handling
- **Accessibility**: ARIA labels, keyboard navigation, and screen reader support

## Getting Started

1. Open `index.html` in a web browser
2. The application will automatically connect to the Django backend at `http://localhost:8000`
3. Use the navigation to explore different sections

## API Endpoints

The frontend is configured to work with these backend endpoints:

- `POST /api/v1/auth/register/` - User registration
- `POST /api/v1/auth/login/` - User login
- `POST /api/v1/auth/token/refresh/` - Token refresh
- `GET /api/v1/auth/profile/` - User profile
- `PUT /api/v1/auth/update/` - Update user profile
- `GET /api/v1/health/` - Health check

## Customization

### Colors and Theming

The CSS uses CSS custom properties (variables) for easy theming. Main variables are defined in `:root`:

```css
:root {
    --primary-color: #3b82f6;
    --secondary-color: #64748b;
    --accent-color: #f59e0b;
    /* ... more variables */
}
```

### Adding New Sections

1. Add HTML structure to `index.html`
2. Add corresponding styles to `styles.css`
3. Add responsive styles to `responsive.css`
4. Add any JavaScript functionality to `app.js`

## Browser Support

- Chrome 60+
- Firefox 60+
- Safari 12+
- Edge 79+

## Performance

- Optimized images and assets
- Minimal JavaScript bundle
- CSS Grid and Flexbox for layout
- Smooth animations with `transform` and `opacity`

## Development

For development, you can use a simple HTTP server:

```bash
# Python 3
python -m http.server 8000

# Node.js (if you have http-server installed)
npx http-server

# PHP
php -S localhost:8000
```

Then open `http://localhost:8000` in your browser.

