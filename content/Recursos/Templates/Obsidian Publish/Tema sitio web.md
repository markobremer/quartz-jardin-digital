/*
Obsidian Publish CSS theme inspirado en https://markobremer.com
Autor: ChatGPT (adaptable)
Instrucciones:
- Guarda este archivo como `markobremer-theme.css`.
- En Obsidian Publish, ve a Settings → Appearance → Custom CSS y sube/pega este CSS.
- Opcional: descomenta las @import de Google Fonts si quieres fuentes más parecidas.

Limitaciones:
- Obsidian Publish y el HTML generado pueden usar selectores distintos; ajusta selectores si alguna regla no aplica.
- Este tema es una aproximación visual (colores, espaciados, tipografías) basada en el sitio referenciado. Para réplica perfecta necesitarías assets y fuentes exactas.
Bibliografía: diseño y estructura tomada de la página pública de Marko Bremer. 
*/

/* ---------- Opcional: importar fonts (descomenta si deseas) ---------- */
/* @import url('https://fonts.googleapis.com/css2?family=Merriweather:wght@400;700&family=Inter:wght@300;400;600&display=swap'); */

:root{
  --mb-bg: #ffffff;
  --mb-text: #222222;
  --mb-muted: #6b6b6b;
  --mb-accent: #0a5fff; /* color de botones/links */
  --mb-radius: 12px;
  --content-max-width: 880px;
  --site-gutter: 24px;
}

/* Reset ligero */
body{
  background: var(--mb-bg) !important;
  color: var(--mb-text) !important;
  font-family: Inter, system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
  line-height: 1.6;
}

/* Contenedor principal y ancho de lectura */
.site-content, .publish-wrapper, .theme-light, .obsidian-publish-root {
  --size: var(--content-max-width);
}

/* Centralizar y limitar ancho */
.markobremer-wrap, .publish-wrapper > .container, .site-content {
  max-width: var(--content-max-width) !important;
  margin-left: auto !important;
  margin-right: auto !important;
  padding-left: var(--site-gutter) !important;
  padding-right: var(--site-gutter) !important;
}

/* Header / navegación */
.site-header, header, .nav-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 28px 0 !important;
  border-bottom: 1px solid rgba(0,0,0,0.06);
}

.site-header .site-title, header .site-title, .brand {
  font-family: Merriweather, Georgia, 'Times New Roman', serif;
  font-weight: 700;
  font-size: 28px;
  letter-spacing: -0.5px;
  color: var(--mb-text);
}

/* Navegación simple a la derecha */
.site-header nav, .nav-right, .site-nav {
  display:flex; gap:18px; align-items:center;
}
.site-header a, .site-header nav a {
  color: var(--mb-text);
  text-decoration: none;
  font-weight: 500;
}
.site-header a.cta, .btn-cta {
  background: var(--mb-accent);
  color: white !important;
  padding: 8px 14px;
  border-radius: 999px;
  box-shadow: 0 6px 18px rgba(10,95,255,0.12);
  text-decoration: none;
}

/* Hero / Intro */
.hero {
  display: grid;
  grid-template-columns: 120px 1fr;
  gap: 22px;
  align-items: center;
  margin: 36px 0 28px 0;
}
.hero .avatar{
  width: 120px; height:120px; border-radius: 50%; overflow:hidden; flex:0 0 120px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.08);
}
.hero h1{
  margin: 0 0 6px 0;
  font-family: Merriweather, Georgia, serif;
  font-size: 28px;
}
.hero p{
  margin:0; color:var(--mb-muted);
}

/* Lista de artículos / tarjetas */
.post-list {
  display: grid;
  grid-template-columns: 1fr;
  gap: 22px;
  margin-top: 18px;
}
.post-card, article.post, .post {
  display:flex; gap:18px; align-items:flex-start;
  padding: 14px; border-radius: var(--mb-radius);
  transition: transform .18s ease, box-shadow .18s ease;
}
.post-card:hover{ transform: translateY(-4px); box-shadow: 0 18px 40px rgba(12,20,40,0.06); }

.post-card .thumb{
  width:160px; height:100px; flex:0 0 160px; border-radius:8px; overflow:hidden; background:#f3f3f3;
}
.post-card .meta{ font-size:13px; color:var(--mb-muted); margin-bottom:6px; }
.post-card .title{ font-weight:700; margin:0 0 4px 0; }
.post-card .excerpt{ color:var(--mb-muted); margin:0; }

/* Fecha encima del post (look similar al sitio) */
.post-meta-date, .post .meta .date { font-size:12px; color:var(--mb-muted); }

/* Links y elementos de texto */
a, .internal-link {
  color: var(--mb-accent);
  text-decoration: none;
}
a:hover{ text-decoration: underline; }

/* Sidebar (cuando exista) */
.sidebar, .site-aside {
  background: transparent;
  border-left: 1px solid rgba(0,0,0,0.03);
  padding-left: 18px;
}

/* Footer ligero */
.site-footer, footer {
  margin-top: 36px; padding: 36px 0 10px 0; color:var(--mb-muted); font-size:14px; text-align:center;
  border-top: 1px solid rgba(0,0,0,0.04);
}

/* Mobile responsiveness */
@media (max-width: 820px){
  .hero{ grid-template-columns: 92px 1fr; gap:14px; }
  .post-card{ flex-direction: column; }
  .post-card .thumb{ width:100%; height:180px }
}

/* Pequeños refinamientos para Obsidian Publish (nombres comunes de clases) */
.markdown-preview-view { font-size:16px; }
.markdown-preview-view h1 { font-family: Merriweather, Georgia, serif; font-size:32px; }
.markdown-preview-view h2 { font-size:22px; }
.markdown-preview-view img.avatar { border-radius:50%; }

/* Variables de fácil personalización */
/* Cambia el color primario */
/* :root{ --mb-accent: #... } */

/* FIN */
