def torre_de_hanoi(entrada, origem, auxiliar, destino):
    if entrada == 1:
        print(f"mova o disco {entrada} de {origem} para {destino}")
    else:
        torre_de_hanoi(entrada-1, origem, destino, auxiliar)
        print(f"mova o disco {entrada} de {origem} para {destino}")
        torre_de_hanoi(entrada-1, auxiliar, origem, destino)

print("digite um número de 1 a 9")
entrada = int(input())
torre_de_hanoi(entrada, 'A', 'B', 'C')
print("Concluido!")
