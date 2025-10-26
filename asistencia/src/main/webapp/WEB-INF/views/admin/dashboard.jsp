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
    <title>Dashboard Administrador</title>
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
        /* Estilo de la tarjeta de gestión y estadísticas */
        .card, .card-stat, .module-card {
            background-color: #1a2935 !important; /* Fondo de tarjeta oscuro */
            color: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        /* Color de los textos dentro de la tarjeta */
        .card-stat h2, .card-stat h6, .module-card h5, .module-card p, .card-body p {
            color: white !important;
        }
        /* Estilos específicos de las tarjetas */
        .card-stat {
            border-left: 4px solid;
            transition: all 0.3s;
        }
        .card-stat:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        .module-card {
            cursor: pointer;
            transition: all 0.3s;
        }
        .module-card:hover {
            transform: scale(1.03);
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        /* Color de los footer de las tarjetas (fondo semitransparente) */
        .card-footer {
            background: rgba(255, 255, 255, 0.05) !important;
            border-color: rgba(255, 255, 255, 0.1);
        }
        /* Estilos de botones outline para el fondo oscuro */
        .btn-outline-primary, .btn-outline-success, .btn-outline-warning {
            border-width: 1px;
            --bs-btn-hover-bg: #3498db;
            --bs-btn-hover-border-color: #3498db;
            --bs-btn-color: white;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand me-4" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="bi bi-shield-check fs-5 me-2"></i> Administrador | ${usuario.nombre}
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/catalogos">
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
<main class="container-fluid">
    <div class="col-md-12 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-speedometer2"></i> Dashboard del Administrador</h2>
            <span class="badge bg-danger fs-6">Admin: ${usuario.nombre}</span>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-md-6">
                <div class="card card-stat" style="border-left-color: #3498db;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-2">Total de Estudiantes</h6>
                                <h2 class="text-primary mb-0">${totalAlumnos}</h2>
                            </div>
                            <i class="bi bi-people-fill fs-1 text-primary"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card card-stat" style="border-left-color: #2ecc71;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-2">Usuarios Registrados</h6>
                                <h2 class="text-success mb-0">${totalUsuarios}</h2>
                            </div>
                            <i class="bi bi-person-check-fill fs-1 text-success"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <h4 class="mb-3"><i class="bi bi-grid-3x3"></i> Módulos de Gestión</h4>
        <div class="row g-4">
            <div class="col-md-3">
                <a href="${pageContext.request.contextPath}/admin/estudiantes" class="text-decoration-none">
                    <div class="card module-card text-center border-primary">
                        <div class="card-body">
                            <i class="bi bi-person-plus fs-1 text-primary"></i>
                            <h5 class="mt-3">Estudiantes</h5>
                            <p class="small">Gestionar estudiantes del sistema</p>
                        </div>
                        <div class="card-footer bg-primary bg-opacity-10">
                            <small class="text-primary">Administrar <i class="bi bi-arrow-right"></i></small>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-3">
                <a href="${pageContext.request.contextPath}/admin/usuarios" class="text-decoration-none">
                    <div class="card module-card text-center border-success">
                        <div class="card-body">
                            <i class="bi bi-people fs-1 text-success"></i>
                            <h5 class="mt-3">Usuarios</h5>
                            <p class="small">Profesores y administradores</p>
                        </div>
                        <div class="card-footer bg-success bg-opacity-10">
                            <small class="text-success">Administrar <i class="bi bi-arrow-right"></i></small>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-3">
                <a href="${pageContext.request.contextPath}/admin/responsables" class="text-decoration-none">
                    <div class="card module-card text-center border-warning">
                        <div class="card-body">
                            <i class="bi bi-person-vcard fs-1 text-warning"></i>
                            <h5 class="mt-3">Responsables</h5>
                            <p class="small">Padres y tutores</p>
                        </div>
                        <div class="card-footer bg-warning bg-opacity-10">
                            <small class="text-warning">Administrar <i class="bi bi-arrow-right"></i></small>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-3">
                <a href="${pageContext.request.contextPath}/admin/catalogos" class="text-decoration-none">
                    <div class="card module-card text-center border-info">
                        <div class="card-body">
                            <i class="bi bi-gear fs-1 text-info"></i>
                            <h5 class="mt-3">Catálogos</h5>
                            <p class="small">Configuración del sistema</p>
                        </div>
                        <div class="card-footer bg-info bg-opacity-10">
                            <small class="text-info">Ver catálogos <i class="bi bi-arrow-right"></i></small>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="bi bi-lightning"></i> Acciones Rápidas</h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-2">
                            <div class="col-md-4">
                                <a href="${pageContext.request.contextPath}/admin/estudiantes/nuevo"
                                   class="btn btn-outline-primary w-100">
                                    <i class="bi bi-plus-circle"></i> Nuevo Estudiante
                                </a>
                            </div>
                            <div class="col-md-4">
                                <a href="${pageContext.request.contextPath}/admin/usuarios/nuevo"
                                   class="btn btn-outline-success w-100">
                                    <i class="bi bi-plus-circle"></i> Nuevo Usuario
                                </a>
                            </div>
                            <div class="col-md-4">
                                <a href="${pageContext.request.contextPath}/admin/responsables/nuevo"
                                   class="btn btn-outline-warning w-100">
                                    <i class="bi bi-plus-circle"></i> Nuevo Responsable
                                </a>
                            </div>
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