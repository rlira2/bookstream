# BookStream

El proyecto escogido es **[eBooks Manager]**. Este es un *SaaS* que te permitirá tener todos tus libros electrónicos sincronizados en todos tus dispositivos.

##Instrucciones de instalación

Para instalar la aplicación debes descargar la carpeta BookStream que se encuentra en el repositorio privado:

> [https://github.com/IIC2143-2016-1/bookstream](https://github.com/IIC2143-2016-1/bookstream)

Luego, debes abrir la terminal o consola de tu computador e ingresar a la carpeta BookStream. Asegúrate de tener Ruby (versión 2.2 o posterior) on Rails (versión 4.2.6 o posterior) instaladas en tu computador antes de correr la aplicación.

Para correr la aplicación en el servidor, escribe desde la consola:
```
$bundle install
$bundle exec rake db:migrate
$rails s
```
Nota: en caso de tener problemas de permisos, ejecuta lo anterior anteponiendo sudo.

Luego, abre la aplicación desde un browser, ingresando en el siguiente link:

> [http://localhost:3000/](http://localhost:3000/)

## Variables de entorno y uso de APIs

Si se quiere cambiar la API key de GoogleBooks y de CloudCovert modifica el archivo que se encuentra en BookStream/config/aplication.yml.
Por excesivo uso podría ocurrir que se agote el recurso de la API para la conversión de archivos (ya que es una versión gratis). Si esto sucede, ir al archivo BookStream/app/controllers/application_controller.rb y descomentar la línea #33 y comentar la #34.

## Lectura de libros

Bookstream está optimizado para la lectura de libros en formato pdf, por lo que si se trata de leer un libro de otra extensión será transformado automáticamente a pdf y guardado en un caché (BookStream/public/tempdf). Por esto, la primera lectura de un libro no pdf tomará más tiempo (conversión + renderización), pero a partir de entonces, será como un libro cualquiera. Tener precaución con esto, ya que podría agotar la gema de conversión.

## Usuario administrador

Los permisos de este usuario son asignados sólo si el mail del usuario es bookstreammailer@gmail.com, por lo tanto, para entrar como administrador de la aplicación, crea un usuario con ese mail e inicia sesión.
Los permisos especiales que tiene este usuario son:
* Ver todos los usuarios, editarlos o eliminarlos.
* Ver todos los libros (información adicional: acceso del libro, su ID, usuario del libro (si es privado) y su ID), editarlos o eliminarlos.
* Ver todas las etiquetas, editarlas o eliminarlas.

## Buscador

La barra para buscar aparecerá en la barra de navegación solo si estás en tu biblioteca, en la pública o, para el usuario administrador, en la página de los usuarios. Se puede buscar libros por su título, autor, etiquetas, descripción, nombre del archivo o de la imagen. En el caso del administrador, adicionalmente, puede buscar por el id del libro, su accesso ("Private" o "Public") o atributos del dueño del libro (id, nombre, apellido o mail).
En la búsqueda de usuarios, se puede buscar por id, nombre, apellido, etiquetas o mail.

## Modelo

El modelo consiste en tres entidades principales:

___

### Usuario
Para usar la aplicación debes registrarte (en *Sign Up*) con tu nombre completo, un email y una clave de 6 caracteres mínimo. Luego, inicia sesión (en *Log In*) y podrás ver todos los libros que tienes disponibles en tu biblioteca para visualizar.
Si deseas cambiar tu contraseña o eliminar tu cuenta, debes tener iniciada la sesión y apretar a la derecha de la barra superior, en las opciones del usuario *Configurations*.
Si quieres dejar comentarios o críticas, puedes presionar en *Give us feedback* para llenar el formulario (estos le llegarán al mail del administrador).

___

### Libro
Para agregar un nuevo libro, inicia sesión y aprieta el botón “Upload a new Book”. Debes ingresar al menos un nombre, un autor y un archivo de tipo *epub*, *mobi* o *pdf*. Opcionalmente, puedes agregarle una carátula y una descripción. Estos aparecerán en tu librería en el *Home* de tu sesión. En el "Show" del libro, se puede enviar al mail del usuario, agregar o quitar etiquetas, editar, eliminar y leer (donde aparecerá disponible en la barra de navegación, la opción de escuchar música).

___

### Etiqueta
Cada usuario puede agregar cuantas etiquetas quiera y asignárselas a sus libros, y así poder organizarlos de mejor manera. Para crear, editar y eliminar tus etiquetas, dirígete al costado inferior de la página web. Ahí encontrarás *Add tags* para crear nuevas etiquetas y *Edit tags* para ver las que ya tienes creadas, editarlas o eliminar alguna. Si quieres asignarle una categoría a un libro, ingresa al *Show* del libro y elige cuál agregar o remover.

## DISFRUTA LA APP!!


## Creadores:


| Nº Alumno    | Nombre              | Email UC      | Github          |
|:-------------|:--------------------|:--------------|:----------------|
| 12639176     | Sofía Zambrano     | sizambrano@uc.cl | @sofizambrano     |
| 12635642     | Ricardo Lira        | rlira2@uc.cl | @rlira2     |
| 13634933     | Juan Ignacio Márquez | jgmarquez@uc.cl | @imarquezc     |
