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
    <title>${responsable.id == null ? 'Nuevo' : 'Editar'} Responsable</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        /* FONDO PRINCIPAL SOLICITADO */
        body {
            background-color: #011116;
            color: #ffffff; /* Asegura que el texto principal sea blanco */
        }
        /* Estilo de la tarjeta principal */
        .card {
            background-color: #1a2935 !important; /* Fondo de tarjeta oscuro */
            color: #ffffff;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .card-header {
            background-color: #ffc107 !important; /* Amarillo de Bootstrap Warning */
            color: #111111 !important; /* Texto negro para contraste */
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
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
            border-color: #ffc107; /* Borde amarillo para enfoque */
            box-shadow: 0 0 0 0.25rem rgba(255, 193, 7, 0.25);
        }

        /* Texto de ayuda en modo oscuro */
        .text-muted {
            color: rgba(255, 255, 255, 0.7) !important;
        }
        /* Alerta de información */
        .alert-info {
            background-color: #17a2b840;
            border-color: #17a2b8;
            color: #17a2b8;
        }
        /* Botones de acción */
        .btn-warning {
            --bs-btn-color: #111;
            --bs-btn-bg: #ffc107;
            --bs-btn-border-color: #ffc107;
        }
        .btn-secondary {
            --bs-btn-color: #ffffff;
            --bs-btn-bg: #6c757d;
            --bs-btn-border-color: #6c757d;
        }

    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-warning text-dark">
                    <h4>
                        <i class="bi bi-person-vcard"></i>
                        ${responsable.id == null ? 'Nuevo' : 'Editar'} Responsable
                    </h4>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/responsables/${responsable.id == null ? 'guardar' : 'actualizar'}"
                          method="post">

                        <c:if test="${responsable.id != null}">
                            <input type="hidden" name="id" value="${responsable.id}">
                        </c:if>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Nombre *</label>
                                <input type="text" name="nombre" class="form-control"
                                       value="${responsable.nombre}" required
                                       placeholder="Ingrese el nombre">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Apellido *</label>
                                <input type="text" name="apellido" class="form-control"
                                       value="${responsable.apellido}" required
                                       placeholder="Ingrese el apellido">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Correo Electrónico *</label>
                                <input type="email" name="correo" class="form-control"
                                       value="${responsable.correo}" required
                                       placeholder="ejemplo@correo.com">
                                <small class="text-muted">Debe ser único en el sistema</small>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Teléfono</label>
                                <input type="text" name="telefono" class="form-control"
                                       value="${responsable.telefono}"
                                       placeholder="7777-7777"
                                       pattern="[0-9]{8,15}">
                                <small class="text-muted">Solo números, 8-15 dígitos</small>
                            </div>
                        </div>

                        <div class="alert alert-info">
                            <i class="bi bi-info-circle"></i> Los campos marcados con * son obligatorios
                        </div>

                        <div class="d-flex gap-2 justify-content-end">
                            <button type="submit" class="btn btn-warning">
                                <i class="bi bi-save"></i> Guardar Responsable
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/responsables"
                               class="btn btn-secondary">
                                <i class="bi bi-x-circle"></i> Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>