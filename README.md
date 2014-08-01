# Photo CMS

[ ![Codeship Status for persocon/photo
cms](https://www.codeship.io/projects/4eccfe90-fbd9-0131-d6f8-5a73486b8860/status)](https://www.codeship.io/projects/29263)

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
