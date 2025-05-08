# Use the official NGINX image as the base
FROM nginx:alpine

# Copy custom NGINX configuration (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Copy static website files into the container
COPY ./index.html /usr/share/nginx/html/

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
