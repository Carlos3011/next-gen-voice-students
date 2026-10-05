# 🤖 Next-Gen Voice AI: El Poder del Audio Nativo en Tiempo Real

Este proyecto contiene el código fuente de los agentes construidos con **Google ADK** y **Gemini**.

## 🛠️ Tecnologías

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

Puedes arrancar la interfaz web para probar cada práctica. Abre tu terminal y ejecuta:

```powershell
# Levanta el entorno con todas las prácticas
uv run adk web .
```

### Temario del Taller

1. **Práctica 1: Básico** (`practica_1_basico/`)
   - Cómo inicializar un Agente, definir un modelo y escribir tu primer *System Prompt*.
2. **Práctica 2: Tools** (`practica_2_tools/`)
   - *Function Calling*: Cómo darle herramientas (funciones Python) a tu agente para que consulte datos reales de tu ciudad en México.
3. **Práctica 3: Workflow Multi-Agente** (`practica_3_workflow/`)
   - Cómo conectar varios agentes en cadena (`SequentialAgent`) pasándose contexto entre ellos.
4. **Práctica 4: Configuración Avanzada** (`practica_4_avanzado/`)
   - Ajuste de tokens, nivel de creatividad (temperatura) y configuración estricta de *Safety Settings* (Seguridad).
5. **Práctica 5: Agente de Voz Nativo** (`practica_5_voz/`)
   - El gran final: Uso de la *Live API* (`gemini-3.8-live`) para hablar en tiempo real con latencia casi nula.

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
