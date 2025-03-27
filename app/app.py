import tkinter as tk
from tkinter import ttk, messagebox
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from PIL import Image, ImageTk
import os

# Cargar datos
df = pd.read_csv("datos_viviendas.csv")

# Crear ventana principal
root = tk.Tk()
root.title("Análisis de Precios de Viviendas")
root.geometry("900x700")

# Frame de filtros
frame_filtros = ttk.Frame(root)
frame_filtros.pack(pady=10)

# Dropdown para seleccionar distrito
ttk.Label(frame_filtros, text="Distrito:").grid(row=0, column=0)
distrito_var = tk.StringVar()
distrito_menu = ttk.Combobox(frame_filtros, textvariable=distrito_var, values=list(df["Distrito"].dropna().unique()))
distrito_menu.grid(row=0, column=1)
if len(df["Distrito"].dropna().unique()) > 0:
    distrito_menu.current(0)

# Función para actualizar imagen del gráfico
def actualizar_grafico():
    distrito = distrito_var.get()
    ruta_grafico = f"graficos/{distrito}.png"
    
    if os.path.exists(ruta_grafico):
        imagen = Image.open(ruta_grafico)
        imagen = imagen.resize((600, 400), Image.Resampling.LANCZOS)
        imagen_tk = ImageTk.PhotoImage(imagen)
        label_grafico.config(image=imagen_tk)
        label_grafico.image = imagen_tk
    else:
        messagebox.showerror("Error", f"No se encontró el gráfico para {distrito}")

# Contenedor para la imagen
graph_frame = ttk.Frame(root)
graph_frame.pack()
label_grafico = tk.Label(graph_frame)
label_grafico.pack()

# Botón para actualizar gráfico
ttk.Button(root, text="Actualizar Gráfico", command=actualizar_grafico).pack()

# Formulario de contacto
def enviar_mensaje():
    nombre = entry_nombre.get()
    mensaje = text_mensaje.get("1.0", tk.END).strip()
    if nombre and mensaje:
        messagebox.showinfo("Mensaje enviado", "Tu mensaje ha sido enviado correctamente.")
    else:
        messagebox.showerror("Error", "Por favor, completa todos los campos.")

frame_contacto = ttk.LabelFrame(root, text="Contacto")
frame_contacto.pack(pady=10, fill="both", expand=True)

ttk.Label(frame_contacto, text="Nombre:").pack()
entry_nombre = ttk.Entry(frame_contacto)
entry_nombre.pack()

ttk.Label(frame_contacto, text="Mensaje:").pack()
text_mensaje = tk.Text(frame_contacto, height=4, width=50)
text_mensaje.pack()

ttk.Button(frame_contacto, text="Enviar", command=enviar_mensaje).pack()

# Iniciar aplicación
root.mainloop()

