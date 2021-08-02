# Тестовое задание Servers.com

#### Описание

Проект создан в рамках выполнения тестового задания от компании Servers.com. Требования предъявленные к проекту описаны ниже.

##### Ruby version
```
ruby 2.7.2
```

##### Rails version
```
Rails 6.1.4 
```

### Первый запуск
```
gem install bundler
bundle install
```

Далее необходимо сконфигурировать файлы `config/database.yml` и `config/schedule.rb`.

Затем подготавливаем базу данных:

```
rails db:create
rails db:migrate
```

Добавляем задачу в cron из конфигурации Whenever:

```
bundle exec whenever --update-crontab --set environment="development"
```

Запуск сервера

```
rails s
```
