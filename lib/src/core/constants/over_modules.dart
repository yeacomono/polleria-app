import 'package:flutter/material.dart';

const Map<String, IconData> iconMap = {
  "buscar_guia": Icons.search,
  "buscar_pda": Icons.qr_code_scanner,
  "desembarque": Icons.flight_land,
  "ubicacion_actual": Icons.location_on,
  "inventario_general": Icons.inventory,
  "inventario_ubicacion": Icons.warehouse,
  "notificaciones": Icons.notifications,
  "embarque_cooler_masivo": Icons.ac_unit,
  "restrict_mini_bins_bins": Icons.block,
  "embarque": Icons.local_shipping,
  "embarque_nuevo": Icons.new_releases,
  "desembarque_nuevo": Icons.flight_takeoff,
  "manifiesto": Icons.assignment,
  "ruta_carguero": Icons.route,
  "embarque_cooler": Icons.thermostat,
  "abandono_mercaderia": Icons.delete_forever,
  "mensajeria": Icons.message,
  "reparto": Icons.delivery_dining,
  "incidencias": Icons.report_problem,
  "embarque_cooler2": Icons.device_thermostat,
  "egresos": Icons.exit_to_app,
  "embarque_aereo": Icons.flight,
  "embarque_aereo_nuevo": Icons.airplanemode_active,
  "desemb_masivo_nuevo": Icons.unarchive, // Ícono sugerido: Desempaque
  "sobrante": Icons.add_shopping_cart, // Ícono sugerido: Productos sobrantes
  "confirmar_abandono":
      Icons.assignment_turned_in, // Ícono sugerido: Confirmación
  "restrict_embar_desemb": Icons.lock, // Ícono sugerido: Restricción
  "gestion_almacen": Icons.store, // Ícono sugerido: Gestión de almacén
  "generar_qr": Icons.qr_code, // Ícono sugerido: Generación QR
  "desemb_masivo": Icons.folder_open, // Ícono sugerido: Desembarque masivo
  "auditoria": Icons.fact_check, // Ícono sugerido: Auditoría
};

const Map<String, String> colorMap = {
  "buscar_guia": "0xFF494caf", // Verde
  "buscar_pda": "0xFF494caf", // Amarillo
  "desembarque": "0xFFF44336", // Rojo
  "ubicacion_actual": "0xFF2196F3", // Azul
  "inventario_general": "0xFF1E88E5", // Azul más oscuro
  "inventario_ubicacion": "0xFF673AB7", // Púrpura
  "notificaciones": "0xFFFF5722", // Naranja
  "embarque_cooler_masivo": "0xFF00BCD4", // Cian
  "restrict_mini_bins_bins": "0xFF9E9E9E", // Gris
  "embarque": "0xFF3F51B5", // Azul índigo
  "embarque_nuevo": "0xFF8BC34A", // Verde claro
  "desembarque_nuevo": "0xFFE91E63", // Rosa
  "manifiesto": "0xFF607D8B", // Azul grisáceo
  "ruta_carguero": "0xFF009688", // Verde azulado
  "embarque_cooler": "0xFF03A9F4", // Azul claro
  "abandono_mercaderia": "0xFF795548", // Marrón
  "mensajeria": "0xFF9C27B0", // Morado
  "reparto": "0xFF00E676", // Verde neón
  "incidencias": "0xFFFF5722", // Naranja fuerte
  "embarque_cooler2": "0xFF0288D1", // Azul más oscuro
  "egresos": "0xFF6D4C41", // Marrón oscuro
  "embarque_aereo": "0xFF80D8FF", // Azul cielo
  "embarque_aereo_nuevo": "0xFF00ACC1", // Verde azulado oscuro
  "desemb_masivo_nuevo": "0xFF8E24AA", // Púrpura oscuro
  "sobrante": "0xFFFF7043", // Naranja rojizo
  "confirmar_abandono": "0xFF9E9D24", // Amarillo oliva
  "restrict_embar_desemb": "0xFF5D4037", // Marrón grisáceo
  "gestion_almacen": "0xFF1B5E20", // Verde bosque
  "generar_qr": "0xFF3949AB", // Azul real
  "desemb_masivo": "0xFFD84315", // Naranja oscuro
  "auditoria": "0xFF512DA8", // Púrpura vibrante
};

const Map<String, String> rutasMap = {
  "buscar_guia": "/buscar_guia",
  "buscar_pda": "/buscar_pda",
  "desembarque": "/desembarque",
  "ubicacion_actual": "/ubicacion_actual",
  "inventario_general": "/inventario_general",
  "inventario_ubicacion": "/inventario_ubicacion",
  "notificaciones": "/notificaciones",
  "embarque_cooler_masivo": "/embarque_cooler_masivo",
  "restrict_mini_bins_bins": "/restrict_mini_bins_bins",
  "embarque": "/embarque",
  "embarque_nuevo": "/embarque_nuevo",
  "desembarque_nuevo": "/desembarque_nuevo",
  "manifiesto": "/manifiesto",
  "ruta_carguero": "/ruta_carguero",
  "embarque_cooler": "/embarque_cooler",
  "abandono_mercaderia": "/abandono_mercaderia",
  "mensajeria": "/mensajeria",
  "reparto": "/reparto",
  "incidencias": "/incidencias",
  "embarque_cooler2": "/embarque_cooler2",
  "egresos": "/egresos",
  "embarque_aereo": "/embarque_aereo",
  "embarque_aereo_nuevo": "/embarque_aereo_nuevo",
  "desemb_masivo_nuevo": "/desemb_masivo_nuevo",
  "sobrante": "/sobrante",
  "confirmar_abandono": "/confirmar_abandono",
  "restrict_embar_desemb": "/restrict_embar_desemb",
  "gestion_almacen": "/gestion_almacen",
  "generar_qr": "/generar_qr",
  "desemb_masivo": "/desemb_masivo",
  "auditoria": "/auditoria",
};
