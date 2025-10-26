<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema de Asistencia</title>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Merriweather:wght@700&family=Poppins:wght@400;600&display=swap');

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #011116;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            display: flex;
            background-color: #0c1a1a;
            width: 800px;
            height: 450px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
            transition: all 0.4s ease;
        }

        /* Lado izquierdo */
        .container::before {
            content: "Sistema\A de\A Asistencia";
            white-space: pre;
            flex: 1;
            background-color: #0a2f3d;
            color: white;
            font-family: 'Merriweather', serif;
            font-weight: bold;
            font-size: 32px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            line-height: 1.8;
            letter-spacing: 1px;
        }

        /* Tarjeta del formulario */
        .card {
            flex: 1;
            background-color: #e4e4e4;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px;
            border-radius: 0;
        }

        /* Título */
        .card-header {
            text-align: center;
            background: none !important;
            color: #000;
            padding: 0;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        /* Campos */
        .form-label {
            font-weight: 500;
            color: #222;
        }

        .form-control {
            border: none;
            border-radius: 8px;
            background-color: #f5f5f5;
            padding: 10px;
            width: 100%;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            background-color: #fff;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }

        /* Botón */
        .btn-primary {
            background-color: #0a2f3d;
            border: none;
            color: white;
            padding: 10px;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
            font-weight: 500;
        }

        .btn-primary:hover {
            background-color: #08303b;
        }

        .text-muted {
            color: #555 !important;
            font-size: 13px;
        }

        /* ================= RESPONSIVE ================= */
        @media (max-width: 992px) {
            .container {
                width: 90%;
                height: auto;
            }
        }

        @media (max-width: 768px) {
            body {
                height: auto;
                padding: 40px 0;
            }

            .container {
                flex-direction: column;
                width: 90%;
                height: auto;
            }

            .container::before {
                font-size: 24px;
                padding: 30px 0;
                line-height: 1.5;
            }

            .card {
                padding: 30px;
                width: 100%;
                border-radius: 0 0 10px 10px;
            }
        }

        @media (max-width: 480px) {
            .container::before {
                font-size: 20px;
                padding: 20px 0;
            }

            .card-header {
                font-size: 22px;
            }

            .btn-primary {
                font-size: 14px;
                padding: 8px;
            }
        }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card p-4" style="width: 400px; border-radius: 15px; box-shadow: 0 10px 40px rgba(0,0,0,0.2);">
        <div class="card-header text-center py-3">
            <h3>Bienvenido</h3>
        </div>
        <div class="card-body">
            <!-- Mostrar error si existe -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <!-- Formulario de login -->
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <label class="form-label">Correo Electrónico</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Contraseña</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Iniciar Sesión</button>
            </form>

            <div class="text-center mt-3">
                <small class="text-muted">Usuario de prueba: cruzodaly25@gmail.com</small>
            </div>
        </div>
    </div>
</div>
</body>
</html>