<%--
  Created by IntelliJ IDEA.
  User: UniRo
  Date: 25/10/2025
  Time: 05:09
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Asistencia</title>
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

        /* Ajuste de las tarjetas y contenedores */
        .card {
            background-color: #1a2935 !important; /* Fondo de tarjeta oscuro */
            color: #ffffff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .card-header, .card-footer {
            background-color: #2c3e50 !important;
            border-color: rgba(255, 255, 255, 0.1);
        }

        /* Estilo de la tabla para fondo oscuro */
        .table {
            --bs-table-bg: #1a2935; /* Color de fondo de la tabla */
            --bs-table-color: #ffffff;
            border-color: rgba(255, 255, 255, 0.1);
        }
        .table-dark {
            --bs-table-bg: #2c3e50;
            border-color: #2c3e50;
        }

        /* Rayado y texto blanco en filas impares */
        .table-striped > tbody > tr > * {
            color: #ffffff; /* Fuerza el texto blanco en TODAS las celdas de la tabla */
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

        /* Alertas para contraste */
        .alert-success { background-color: #28a74540; border-color: #28a745; color: #28a745; }
        .alert-danger { background-color: #dc354540; border-color: #dc3545; color: #dc3545; }
        .alert-info { background-color: #17a2b840; border-color: #17a2b8; color: #17a2b8; }
        .alert-warning { background-color: #ffc10740; border-color: #ffc107; color: #ffc107; }
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/profesor/asistencia/editar">
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
            <h2><i class="bi bi-pencil-square"></i> Editar Asistencia</h2>
            <hr class="text-white-50">

            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="bi bi-check-circle"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="bi bi-exclamation-triangle"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form method="get" class="card mb-4">
                <div class="card-body">
                    <div class="row align-items-end">
                        <div class="col-md-4">
                            <label class="form-label"><i class="bi bi-calendar"></i> Seleccionar Fecha</label>
                            <input type="date" name="fecha" class="form-control" value="${fecha}" required>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-search"></i> Buscar Registros
                            </button>
                        </div>
                    </div>
                </div>
            </form>

            <c:if test="${not empty asistencias}">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Registros de Asistencia - <fmt:formatDate value="${fecha}" pattern="dd/MM/yyyy"/></h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Alumno</th>
                                    <th>Sección</th>
                                    <th>Estado Actual</th>
                                    <th style="width: 300px;">Cambiar Estado</th>
                                    <th>Acción</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${asistencias}" var="asist">
                                    <tr>
                                        <td>${asist.id}</td>
                                        <td>
                                            <strong>${asist.alumno.nombre} ${asist.alumno.apellido}</strong>
                                        </td>
                                        <td>${asist.alumno.seccion.nombre}</td>
                                        <td>
                                                    <span class="badge
                                                        ${asist.estado.estado == 'Presente' ? 'bg-success' : ''}
                                                        ${asist.estado.estado == 'Ausente' ? 'bg-danger' : ''}
                                                        ${asist.estado.estado == 'Tarde' ? 'bg-warning text-dark' : ''}
                                                        ${asist.estado.estado == 'Justificado' ? 'bg-info' : ''}">
                                                        <i class="bi bi-circle-fill"></i> ${asist.estado.estado}
                                                    </span>
                                        </td>
                                        <td>
                                            <form method="post" action="${pageContext.request.contextPath}/profesor/asistencia/actualizar"
                                                  class="d-flex gap-2 align-items-center">
                                                <input type="hidden" name="asistenciaId" value="${asist.id}">
                                                <select name="estadoId" class="form-select form-select-sm" style="width: 150px;">
                                                    <c:forEach items="${estados}" var="est">
                                                        <option value="${est.id}" ${est.id == asist.estado.id ? 'selected' : ''}>
                                                                ${est.estado}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                                <button type="submit" class="btn btn-sm btn-success">
                                                    <i class="bi bi-check-lg"></i> Actualizar
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer">
                        <small class="text-muted">Total de registros: <strong>${asistencias.size()}</strong></small>
                    </div>
                </div>
            </c:if>

            <c:if test="${empty asistencias && not empty fecha}">
                <div class="alert alert-info">
                    <i class="bi bi-info-circle"></i> No hay registros de asistencia para la fecha seleccionada
                </div>
            </c:if>

            <c:if test="${empty fecha}">
                <div class="alert alert-warning">
                    <i class="bi bi-exclamation-triangle"></i> Seleccione una fecha para ver los registros
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>