# Partner Center — чеклист (Pier)

**Status as of 2026-10-30**

Кратък списък от акаунт до submit. Бots **не** регистрират акаунт и **не** качват подписани пакети без Pier.

- [ ] Отвори https://storedeveloper.microsoft.com и влез с Microsoft акаунт на Pier
- [ ] Регистрация **Individual developer** (безплатно; ID + selfie)
- [ ] Запиши **Publisher display name** и **Publisher CN** от Partner Center
- [ ] **CN mismatch:** [PACKAGING.md](../PACKAGING.md) таблицата цели `CN=PED Toolbox`, а `packaging/msix/Package.appxmanifest` има `Publisher="CN=PierMobayed"` — Pier решава кой CN е каноничен; **не променяй** manifest или PACKAGING в този docs PR
- [ ] Reserv/reserve app name **PED Toolbox** (ако е свободно)
- [ ] Качи Store-signed или upload MSIX след Ped Release build (T032-3)
- [ ] Listing: [LISTING.md](LISTING.md) (EN + BG)
- [ ] Privacy policy URL: [PRIVACY.md](PRIVACY.md) blob линк
- [ ] Screenshots: [SCREENSHOTS.md](SCREENSHOTS.md) (PNG 1366×768+)
- [ ] Age rating: [AGE-RATING.md](AGE-RATING.md) / IARC
- [ ] Pricing: Free
- [ ] Submit за certification; след одобрение — winget `msstore` източник (по backlog)

Support URL: https://github.com/PierMobayed/PEDToolBox/issues
