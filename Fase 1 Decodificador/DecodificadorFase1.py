import tkinter as tk  
from tkinter import filedialog  
from tkinter import messagebox 
from tkinter import colorchooser #pendiente

# Función para convertir un número decimal a binario de 5 bits
def decimal_a_binario(n):
    return '{:05b}'.format(n)

# Función para convertir una instrucción ensamblador a binario
def assemble(instruccion):
    # Definicion de los códigos de operación y los bits de función
    opcode = {
        'ADD': '000000',
        'SUB': '000000',
        'AND': '000000',
        'OR': '000000',
         'SLT': '000000'
    }
    funct = {
        'ADD': '100000',
        'SUB': '100010',
        'AND': '100100',
        'OR': '100101',
        'SLT': '101010'
    }
    # Definicion de la instrucción en partes y obtencion de los valores necesarios
    partes = instruccion.replace(',', '').split()
    op = opcode[partes[0]]
    rs = decimal_a_binario(int(partes[2][1:]))
    rt = decimal_a_binario(int(partes[3][1:]))
    rd = decimal_a_binario(int(partes[1][1:]))
    shamt = '00000'
    func = funct[partes[0]]
    # Concatenacion de los valores y devolucion la instrucción en binario
    return op + " " + rs + " " + rt + " " + rd + " " + shamt + " " + func

# Función para manejar el botón "Convertir"
def convertir():
    # Se obtienen las rutas de los archivos de entrada y salida desde las entradas de texto
    ruta_archivo_entrada = archivo_entrada.get()
    ruta_archivo_salida = archivo_salida.get()
    
    try:
        # Leer las instrucciones desde el archivo de entrada
        with open(ruta_archivo_entrada, 'r') as f:
            instrucciones = f.readlines()
        
        # Convertir las instrucciones a binario
        instrucciones_binario = [assemble(instruccion.strip()) for instruccion in instrucciones]

        # Escribir las instrucciones binarias en el archivo de salida
        with open(ruta_archivo_salida, 'w') as f:
            for instruccion_binario in instrucciones_binario:
                f.write(instruccion_binario + '\n')

        # Mensaje de éxito
        messagebox.showinfo("Éxito", "Se ha convertido el texto exitosamente! =D")
    except Exception as e:
        # Si ocurre algún error, se muestra un mensaje de error
        messagebox.showerror("Error", f"Ha ocurrido un error: {str(e)}")

# Función para manejar el botón "Seleccionar archivo de entrada"
def seleccionar_archivo_entrada():
    # Se abre un cuadro de diálogo para que el usuario seleccione un archivo de entrada
    input_file_path = filedialog.askopenfilename(filetypes=[("Text files", "*.txt")]) #AQUI MOVER PARA QUE SEA ENSAMBLADOR ASM
    # Se actualiza el campo de entrada de archivo con la ruta seleccionada
    archivo_entrada.delete(0, tk.END)
    archivo_entrada.insert(0, input_file_path)

# Función para manejar el botón "Seleccionar archivo de salida"
def seleccionar_archivo_salida():
    # Se abre un cuadro de diálogo para que el usuario seleccione la ubicación y el nombre del archivo de salida
    output_file_path = filedialog.asksaveasfilename(defaultextension=".txt") #AQUI MOVER PARA QUE SEA .BIN
    # Actualiza el campo de entrada de archivo con la ruta seleccionada
    archivo_salida.delete(0, tk.END)
    archivo_salida.insert(0, output_file_path)

# Crear la ventana principal
root = tk.Tk()
root.title("Convertidor de instrucciones a binario")  # Establecemos el título de la ventana

# Frame para el archivo de entrada
input_frame = tk.Frame(root)  # Crear un marco para organizar los elementos
input_frame.pack(pady=10)  # Empaquetar el marco en la ventana principal y agregamos un relleno vertical

# Etiqueta y campo de entrada para el archivo de entrada
input_label = tk.Label(input_frame, text="Archivo de entrada(.asm):")  # Crear una etiqueta con el texto especificado
input_label.grid(row=0, column=0)  # Colocar la etiqueta en la primera fila y primera columna del marco

archivo_entrada = tk.Entry(input_frame, width=50)  # crear un campo de entrada con el ancho especificado
archivo_entrada.grid(row=0, column=1)  # colocar el campo de entrada en la primera fila y segunda columna del marco

input_button = tk.Button(input_frame, text="Seleccionar archivo", command=seleccionar_archivo_entrada)  # Crear un botón con el texto especificado y vinculamos la función select_input_file al evento de clic
input_button.grid(row=0, column=2)  # colocar el botón en la primera fila y tercera columna del marco

# Frame para el archivo de salida
output_frame = tk.Frame(root)  # crear otro marco para organizar los elementos
output_frame.pack(pady=10)  # empaquetar el marco en la ventana principal y agregamos un relleno vertical

# Etiqueta y campo de entrada para el archivo de salida
output_label = tk.Label(output_frame, text="Archivo de salida(.bin):")  # crear una etiqueta con el texto especificado
output_label.grid(row=0, column=0)  # colocar la etiqueta en la primera fila y primera columna del marco

archivo_salida = tk.Entry(output_frame, width=50)  # crear un campo de entrada con el ancho especificado
archivo_salida.grid(row=0, column=1)  # colocar el campo de entrada en la primera fila y segunda columna del marco

output_button = tk.Button(output_frame, text="Seleccionar archivo", command=seleccionar_archivo_salida)  # crear un botón con el texto especificado y vinculamos la función select_output_file al evento de clic
output_button.grid(row=0, column=2)  # colocar el botón en la primera fila y tercera columna del marco

# Botón para convertir
convert_button = tk.Button(root, text="Convertir", command=convertir)  # crear un botón con el texto especificado y vinculamos la función convert al evento de clic
convert_button.pack(pady=10)  # empaquetar el botón en la ventana principal y agregamos un relleno vertical

# Ejecutar la aplicación
root.mainloop()  # iniciar el bucle de eventos de Tkinter para que la ventana sea visible y responda a las interacciones del usuario