Convertidor de Instrucciones a Binario

Este programa, desarrollado en Python, proporciona una herramienta gráfica para convertir instrucciones de ensamblador a su 
representación binaria de 32 bits correspondiente. Es útil para desarrolladores y estudiantes que trabajan con lenguaje 
ensamblador y necesitan traducir rápidamente sus códigos a formato binario para su procesamiento por parte de una máquina.

Funcionalidades principales:
•	Interfaz Gráfica Intuitiva: Construida con la biblioteca Tkinter de Python, que permite a los usuarios seleccionar archivos de entrada y salida, visualizar y editar las instrucciones fácilmente.
•	Conversión Automatizada: Utiliza algoritmos para analizar y convertir las instrucciones de ensamblador a su equivalente binario de 32 bits. 
•	Gestión de Archivos: Permite seleccionar archivos de entrada (.asm) y salida (.txt /.bin) a través de una interfaz amigable.

Adiciones:
1.	Se importó el módulo scrolledtext de tkinter para permitir la creación de un editor de texto con barras de desplazamiento, facilitando muchísimo más la edición.
2.	Se añadió un nuevo widget de ScrolledText para mostrar y editar el archivo de ensamblador antes de la conversión, lo que proporciona la capacidad de modificar el contenido del archivo de entrada.
3.	Se creó la función guardar_cambios() para permitir guardar los cambios realizados en el archivo de ensamblador abierto, agregando así una funcionalidad de guardado directamente desde la interfaz de usuario.
4.	Se incluyó un botón "Guardar Cambios" que invoca la función guardar_cambios() cuando se hace clic, ofreciendo una forma rápida y fácil de guardar los cambios realizados en el archivo de ensamblador.

Modificaciones:
1.	La función convertir() fue adaptada para obtener las instrucciones directamente del editor de texto, utilizando el método editor.get("1.0", tk.END).
Esta modificación simplifica el proceso y hace que la herramienta sea más interactiva.
2.	Se implementó una lista llamada problemas para almacenar las instrucciones que no pudieron ser convertidas correctamente, junto con el mensaje de error correspondiente. 
Esta lista proporciona una retroalimentación útil al usuario y facilita la corrección de errores.
3.	Se ajustó el código para que las instrucciones convertidas tengan un ancho de palabra de 32 bits. Esto se aplicó en la función assemble(instruccion) 
para garantizar la coherencia en el formato de las instrucciones convertidas.
