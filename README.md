# Proyecto-Segunda-Fase-Final
#  Sistema Digital para el Registro y Control de Asistencia Escolar

## Descripción General
El **Sistema de Asistencia Automatizado** es una aplicación web desarrollada en **Java con Spring Boot**, utilizando el patrón **MVC (Modelo–Vista–Controlador)** y la persistencia de datos con **JPA (Java Persistence API)**.  
Su objetivo es optimizar el proceso de registro y control de asistencia escolar, eliminando el uso de métodos manuales y proporcionando una gestión moderna, precisa y accesible desde cualquier dispositivo conectado.

El sistema permite a los **docentes** registrar la asistencia diaria y a los **administradores** gestionar usuarios, alumnos y generar reportes en PDF.

---

##  Funcionalidades Principales
-  **Inicio de sesión con roles diferenciados** (Administrador / Docente).  
-  **Registro diario de asistencia** (Presente, Ausente, Llegada tarde).  
-  **Gestión completa de alumnos y usuarios** (Agregar, Editar, Eliminar).  
-  **Búsqueda y filtrado** por alumno, grado, sección o fecha.  
-  **Generación de reportes automáticos en PDF** con JasperReport.  
-  **Persistencia de datos** con **JPA** y base de datos **MySQL**.  
-  **Interfaz web responsiva e intuitiva**, accesible desde cualquier navegador.  

---

##  Requisitos del Sistema
-  **Java JDK 17 o superior**  
-  **Spring Boot 3.x**  
-  **Maven** (gestión de dependencias)  
-  **MySQL Server 
-  **Apache Tomcat (integrado con Spring Boot)**  
-  Dependencias principales:
  - `spring-boot-starter-data-jpa`
  - `spring-boot-starter-thymeleaf` o `spring-boot-starter-web`
  - `mysql-connector-j`
  - `jasperreports`

---

##  Instalación y Ejecución

### Clonar el repositorio
```bash
git clone https://github.com/[tu_usuario]/SistemaAsistenciaEscolar.git
