from random import randint


menu = """

  [1] Depositar
  [2] Sacar
  [3] Extrato
  [4] Nova Conta
  [5] Listar Contas
  [6] Novo Usuário
  [0] Sair

"""

agency = 0
balance = 0.00
limit = 500
extract = ""
count_balance = 0
limit_balance = 3
list_users: list = list()
list_accounts: list = list()


def saque(*, balance, limit, limit_balance, count_balance, extract, value):

  if value < 0:
    return print("Valor invalido!")

  if value >= limit:
    return print("O Valor excede o limite")

  if value > balance:
    return print("Saldo insuficiente!")

  if count_balance >= limit_balance:
    return print("Limite diário alcançado!")

  count_balance += 1
  balance -= value
  extract += f"Saque: R$:{value:.2f}\n"
  return balance, count_balance, extract


def deposit(balance: float, extract: str, value: float, /):

  if not value > 0:
    return print("valor valido!")

  balance += value
  extract += f"Deposito: R$ {value:.2f}\n"
  return balance, extract


def generate_extract(balance, /, *, extract):

  print("\n", "EXTRATO".center(50,"="))
  print(f"\n O seu Saldo é: R$ {balance:.2f} \n")
  print("Não foram realizadas movimentações." if not extract else extract)
  print("=" * 50)


def create_user(list_users):
  cpf = input("Informe o CPF (somente número): ")
  has_user = filter(cpf=cpf, users=list_users)

  if has_user:
    return print("Já existe usuário com esse CPF!")
  
  name = input("Informe o nome completo: ")
  date = input("Informe a data de nascimento (dd-mm-aaaa): ")
  address = input("Informe o endereço (logradouro, rua - bairro - cidade/sigla estado): ")

  new_user = {
    "name": name,
    "date": date,
    "cpf": cpf,
    "address": address,
  }
  list_users.append(new_user)
  print("Usuário criado com sucesso!")


def filter(*, cpf, users):
  result = list()
  for user in users:
    if user["cpf"] == cpf:
      result.append(user)
  if len(result) == 0:
    return False
  return result


def create_account(agency, account_number, users):
  cpf = input("Informe o CPF do usuário: ")
  user = filter(cpf=cpf, users=users)

  if user:
    agency += 1
    new_agency = str(agency).rjust(4, "0")

    print("conta criada com sucesso!")
    return {"agency": new_agency, "account_number": account_number, "user": user[0]}, agency

  print("usuário não encontrado!")


def view_account(accounts):
  for account in accounts:
    print(
      f""" 
        Agência: {account["agency"]}
        C/C: {account["account_number"]}
        Titular: {account["user"]["name"]}
      """
    )

while True:
  options = int(input(menu))

  if options == 1:
    value = float(input("Informe o Valor: R$ "))

    balance, extract = deposit(balance, extract, value)

  elif options == 2:
    value = float(input("Informe um valor: R$ "))

    balance, count_balance, extract  = saque(balance=balance, limit=limit, limit_balance=limit_balance, count_balance=count_balance, extract=extract, value=value)

  elif options == 3:
    generate_extract(balance, extract=extract)

  elif options == 4:
   new_account, agency = create_account(agency=agency, account_number='10201025', users=list_users)

   if new_account:
     list_accounts.append(new_account)

  elif options == 5:
    view_account(list_accounts)

  elif options == 6:
    create_user(list_users)

  elif options == 0:
    break
  
  else:
    print("Operação invalida, por favor selecione novamente.")