
from deep_translator import GoogleTranslator
import pandas as pd
import langid as lid
import time

def get_file_text(address:str) -> str:
    with open(address, "r", encoding="utf-8") as text:
        csv_text = text.read()
        return csv_text
    

def traducir_texto(texto):
    traductor = GoogleTranslator(source="auto", target="en")
    traduccion = traductor.translate(texto)
    return traduccion
    # for i in range(0, len(texto), max_chars):
        # parte = texto[i : i + max_chars]
        # traduccion = traductor.translate(parte)
        # traducciones.append(traduccion)
    # texto_traducido = " ".join(traducciones)
    # return texto_traducido


def is_english(text: str) -> bool:
    lang, num = lid.classify(text)
    return lang == "en"


def is_spanish(text: str) -> bool:
    lang, num = lid.classify(text)
    return lang == "es"


def traducir(csv_address = "valencia_reviews.csv", nombre_columna = "comments", destino = "en_reviews.txt", i = 0, amount = -1):
    csv = pd.read_csv(csv_address)
    comentarios = []
    serie_comentarios = csv[nombre_columna]
    com = i
    top = i + amount
    count_spanish = 0
    if amount < 0:
        amount = len(serie_comentarios)
    while i < len(serie_comentarios):
        comentario = serie_comentarios[i]
        i += 1
        comentario = str(comentario)
        if is_spanish(comentario):
            count_spanish += 1
        if is_english(comentario):
            pass
        else:
            comentario = traducir_texto(comentario)
        print(i)
        errores = []
        with open(destino, "a", encoding="utf-8") as doc:
            try:
                doc.write(comentario + "\n")
            except:
                errores.append(i)
        if i == top:
            break
    #return "Hecho\n", "errores: ", errores, "comienzo:", com, "fin:", i
    return com, i, errores, count_spanish
a = time.time()
print(traducir())
b = time.time()
print("Tiempo de hacer todos:", b-a)
#print(is_spanish("Hola, buenos días a todos, me llamo Rafael"))