# 🤖 Taller ADK — Desarrollo de Agentes con Gemini

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
