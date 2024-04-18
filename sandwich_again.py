import time

bread_count   = 10  # общее количество ломтиков хлеба
cutlet_count  = 16  # общее количество котлет
cheese_count  = 12  # общее количество ломтиков сыра
sauce_count   = 10  # общее количество порций соуса
lettuce_count = 15  # общее количество листов салата

# Для изготовления одного сэндвича A используется: 
BREAD_A   = 2  # 1) 2 ломтика хлеба 
CUTLET_A  = 1  # 2) 1 котлеты
CHEESE_A  = 1  # 3) 1 ломтик сыра 
SAUCE_A   = 1  # 4) 1 порция соуса
LETTUCE_A = 1  # 5) 1 лист салата 

# Для изготовления одного сэндвича B используется: 
BREAD_B   = 2  # 1) 2 ломтика хлеба 
CUTLET_B  = 3  # 2) 3 котлеты
CHEESE_B  = 1  # 3) 1 ломтик сыра 
SAUCE_B   = 1  # 4) 1 порция соуса
LETTUCE_B = 1  # 5) 1 лист салата
k=0
def cheeeck(w):
    global k
    print('Введите количество сэндвичей для приготовления:')
    k = int(input())
    if w == 1:
        divv = {'хлеб': bread_count - k * BREAD_A, 'ветчина': cutlet_count - k * CUTLET_A,
                'сыр': cheese_count - k * CHEESE_A,
                'соус': sauce_count - k * SAUCE_A,
                'салат': lettuce_count - k * LETTUCE_A}
        n = 1
        for i in divv:
            if divv[i] < 0:
                print('Не хватает', divv[i] * (-1), i)
                n = 0

    if w == 2:
        divv = {'хлеб': bread_count - k * BREAD_B, 'ветчина': cutlet_count - k * CUTLET_B,
                'сыр': cheese_count - k * CHEESE_B,
                'соус': sauce_count - k * SAUCE_B,
                'салат': lettuce_count - k * LETTUCE_B}
        n = 1
        for i in divv:
            if divv[i] < 0:
                print('Не хватает', divv[i] * (-1), i)
                n = 0
    if n==1:
        print('Отлично, на складе достаточно ингедиентов для приготовления', k, 'сэндвичей')
    else:
        print('На складе недостаточно ингедиентов для приготовления', k, 'сэндвичей')
        print()
    return n


def sand_a():
    global bread_count, cutlet_count, cheese_count, sauce_count, lettuce_count, k
    print("Для изготовления сэндвича A необходимо:", BREAD_A, "ломтика хлеба,",
          CUTLET_A, "ломтик ветчины", CHEESE_A, "ломтик сыра", SAUCE_A, "порция соуса",
          LETTUCE_A, "лист салата")
    w = 1

    n = cheeeck(w)

    # Создай необходимое число сэндвичей
    if n:
        for i in range(k):
            print('Делаем', i + 1, 'сэндвич')
            print('Кладем хлебушек')
            time.sleep(0.5)
            print('Кладем ветчину')
            time.sleep(0.5)
            print('Кладем сыр')
            time.sleep(0.5)
            print('Кладем соус')
            time.sleep(0.5)
            print('Кладем листья салата')
            time.sleep(0.5)
            print('Кладем хлебушек')
            print()
            bread_count -= BREAD_A
            cutlet_count -= CUTLET_A
            cheese_count -= CHEESE_A
            sauce_count -= SAUCE_A
            lettuce_count -= LETTUCE_A


def sand_b():
    global bread_count, cutlet_count, cheese_count, sauce_count, lettuce_count, k
    print("Для изготовления сэндвича B необходимо:", BREAD_B, "ломтика хлеба,",
          CUTLET_B, "ломтика ветчины", CHEESE_B, "ломтик сыра", SAUCE_B, "порция соуса",
          LETTUCE_B, "лист салата")
    w = 2

    n = cheeeck(w)

        # Создай необходимое число сэндвичей
    if n:
        # Создай необходимое число сэндвичей
        for i in range(k):
            print('Делаем', i + 1, 'сэндвич:')
            print('Кладем хлебушек')
            time.sleep(0.5)
            for _ in range(CUTLET_B):
                print('Кладем ветчину')
            time.sleep(0.5)
            print('Кладем сыр')
            time.sleep(0.5)
            print('Кладем соус')
            time.sleep(0.5)
            print('Кладем листья салата')
            time.sleep(0.5)
            print('Кладем хлебушек')
            print()
            bread_count -= BREAD_B
            cutlet_count -= CUTLET_B
            cheese_count -= CHEESE_B
            sauce_count -= SAUCE_B
            lettuce_count -= LETTUCE_B

def count_ing():
    # Отобрази пользователю количество запасов каждого ингредиента
    for k, v in {'хлеб': bread_count, 'ветчина': cutlet_count, 'сыр': cheese_count, 'соус': sauce_count,
                 'салат': lettuce_count}.items():
        print(k, v)

def add_ing():
    global bread_count, cutlet_count, cheese_count, sauce_count, lettuce_count
    print("1) Ломтики хлеба")
    print("2) Ломтики ветчины")
    print("3) Ломтики сыра")
    print("4) Порции соуса")
    print("5) Листы салата")

    ingredient_choice = int(input())
    # Считай ввод пользователя в переменную ingredient_choice

    print("Введите количество, которое хотите добавить:")
    # Считай ввод пользователя
    nn = int(input())

    if ingredient_choice == 1:
        bread_count += nn

    if ingredient_choice == 2:
        cutlet_count += nn

    if ingredient_choice == 3:
        cheese_count += nn

    if ingredient_choice == 4:
        sauce_count += nn

    if ingredient_choice == 5:
        lettuce_count += nn

def only_check():
    print('Введите номер, соответстующий виду сэндвича:')
    print('1) Сэндвич А')
    print('2) Сэндвич В')
    w = int(input())
    return cheeeck(w)

def end_sand():
    global flag
    print('Заказ завершен. Приходите еще!')
    flag = False

# Перепиши решение из файла `materials/week1/day2/sandwich_5.py`
# Для создания меню используй "бесконечный цикл"
flag = True
while flag:

    print('\nВыберите пункт меню:')
    print('1) Приготовить сэндвич A')
    print('2) Приготовить сэндвич B')
    print('3) Вывести количество доступных ингредиентов на складе')
    print('4) Добавить ингредиенты на склад')
    print('5) Проверка возможности приготовления желаемого количества сэндвичей')
    print('6) Выйти')

    func_dic = {1: sand_a, 2: sand_b, 3: count_ing, 4: add_ing, 5: only_check, 6: end_sand}

    # Считай ввод пользователя в переменную choice
    choice = int(input())
    func_dic[choice]()



# Используй функции для создания сэндвичей, 
# для проверки "Можно ли создать сэндвич?"
