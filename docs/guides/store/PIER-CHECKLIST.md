# Partner Center — чеклист (Pier)

**Status as of 2026-10-30**

Кратък списък от акаунт до submit. Bots **не** регистрират акаунт и **не** качват подписани пакети без Pier. Listing/support: **public GitHub URLs only**, plus https://pedtoolbox.com and pedtoolbox@gmail.com.

- [ ] Отвори https://storedeveloper.microsoft.com и влез с Microsoft акаунт на Pier
- [ ] Регистрация **Individual developer** (безплатно; ID + selfie)
- [ ] Запиши **Publisher display name** и **Publisher CN** от Partner Center
- [ ] **CN mismatch:** `packaging/msix/Package.appxmanifest` има `Publisher="CN=PierMobayed"`; [PACKAGING.md](../PACKAGING.md) описва целеви publisher след T048 — Pier решава каноничния CN; **не променяй** manifest или PACKAGING в този docs PR
- [ ] Reserve app name **PED Toolbox** (ако е свободно)
- [ ] Качи Store-signed или upload MSIX след Ped Release build (T032-3)
- [ ] Listing: [LISTING.md](LISTING.md) (EN + BG; support = Issues + pedtoolbox.com + pedtoolbox@gmail.com)
- [ ] Privacy policy URL: [PRIVACY.md](PRIVACY.md) blob линк (лог, PED-Recovery, DISM, About бутони)
- [ ] Screenshots: [SCREENSHOTS.md](SCREENSHOTS.md) (PNG 1366×768+)
- [ ] Age rating: [AGE-RATING.md](AGE-RATING.md) / IARC
- [ ] Pricing: Free
- [ ] Submit за certification; след одобрение — winget `msstore` източник (по backlog)

Support (Partner Center): https://github.com/PierMobayed/PEDToolBox/issues · https://pedtoolbox.com · pedtoolbox@gmail.com
