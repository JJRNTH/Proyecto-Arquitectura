import tkinter as tk
from tkinter import filedialog
from tkinter import messagebox
from tkinter import scrolledtext

# Función para convertir un número decimal a binario con un número específico de bits
def decimal_a_binario(n, bits):
    return format(n, f'0{bits}b')

# Función para convertir una instrucción de ensamblador a binario
def assemble(instruccion):
    opcode = {
        'ADD': '000000',
        'SUB': '000000',
        'AND': '000000',
        'OR': '000000',
        'SLT': '000000',
        'ADDI': '001000',
        'ORI': '001101',
        'ANDI': '001100',
        'LW': '100011',
        'SW': '101011',
        'SLTI': '001010',
        'BEQ': '000100',
        'J': '000010',
        'NOP': '000000'
    }
    funct = {
        'ADD': '100000',
        'SUB': '100010',
        'AND': '100100',
        'OR': '100101',
        'SLT': '101010',
        'NOP': '000000'
    }
    partes = instruccion.replace(',', '').split()
    op = opcode[partes[0]]
    
    if partes[0] in ['ADDI', 'ORI', 'ANDI', 'SLTI']:
        rs = decimal_a_binario(int(partes[2][1:]), 5)
        rt = decimal_a_binario(int(partes[1][1:]), 5)
        inmediato = decimal_a_binario(int(partes[3][1:]), 16)
        instruccion_binaria = op + rs + rt + inmediato
    elif partes[0] in ['LW', 'SW']:
        rt = decimal_a_binario(int(partes[1][1:]), 5)
        inmediato = decimal_a_binario(int(partes[2][1:]), 16)
        rs = decimal_a_binario(int(partes[3][1:]), 5)
        instruccion_binaria = op + rs + rt + inmediato
    elif partes[0] == 'BEQ':
        rs = decimal_a_binario(int(partes[1][1:]), 5)
        rt = decimal_a_binario(int(partes[2][1:]), 5)
        inmediato = decimal_a_binario(int(partes[3][1:]), 16)
        instruccion_binaria = op + rs + rt + inmediato
    elif partes[0] == 'J':
        direccion = decimal_a_binario(int(partes[1][1:]), 26)
        instruccion_binaria = op + direccion
    elif partes[0] == 'NOP':
        instruccion_binaria = '0' * 32
    else:
        rs = decimal_a_binario(int(partes[2][1:]), 5)
        rt = decimal_a_binario(int(partes[3][1:]), 5)
        rd = decimal_a_binario(int(partes[1][1:]), 5)
        shamt = '00000'
        func = funct[partes[0]]
        instruccion_binaria = op + rs + rt + rd + shamt + func
    
    return ' '.join([instruccion_binaria[i:i+8] for i in range(0, len(instruccion_binaria), 8)])

# Función para manejar el botón "Convertir"
def convertir():
    instrucciones = editor.get("1.0", tk.END).splitlines()
    instrucciones_binario = []
    problemas = []
    for instruccion in instrucciones:
        instruccion = instruccion.strip()
        if instruccion:
            try:
                instruccion_binaria = assemble(instruccion)
                instrucciones_binario.append(instruccion_binaria)
            except Exception as e:
                problemas.append((instruccion, str(e)))
    ruta_archivo_salida = archivo_salida.get()
    try:
        with open(ruta_archivo_salida, 'w') as f:
            for instruccion_binaria in instrucciones_binario:
                f.write(instruccion_binaria + '\n')
        messagebox.showinfo("Éxito", "Archivo de texto creado exitosamente!")
    except Exception as e:
        messagebox.showerror("Error", f"Ha ocurrido un error: {str(e)}")

    if problemas:
        with open('problemas.txt', 'w') as f:
            for instruccion, mensaje in problemas:
                f.write(f"Instrucción: {instruccion}\nError: {mensaje}\n\n")

