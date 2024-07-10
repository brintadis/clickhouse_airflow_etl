# ClickHouse Airflow ETL

## Введение

Этот проект демонстрирует ETL-пайплайн с использованием ClickHouse в качестве базы данных и Apache Airflow в качестве оркестратора. Пайплайн извлекает логи из csv, преобразует их и загружает в базу данных ClickHouse для дальнейшего анализа.

## Структура проекта

```plaintext
clickhouse_airflow_etl/
├── airflow/dags/
│           └── etl_script_logs.py
├── init/
│   ├── 01-init.sql
│   ├── 02-create.sql
├── 03-insert.sql
├── analytics_query.sql
├── sm_test_data.csv
├── docker-compose.yml
├── Dockerfile
├── Задание РТК.md
└── README.md
```


## Описание данных

Набор данных содержит логи работы скрипт-менеджера. Основные признаки данных:

* `timestamp` - Дата и время
* `user` - Логин
* `communication_number` - Номер обращения 
* `communication_id` - ID Вызова
* `script_id` - ID скрипта
* `script_name` - Имя скрипта
* `mrf` - Регион оператора
* `client_mrf` - Регион клиента
* `script_owner` - Разработчик скрипта
* `current_script_owner` - Разработчик вложенного скрипта
* `script_responsible` - Ответственный по скрипту
* `current_script_responsible` - Ответственный по вложенному скрипту
* `crm_departament` - Подразделение
* `ACCOUNT_NUMBER` - Номер лицевого счета
* `CALLER_ID` - Номер телефона
* `COMMUNICATION_THEME` - Тема обращения
* `COMMUNICATION_DETAIL` - Детализация обращения
* `COMMUNICATION_RESULT` - Результат обращения

Некоторые признаки хранятся в поле `parameters` в формате JSON.

## ETL Процесс

ETL пайплайн выполняет следующие шаги:

1. **Извлечение:** Логи загружаются из CSV файла в таблицу `script_logs_raw` в ClickHouse.
2. **Преобразование:** Извлекаются и преобразуются необходимые поля, включая парсинг JSON полей из столбца `parameters`.
3. **Загрузка:** Преобразованные данные вставляются в таблицу `script_logs` для анализа.

## Инструкции по настройке и запуску

### Шаги для запуска

1. **Клонирование репозитория:**

    ```bash
    git clone https://github.com/brintadis/clickhouse_airflow_etl.git
    cd clickhouse_airflow_etl
    ```

2. **Сборка и запуск Docker контейнеров:**

    ```bash
    docker-compose up -d --build
    ```

3. **Инициализация базы данных ClickHouse:**

    SQL скрипты в папке `init` будут автоматически выполнены для настройки базы данных и загрузки начальных данных.

4. **Доступ к Airflow:**

    Откройте браузер и перейдите по адресу `http://localhost:8080`. Войдите с учетными данными по умолчанию (admin/admin) и запустите DAG `etl_script_logs` для начала ETL процесса.
