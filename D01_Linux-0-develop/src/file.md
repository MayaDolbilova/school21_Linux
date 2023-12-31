## Part 1. Установка ОС

- через cd .. выхожу в директорию home
- через cd .. выхожу в директорию /
- узнаю версию Ubuntu
![](pictures/Part1.png)

## Part 2. Создание пользователя

- с помощью команд sudo adduser создаю нового пользователя sunnyday
![](pictures/Part2.1.png)
- с помощью sudo usermod добавляю пользователя sunnyday в группу adm
![](pictures/Part2.2.png)
- пользователь появился в выводе команды  /etc/passwd
![](pictures/Part2.3.png)

## Part 3. Настройка сети ОС

- открыла файл etc/hostname в vim, перешла в режим вставки (i), изменила имя машины на user-1
 ![](pictures/Part3.1.png)
 ![](pictures/Part3.1.2.png)
 - узнала свою временную зону с помощью команды timedatectl list-timezones
 - установила временную зону по своему текущему положению timedatectl set-timezone Europe/Moscow
 ![](pictures/Part3.2.png)
 - с помощью команды ip link show вывела список сетевых интерфейсов, интерфейс lo присутствует в linux по умолчанию, используется для отладки сетевых программ и запуска серверных приложений на локальной машине
![](pictures/Part3.3.png)
- DHCP — протокол прикладного уровня модели TCP/IP, служит для автоматизации назначения IP-адреса клиенту. Dynamic Host Configuration Protocol. Помимо автоматизации процесса настройки IP, DHCP позволяет упростить диагностику подключения и переход из одной подсети в другую, оставляя уведомления для системного администратора в логах.
- получение ip устройства через DHCP сервер hostname -I

![](pictures/Part3.4.png)
- внешний ip-адрес шлюза (ip) curl icanhazip.com

![](pictures/Part3.6.png)
- внутренний IP-адрес шлюза, он же ip-адрес по умолчанию (gw) ip route | default
![](pictures/Part3.5.png)
- задать статичные (заданные вручную, а не полученные от DHCP сервера) настройки ip, gw, dns
![](pictures/Part3.8.png)
![](pictures/Part3.7.png)
- с помощью команды sudo netplan try подтвердила новые настройки и обновила систему через reboot
- успешно пропинговала удаленные хосты 1.1.1.1 и ya.ru
![](pictures/Part3.9.png)
![](pictures/Part3.10.png)

## Part 4. Обновление ОС
- sudo apt update показало сколько пакетов нужно обновить
![](pictures/Part4.1.png)
- sudo apt upgrade после выполнения обновления
![](pictures/Part4.2.png)

## Part 5. Использование команды sudo
- sudo (англ. Substitute User and do, дословно «подменить пользователя и выполнить») — программа для системного администрирования UNIX-систем, позволяющая делегировать те или иные привилегированные ресурсы пользователям с ведением протокола работы. Основная идея — дать пользователям как можно меньше прав, при этом достаточных для решения поставленных задач. Программа поставляется для большинства UNIX и UNIX-подобных операционных систем. Команда sudo предоставляет возможность пользователям выполнять команды от имени суперпользователя root, либо других пользователей. Предоставляя привилегии root только при необходимости, использование sudo снижает вероятность того, что опечатка или ошибка в выполняемой команде произведут в системе разрушительные действия.
- добавила пользователя sunnyday в группу sudo, команда: sudo usermod -aG sudo sunnyday
![](pictures/Part5.1.png)
- перешла на пользователя sunnyday su sunnyday и поменяла имя машины через команду sudo 
![](pictures/Part5.2.png)
- после reboot

![](pictures/Part5.3.png)

## Part 6. Установка и настройка службы времени

- Вывод команды timedatectl show, показывающая время часового пояса. Есть строчка NTPSynchronized=yes:
![](pictures/Part6.1.png)

