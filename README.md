1. Создание кластера
1.1 Создайте в папке "tf" файл переменных vars.tf, подставив
актуальные значения токенов/идентификаторов ресурсов

variable "token" {
  type    = string
  default = ${yandex_cloud_token}
}

variable "cloud_id" {
  type    = string
  default = ${yandex_cloud_id}
}

variable "folder_id" {
  type    = string
  default = ${yandex_folder_id}
}
variable "subnet_id" {
  type    = string
  default = ${yandex_subnet_id}
}

1.2 Создайте файл "userinfo" с информацией о пользователя,
от лица коготорого будут выполнятся задачи конфигурирования

ssh_pwauth: no
users:
  - name: имя_пользователя
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh-authorized-keys:
      - публичный ключ пользователя

1.3 Запустите инициализацию конфигурации Terraform командой "terraform init"

1.4 Запустите создание кластера командой "terraform apply"

2. Развёртывание кластера k8s

2.1 Экспортируйте в окрежение публичные адреса хостов кластера
. <(terraform output | sed -e 's/[ "]//g' | sed -e 's/^/export /g')

2.2 Перейдите в папку "ansible", создайте файл inventory используя шаблон hosts.template
envsubst >hosts.yaml < hosts.template

2.3 Запустите создание кластера командой
ansible-playbook ./playbook.yaml -i hosts.yaml
