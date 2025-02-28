
with open("el_quijote.txt", "r+", encoding="utf-8") as quijote:
    text = quijote.read()

from deep_translator import GoogleTranslator

def traducir_texto_largo(texto, max_chars=4000):
    traductor = GoogleTranslator(source="auto", target="en")
    partes, traducciones = [], []

    for i in range(0, len(texto), max_chars):
        parte = texto[i : i + max_chars]
        partes.append(parte)
        traduccion = traductor.translate(parte)
        traducciones.append(traduccion)
        print(traduccion)


    return traducciones


resultado = traducir_texto_largo(text)
print(resultado)
