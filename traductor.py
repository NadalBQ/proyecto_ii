
from deep_translator import GoogleTranslator
import pandas as pd


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



def traducir(csv_address = "valencia_reviews.csv", nombre_columna = "comments", destino = "en_reviews.txt"):
    csv = pd.read_csv(csv_address)
    comentarios = []
    serie_comentarios = csv[nombre_columna]
    i = 0
    for comentario in serie_comentarios:
        i += 1
        comentario = str(comentario)
        comment = traducir_texto(comentario)
        print(i)
        errores = []
        with open(destino, "a", encoding="utf-8") as doc:
            try:
                doc.write(comentario + "\n")
            except:
                errores.append(i)
        # if i == 100:
            # break
    return "hecho", "\n" + "errores: ", errores

print(traducir())
