<%--
  Created by IntelliJ IDEA.
  User: UniRo
  Date: 25/10/2025
  Time: 05:14
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${usuario.id == null ? 'Nuevo' : 'Editar'} Usuario</title>
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
            background-color: #198754 !important; /* Verde (Success) */
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
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
            border-color: #198754; /* Borde verde para enfoque */
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
        }

        /* Botones de acción */
        .btn-success {
            --bs-btn-bg: #198754;
            --bs-btn-border-color: #198754;
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
        <div class="col-md-6">
            <div class="card shadow-lg">
                <div class="card-header bg-success text-white">
                    <h4>
                        <i class="bi bi-person-${usuario.id == null ? 'plus' : 'gear'}"></i>
                        ${usuario.id == null ? 'Nuevo' : 'Editar'} Usuario
                    </h4>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/usuarios/${usuario.id == null ? 'guardar' : 'actualizar'}"
                          method="post">

                        <c:if test="${usuario.id != null}">
                            <input type="hidden" name="id" value="${usuario.id}">
                        </c:if>

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-person"></i> Nombre Completo *</label>
                            <input type="text" name="nombre" class="form-control"
                                   value="${usuario.nombre}" required
                                   placeholder="Ingrese el nombre completo">
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-envelope"></i> Email *</label>
                            <input type="email" name="email" class="form-control"
                                   value="${usuario.email}" required
                                   placeholder="ejemplo@dominio.com">
                        </div>

                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-shield-lock"></i> Rol *</label>
                            <select name="rol" class="form-select" required>
                                <option value="">Seleccionar...</option>
                                <c:forEach items="${roles}" var="rol">
                                    <option value="${rol}" ${rol == usuario.rol ? 'selected' : ''}>
                                            ${rol}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label"><i class="bi bi-key"></i> Firebase UID (opcional)</label>
                            <input type="text" name="firebaseUid" class="form-control"
                                   value="${usuario.firebaseUid}"
                                   placeholder="UID de autenticación de Firebase">
                            <small class="text-muted">Necesario para la autenticación externa.</small>
                        </div>

                        <div class="d-flex gap-2 justify-content-end">
                            <a href="${pageContext.request.contextPath}/admin/usuarios"
                               class="btn btn-secondary">
                                <i class="bi bi-x-circle"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-save"></i> Guardar Usuario
                            </button>
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