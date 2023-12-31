## Part 1. Готовый докер
- Cкачиваю докер с помощью команды  sudo apt install docker.io и проверяю его статус с помощью systemctl status docker
![](screen/1.1.png)
- Взять официальный докер образ с nginx и выкачать его при помощи docker pull
![](screen/1.2.png)
- Проверить наличие докер образа через docker images
![](screen/1.3.png)
- Запустить докер образ через docker run -d [image_id|repository]
![](screen/1.4.png)
- Проверить, что образ запустился через docker ps
![](screen/1.5.png)
- Посмотреть информацию о контейнере через docker inspect [container_id|container_name]
![](screen/1.6.png)
- По выводу команды определить и поместить в отчёт размер контейнера, список замапленных портов и ip контейнера

Размер контейнера
![](screen/1.7.png)

Список замапленных портов (строчка ports)
![](screen/1.8.png)

ip контейнера
![](screen/1.9.png)
- Остановить докер образ через docker stop [container_id|container_name]
![](screen/1.10.png)
- Проверить, что образ остановился через docker ps
![](screen/1.11.png)
- Запустить докер с портами 80 и 443 в контейнере, замапленными на такие же порты на локальной машине, через команду run
![](screen/1.12.png)
- Проверить, что в браузере по адресу localhost:80 доступна стартовая страница nginx
![](screen/1.13.png)
- Перезапустить докер контейнер через docker restart [container_id|container_name]
![](screen/1.14.png)
- Проверить любым способом, что контейнер запустился
![](screen/1.15.png)
## Part 2. Операции с контейнером
- Прочитать конфигурационный файл nginx.conf внутри докер контейнера через команду exec
![](screen/2.1.png)
- Создать на локальной машине файл nginx.conf
Создала файл vim nginx.conf (лежит в папке server, на момент выполнения задания лежал в папке rosamonj на виртуалке, поэтому так прописаны пути, потом я его изменила в 3 задании)
- Настроить в нем по пути /status отдачу страницы статуса сервера nginx
![](screen/2.2.png)
- Скопировать созданный файл nginx.conf внутрь докер образа через команду docker cp
![](screen/2.3.png)
- Перезапустить nginx внутри докер образа через команду exec
![](screen/2.4.png)
- Проверить, что по адресу localhost:80/status отдается страничка со статусом сервера nginx
![](screen/2.5.png)
- Экспортировать контейнер в файл container.tar через команду export
![](screen/2.6.png)
- Остановить контейнер

![](screen/2.7.png)
![](screen/2.8.png)
- Удалить образ через docker rmi [image_id|repository], не удаляя перед этим контейнеры
![](screen/2.9.png)
![](screen/2.10.png)
![](screen/2.11.png)
- Удалить остановленный контейнер
![](screen/2.12.png)
![](screen/2.13.png)
![](screen/2.14.png)
- Импортировать контейнер обратно через команду import
docker import -c 'CMD ["nginx", "-g", "daemon off;"]' container.tar
![](screen/2.15.png)
![](screen/2.16.png)
- Запустить импортированный контейнер
![](screen/2.17.png)
- Проверить, что по адресу localhost:80/status отдается страничка со статусом сервера nginx
![](screen/2.18.png)
## Part 3. Мини веб-сервер
- Написать мини сервер на C и FastCgi, который будет возвращать простейшую страничку с надписью Hello World!
 Код можно посмотреть в src/server/server.c
- Написать свой nginx.conf, который будет проксировать все запросы с 81 порта на 127.0.0.1:8080
Файл лежит в src/server/nginx.conf
- Запустить написанный мини сервер через spawn-fcgi на порту 8080

Запускаю докер с замапленным портом 81
![](screen/3.1.png)
Копирую созданные файлы в докер с помощью docker cp /home/rosamonj/DO5_SimpleDocker-1/src/server/nginx.conf 8b1a2452c618:/etc/nginx/ и docker cp /home/rosamonj/DO5_SimpleDocker-1/src/server/server.c 8b1a2452c618:/home/ (забыла сделать скриншот, сделаю с другим контейнером)
![](screen/3.0.png)
Вхожу в контейнер с помощью docker exec -it container_id bash (exit - выход из докера) и устанавливаю нужные для компиляции пакеты apt install gcc spawn-fcgi libfcgi-dev
![](screen/3.2.png)
Компилирую сервер
![](screen/3.3.png)
Запускаю сервер
![](screen/3.4.png)
Перезапускаю контейнер
![](screen/3.5.png)
- Проверить, что в браузере по localhost:81 отдается написанная вами страничка
![](screen/3.6.png)
- Положить файл nginx.conf по пути ./nginx/nginx.conf (это понадобится позже)
![](screen/3.7.png)
## Part 4. Свой докер
Создала файлы Dockerfile и start.sh (их можно найти в папке 04)
Собрала написанный докер образ командой docker build -t maya:1 .
![](screen/4.3.png)
![](screen/4.4.png)
-  Проверим через docker images, что все собралось корректно
![](screen/4.5.png)
- Запустить собранный докер образ с маппингом 81 порта на 80 на локальной машине и маппингом папки ./nginx внутрь контейнера по адресу, где лежат конфигурационные файлы nginx'а (см. Часть 2)
![](screen/4.6.png)
- Проверить, что по localhost:80 доступна страничка написанного мини сервера
![](screen/4.7.png)
- Дописать в ./nginx/nginx.conf проксирование странички /status, по которой надо отдавать статус сервера nginx
- Перезапустить докер образ
- Проверить, что теперь по localhost:80/status отдается страничка со статусом nginx
![](screen/4.8.png)


Команды на тот случай, если при проверке что-то пойдет не так: (если все ок, не нужны)
sudo systemctl restart docker.socket docker.service
sudo lsof -i :80
sudo kill <PID>
## Part 5. Dockle
- Просканировать образ из предыдущего задания через dockle [image_id|repository]
Установила dockle
![](screen/5.1.png)
Проверила на dockle
![](screen/5.2.png)
- Исправить образ так, чтобы при проверке через dockle не было ошибок и предупреждений
Удалила образ, обновила Dockerfile, заново собрала образ и просканировала его 
![](screen/5.3.png)
Ориентировалась на информацию в конфе Devops - там говорили, что Info это не ошибка. Также при запуске сканирования я использую тэги, убирающие ошибку CIS-DI-0010, которую не нужно исправлять в контексте этого задания 
sudo dockle -ak NGINX_GPGKEY -ak NGINX_GPGKEY_PATH maya:1
![](screen/5.4.png)
## Part 6. Базовый Docker Compose
- Написала файл docker-compose.yml, его можно найти в папке 06
- Остановить все запущенные контейнеры
![](screen/6.1.png)
- Собрать и запустить проект с помощью команд docker-compose build и docker-compose up
![](screen/6.2.png)
- Проверить, что в браузере по localhost:80 отдается написанная вами страничка, как и ранее
![](screen/6.3.png)