<%--
  Created by IntelliJ IDEA.
  User: UniRo
  Date: 25/10/2025
  Time: 05:15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historial de Asistencia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        /* FONDO PRINCIPAL SOLICITADO */
        body {
            background-color: #011116;
            color: #ffffff; /* Asegura que el texto principal sea blanco */
        }

        /* Ajuste de las tarjetas y contenedores (Datos del Alumno y Filtros) */
        .card {
            background-color: #1a2935; /* Fondo de tarjeta oscuro */
            color: #ffffff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .card-header {
            background-color: #2c3e50 !important; /* Cabecera con más contraste */
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

        /* Input y select en modo oscuro */
        .form-control {
            background-color: #34495e;
            color: #ffffff;
            border-color: #555;
        }
        .form-control:focus {
            background-color: #34495e;
            color: #ffffff;
            border-color: #3498db;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        /* Alertas para contraste */
        .alert-info { background-color: #17a2b840; border-color: #17a2b8; color: #17a2b8; }
    </style>
</head>
<body>
<div class="container-fluid p-4">
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/profesor/estudiantes" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Volver a Estudiantes
        </a>
    </div>

    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h4><i class="bi bi-person-lines-fill"></i> Historial de Asistencia</h4>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h5>${alumno.nombre} ${alumno.apellido}</h5>
                    <p class="mb-1"><strong>Sección:</strong> ${alumno.seccion.nombre}</p>
                    <p class="mb-1"><strong>Especialidad:</strong> ${alumno.especialidad.nombre}</p>
                    <p class="mb-1"><strong>Responsable:</strong> ${alumno.responsable.nombre} ${alumno.responsable.apellido}</p>
                    <p><strong>Contacto:</strong> ${alumno.responsable.correo} - ${alumno.responsable.telefono}</p>
                </div>

                <div class="col-md-6">
                    <h5>Estadísticas del Periodo</h5>
                    <ul class="list-unstyled">
                        <li><span class="badge bg-success">Presente:</span> ${estadisticas.presente}</li>
                        <li><span class="badge bg-danger">Ausente:</span> ${estadisticas.ausente}</li>
                        <li><span class="badge bg-warning text-dark">Tarde:</span> ${estadisticas.tarde}</li>
                        <li><span class="badge bg-info">Justificado:</span> ${estadisticas.justificado}</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <form method="get" class="card mb-4">
        <div class="card-header">
            <i class="bi bi-filter"></i> Filtrar Periodo
        </div>
        <div class="card-body">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label">Fecha Inicio</label>
                    <input type="date" name="inicio" class="form-control" value="${inicio}">
                </div>
                <div class="col-md-4">
                    <label class="form-label">Fecha Fin</label>
                    <input type="date" name="fin" class="form-control" value="${fin}">
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-search"></i> Filtrar
                    </button>
                </div>
            </div>
        </div>
    </form>

    <h4>Registros Detallados</h4>
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
            <tr>
                <th>Fecha</th>
                <th>Estado</th>
                <th>Hora Registro</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${historial}" var="asist">
                <tr>
                    <td><fmt:formatDate value="${asist.fecha}" pattern="dd/MM/yyyy"/></td>
                    <td>
                        <span class="badge
                            ${asist.estado.estado == 'Presente' ? 'bg-success' : ''}
                            ${asist.estado.estado == 'Ausente' ? 'bg-danger' : ''}
                            ${asist.estado.estado == 'Tarde' ? 'bg-warning text-dark' : ''}
                            ${asist.estado.estado == 'Justificado' ? 'bg-info' : ''}">
                                ${asist.estado.estado}
                        </span>
                    </td>
                    <td>
                        <c:if test="${asist.registro != null}">
                            ${asist.registro.toLocalTime()}
                        </c:if>
                        <c:if test="${asist.registro == null}">
                            N/A
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <c:if test="${empty historial}">
            <div class="alert alert-info">No hay registros en el periodo seleccionado</div>
        </c:if>
        <div class="mt-3 text-white">
            <strong>Total de registros mostrados: ${historial.size()}</strong>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>