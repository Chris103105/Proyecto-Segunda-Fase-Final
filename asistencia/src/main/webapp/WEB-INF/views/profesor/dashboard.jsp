<%--
  Created by IntelliJ IDEA.
  User: UniRo
  Date: 25/10/2025
  Time: 04:59
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Profesor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        /* FONDO PRINCIPAL SOLICITADO */
        body {
            background-color: #011116; /* Color de fondo preferido */
            color: #ffffff;
        }
        /* Color de la barra de navegación (mantenido oscuro) */
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
        /* Estilo de las tarjetas ajustado para el fondo oscuro */
        .card-dashboard {
            border-left: 4px solid #3498db;
            transition: all 0.3s;
            cursor: pointer;
            background-color: #2c3e50; /* Fondo de tarjeta oscuro, mismo que Navbar */
            color: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        .card-dashboard h6, .card-dashboard p {
            color: white !important; /* Asegura que el texto sea visible */
        }
        .card-dashboard:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        /* Ajusta el fondo de la sección "Accesos Rápidos" */
        .card {
            background-color: #1a2935 !important; /* Fondo de tarjeta más claro que el body */
            border-color: rgba(255, 255, 255, 0.1);
        }
        .card-header, .card-body {
            background-color: #1a2935 !important;
            color: white;
        }
        .list-group-item {
            background-color: transparent !important;
            color: white;
            border-color: rgba(255,255,255,0.1);
        }
        .list-group-item:hover {
            background-color: rgba(255,255,255,0.15) !important;
        }
        /* Asegura que los títulos principales sigan siendo blancos */
        h2, .badge {
            color: white !important;
        }
        main {
            padding-top: 20px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand me-4" href="${pageContext.request.contextPath}/profesor/dashboard">
            <i class="bi bi-person-circle me-2"></i> Profesor | ${usuario.nombre}
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/profesor/dashboard">
                        <i class="bi bi-house-door"></i> Dashboard
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/profesor/estudiantes">
                        <i class="bi bi-people"></i> Estudiantes
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
<main class="container-fluid">
    <div class="col-md-12 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-grid"></i> Dashboard del Profesor</h2>
            <span class="badge bg-primary fs-6">Bienvenido, ${usuario.nombre}</span>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-4">
                <a href="${pageContext.request.contextPath}/profesor/asistencia/tomar" class="text-decoration-none">
                    <div class="card card-dashboard border-primary">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-2">Tomar Asistencia</h6>
                                    <p class="mb-0">Registrar asistencia diaria de estudiantes</p>
                                </div>
                                <i class="bi bi-clipboard-check fs-1 text-primary"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-primary bg-opacity-10 border-0">
                            <small class="text-primary"><i class="bi bi-arrow-right"></i> Ir al módulo</small>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-6 col-lg-4">
                <a href="${pageContext.request.contextPath}/profesor/asistencia/ver" class="text-decoration-none">
                    <div class="card card-dashboard border-success">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-2">Ver Asistencia</h6>
                                    <p class="mb-0">Consultar registros de asistencia</p>
                                </div>
                                <i class="bi bi-eye fs-1 text-success"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-success bg-opacity-10 border-0">
                            <small class="text-success"><i class="bi bi-arrow-right"></i> Ir al módulo</small>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-6 col-lg-4">
                <a href="${pageContext.request.contextPath}/profesor/asistencia/editar" class="text-decoration-none">
                    <div class="card card-dashboard border-warning">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-2">Editar Asistencia</h6>
                                    <p class="mb-0">Actualizar registros existentes</p>
                                </div>
                                <i class="bi bi-pencil-square fs-1 text-warning"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-warning bg-opacity-10 border-0">
                            <small class="text-warning"><i class="bi bi-arrow-right"></i> Ir al módulo</small>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-6 col-lg-4">
                <a href="${pageContext.request.contextPath}/profesor/estudiantes" class="text-decoration-none">
                    <div class="card card-dashboard border-info">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-2">Información Estudiantil</h6>
                                    <p class="mb-0">Ver datos de estudiantes</p>
                                </div>
                                <i class="bi bi-people fs-1 text-info"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-info bg-opacity-10 border-0">
                            <small class="text-info"><i class="bi bi-arrow-right"></i> Ir al módulo</small>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="bi bi-info-circle"></i> Accesos Rápidos</h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                            <a href="${pageContext.request.contextPath}/profesor/asistencia/tomar"
                               class="list-group-item list-group-item-action">
                                <i class="bi bi-clipboard-check text-primary"></i>
                                <strong>Tomar Asistencia Hoy</strong> - Registrar asistencia del día actual
                            </a>
                            <a href="${pageContext.request.contextPath}/profesor/asistencia/ver"
                               class="list-group-item list-group-item-action">
                                <i class="bi bi-download text-success"></i>
                                <strong>Descargar Reportes</strong> - Exportar asistencia en PDF o Excel
                            </a>
                            <a href="${pageContext.request.contextPath}/profesor/estudiantes"
                               class="list-group-item list-group-item-action">
                                <i class="bi bi-search text-info"></i>
                                <strong>Buscar Estudiante</strong> - Ver historial individual
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>