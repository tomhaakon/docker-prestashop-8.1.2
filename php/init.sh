#!/bin/bash

# The directory where PrestaShop is supposed to be installed
PRESHOP_DIR="/var/www/html"

# The directory for the theme
THEME_DIR="$PRESHOP_DIR/themes/panda"

# Check if PrestaShop is installed (adjust the check as needed)
if [ -f "$PRESHOP_DIR/config/settings.inc.php" ]; then
    echo "PrestaShop is installed, proceeding to install the theme."

    # If the theme is not already expanded, unzip it
    if [ ! -d "$THEME_DIR" ]; then
        echo "Unzipping theme..."
        unzip /tmp/panda.zip -d "$PRESHOP_DIR/themes/"
        chown -R www-data:www-data "$THEME_DIR"
    fi

    # Run PrestaShop CLI to install the theme
    php "$PRESHOP_DIR/bin/console" prestashop:theme:install "$THEME_DIR"
else
    echo "PrestaShop is not installed. Skipping theme installation."
fi

# Now call the original entrypoint
exec docker-php-entrypoint apache2-foreground





# #!/bin/bash

# THEME_DIR="/var/www/html/themes/panda"

# if [ ! -d "$THEME_DIR" ]; then
#     echo "Panda theme not found, copying..."
#     mkdir -p $THEME_DIR
#     # Assume panda.zip is already in the image at /tmp/panda.zip
#     unzip /tmp/panda.zip -d $THEME_DIR
#     chown -R www-data:www-data $THEME_DIR
# fi

# # Now call the original entrypoint
# #exec docker-php-entrypoint apache2-foreground