# Función para seleccionar el archivo de entrada y cargar su contenido en el editor
def seleccionar_archivo_entrada():
    input_file_path = filedialog.askopenfilename(filetypes=[("Assembler files", "*.asm")])
    archivo_entrada.delete(0, tk.END)
    archivo_entrada.insert(0, input_file_path)
    try:
        with open(input_file_path, 'r') as file:
            content = file.read()
        editor.delete("1.0", tk.END)
        editor.insert("1.0", content)
    except Exception as e:
        messagebox.showerror("Error", f"Ha ocurrido un error al abrir el archivo :(: {str(e)}")

# Función para seleccionar el archivo de salida
def seleccionar_archivo_salida():
    output_file_path = filedialog.asksaveasfilename(defaultextension=".txt", filetypes=[("Text files", "*.txt")])
    archivo_salida.delete(0, tk.END)
    archivo_salida.insert(0, output_file_path)

# Función para guardar los cambios hechos al archivo de ensamblador abierto
def guardar_cambios():
    content = editor.get("1.0", tk.END)
    input_file_path = archivo_entrada.get()
    try:
        with open(input_file_path, 'w') as file:
            file.write(content)
        messagebox.showinfo("Éxito", "Cambios guardados exitosamente :D.")
    except Exception as e:
        messagebox.showerror("Error", f"No se pudieron guardar los cambios: {str(e)}")

# Crear la ventana principal
root = tk.Tk()
root.title("Convertidor de instrucciones a binario")

# Frame para el archivo de entrada
input_frame = tk.Frame(root)
input_frame.pack(pady=10)  # Empaquetar el marco en la ventana principal con un relleno vertical de 10 píxeles

# Etiqueta y campo de entrada para el archivo de entrada
input_label = tk.Label(input_frame, text="Archivo de entrada(.asm):")
input_label.grid(row=0, column=0)  # Colocar la etiqueta en la primera fila y primera columna del marco
archivo_entrada = tk.Entry(input_frame, width=50)
archivo_entrada.grid(row=0, column=1)  # Colocar el campo de entrada en la primera fila y segunda columna del marco
input_button = tk.Button(input_frame, text="Seleccionar archivo", command=seleccionar_archivo_entrada)
input_button.grid(row=0, column=2)  # Colocar el botón en la primera fila y tercera columna del marco

# Frame para el archivo de salida
output_frame = tk.Frame(root)
output_frame.pack(pady=10)  # Empaquetar el marco en la ventana principal con un relleno vertical de 10 píxeles

# Etiqueta y campo de entrada para el archivo de salida
output_label = tk.Label(output_frame, text="Archivo de salida(.txt):")
output_label.grid(row=0, column=0)  # Colocar la etiqueta en la primera fila y primera columna del marco
archivo_salida = tk.Entry(output_frame, width=50)
archivo_salida.grid(row=0, column=1)  # Colocar el campo de entrada en la primera fila y segunda columna del marco
output_button = tk.Button(output_frame, text="Seleccionar archivo", command=seleccionar_archivo_salida)
output_button.grid(row=0, column=2)  # Colocar el botón en la primera fila y tercera columna del marco

# Editor de texto para mostrar y editar el archivo de ensamblador
editor = scrolledtext.ScrolledText(root, width=80, height=20)
editor.pack(pady=10)  # Empaquetar el editor en la ventana principal con un relleno vertical de 10 píxeles

# Botón para guardar los cambios en el archivo de ensamblador
save_button = tk.Button(root, text="Guardar Cambios", command=guardar_cambios)
save_button.pack(pady=10)  # Empaquetar el botón en la ventana principal con un relleno vertical de 10 píxeles

# Botón para convertir el archivo de ensamblador a binario
convert_button = tk.Button(root, text="Convertir", command=convertir)
convert_button.pack(pady=10)  # Empaquetar el botón en la ventana principal con un relleno vertical de 10 píxeles

# Iniciar la aplicación
root.mainloop()
