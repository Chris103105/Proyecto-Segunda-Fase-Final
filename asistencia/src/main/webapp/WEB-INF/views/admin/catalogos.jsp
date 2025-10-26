<%--
  Created by IntelliJ IDEA.
  User: UniRo
  Date: 25/10/2025
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Catálogos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        /* FONDO PRINCIPAL SOLICITADO */
        body {
            background-color: #011116;
            color: #ffffff; /* Asegura que el texto principal sea blanco */
        }
        /* Color de la barra de navegación */
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

        /* Estilo de las tarjetas de catálogo */
        .card, .catalog-card {
            background-color: #1a2935 !important;
            color: #ffffff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .card-header {
            border-color: rgba(255, 255, 255, 0.1) !important;
        }
        .card-footer {
            background-color: #2c3e50 !important;
            border-color: rgba(255, 255, 255, 0.1);
        }
        .catalog-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }

        /* Ajuste de la lista de catálogos */
        .list-group-item {
            background-color: #1a2935 !important;
            color: white;
            border-color: rgba(255, 255, 255, 0.1);
        }
        .list-group-item:nth-child(odd) {
            background-color: #34495e !important;
        }

        /* Texto mutado para el fondo oscuro */
        .text-muted {
            color: rgba(255, 255, 255, 0.7) !important;
        }

        /* Alertas de información */
        .alert-info { background-color: #17a2b840; border-color: #17a2b8; color: #17a2b8; }

    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand me-4" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="bi bi-shield-check fs-5 me-2"></i> Administrador
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="bi bi-house-door"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/estudiantes">
                        <i class="bi bi-person-plus"></i> Estudiantes
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/usuarios">
                        <i class="bi bi-people"></i> Usuarios
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/responsables">
                        <i class="bi bi-person-vcard"></i> Responsables
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/catalogos">
                        <i class="bi bi-gear"></i> Catálogos
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link text-danger fw-bold" href="${pageContext.request.contextPath}/logout">
                        <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12 p-4">
            <h2 class="mb-4">
                <i class="bi bi-gear"></i> Gestión de Catálogos
            </h2>
            <hr class="text-white-50">

            <p class="text-muted">Administra los catálogos del sistema: Bachilleratos, Secciones y Especialidades</p>

            <div class="row g-4 mt-2">
                <div class="col-md-4">
                    <div class="card catalog-card h-100">
                        <div class="card-header bg-primary text-white">
                            <h5><i class="bi bi-building"></i> Bachilleratos</h5>
                        </div>
                        <div class="card-body">
                            <p class="text-muted">Años escolares disponibles</p>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${bachilleratos}" var="bach">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                            ${bach.nombre}
                                        <span class="badge bg-primary rounded-pill">${bach.id}</span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="card-footer">
                            <small class="text-muted">Total: ${bachilleratos.size()} registros</small>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card catalog-card h-100">
                        <div class="card-header bg-success text-white">
                            <h5><i class="bi bi-grid-3x3"></i> Secciones</h5>
                        </div>
                        <div class="card-body">
                            <p class="text-muted">Secciones por bachillerato</p>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${secciones}" var="sec">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        Sección ${sec.nombre}
                                        <span class="badge bg-success rounded-pill">
                                                ${sec.bachillerato.nombre}
                                        </span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="card-footer">
                            <small class="text-muted">Total: ${secciones.size()} registros</small>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card catalog-card h-100">
                        <div class="card-header bg-info text-white">
                            <h5><i class="bi bi-mortarboard"></i> Especialidades</h5>
                        </div>
                        <div class="card-body">
                            <p class="text-muted">Especialidades técnicas</p>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${especialidades}" var="esp">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                            ${esp.nombre}
                                        <span class="badge bg-info rounded-pill">
                                                ${esp.bachillerato.nombre}
                                        </span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="card-footer">
                            <small class="text-muted">Total: ${especialidades.size()} registros</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="alert alert-info">
                        <h5><i class="bi bi-info-circle"></i> Información</h5>
                        <p class="mb-0">
                            Los catálogos son datos maestros del sistema. Para agregar, editar o eliminar registros,
                            debes hacerlo directamente en la base de datos o solicitar al administrador del sistema.
                        </p>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header bg-dark text-white">
                            <h5><i class="bi bi-bar-chart"></i> Resumen del Sistema</h5>
                        </div>
                        <div class="card-body">
                            <div class="row text-center">
                                <div class="col-md-3">
                                    <h3 class="text-primary">${bachilleratos.size()}</h3>
                                    <p class="text-muted">Bachilleratos</p>
                                </div>
                                <div class="col-md-3">
                                    <h3 class="text-success">${secciones.size()}</h3>
                                    <p class="text-muted">Secciones</p>
                                </div>
                                <div class="col-md-3">
                                    <h3 class="text-info">${especialidades.size()}</h3>
                                    <p class="text-muted">Especialidades</p>
                                </div>
                                <div class="col-md-3">
                                    <h3 class="text-warning">4</h3>
                                    <p class="text-muted">Estados de Asistencia</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Volver al Dashboard
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>