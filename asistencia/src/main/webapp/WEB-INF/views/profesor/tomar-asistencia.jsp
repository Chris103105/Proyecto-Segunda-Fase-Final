<%--
  Created by IntelliJ IDEA.
  User: UniRo
  Date: 25/10/2025
  Time: 05:09
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tomar Asistencia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        /* FONDO PRINCIPAL SOLICITADO */
        body {
            background-color: #011116;
            color: #ffffff; /* Asegura que el texto principal sea blanco */
        }
        /* Color de la barra de navegación (se mantiene oscuro para contraste) */
        .navbar-custom {
            background-color: #2c3e50;
        }
        .nav-link {
            color: rgba(255,255,255,0.8);
            transition: all 0.3s;
        }
        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.1);
            color: white !important;
            border-radius: 5px;
        }
        main {
            padding-top: 20px;
        }

        /* Ajuste de las tarjetas (Filtros) con leve contraste */
        .card {
            background-color: #1a2935 !important;
            color: #ffffff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* El contenedor de la tabla será transparente */
        .table-responsive {
            background-color: transparent;
            padding: 15px;
            border-radius: 8px;
            box-shadow: none;
        }

        /* ESTILO DE LA TABLA: Fondo igual que el body */
        .table {
            --bs-table-bg: #011116; /* MISMO color que el body */
            --bs-table-color: #ffffff; /* Color del texto de las filas pares y por defecto */
            border-color: rgba(255, 255, 255, 0.1);
        }

        /* Redefinir el encabezado */
        .table-dark {
            --bs-table-bg: #2c3e50;
            border-color: #2c3e50;
        }

        /* ESTILO CRÍTICO: Rayado para las filas impares */
        .table-striped > tbody > tr:nth-of-type(odd) > * {
            --bs-table-bg-type: #1a2935; /* Color sutilmente diferente para las filas impares */
            background-color: var(--bs-table-bg-type) !important;
            color: #ffffff; /* Mantiene el texto en blanco para las filas impares */
        }

        /* Input y select en modo oscuro */
        .form-control, .form-select {
            background-color: #34495e;
            color: #ffffff;
            border-color: #555;
        }
        .form-control:focus, .form-select:focus {
            background-color: #34495e;
            color: #ffffff;
            border-color: #3498db;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        /* Alertas para contraste en fondo oscuro */
        .alert-info { background-color: #17a2b840; border-color: #17a2b8; color: #17a2b8; }
        .alert-success { background-color: #28a74540; border-color: #28a745; color: #28a745; }
        .alert-warning { background-color: #ffc10740; border-color: #ffc107; color: #ffc107; }
        .alert-danger { background-color: #dc354540; border-color: #dc3545; color: #dc3545; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand me-4" href="${pageContext.request.contextPath}/profesor/dashboard">
            <i class="bi bi-person-circle me-2"></i> Profesor
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/profesor/dashboard">
                        <i class="bi bi-house-door"></i> Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/profesor/asistencia/tomar">
                        <i class="bi bi-clipboard-check"></i> Tomar Asistencia
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/profesor/asistencia/ver">
                        <i class="bi bi-eye"></i> Ver Asistencia
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/profesor/asistencia/editar">
                        <i class="bi bi-pencil-square"></i> Editar Asistencia
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/profesor/estudiantes">
                        <i class="bi bi-people"></i> Estudiantes
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link text-danger fw-bold" href="${pageContext.request.contextPath}/logout">
                        <i class="bi bi-box-arrow-right"></i> Salir
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12 p-4">
            <h2><i class="bi bi-clipboard-check"></i> Tomar Asistencia</h2>
            <hr class="text-white-50">

            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show">
                        ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">
                        ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title text-white">Filtros de Búsqueda</h5>
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label">Fecha</label>
                            <input type="date" id="fecha" class="form-control" value="${fecha}" required>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Bachillerato</label>
                            <select id="bachilleratoId" class="form-select">
                                <option value="">Todos</option>
                                <c:forEach items="${bachilleratos}" var="bach">
                                    <option value="${bach.id}">${bach.nombre}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Sección</label>
                            <select id="seccionId" class="form-select">
                                <option value="">Todos</option>
                                <c:forEach items="${secciones}" var="sec">
                                    <option value="${sec.id}">${sec.nombre}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Especialidad</label>
                            <select id="especialidadId" class="form-select">
                                <option value="">Todos</option>
                                <c:forEach items="${especialidades}" var="esp">
                                    <option value="${esp.id}">${esp.nombre}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <button type="button" onclick="cargarAlumnos()" class="btn btn-primary mt-3">
                        <i class="bi bi-search"></i> Filtrar Alumnos
                    </button>
                </div>
            </div>

            <div id="listaAlumnos">
                <div class="alert alert-info">
                    <i class="bi bi-info-circle"></i> Seleccione los filtros y haga clic en "Filtrar Alumnos"
                </div>
            </div>

            <form id="formAsistencia" action="${pageContext.request.contextPath}/profesor/asistencia/guardar"
                  method="post" style="display: none;">
                <input type="hidden" id="fechaGuardar" name="fecha">
                <div id="alumnosAsistencia" class="mb-3"></div>
                <div class="mt-4">
                    <button type="submit" class="btn btn-success btn-lg">
                        <i class="bi bi-check-circle"></i> Guardar Asistencia
                    </button>
                    <button type="button" onclick="cancelar()" class="btn btn-secondary btn-lg ms-2">
                        <i class="bi bi-x-circle"></i> Cancelar
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const contextPath = '${pageContext.request.contextPath}';

    function cargarAlumnos() {
        const bachilleratoId = document.getElementById('bachilleratoId').value;
        const seccionId = document.getElementById('seccionId').value;
        const especialidadId = document.getElementById('especialidadId').value;
        const fecha = document.getElementById('fecha').value;

        if (!fecha) {
            alert('Por favor seleccione una fecha');
            return;
        }

        // Construir URL con parámetros
        let url = contextPath + '/profesor/asistencia/alumnos?';
        const params = [];

        // Solo añadir IDs si están seleccionados (no 'Todos')
        if (bachilleratoId) params.push('bachilleratoId=' + bachilleratoId);
        if (seccionId) params.push('seccionId=' + seccionId);
        if (especialidadId) params.push('especialidadId=' + especialidadId);

        url += params.join('&');

        console.log('Cargando alumnos desde:', url);

        // Mostrar loading
        document.getElementById('listaAlumnos').innerHTML =
            '<div class="text-center p-4"><div class="spinner-border text-primary" role="status"></div><p class="mt-2 text-white">Cargando alumnos...</p></div>';

        // Hacer petición AJAX
        fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error en la respuesta del servidor');
                }
                return response.json();
            })
            .then(alumnos => {
                console.log('Alumnos recibidos:', alumnos);

                if (alumnos.length === 0) {
                    document.getElementById('listaAlumnos').innerHTML =
                        '<div class="alert alert-warning"><i class="bi bi-exclamation-triangle"></i> No se encontraron alumnos con los filtros seleccionados</div>';
                    document.getElementById('formAsistencia').style.display = 'none';
                } else {
                    mostrarAlumnos(alumnos, fecha);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('listaAlumnos').innerHTML =
                    '<div class="alert alert-danger"><i class="bi bi-exclamation-circle"></i> Error al cargar alumnos: ' + error.message + '</div>';
                document.getElementById('formAsistencia').style.display = 'none';
            });
    }

    function mostrarAlumnos(alumnos, fecha) {
        // Mensaje de éxito
        document.getElementById('listaAlumnos').innerHTML =
            '<div class="alert alert-success"><i class="bi bi-check-circle"></i> ' + alumnos.length + ' alumno(s) encontrado(s)</div>';

        // Construir tabla
        let html = '<div class="table-responsive"><table class="table table-striped table-hover table-bordered">';
        html += '<thead class="table-dark">';
        html += '<tr>';
        html += '<th class="text-center" style="width: 50px;">#</th>';
        html += '<th>Nombre Completo</th>';
        html += '<th class="text-center" style="width: 150px;">Sección</th>';
        html += '<th class="text-center" style="width: 100px;">Presente</th>';
        html += '<th class="text-center" style="width: 100px;">Ausente</th>';
        html += '<th class="text-center" style="width: 100px;">Tarde</th>';
        html += '<th class="text-center" style="width: 120px;">Justificado</th>';
        html += '</tr>';
        html += '</thead>';
        html += '<tbody>';

        alumnos.forEach((alumno, index) => {
            html += '<tr>';
            html += '<td class="text-center">' + (index + 1) + '</td>';
            // Nota: Estos campos dependen de que el backend los envíe correctamente.
            html += '<td><strong>' + (alumno.nombre || 'N/A') + ' ' + (alumno.apellido || 'N/A') + '</strong></td>';
            // La sección depende de que la propiedad 'seccion' esté cargada y tenga 'nombre'
            html += '<td class="text-center">' + (alumno.seccion && alumno.seccion.nombre ? alumno.seccion.nombre : 'N/A') + '</td>';
            // Radio buttons: por defecto, ninguno está marcado, el usuario debe elegir o el servidor debe pre-cargar el estado.
            html += '<td class="text-center"><input type="radio" name="alumno_' + alumno.id + '" value="1" class="form-check-input" required></td>';
            html += '<td class="text-center"><input type="radio" name="alumno_' + alumno.id + '" value="2" class="form-check-input"></td>';
            html += '<td class="text-center"><input type="radio" name="alumno_' + alumno.id + '" value="3" class="form-check-input"></td>';
            html += '<td class="text-center"><input type="radio" name="alumno_' + alumno.id + '" value="4" class="form-check-input"></td>';
            html += '</tr>';
        });

        html += '</tbody></table></div>';

        // Insertar tabla en el formulario
        document.getElementById('alumnosAsistencia').innerHTML = html;
        document.getElementById('fechaGuardar').value = fecha;
        document.getElementById('formAsistencia').style.display = 'block';

        // Scroll al formulario
        document.getElementById('formAsistencia').scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function cancelar() {
        document.getElementById('formAsistencia').style.display = 'none';
        document.getElementById('listaAlumnos').innerHTML =
            '<div class="alert alert-info"><i class="bi bi-info-circle"></i> Seleccione los filtros y haga clic en "Filtrar Alumnos"</div>';
    }

    // Validación antes de enviar
    document.getElementById('formAsistencia').addEventListener('submit', function(e) {
        const totalAlumnos = document.querySelectorAll('#alumnosAsistencia tbody tr').length;
        const radiosMarcados = this.querySelectorAll('input[type="radio"]:checked').length;

        if (radiosMarcados < totalAlumnos) {
            e.preventDefault();
            alert('Debe marcar un estado de asistencia para CADA alumno.');
            return false;
        }
    });
</script>
</body>
</html>