def limpiar_numero(numero):
    if numero != 'Telefono Desconocido':
        numero = numero.replace(' ', '').replace('-', '').replace('/', '')
    return numero