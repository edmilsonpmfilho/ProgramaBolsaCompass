import hashlib as hs

texto = input("Informe o texto: ")

while texto != "Sair":
    hash = hs.sha1(texto.encode())
    print(hash.hexdigest())

    texto = input("Informe o texto: (ou para sair do hash digite Sair)")



