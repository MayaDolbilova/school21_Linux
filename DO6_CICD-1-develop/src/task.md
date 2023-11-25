## Part 1. Настройка gitlab-runner
- Поднять виртуальную машину Ubuntu Server 20.04 LTS
- Скачать и установить на виртуальную машину gitlab-runner
![](screenshots/1.1.png)
- Запустить gitlab-runner и зарегистрировать его для использования в текущем проекте (DO6_CICD)
![](screenshots/1.2.png)
## Part 2. Сборка
- прописала в gitlab-ci.yml этап  build и проверила его работоспособность
![](screenshots/2.png)
## Part 3. Тест кодстайла
- прописала этап code_style_check, предусмотрела остановку pipeline при наличии ошибок
![](screenshots/3.1.png) 
вывод без ошибок
![](screenshots/3.2.png)
вывод с ошибками, сработал exit 1
## Part 4. Интеграционные тесты
- прописала этап integration_test, предусмотрела остановку pipeline при наличии ошибок
![](screenshots/4.1.png)
вывод без fail в тестах
![](screenshots/4.2.png)
вывод, когда есть хоть один fail
## Part 5. Этап деплоя
- связала машины между собой

![](screenshots/5.1.png)
![](screenshots/5.2.png)
![](screenshots/5.3.png)
![](screenshots/5.4.png)
![](screenshots/5.7.png)
- файлы на 2 машине
![](screenshots/5.6.png)