## Part 7. Установка и использование текстовых редакторов
- чтобы сохранить файл перед закрытием в vim нужна команда :wq
![](pictures/Part7.1.png)
- ctrl+O чтобы сохранить изменения и ctrl+x чтобы выйти из редактора nano
![](pictures/Part7.2.png)
-ctrl+KX чтобы сохранить изменения и выйти из joe
![](pictures/Part7.3.png)
- команда :q! в vim для выхода без изменений
![](pictures/Part7.4.png)
- ctrl+x потом n чтобы выйти без сохранения из nano
![](pictures/Part7.5.png)
- ctrl+c и y чтобы выйти из joe без сохранения
![](pictures/Part%207.6.png)
- поиск по словам в vim /pattern n и N чтобы перемещаться по совпадениям
![](pictures/Part7.7.png)
- замена слова в vim :s/паттерн, который надо заменить/паттерн, которым заменяем
![](pictures/Part7.8.png)
- ctrl + w поиск слова в nano
![](pictures/Part7.9.png)
- ctrl + \ ввод паттерна, который нужно заменить + Enter + ввод паттерна, на который надо заменить + Enter + Y в nano
![](pictures/Part7.10.png)
- ctrlK F - поиск слова в joe
- ctrlK F + R - поиск и замена слова в joe
![](pictures/Part7.11.png)


## Part 8. Установка и базовая настройка сервиса SSHD

- Установила службу SSHd. sudo apt-get install openssh-server
- Добавила автостарт службы при загрузке системы. sudo systemctl enable ssh
![](pictures/Part8.1.png)

- Перенастроила службу SSHd на порт 2022. Изменила значение строчки Port в файле /etc/ssh/sshd_config
![](pictures/Part8.2.png)

- Используя команду ps, показать наличие процесса sshd. C помощью флага -C
![](pictures/Part8.3.png)

- Команда ps выводит список текущих процессов на вашем сервере в виде таблицы
-A, -e, (a) - выбрать все процессы;
-a - выбрать все процессы, кроме фоновых;
-d, (g) - выбрать все процессы, даже фоновые, кроме процессов сессий;
-N - выбрать все процессы кроме указанных;
-С - выбирать процессы по имени команды;
-G - выбрать процессы по ID группы;
-p, (p) - выбрать процессы PID;
--ppid - выбрать процессы по PID родительского процесса;
-s - выбрать процессы по ID сессии;
-t, (t) - выбрать процессы по tty;
-u, (U) - выбрать процессы пользователя.

- Вывод команды netstat -tan
![](pictures/Part8.4.png)
- значение ключей: -t информация по протоколу TCP -a вывод всех активных подключений TCP и прослушиваемых компьютером портов TCP и UDP. -n вывод активных подключений TCP с отображением адресов и номеров портов в числовом формате без попыток определения имен.
- значение каждого столбца вывода: Proto - Протокол (tcp, udp, raw), используемый сокетом. Recv-Q - Счётчик байт не скопированных программой пользователя из этого сокета. Send-Q - Счётчик байтов, не подтверждённых удалённым узлом.
Local Address - Адрес и номер порта локального конца сокета. Если не указана опция −−numeric (−n), адрес сокета преобразуется в каноническое имя узла (FQDN), и номер порта преобразуется в соответствующее имя службы.  Foreign Address - Адрес и номер порта удалённого конца сокета. Аналогично "Local Address."
- IP-адрес 0.0.0.0 — это немаршрутизируемый адрес IPv4, который можно использовать в разных целях, в основном, в качестве адреса по умолчанию или адреса-заполнителя. Несмотря на то, что адрес 0.0.0.0 может использоваться в компьютерных сетях, он не является адресом какого-либо устройства. Говоря попросту, IP-адрес 0.0.0.0 означает «эта сеть», но для использования в традиционном смысле этот адрес непригоден. Это похоже на ссылку: «Вставьте сюда адрес», или, в зависимости от контекста, «без конкретного адреса назначения». Он действует как резервный, пока не будет назначен действительный маршрутизируемый IP-адрес. Адрес 0.0.0.0 может также появиться в результате ошибки или быть назначен намеренно.

