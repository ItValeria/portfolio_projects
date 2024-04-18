# Дан список студентов, которые уже есть в системе
students = [
    {
        "name": "Семён",
        "age" : 19,
        "avg_score": 4.5
    },
    {
        "name": "Алина",
        "age" : 29,
        "avg_score": 4.7
    },
    {
        "name": "Ольга",
        "age" : 21,
        "avg_score": 4.1
    }
]
names = [i['name'] for i in students]
# Необходимо дописать следующие функции
# 1) Добавление студента в список
# 2) Удаление студента по ИМЕНИ
# 3) Сортировка студентов по ЛЮБОМУ из полей (по возрастанию/по убыванию)
# 4) Отобразить список студентов
def show_students():
    k=1
    n,a,s=0,4,4
    for i in students:
        if len(i['name']) > n:
            n = len(i['name'])
    print('Список студентов:')
    print('_'*(n+a+s+12))
    print(f'| № | Имя {" " * (n - 3)} |Лет |Балл |')
    print('_' * (n + a + s + 12))
    for i in students:
        print(f'| {k}.| {i["name"]} {" "*(n-len(i["name"]))} | {i["age"]} | {i["avg_score"]} |')
        print('_' * (n + a + s + 12))
        k+=1
      # ключевое слово pass можешь удалить после того как допишешь функцию

def add_student(name, age, avg_score):
    students.append({"name": name, "age": age, "avg_score": avg_score})

def remove_by_name(name, k = 0):
    if k != 0:
        students.pop(k-1)
    else:
        for i in students:
            if i["name"] == name:
                students.remove(i)

def sort_by(field, asc=True):
    global students, names
    students = sorted(students, key = lambda i: i[field], reverse = not asc)
    names = [i['name'] for i in students]
    show_students()




# Представь решение в виде консольного меню:
# 1) Отобразить список всех студентов (в виде таблички)
# 2) Добавить студента
# 3) Исключить студента
# 4) Сортировать студентов по ... 
# 5) Выход
Flag = True
while Flag:
    print("Введите номер команды")
    print("1) Список студентов")
    print("2) Добавить студента")
    print("3) Исключить студента")
    print("4) Сортировать студентов по ...")
    print("5) Выход")
    choice = int(input())
    if choice == 1:
        show_students()
    if choice == 2:
        print("Введите имя студента:")
        n = input()
        if n in names:
            print('Предупреждение! Данное имя есть в списке, студент будет добавлен под другим номером')
        print("Введите возраст студента:")
        a = int(input())
        print("Введите средний балл студента:")
        s = float(input())
        add_student(n, a, s)
        names += [n]
        print("Студент добавлен в список")
        print()
    if choice == 3:
        print("Введите имя студента:")
        n = input()
        if names.count(n) > 1:
                print('Предупреждение! В списке несколько студентов с данным именем. Введите номер удаляемого студента в соответствии со списком:')
                k = int(input())
                remove_by_name(n, k)
        else:
            remove_by_name(n)
        print("Студент удален из списка")
    if choice == 4:
        print("Введите номер, соответствующий параметру сортировки:")
        print('1) Сортировка по имени')
        print('2) Сортировка по возрасту')
        print('3) Сортировка по среднему баллу')
        f = ['name', 'age', 'avg_score'][int(input())-1]
        print("Введите номер, соответствующий пособу сортировки:")
        print('1) Сортировка по убыванию (или в порядке, обратном алфавитному, для слов)')
        print('2) Сортировка по возрастанию (или в алфавитном порядке для слов)')
        asc = bool(int(input())-1)
        sort_by(f, asc)
    if choice == 5:
        print('Редактирования списка завершено')
        break







