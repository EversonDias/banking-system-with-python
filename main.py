menu = """

  [1] Depositar
  [2] Sacar
  [3] Extrato
  [4] Sair

"""

balance = 0.00
limit = 500
extract = ""
count_balance = 0
limit_balance = 3

while True:
  options = int(input(menu))

  if options == 1:
    value = float(input("Informe o Valor: R$ "))

    if not value > 0:
      print("valor valido!")
      continue
    balance += value
    extract += f"Deposito: R$ {value:.2f}\n"

  elif options == 2:
    value = float(input("Informe um valor: R$ "))

    if value < 0:
      print("Valor invalido!")
      continue

    if value >= limit:
      print("O Valor excede o limite")
      continue

    if value > balance:
      print("Saldo insuficiente!")
      continue

    if count_balance >= limit_balance:
      print("Limite diário alcançado!")
      continue

    count_balance += 1
    balance -= value
    extract += f"Saque: R$:{value:.2f}\n"

  elif options == 3:
    print("\n", "EXTRATO".center(50,"="))
    print(f"\n O seu Saldo é: R$ {balance:.2f} \n")
    print("Não foram realizadas movimentações." if not extract else extract)
    print("=" * 50)

  elif options == 4:
    break
  
  else:
    print("Operação invalida, por favor selecione novamente.")