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
    <title>${alumno.id == null ? 'Nuevo' : 'Editar'} Estudiante</title>
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
            background-color: #3498db !important; /* Color primario para el encabezado */
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
            border-color: #3498db;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
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
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white">
                    <h4>
                        <i class="bi bi-person-${alumno.id == null ? 'plus' : 'edit'}"></i>
                        ${alumno.id == null ? 'Nuevo' : 'Editar'} Estudiante
                    </h4>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/admin/estudiantes/${alumno.id == null ? 'guardar' : 'actualizar'}"
                          method="post">

                        <c:if test="${alumno.id != null}">
                            <input type="hidden" name="id" value="${alumno.id}">
                        </c:if>

                        <h5 class="mb-3 text-primary"><i class="bi bi-person"></i> Datos Personales</h5>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Nombre *</label>
                                <input type="text" name="nombre" class="form-control"
                                       value="${alumno.nombre}" required
                                       placeholder="Ingrese el nombre del estudiante">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Apellido *</label>
                                <input type="text" name="apellido" class="form-control"
                                       value="${alumno.apellido}" required
                                       placeholder="Ingrese el apellido del estudiante">
                            </div>
                        </div>

                        <hr class="text-white-50">

                        <h5 class="mb-3 text-primary"><i class="bi bi-mortarboard"></i> Datos Académicos</h5>
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Bachillerato *</label>
                                <select name="idBachillerato" id="bachillerato" class="form-select" required>
                                    <option value="">Seleccionar...</option>
                                    <c:forEach items="${bachilleratos}" var="bach">
                                        <option value="${bach.id}"
                                            ${bach.id == alumno.idBachillerato ? 'selected' : ''}>
                                                ${bach.nombre}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Sección *</label>
                                <select name="idSeccion" id="seccion" class="form-select" required>
                                    <option value="">Primero seleccione bachillerato...</option>
                                    <c:if test="${alumno.seccion != null}">
                                        <option value="${alumno.seccion.id}" selected>
                                                ${alumno.seccion.nombre}
                                        </option>
                                    </c:if>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Especialidad *</label>
                                <select name="idEspecialidad" id="especialidad" class="form-select" required>
                                    <option value="">Primero seleccione bachillerato...</option>
                                    <c:if test="${alumno.especialidad != null}">
                                        <option value="${alumno.especialidad.id}" selected>
                                                ${alumno.especialidad.nombre}
                                        </option>
                                    </c:if>
                                </select>
                            </div>
                        </div>

                        <hr class="text-white-50">

                        <h5 class="mb-3 text-primary"><i class="bi bi-person-vcard"></i> Responsable</h5>
                        <div class="mb-3">
                            <label class="form-label">Seleccionar Responsable (Padre/Tutor) *</label>
                            <select name="idResponsable" class="form-select" required>
                                <option value="">Seleccionar...</option>
                                <c:forEach items="${responsables}" var="resp">
                                    <option value="${resp.id}"
                                        ${alumno.responsable != null && resp.id == alumno.responsable.id ? 'selected' : ''}>
                                            ${resp.nombre} ${resp.apellido} - ${resp.correo} - ${resp.telefono}
                                    </option>
                                </c:forEach>
                            </select>
                            <small class="text-muted">Si no encuentra al responsable, primero debe crearlo en el módulo de Responsables</small>
                        </div>

                        <div class="alert alert-info">
                            <i class="bi bi-info-circle"></i> Los campos marcados con * son obligatorios
                        </div>

                        <div class="d-flex gap-2 justify-content-end">
                            <a href="${pageContext.request.contextPath}/admin/estudiantes"
                               class="btn btn-secondary btn-lg">
                                <i class="bi bi-x-circle"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="bi bi-save"></i> Guardar Estudiante
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Cargar secciones y especialidades cuando se selecciona bachillerato
    document.getElementById('bachillerato').addEventListener('change', function() {
        const bachId = this.value;
        const seccionSelect = document.getElementById('seccion');
        const especialidadSelect = document.getElementById('especialidad');

        // Deshabilita y resetea los campos si no hay bachillerato seleccionado
        if (!bachId) {
            seccionSelect.innerHTML = '<option value="">Primero seleccione bachillerato...</option>';
            especialidadSelect.innerHTML = '<option value="">Primero seleccione bachillerato...</option>';
            seccionSelect.disabled = true;
            especialidadSelect.disabled = true;
            return;
        }

        // Indica carga y habilita los campos
        seccionSelect.innerHTML = '<option value="">Cargando...</option>';
        especialidadSelect.innerHTML = '<option value="">Cargando...</option>';
        seccionSelect.disabled = false;
        especialidadSelect.disabled = false;

        // --- Lógica AJAX de Producción (Debes implementarla en el servidor) ---
        // En un entorno de producción, aquí harías una llamada AJAX a tu controlador
        // '/admin/catalogos/secciones?bachilleratoId=' + bachId
        // para obtener las listas dinámicamente y rellenar los dropdowns.

        fetch(`${pageContext.request.contextPath}/admin/catalogos/secciones?bachilleratoId=${bachId}`)
            .then(response => response.json())
            .then(data => {
                seccionSelect.innerHTML = '<option value="">Seleccionar...</option>';
                data.forEach(sec => {
                    seccionSelect.innerHTML += `<option value="${sec.id}">${sec.nombre}</option>`;
                });
                // Si el alumno ya tenía una sección, la deja seleccionada (Solo en editar)
                const currentSeccionId = '${alumno.seccion.id}';
                if (currentSeccionId && !${alumno.id == null}) {
                    seccionSelect.value = currentSeccionId;
                }
            })
            .catch(() => {
                seccionSelect.innerHTML = '<option value="">Error al cargar secciones</option>';
            });

        fetch(`${pageContext.request.contextPath}/admin/catalogos/especialidades?bachilleratoId=${bachId}`)
            .then(response => response.json())
            .then(data => {
                especialidadSelect.innerHTML = '<option value="">Seleccionar...</option>';
                data.forEach(esp => {
                    especialidadSelect.innerHTML += `<option value="${esp.id}">${esp.nombre}</option>`;
                });
                // Si el alumno ya tenía una especialidad, la deja seleccionada (Solo en editar)
                const currentEspecialidadId = '${alumno.especialidad.id}';
                if (currentEspecialidadId && !${alumno.id == null}) {
                    especialidadSelect.value = currentEspecialidadId;
                }
            })
            .catch(() => {
                especialidadSelect.innerHTML = '<option value="">Error al cargar especialidades</option>';
            });
    });

    // Trigger change event on page load if a bachillerato is already selected (for editing)
    document.addEventListener('DOMContentLoaded', function() {
        const bachilleratoSelect = document.getElementById('bachillerato');
        if (bachilleratoSelect.value) {
            bachilleratoSelect.dispatchEvent(new Event('change'));
        }
    });
</script>
</body>
</html>