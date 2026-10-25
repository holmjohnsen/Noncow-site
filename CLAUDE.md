# NonCow (noncow.com)

Statisk nettsted om plantemelk: quiz, bloggartikler og Amazon-affiliate-lenker. Innholdet er på engelsk.
Hostes på GitHub Pages fra `main` (domenet ligger i `CNAME`). GitHub Pages bygger med Jekyll, men det brukes bare til felles includes. Det er ingen layouts, pakker eller lokalt byggesteg som kreves. Alt i repoet blir publisert, unntatt filer/mapper som starter med `_` eller `.`, og det som står i `exclude` i `_config.yml`.

## Struktur

- `index.html`: forside · `quiz.html`: quizen (resultatene bygges i JS) · `disclosure.html` · `privacy.html`
- `blog/index.html`: bloggoversikt (kort sortert med nyeste først) · `blog/*.html`: artikler
- `style.css`: felles stilark · `sitemap.xml` · `robots.txt`
- `images/`: bilder. `*-vertical.jpg` (1000×1500) er Pinterest-bilder, de andre er artikkelbilder
- `logo.png` (512×512) brukes som `publisher.logo` i schema. Favicons: `favicon.svg`, `favicon-48.png`, `favicon.ico`, `apple-touch-icon.png`. Kilden til alle er `images/logo.svg`

**Felles elementer ligger i `_includes/` og skal ALDRI kopieres inn i sidene:**
- `cookie-banner.html`: rett etter `<body>`
- `header.html`: logo og meny, først inne i `.container`
- `footer.html`: sist inne i `.container` (årstallet settes automatisk)
- `consent.html`: samtykke- og GA-skriptet, rett før `</body>`

Alle sider starter med en tom front matter (`---` / `---`), ellers kjører ikke Jekyll includes. Pass på at sidene ikke inneholder `{{` eller `{%` utenfor includes (Liquid-syntaks).

**Teste lokalt:** `jekyll build` og deretter `python3 -m http.server 8000 -d _site` (installert med `gem install --user-install jekyll -v 3.10.0`, samme versjon som GitHub Pages).

## Konvensjoner

**Lenker** (bruk alltid samme form, den samme som står i canonical):
- `/` · `/quiz` · `/blog/` (med skråstrek) · `/blog/<slug>.html` · `/disclosure` · `/privacy`
- Alltid rotrelativt (`/style.css`, `/images/...`). Aldri `../`, og ikke `https://noncow.com/...` i interne `href`.

**Canonical:** `https://noncow.com` + samme sti som over, f.eks. `https://noncow.com/blog/<slug>.html`. Skal finnes på alle sider.

**Affiliate-lenker:** `https://www.amazon.com/s?k=SØK+ORD&tag=e12nni-20`, med `target="_blank" rel="sponsored noopener"`. Alle Amazon-lenker skal ha `sponsored`, også de som genereres i quiz-JS.

**Google Analytics (G-B4ZDS9NB49):** lastes KUN via `loadGoogleAnalytics()` i `_includes/consent.html`, etter at brukeren har trykket «Accept». Legg aldri `gtag.js` direkte i `<head>`, det bryter GDPR og personvernerklæringen. Cookie-banneret lenker til `/privacy`.

**Head:** canonical, favicon-lenkene, Open Graph (`og:type/url/title/description/image/site_name`) og Twitter Card (`summary_large_image`). `og:url` = canonical.

**Schema (JSON-LD):** Artikler har `Article` (med `image`, `datePublished`, `dateModified`, `mainEntityOfPage`, `author` = Person «Øyvind Holm-Johnsen» med `sameAs` LinkedIn, `publisher.logo` = `https://noncow.com/logo.png`) og `BreadcrumbList`, og ev. `FAQPage` eller `Recipe`. Alle URL-er i schema og `og:image` må peke på filer som finnes.

**Overskrifter:** én `<h1>` per side. Logoen i headeren er `<div class="logo-title">`, ikke en overskrift.

**Merke:** farger `#667eea` → `#764ba2` (gradient). Logoen i headeren er `🥛 NonCow`.

## Etter hver push: IndexNow

Bing er den viktigste søkekanalen (den forsyner også Yahoo, DuckDuckGo, ChatGPT-søk og Copilot). Etter at GitHub Pages har bygget, varsle IndexNow om endrede sider:

- `_tools/indexnow.sh https://noncow.com/blog/<slug>.html ...` sender bestemte URL-er
- `_tools/indexnow.sh --all` sender alle URL-er i `sitemap.xml` (etter store endringer)

Nøkkelfilen `b2255992a86765c4c50f10220347e417.txt` i roten må ligge der (den beviser eierskap). HTTP 200/202 betyr mottatt. Google bruker ikke IndexNow, der gjelder Search Console og sitemap.

## Ny artikkel: sjekkliste

Ta utgangspunkt i `blog/best-plant-milk-for-baking.html` (front matter → head → `{% include cookie-banner.html %}` → `.container` → `{% include header.html %}` → `.breadcrumbs` → `article` → `.related-articles` → `{% include footer.html %}` → `{% include consent.html %}`).

1. `<title>` ≤ 60 tegn, `meta description` ≤ 160 tegn, canonical, Open Graph (`og:title`, `og:description`, `og:image`, `og:url`, `og:type=article`)
2. Schema som beskrevet over, med et bilde som finnes i `images/`
3. `.affiliate-disclosure` øverst, `.affiliate-section` for produktlenker, `.cta-box` med lenke til `/quiz`, `.related-articles` til slutt
4. Bilder: beskrivende `alt`, `width`/`height` og `loading="lazy"` (ikke på det første bildet)
5. Legg til et kort i `blog/index.html` (med dato og lesetid, ca. 220 ord/min)
6. Legg til i `sitemap.xml` (`lastmod` = sist endret)
7. Lenk til artikkelen fra minst 2–3 relaterte artikler, så den ikke blir foreldreløs
8. Når en artikkel endres: oppdater `dateModified` i schema, «Updated» i `.blog-meta` og `lastmod` i sitemap

## Kjente mangler (ikke fikset ennå)

- `privacy.html` mangler kontakt-e-post (TODO i filen)
- Titlene inneholder «(2026)» og må oppdateres ved årsskiftet
