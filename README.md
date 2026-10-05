# 🤖 Next-Gen Voice AI: El Poder del Audio Nativo en Tiempo Real

Taller práctico de 3 horas para construir agentes de IA usando Google ADK y Gemini.

## ⚡ Setup rápido

### Windows
```powershell
.\setup.ps1
```

### macOS / Linux
```bash
make setup
```

Eso es todo. El script instala automáticamente:
- ✅ `uv` (gestor de paquetes)
- ✅ Python 3.12
- ✅ `google-adk` (dependencia única)

## 🔑 Configurar API Key (Gratis)

Para usar los modelos de Gemini sin costo, necesitamos una clave de Google AI Studio. **Sigue estos pasos exactamente para evitar errores de permisos:**

1. Entra a **[https://aistudio.google.com/](https://aistudio.google.com/)** e inicia sesión con tu cuenta de Google.
2. En el menú, busca la sección **"Get API key"** (o ve directo a [este enlace](https://aistudio.google.com/app/apikey)).
3. Haz clic en el botón **"Create API key"**.
4. ⚠️ **MUY IMPORTANTE:** En el menú que aparece, selecciona la opción **"Create API key in new project"** (Crear en un proyecto nuevo). *Si eliges un proyecto existente viejo, Google podría bloquear la conexión.*
5. Copia la clave generada (empieza con `AIzaSy...`).
6. En tu código, abre el archivo `.env` y pega tu clave para que quede así:

```env
GOOGLE_API_KEY=AIzaSyTuClaveAqui...
```

## 🚀 Correr las prácticas

```bash
# Abrir el playground con todas las prácticas
make run          # macOS/Linux
uv run adk web .  # Windows

# O correr una práctica específica
make run-1        # Práctica 1: Agente básico
make run-2        # Práctica 2: Agente + Tools
make run-3        # Práctica 3: Multi-agente
make run-4        # Práctica 4: Agente de voz
```

Abrir **http://localhost:8000** en el navegador.

## 📂 Estructura

```
├── practica_1_basico/    🟢 Agente básico (30 min)
├── practica_2_tools/     🔵 Agente + Tools (45 min)
├── practica_3_multi/     🟣 Multi-agente (45 min)
└── practica_4_voz/       🔴 Agente de voz (30 min)
```

## 📋 Checklist pre-taller

- [ ] Ejecutar `.\setup.ps1` (Win) o `make setup` (Mac/Linux)
- [ ] Tener API Key en `.env`
- [ ] Verificar con `uv run adk web .` → abre en el navegador
## 🛠️ Solución de Problemas Frecuentes (Troubleshooting)

### 🪟 Windows

**1. Error: "No se puede cargar el archivo setup.ps1 porque la ejecución de scripts está deshabilitada"**
*   **Por qué pasa:** Windows bloquea la ejecución de scripts por seguridad.
*   **Solución:** Ejecuta el comando forzando el salto de la política de seguridad:
    ```powershell
    powershell -ExecutionPolicy ByPass -File .\setup.ps1
    ```

**2. Error: "uv : El término 'uv' no se reconoce" (Justo después de instalar)**
*   **Por qué pasa:** La terminal actual no ha recargado las variables de entorno.
*   **Solución:** **Cierra por completo la ventana de tu terminal**, abre una nueva y vuelve a intentar el comando.

### 🍎 Mac / Linux

**1. Error: "make: command not found"**
*   **Por qué pasa:** Tu Mac no tiene instaladas las herramientas de consola básicas.
*   **Solución:** Abre la terminal y ejecuta `xcode-select --install`. Cuando termine, vuelve a intentar `make setup`.

### 🌐 Generales (Cualquier Sistema)

**1. Error en la interfaz: "403 PERMISSION_DENIED" o "API_KEY_SERVICE_BLOCKED"**
*   **Por qué pasa:** Elegiste un proyecto viejo en Google Cloud al crear tu API Key y no tiene Gemini habilitado.
*   **Solución:** Regresa a [Google AI Studio](https://aistudio.google.com/app/apikey), haz clic en crear clave y elige **ESTRICTAMENTE** la opción **"Create API key in new project"**. Pega esa nueva clave en tu `.env` y reinicia el servidor.

**2. Error en la interfaz: "503 UNAVAILABLE - This model is experiencing high demand"**
*   **Por qué pasa:** Tráfico mundial alto momentáneo en la capa gratuita. Tu código y configuración están perfectos.
*   **Solución:** Literalmente solo espera 30 a 60 segundos y vuelve a enviarle el mensaje al agente.
