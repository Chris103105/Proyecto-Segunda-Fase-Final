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
    <title>Información Estudiantil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        /* FONDO PRINCIPAL SOLICITADO */
        body {
            background-color: #011116;
            color: #ffffff;
        }
        /* Color de la barra de navegación (Navbar Superior) */
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

        /* Ajuste de las tarjetas y contenedores */
        .card {
            background-color: #1a2935 !important;
            color: #ffffff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .card-header, .card-body {
            background-color: #1a2935 !important;
            color: white;
        }

        /* Estilo de la tabla para fondo oscuro */
        .table {
            --bs-table-bg: #1a2935;
            --bs-table-color: #ffffff;
            border-color: rgba(255, 255, 255, 0.1);
        }
        .table-dark {
            --bs-table-bg: #2c3e50;
            border-color: #2c3e50;
        }

        /* Rayado y texto blanco en filas impares */
        .table-striped > tbody > tr > * {
            color: #ffffff;
        }
        .table-striped > tbody > tr:nth-of-type(odd) > * {
            --bs-table-bg-type: #34495e;
            background-color: var(--bs-table-bg-type) !important;
        }
        .table-striped > tbody > tr:nth-of-type(even) > * {
            --bs-table-bg-type: #1a2935;
            background-color: var(--bs-table-bg-type) !important;
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

        /* Alertas y botones de acción */
        .alert-info { background-color: #17a2b840; border-color: #17a2b8; color: #17a2b8; }
        .btn-info { --bs-btn-bg: #17a2b8; --bs-btn-border-color: #17a2b8; }
        .btn-info:hover { background-color: #117a8b; border-color: #117a8b; }
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/profesor/asistencia/tomar">
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/profesor/estudiantes">
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
            <h2><i class="bi bi-people"></i> Información Estudiantil</h2>
            <hr class="text-white-50">

            <form method="get" class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title text-white">Filtros de Búsqueda</h5>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Buscar por Nombre</label>
                            <input type="text" name="busqueda" class="form-control"
                                   placeholder="Ingrese nombre o apellido..." value="${param.busqueda}">
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Filtrar por Sección</label>
                            <select name="seccionId" class="form-select">
                                <option value="">Todas las secciones</option>
                                <c:forEach items="${secciones}" var="sec">
                                    <option value="${sec.id}" ${param.seccionId == sec.id ? 'selected' : ''}>${sec.nombre}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-search"></i> Buscar
                            </button>
                        </div>
                    </div>
                </div>
            </form>

            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Lista de Estudiantes</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Nombre Completo</th>
                                <th>Sección</th>
                                <th>Especialidad</th>
                                <th>Responsable</th>
                                <th>Teléfono</th>
                                <th>Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${alumnos}" var="alumno">
                                <tr>
                                    <td>${alumno.id}</td>
                                    <td><strong>${alumno.nombre} ${alumno.apellido}</strong></td>
                                    <td>${alumno.seccion.nombre}</td>
                                    <td>${alumno.especialidad.nombre}</td>
                                    <td>${alumno.responsable.nombre} ${alumno.responsable.apellido}</td>
                                    <td>${alumno.responsable.telefono}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/profesor/estudiante/${alumno.id}/historial"
                                           class="btn btn-sm btn-info">
                                            <i class="bi bi-clock-history"></i> Historial
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <c:if test="${empty alumnos}">
                        <div class="alert alert-info mt-3">No se encontraron estudiantes</div>
                    </c:if>
                </div>
                <div class="card-footer">
                    <small>Total de estudiantes: <strong>${alumnos.size()}</strong></small>
                </div>
            </div>


        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>