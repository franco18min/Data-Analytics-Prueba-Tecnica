def estandarizacion(valor):
    # Eliminamos espacios al inicio y al final
    valor = valor.strip()
    # Cambiamos los espacios dobles por un solo espacio
    valor = ' '.join(valor.split())
    # Reemplazamos "," por "."
    valor = valor.replace(',', '.')
    # Agregamos espacios después de los puntos si hace falta
    valor = valor.replace('.', '. ')
    # Eliminamos caracteres especiales como -
    valor = valor.replace('-', '')
    # Capitalizamos la primera letra de cada cadena si tiene más de 2 caracteres
    valor = ' '.join([word.capitalize() if len(word) > 2 else word for word in valor.split()])
    # Convertimos a minúsculas las cadenas de 2 o menos caracteres
    valor = ' '.join([word.lower() if len(word) <= 2 else word for word in valor.split()])
    return valor