package com.asistencia.controller;

import com.asistencia.model.*;
import com.asistencia.service.*;
import com.itextpdf.text.*;
import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.*;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/reportes")
public class ReporteController {

    @Autowired
    private AsistenciaService asistenciaService;

    @Autowired
    private AlumnoService alumnoService;

    // Generar reporte PDF
    @GetMapping("/pdf")
    public void generarReportePDF(@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
                                  @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fin,
                                  @RequestParam(required = false) Integer alumnoId,
                                  HttpServletResponse response) throws IOException, DocumentException {

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=reporte_asistencia.pdf");

        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();

        // Título
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
        Paragraph title = new Paragraph("Reporte de Asistencia", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);

        // Fechas
        Font normalFont = new Font(Font.FontFamily.HELVETICA, 12);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        Paragraph periodo = new Paragraph("Periodo: " + inicio.format(formatter) + " al " + fin.format(formatter), normalFont);
        periodo.setSpacingAfter(20);
        document.add(periodo);

        // Obtener datos
        List<Asistencia> asistencias;
        if (alumnoId != null) {
            Alumno alumno = alumnoService.obtenerPorId(alumnoId);
            Paragraph alumnoInfo = new Paragraph("Estudiante: " + alumno.getNombreCompleto(), normalFont);
            alumnoInfo.setSpacingAfter(10);
            document.add(alumnoInfo);

            asistencias = asistenciaService.obtenerPorRangoFechas(inicio, fin);
            asistencias.removeIf(a -> !a.getAlumno().getId().equals(alumnoId));
        } else {
            asistencias = asistenciaService.obtenerPorRangoFechas(inicio, fin);
        }

        // Tabla
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10);

        // Encabezados
        Font headerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        PdfPCell cell;

        cell = new PdfPCell(new Phrase("Alumno", headerFont));
        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Fecha", headerFont));
        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Estado", headerFont));
        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Hora Registro", headerFont));
        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(cell);

        // Datos
        for (Asistencia asist : asistencias) {
            table.addCell(asist.getAlumno().getNombreCompleto());
            table.addCell(asist.getFecha().format(formatter));
            table.addCell(asist.getEstado().getEstado().name());
            table.addCell(asist.getRegistro() != null ? asist.getRegistro().format(DateTimeFormatter.ofPattern("HH:mm:ss")) : "N/A");
        }

        document.add(table);

        // Total
        Paragraph total = new Paragraph("\nTotal de registros: " + asistencias.size(), normalFont);
        total.setSpacingBefore(10);
        document.add(total);

        document.close();
    }

    // Generar reporte Excel
    @GetMapping("/excel")
    public void generarReporteExcel(@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
                                    @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fin,
                                    @RequestParam(required = false) Integer alumnoId,
                                    HttpServletResponse response) throws IOException {

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=reporte_asistencia.xlsx");

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Asistencia");

        // Estilo para encabezados
        CellStyle headerStyle = workbook.createCellStyle();
        Font headerFont = (Font) workbook.createFont();
        ((org.apache.poi.ss.usermodel.Font) headerFont).setBold(true);
        headerStyle.setFont((org.apache.poi.ss.usermodel.Font) headerFont);
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // Crear encabezado
        Row headerRow = sheet.createRow(0);
        String[] columns = {"ID", "Alumno", "Bachillerato", "Sección", "Especialidad", "Fecha", "Estado", "Hora Registro"};

        for (int i = 0; i < columns.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columns[i]);
            cell.setCellStyle(headerStyle);
        }

        // Obtener datos
        List<Asistencia> asistencias;
        if (alumnoId != null) {
            asistencias = asistenciaService.obtenerPorRangoFechas(inicio, fin);
            asistencias.removeIf(a -> !a.getAlumno().getId().equals(alumnoId));
        } else {
            asistencias = asistenciaService.obtenerPorRangoFechas(inicio, fin);
        }

        // Llenar datos
        int rowNum = 1;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");

        for (Asistencia asist : asistencias) {
            Row row = sheet.createRow(rowNum++);

            row.createCell(0).setCellValue(asist.getId());
            row.createCell(1).setCellValue(asist.getAlumno().getNombreCompleto());
            row.createCell(2).setCellValue(asist.getAlumno().getSeccion().getBachillerato().getNombre());
            row.createCell(3).setCellValue(asist.getAlumno().getSeccion().getNombre());
            row.createCell(4).setCellValue(asist.getAlumno().getEspecialidad().getNombre());
            row.createCell(5).setCellValue(asist.getFecha().format(formatter));
            row.createCell(6).setCellValue(asist.getEstado().getEstado().name());
            row.createCell(7).setCellValue(asist.getRegistro() != null ? asist.getRegistro().format(timeFormatter) : "N/A");
        }

        // Ajustar ancho de columnas
        for (int i = 0; i < columns.length; i++) {
            sheet.autoSizeColumn(i);
        }

        workbook.write(response.getOutputStream());
        workbook.close();
    }

    // Generar reporte de estadísticas por alumno
    @GetMapping("/estadisticas/excel")
    public void generarEstadisticasExcel(@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
                                         @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fin,
                                         @RequestParam(required = false) Integer seccionId,
                                         HttpServletResponse response) throws IOException {

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=estadisticas_asistencia.xlsx");

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Estadísticas");

        // Estilo para encabezados
        CellStyle headerStyle = workbook.createCellStyle();
        Font headerFont = (Font) workbook.createFont();
        ((org.apache.poi.ss.usermodel.Font) headerFont).setBold(true);
        headerStyle.setFont((org.apache.poi.ss.usermodel.Font) headerFont);
        headerStyle.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // Crear encabezado
        Row headerRow = sheet.createRow(0);
        String[] columns = {"Alumno", "Sección", "Presentes", "Ausentes", "Tardes", "Justificados", "Total Registros"};

        for (int i = 0; i < columns.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columns[i]);
            cell.setCellStyle(headerStyle);
        }

        // Obtener alumnos
        List<Alumno> alumnos;
        if (seccionId != null) {
            alumnos = alumnoService.obtenerPorSeccion(seccionId);
        } else {
            alumnos = alumnoService.obtenerTodos();
        }

        // Llenar datos
        int rowNum = 1;
        for (Alumno alumno : alumnos) {
            Row row = sheet.createRow(rowNum++);

            var stats = asistenciaService.obtenerEstadisticas(alumno.getId(), inicio, fin);

            row.createCell(0).setCellValue(alumno.getNombreCompleto());
            row.createCell(1).setCellValue(alumno.getSeccion().getNombre());
            row.createCell(2).setCellValue(stats.get("presente"));
            row.createCell(3).setCellValue(stats.get("ausente"));
            row.createCell(4).setCellValue(stats.get("tarde"));
            row.createCell(5).setCellValue(stats.get("justificado"));

            long total = stats.get("presente") + stats.get("ausente") + stats.get("tarde") + stats.get("justificado");
            row.createCell(6).setCellValue(total);
        }

        // Ajustar ancho de columnas
        for (int i = 0; i < columns.length; i++) {
            sheet.autoSizeColumn(i);
        }

        workbook.write(response.getOutputStream());
        workbook.close();
    }
}