## Part 9. Установка и использование утилит top, htop
- установка утилит sudo apt install top и sudo apt install htop

![](pictures/Part9.1.png)
- uptime - 1:37
- количество авторизованных пользователей - 1 user
- общая загрузка системы - load average 0.00, 0.00, 0.00
- общее количество процессов 103 total
- загрузка cpu - все что в строчке %Cpu(s):
- загрузка памяти - строчка MiB Mem :
- pid процесса занимающего больше всего памяти. Если нажать M, список процессов отсортируется по памяти, в первом столбце первой строчки будет pid процесса, занимающего больше всего памяти
![](pictures/Part9.3.png)
- pid процесса, занимающего больше всего процессорного времени. Если нажать P, список процессов отсортируется по памяти, в первом столбце первой строчки будет pid процесса, занимающего больше всего процессорного времени
![](pictures/Part9.2.png)

- htop отсортированному по:
- PID
![](pictures/Part9.4.png)
- PERCENT_CPU
![](pictures/Part9.5.png)
- PERCENT_MEM
![](pictures/Part9.6.png)
- TIME
![](pictures/Part9.7.png)
- отфильтрованному для процесса sshd
![](pictures/Part9.8.png)
- с процессом syslog, найденным, используя поиск
![](pictures/Part9.9.png)
- с добавленным выводом hostname, clock и uptime
![](pictures/Part9.10.png)

## Part 10. Использование утилиты fdisk
![](pictures/Part10.1.png)
- название жесткого диска - VBOX HARDDISK, его размер - 10 GIB и количество секторов - 20971520.
![](pictures/Part10.2.png)
![](pictures/Part10.3.png)
- no swap

## Part 11. Использование утилиты df
![](pictures/Part11.1.png)
df /

размер раздела 8408452
размер занятого пространства - 4664680
размер свободного пространства - 3295056
процент использования - 59%
единица измерения в выводе - килобайт. 

![](pictures/Part11.2.png)
размер раздела - 8.1G
размер занятого пространства - 4.5G
размер свободного пространства - 3.2G
процент использования - 59%
тип файловой системы для раздела - ext4

## Part 12. Использование утилиты du
- Вывести размер папок /home, /var, /var/log (в байтах, в человекочитаемом виде)
![](pictures/Part12.1.png)
- Вывести размер всего содержимого в /var/log (не общее, а каждого вложенного элемента, используя *)
![](pictures/Part12.2.png)

## Part 13. Установка и использование утилиты ncdu
- размер папки /home
![](pictures/Part13.1.png)
- размер папки /var
![](pictures/Part13.2.png)
- размер папки /var/log
![](pictures/Part13.3.png)

## Part 14. Работа с системными журналами
- Открыть для просмотра: /var/log/dmesg, команда: less /var/log/dmesg
![](pictures/Part14.1.png)
- Открыть для просмотра: /var/log/syslog, команда: less /var/log/syslog
![](pictures/Part14.2.png)
- Открыть для просмотра: /var/log/auth.log, команда: less /var/log/auth.log
![](pictures/Part14.3.png)
- Поиск времени последней успешной авторизации, имени пользователя и метода входа в систему, команда grep LOGIN /var/log/auth.log  Время последней успешной авторизации: 19:15:09, имя пользователя: rosamonj, метод входа: LOGIN.
![](pictures/Part14.4.png)
- Перезапустить службу SSHd, команда: sudo systemctl restart sshd
![](pictures/Part14.5.png)

## Part 15. Использование планировщика заданий CRON
- открыла cron через crontab -e и nano
- запустила команду uptime через каждые 2 минуты.
![](pictures/Part15.1.png)
- grep CRON /var/log/syslog
![](pictures/Part15.2.png)
- список текущих задач crontab -l
![](pictures/Part15.3.png)
- Удалила все задания из планировщика заданий.
![](pictures/Part15.4.png)