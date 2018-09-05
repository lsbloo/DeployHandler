#!/bin/bash



#Instala as dependencias que são necessarias para a utilização do figlet e do dialog(interface);
function install_Dep(){
	# Installing dependencies
	
	echo 
	echo '----------------------------------------------------------------'
	echo ' Installing Figlet and Dialog '
	echo '----------------------------------------------------------------'
	echo ''
	figlet=$(which figlet)
	dialog_=$(which dialog)
	if [ -z $figlet ]; then
		sudo apt-get install -y figlet
	fi
	if [ -z $dialog ]; then
		sudo apt-get install -y dialog
	fi
}
 figlet Deploy your java application using heroku
 echo '--------------------------------------------'

function create_DIR_A(){
	DIR_=$(pwd)
	echo
	echo 'Diretorio Atual: '
	dialog --stdout --title "Current Directory" --msgbox $DIR_ 10 30
	echo 
	
	new_Dir=$(dialog --stdout --title "Sign in to app directory" --inputbox 'Enter the application directory!! [0] exit' 10 50)
	while [ -z $new_Dir ]; do
		new_Dir=$(dialog --stdout --title "Sign in to app directory" --inputbox 'Enter the application directory!!' 10 50)
		
		if [ $new_Dir == '0' ]; then
			dialog --stdout --title "Default directory" --msgbox "Directory did not change!" 10 30 
		fi
	done
	if [ $new_Dir != '0' ]; then
		echo $new_Dir
		cd $new_Dir
	fi
}
function deploy_heroku_app_jar(){
	# É necessario que o diretorio atual seja o diretorio da aplicação ou seja onde esteja o codigo fonte;
	name_COMMIT=''
	while [ -z $name_COMMIT ]; do
		name_COMMIT=$(dialog --stdout --title "Enter the name of the commit in HEROKU" --inputbox "name of the commit HEROKU" 10 30)
	done
	git init 
	git add *
	git commit -m $name_COMMIT

	nome_app_heroku=''
	while [ -z nome_app_heroku ]; do
		nome_app_heroku=$(dialog --stdout --title "Enter the name of the APP in HEROKU" --inputbox 'name of the APP Heroku' 10 30)
	done
	heroku create $nome_app_heroku
	heroku buildpacks:set https://github.com/heroku/heroku-buildpack-java
	git push heroku master && heroku logs --tail
	
}
function main(){
	install_Dep
	create_DIR_A
	deploy_heroku_app_jar
}
main
