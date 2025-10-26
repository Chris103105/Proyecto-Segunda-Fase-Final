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
    <title>Gestión de Usuarios</title>
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

        /* Estilo de la tabla y contenedores */
        .table-responsive {
            padding-top: 15px;
        }
        .table {
            --bs-table-bg: #1a2935; /* Fondo base de la tabla */
            --bs-table-color: #ffffff;
            border-color: rgba(255, 255, 255, 0.1);
        }
        .table-dark {
            --bs-table-bg: #2c3e50; /* Cabecera con más contraste */
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

        /* Ajuste de alertas */
        .alert-success { background-color: #28a74540; border-color: #28a745; color: #28a745; }
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/usuarios">
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
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12 p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="bi bi-people"></i> Gestión de Usuarios</h2>
                <a href="${pageContext.request.contextPath}/admin/usuarios/nuevo" class="btn btn-success">
                    <i class="bi bi-plus-circle"></i> Nuevo Usuario
                </a>
            </div>
            <hr class="text-white-50">

            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="bi bi-check-circle"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Rol</th>
                        <th>Fecha Registro</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${usuarios}" var="usuario">
                        <tr>
                            <td>${usuario.id}</td>
                            <td><strong>${usuario.nombre}</strong></td>
                            <td>${usuario.email}</td>
                            <td>
                                <span class="badge ${usuario.rol == 'ADMINISTRADOR' ? 'bg-danger' : 'bg-primary'}">
                                        ${usuario.rol}
                                </span>
                            </td>
                            <td>${usuario.fechaRegistro}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/usuarios/editar/${usuario.id}"
                                   class="btn btn-sm btn-warning">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/usuarios/eliminar/${usuario.id}"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('¿Está seguro de eliminar a ${usuario.nombre}?')"
                                   title="Eliminar">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty usuarios}">
                <div class="alert alert-info mt-3">
                    <i class="bi bi-info-circle"></i> No hay usuarios registrados.
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>