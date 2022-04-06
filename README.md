# README

This is a simple REST API developed with Ruby on Rails 6.

To get the application running on your computer.

* Ruby version 3.0.3
* Rails version 6.1.5
* sqlite3

## NB: Every request needs a Bearer token except sign up and login.

### Up and running


```bash
   $ git clone git@github.com:efocoder/rails-todo-api.git
   
   $ bundle install
```
* Set the secret for JWT
```bash
    $ rake secret
```
* copy the secret to and update the credentials.
```bash 
    $ EDITOR=nano rails credentials:edit
```
* update the credentials with the secret you copied

* devise:
  jwt_secret: 'secret here'

### Get running

```bash
    $ rails db:migrate
    
    $ rails server
```


