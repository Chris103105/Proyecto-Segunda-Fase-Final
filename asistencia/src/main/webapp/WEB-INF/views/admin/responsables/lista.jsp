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
    <title>Gestión de Responsables</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        /* FONDO PRINCIPAL SOLICITADO */
        body {
            background-color: #011116;
            color: #ffffff; /* Asegura que el texto principal sea blanco */
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

        /* Estilo de la tarjeta principal */
        .card {
            background-color: #1a2935 !important;
            color: #ffffff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .card-header {
            background-color: #34495e !important;
            border-color: rgba(255, 255, 255, 0.1);
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

        /* Ajuste de botones y alertas */
        .btn-warning {
            --bs-btn-bg: #ffc107;
            --bs-btn-color: #111;
        }
        .btn-danger {
            --bs-btn-bg: #dc3545;
            --bs-btn-border-color: #dc3545;
        }
        .alert-success { background-color: #28a74540; border-color: #28a745; color: #28a745; }
        .alert-danger { background-color: #dc354540; border-color: #dc3545; color: #dc3545; }
        .alert-info { background-color: #17a2b840; border-color: #17a2b8; color: #17a2b8; }
        .text-muted { color: rgba(255, 255, 255, 0.7) !important; }

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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/responsables">
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
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12 p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="bi bi-person-vcard"></i> Gestión de Responsables</h2>
                <a href="${pageContext.request.contextPath}/admin/responsables/nuevo" class="btn btn-warning">
                    <i class="bi bi-plus-circle"></i> Nuevo Responsable
                </a>
            </div>
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

            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Lista de Responsables</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Nombre Completo</th>
                                <th>Correo</th>
                                <th>Teléfono</th>
                                <th>Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${responsables}" var="resp">
                                <tr>
                                    <td>${resp.id}</td>
                                    <td><strong>${resp.nombre} ${resp.apellido}</strong></td>
                                    <td>${resp.correo}</td>
                                    <td>${resp.telefono}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/responsables/editar/${resp.id}"
                                           class="btn btn-sm btn-warning">
                                            <i class="bi bi-pencil"></i> Editar
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/responsables/eliminar/${resp.id}"
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('¿Está seguro de eliminar a ${resp.nombre} ${resp.apellido}? Se desvinculará de sus estudiantes.')">
                                            <i class="bi bi-trash"></i> Eliminar
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${empty responsables}">
                            <div class="alert alert-info">No hay responsables registrados</div>
                        </c:if>
                    </div>
                </div>
                <div class="card-footer">
                    <p class="text-muted mb-0">Total de responsables: <strong>${responsables.size()}</strong></p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>