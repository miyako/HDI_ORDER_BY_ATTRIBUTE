# HDI_ORDER_BY_ATTRIBUTE

A 4D v17 **HDI** (How Do I) binary database converted to a 4D project using 4D 21. The codebase was then modernised with the help of **GitHub Copilot**.

## Origin

This project started as a binary `.4DB` example database originally distributed with 4D {version}. It was converted to the modern project architecture (`.4DProject`) using 4D 21's built-in binary-to-project conversion tool.

- **Blog post:** https://blog.4d.com/sort-records-by-object-attribute/

- **Original download:** https://download.4d.com/Demos/4D_v16_R2/HDI_ORDER_BY_ATTRIBUTE.zip

## What This Example Demonstrates

The demo shows how to sort a list box's underlying selection dynamically by an **object attribute** (a field inside an object/blob field) rather than a plain scalar field, using `ORDER BY ATTRIBUTE`.

- A `[CONTACTS_2]` table stores contact details inside an `Info` object field (e.g. `Info.LastName`, `Info.FirstName`, `Info.City`, `Info.Phone`, `Info.CompanyName`, `Info.Age`, `Info.Adress`).
- The `contactsList` list box header click handler (`onHeaderClick`) reads the clicked header's title, resolves it to the underlying attribute name, and calls `ORDER BY ATTRIBUTE([CONTACTS_2]; [CONTACTS_2]Info; "AttributeName"; >/<)` to re-sort the selection in ascending/descending order, toggling a `>`/`<` indicator per column via the object reference (`Self->`).
- The "Name" column is a concatenation of two attributes (`LastName` + `FirstName`), so it issues two linked `ORDER BY ATTRIBUTE` calls in one click — illustrating multi-attribute sort chaining.
- Selecting a row (`On Selection Change`) stringifies the current record's `Info` object with `JSON Stringify` for display, showing how to introspect an object field's contents at runtime.

## Modernisation Highlights

This branch brought the project in line with current 4D project-mode conventions. Each area is backed by a corresponding instruction file under `.github/instructions/`:

| Area | What changed |
|------|--------------|
| **Localisation (XLIFF)** | All menu titles, form text/labels, and message strings now resolve through `:xliff:` references or `Localized string(...)`, backed by purpose-split `.xlf` files (`menu`, `HDI`, `HDI2`, `messages`) for every supported language, including the source language. |
| **Variable declarations** | Deprecated `C_LONGINT`/`C_TEXT`/etc. directives replaced project-wide with `var`/`#DECLARE` syntax. |
| **Menu actions** | The legacy one-line `m_Quit` method wrapper was replaced with the built-in `"action": "quit"` standard action in `menus.json`, so Quit gets native platform integration (e.g. moving to the app menu on macOS) instead of a raw `QUIT 4D` call. |
| **Method visibility** | Subroutines, form-dependent methods, and event handlers are marked `"invisible":true` so only real entry points (e.g. `00_Start`) show up in the Run Method dialog. |
| **Startup dialog pattern** | The splash screen (`00_Start`) now uses `#DECLARE`, `CALL WORKER` instead of `New process`, a non-blocking `DIALOG(...; *)`, and window-reuse detection instead of opening duplicate splash windows. |
| **Dark mode & Liquid Glass** | `styleSheets.css` uses `"automatic"`/`"automaticAlternate"` colour values so text, backgrounds, and the list box adapt to light/dark mode. `styleSheets_mac.css` sets Liquid Glass-appropriate button heights (27px vs. 23px classic) via `form-theme` media queries. |
| **List box display defaults** | Every list box column uses `"truncateMode": "none"` (no mid-word ellipsis) and the list box uses `"resizingMode": "legacy"` (last column grows) instead of proportional resizing. |

## Points of Interest

- **`ORDER BY ATTRIBUTE`** — the core command demonstrated here; see the References section for the command doc. Note the object field is passed by reference (`[CONTACTS_2]Info`), not a scalar field.
- **CSS specificity in 4D forms** — properties set directly in `.4DForm` JSON always win over CSS. Colours and button heights had to be *removed* from the JSON (and a `"class"` added) before `styleSheets*.css` rules could take effect; see `.github/instructions/css.instructions.md`.
- **4D CSS `form-theme` media queries** — `@media (form-theme: liquid-glass)` / `@media (form-theme: mac-classic)` let a single stylesheet target macOS Tahoe's Liquid Glass look and older/classic rendering side by side.
- **Token safety in project-mode source** — `.4dm` files may contain optional `:CNNN` command tokens. This project's convention (and this modernisation pass) is to never guess a token; only include one if it's already verified elsewhere in the source, otherwise omit it and let 4D re-resolve the plain name.
- **Form-scoped state over interprocess variables** — the splash-to-demo transition passes state via the `Form` object (e.g. `Form.quit`) rather than interprocess variables, keeping each window's state isolated.

## Project Structure

```
Project/Sources/
  Methods/              Project methods (00_Start, hdi_init, onHeaderClick, ...)
  Forms/HDI/             Splash screen form + its object methods
  Forms/HDI2/            Main demo form (list box, tab control, object methods)
  menus.json             Menu bar definition
  styleSheets.css         Cross-platform colours (dark mode / automatic values)
  styleSheets_mac.css     macOS-specific rules (Liquid Glass button heights)
Resources/
  en.lproj/, ja.lproj/    XLIFF translation files, split by purpose
```

## References

- `ORDER BY ATTRIBUTE`: https://developer.4d.com/docs/commands/order-by-attribute
- `OB Get`: https://developer.4d.com/docs/commands/ob-get
- CSS in 4D forms: https://developer.4d.com/docs/FormEditor/stylesheets
- 4D project structure: https://developer.4d.com/docs/Project/architecture
- XLIFF localisation in 4D: https://developer.4d.com/docs/Notions/localization
