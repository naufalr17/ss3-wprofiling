Profile PHP applications with xhgui and xhprof on docker
========================================================

to validate and build images run:
```bash
docker-compose build
```

to use run 
```bash
docker-compose up -d`
```

if you want to update the docker via docker compose run:
```bash
docker compose down`
```

[Detailed tutorial here for setting up xhgui_config.php.](https://baptiste.bouchereau.pro/tutorial/profile-php-applications-with-xhgui-and-xhprof-on-docker/)

Usage
-----

Run

```bash
git clone https://github.com/Ovski4/tutorials.git
cd docker-xhprof-xhgui
docker-compose up -d
```

Hit the app at http://localhost:8080/ then go to http://localhost:8081/ to see the profile data.

adjust the xhgui.config.php and xhgui.conf to your needs.