from typing import List
import pandas as pd
import tkinter as tk
from tkinter import ttk
from tipos import dev

class Gui():
    df: pd.DataFrame
    graph_names: List[str]
    devs: List[dev]
    root: tk.Tk
    tabs: dict


    def __init__(self, root: tk.Tk):
        self.root = root  # Ventana principal de Tkinter
        self.df = pd.DataFrame()
        self.graph_names = []
        self.devs = []
        self.tabs = {}  # Diccionario para almacenar las pestañas creadas
        self.selected_graph = tk.StringVar()  # Variable para el gráfico seleccionado
        self.create_widgets()

    def setconfig(self, **kwargs):
        self.df = kwargs.get("df", self.df)
        self.graph_names = kwargs.get("graph_names", self.graph_names)
        self.devs = kwargs.get("devs", self.devs)
        if self.graph_names:
            self.selected_graph.set(self.graph_names[0])  # Selecciona el primer gráfico por defecto
        self.update_graph()

    def create_widgets(self):
        """Crea el Notebook para manejar pestañas."""
        self.notebook = ttk.Notebook(self.root)
        self.notebook.pack(expand=True, fill="both")

        # Menú desplegable para seleccionar el gráfico
        self.graph_selector = ttk.Combobox(self.root, textvariable=self.selected_graph, state="readonly")
        self.graph_selector.pack(pady=5)
        self.graph_selector.bind("<<ComboboxSelected>>", lambda e: self.update_graph())

    def add_tab(self, tab_name: str):
        """Agrega una pestaña nueva si no existe."""
        if tab_name not in self.tabs:
            frame = tk.Frame(self.notebook)
            self.notebook.add(frame, text=tab_name)
            self.tabs[tab_name] = frame

    def load_tab(self, tab_name: str):
        """Selecciona la pestaña especificada si existe."""
        if tab_name in self.tabs:
            index = list(self.tabs.keys()).index(tab_name)
            self.notebook.select(index)

    def update_graph(self):
        """Carga el gráfico seleccionado en la pestaña activa."""
        current_tab_index = self.notebook.index(self.notebook.select())  # Índice de la pestaña activa
        current_tab_name = list(self.tabs.keys())[current_tab_index]  # Nombre de la pestaña activa
        current_frame = self.tabs[current_tab_name]  # Frame de la pestaña activa

        # Limpiar el contenido actual de la pestaña activa
        for widget in current_frame.winfo_children():
            widget.destroy()

        # Obtener el gráfico seleccionado
        selected_graph = self.selected_graph.get()

        # Mostrar el gráfico seleccionado
        label = tk.Label(current_frame, text=f"Mostrando: {selected_graph}", font=("Arial", 12))
        label.pack(pady=10)

    def update_graph_list(self):
        """Actualiza la lista de gráficos en el selector."""
        self.graph_selector["values"] = self.graph_names
        if self.graph_names:
            self.selected_graph.set(self.graph_names[0])  # Selecciona el primer gráfico si hay disponibles
