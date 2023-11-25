#!/bin/bash
scp src/cat/s21_cat rosamonj2@10.10.0.2:~/
scp src/grep/s21_grep rosamonj2@10.10.0.2:~/
ssh -T rosamonj2@10.10.0.2 << EOF
    # Выполняем команды внутри SSH сеанса, используя sudo -S для ввода пароля
    echo '34128359maya' | sudo -S mv ~/s21_cat /usr/local/bin/
    echo '34128359maya' | sudo -S mv ~/s21_grep /usr/local/bin/
    echo '34128359maya' | sudo -S ls /usr/local/bin/
EOF
