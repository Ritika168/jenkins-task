# Use official Nginx image as base
FROM nginx:alpine

# Remove default Nginx static content
RUN rm -rf /usr/share/nginx/html/*

# Copy our website files to Nginx
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx (runs in foreground)
CMD ["nginx", "-g", "daemon off;"]
