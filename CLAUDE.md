# NonCow (noncow.com)

Statisk nettsted om plantemelk: quiz, bloggartikler og Amazon-affiliate-lenker. Innholdet er på engelsk.
Hostes på GitHub Pages fra `main` (domenet ligger i `CNAME`). Ingen byggesteg, ingen pakker. Alt i repoet blir publisert, unntatt det som står i `exclude` i `_config.yml`.

## Struktur

- `index.html`: forside · `quiz.html`: quizen (resultatene bygges i JS) · `disclosure.html` · `privacy.html`
- `blog/index.html`: bloggoversikt (kort sortert med nyeste først) · `blog/*.html`: artikler
- `style.css`: felles stilark · `sitemap.xml` · `robots.txt`
- `images/`: bilder. `*-vertical.jpg` (1000×1500) er Pinterest-bilder, de andre er artikkelbilder
- `logo.png` (512×512) brukes som `publisher.logo` i schema. Favicons: `favicon.svg`, `favicon-48.png`, `favicon.ico`, `apple-touch-icon.png`. Kilden til alle er `images/logo.svg`

Header, footer og cookie-banner er kopiert inn i hver side. Endres de, må alle sidene oppdateres.

## Konvensjoner

**Lenker** (bruk alltid samme form, den samme som står i canonical):
- `/` · `/quiz` · `/blog/` (med skråstrek) · `/blog/<slug>.html` · `/disclosure` · `/privacy`
- Alltid rotrelativt (`/style.css`, `/images/...`). Aldri `../`, og ikke `https://noncow.com/...` i interne `href`.

**Canonical:** `https://noncow.com` + samme sti som over, f.eks. `https://noncow.com/blog/<slug>.html`. Skal finnes på alle sider.

**Affiliate-lenker:** `https://www.amazon.com/s?k=SØK+ORD&tag=e12nni-20`, med `target="_blank" rel="sponsored noopener"`. Alle Amazon-lenker skal ha `sponsored`, også de som genereres i quiz-JS.

**Google Analytics (G-B4ZDS9NB49):** lastes KUN via `loadGoogleAnalytics()` i samtykkeskriptet nederst på hver side, etter at brukeren har trykket «Accept». Legg aldri `gtag.js` direkte i `<head>`, det bryter GDPR og personvernerklæringen. Cookie-banneret lenker til `/privacy`.

**Head:** canonical, favicon-lenkene, Open Graph (`og:type/url/title/description/image/site_name`) og Twitter Card (`summary_large_image`). `og:url` = canonical.

**Schema (JSON-LD):** Artikler har `Article` (med `image`, `datePublished`, `dateModified`, `mainEntityOfPage`, `publisher.logo` = `https://noncow.com/logo.png`) og `BreadcrumbList`, og ev. `FAQPage` eller `Recipe`. Alle URL-er i schema og `og:image` må peke på filer som finnes.

**Overskrifter:** én `<h1>` per side. Logoen i headeren er `<div class="logo-title">`, ikke en overskrift.

**Merke:** farger `#667eea` → `#764ba2` (gradient). Logoen i headeren er `🥛 NonCow`.

## Ny artikkel: sjekkliste

Ta utgangspunkt i `blog/best-plant-milk-for-baking.html` (riktig struktur: cookie-banner → `.container` → `.logo` → `nav` → `.breadcrumbs` → `article` → `.related-articles` → `footer` → samtykkeskript).

1. `<title>` ≤ 60 tegn, `meta description` ≤ 160 tegn, canonical, Open Graph (`og:title`, `og:description`, `og:image`, `og:url`, `og:type=article`)
2. Schema som beskrevet over, med et bilde som finnes i `images/`
3. `.affiliate-disclosure` øverst, `.affiliate-section` for produktlenker, `.cta-box` med lenke til `/quiz`, `.related-articles` til slutt
4. Bilder: beskrivende `alt`, `width`/`height` og `loading="lazy"` (ikke på det første bildet)
5. Legg til et kort i `blog/index.html` (med dato og lesetid, ca. 220 ord/min)
6. Legg til i `sitemap.xml` (`lastmod` = sist endret)
7. Lenk til artikkelen fra minst 2–3 relaterte artikler, så den ikke blir foreldreløs
8. Når en artikkel endres: oppdater `dateModified` i schema, «Updated» i `.blog-meta` og `lastmod` i sitemap

## Kjente mangler (ikke fikset ennå)

- `author` i Article-schema er `Organization`, bør være en `Person` (E-E-A-T, særlig for helseartikler)
- `privacy.html` mangler kontakt-e-post (TODO i filen)
- Titlene inneholder «(2026)» og må oppdateres ved årsskiftet
- På sikt: flytte header/footer/cookie-banner til Jekyll `_includes/`
