#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Mensajes de selección de servicio
# -----------------------------------------------------------------------------
export MSG_CHOOSE_SERVICE="✨ Por favor, elija un servicio:"
export MSG_INVALID_SELECTION="❌ Selección inválida! Intente nuevamente."
export MSG_SELECT_NUMBER="🔢 Selección (número)"
export MSG_SELECT=" selección"
export MSG_SERVICE_SELECTED="✅ Servicio seleccionado correctamente:"


# -----------------------------------------------------------------------------
# Errores de variables / entorno
# -----------------------------------------------------------------------------
export MSG_ERROR_ENV_NOT_SET="⚠️ La variable de entorno no está establecida!"
export MSG_ERROR_AWS_NOT_SET="⚠️ La variable de AWS no está establecida!"
export MSG_TARGET_FILE_NOT_FOUND="📂 Archivo de destino '%s' no encontrado"
export MSG_MISSING_REQ_VAR="⚠️ Falta la variable requerida: %s"
export MSG_MISSING_VAR="⚠️ Falta la variable: %s"

# -----------------------------------------------------------------------------
# Autenticación / AWS
# -----------------------------------------------------------------------------
export MSG_AUTHENTICATION_FAILED="❌ Falló la autenticación para el servicio: %s"
export MSG_CREDENTIAL_ALREADY_SET="🔑 Credenciales de AWS ya configuradas para el servicio: %s"
export MSG_AUTHENTICATION_SUCCESSFULLY="✅ Autenticado correctamente para el servicio: %s"
export MSG_AUTH_SUCCESS="🎉 Autenticación exitosa."

# -----------------------------------------------------------------------------
# Sesión / conexión
# -----------------------------------------------------------------------------
export MSG_SESSION_STARTED="🚀 Sesión SSM iniciada."
export MSG_CONFIRM_CONNECT="🔗 ¿Desea conectarse ahora? [S/n] "
export MSG_TOKEN_VALIDITY="⏱ Token válido por 15 minutos."
export MSG_ABORTED="🛑 Cancelado"
export MSG_DISCONNECTED="⚡ Desconectado de %s"

# -----------------------------------------------------------------------------
# Información de servicio / DB
# -----------------------------------------------------------------------------
export MSG_SERVICE="🛠 Servicio"
export MSG_DB="🗄 Nombre de DB"
export MSG_USER="👤 Usuario"
export MSG_CONNECT="🔌 Conectar? [S/n] "
export MSG_COMMAND="💻 Comando"
