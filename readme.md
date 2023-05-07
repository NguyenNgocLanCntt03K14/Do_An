# Shopify Orders and Auth.net Transaction Export
## Description:
The project to assists managers in reporting their transactions to make sure that all records matches  
from shopify orders to Auth.net transactions.  
Admin users should be able to login and select a range of date to export a report.  
The reports should container required fields, coming from a **joint** data between **shopify transactions, orders** and  
**auth.net transactions** by **joining Authenticate Key**.  

## Schedule Tasks:
There should be a schedule task to run daily to collect orders, transactions from both shopify and auth.net  
for later report / export.  
The tasks can also be run  via cli:  
```
php -f index.php orders/import-daily
```
and  
```
php -f index.php authnet_transaction/import-daily
```

## Authentication:
System will support **2 way authentication**:  

- After enter correct username and password, an email with a random code will be sent to the current user
- User will have to enter the correct code to access the system


## Users management:
System will also manage users in a minimal way as follow:  

1. System will allow user to reset their password via a forgot-password interface with protocol:
    - User will enter a username: if account is found, an email with generated token will be sent in assisting with the process.  
    - User will have to click on that link within  15 mins to continue with the reseting password process
2. CLI for admin only: Only cli admin user can perform the following tasks:
    - Add new User:
        ```
        php -f index.php user/add
        ```
        A prompt will ask for some basic information and create a unique user with a random password. 
    - Remove a User:  
        ```
        php -f index.php user/remove
        ```
        A prompt will ask for user login. If found,  system will *try to confirm* removal before processing the removing process.  
    - Update password: 
        ```
        php -f index.php user/update-password
        ```
        A Prompt will ask for login. If found then will continue with password *twice*. If match then system will *attempt to confirm* password change  
        before really change the password.


## API Reference:
1. Shopify API - [Orders](https://shopify.dev/docs/api/admin-rest/2023-01/resources/transaction)
2. Auth.net  API - [Transaction Report](https://developer.authorize.net/api/reference/index.html#transaction-reporting)
3. Sendgrid API - [Using dynamic template](https://docs.sendgrid.com/ui/sending-email/how-to-send-an-email-with-dynamic-templates)



# Development
## Framework: 
1. Codeigniter 3.2.1
2. Packages: 
    - phpclassic/php-shopify
    - vlucas/phpdotenv

## Start Container
Team member can run: 
```
./restart-gw-export-container.sh
```
To start a development container.  
**Note:** An image hutgate/php74-dev is needed. If not, please refer to the build protocol to  
build the required image to continue

## File restart-gw-export-container.sh
The basic of the file is to start development container with apache server watching  
folder src and load overwrite configuration for apache2 in **./config** folder.

### Container Name
Developer can change variable ```__container_name``` to any value required.

### Change port
Developer can change variable ```__http_default_port``` to any port necessary.

### Network
Developer can change variable ```__the_network``` to any network necessary.

## Config./
Team can feel free to modify php.ini-production to add additional configuration required.

# ENV
The following are the required env entries for the application 
```
ROOT_PATH=/var/www/html
ENVIRONMENT=development
BASE_URL=
TIMEZONE=America/Los_Angeles
ENCRYPTION_KEY=
ASSETS_VERSION=r0321221154
SESSION_PATH=${ROOT_PATH}/_sess
ASSETS_PATH=${ROOT_PATH}/public/theme/
DEBUG_LEVEL=4
COOKIE_NAME=
SHOPIFY_SHOP_URL=
SHOPIFY_ADMIN_ACCESS_TOKEN=
SHOPIFY_API_KEY=
SHOPIFY_API_VERSION=2022-07
SHOPIFY_DF_PER_PAGE=250
AUTHNET_LOGIN_ID=
AUTHNET_TRANSACTION_KEY=
SG_API_KEY=
SG_ID_TEMPLATE_FORGET_PASSWORD=
SG_SENDING_FROM=
DB_HOST=
DB_PASSWORD=
DB_USER=
DB_NAME=
DB_PORT=
USE_TWO_WAY_AUTH
```


# USE TWO WAY AUTH 
If the value is equal to 1, it will perform login through two classes, login normally and confirm the otp code

# Tests
## Send email via sendgrid
Dev can update this method to test out sending email method
```
php -f index.php sendgrid/send
```
