# Photo CMS

### SETUP
edit config/database.rb to desired **mysql** `user` and `password`  
$ padrino rake sq:migrate:auto  
$ padrino rake db:seed  
$ padrino start -p 9090


## WARNING
**INSTALL IMAGEMAGICK**
**MAC:**
- brew install imagemagick
**LINUX**
- sudo apt-get install imagemagick


### DEPLOY PURPOSE
$ rvm alias create photocms ruby-2.1.1@photocms