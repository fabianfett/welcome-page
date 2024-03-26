import HTML

struct WelcomePage {

    struct Section {
        var title: String?
        var caption: String?
        var sites: [Site]
    }

    struct Site {
        var title: String
        var caption: String
        var href: String
    }

    var sections: [Section] = [
        .init(
            sites: [
                .init(title: "Homeassistant", caption: "ha", href: "https://home.fett.one"),
                .init(title: "OnTrack", caption: "Unser Finance Planer", href: "https://ontrack.fett.one"),
                .init(title: "Dateien", caption: "Files", href: "https://files.fett.one"),
                .init(title: "Hochzeit", caption: "Unsere Hochzeitswebsite", href: "https://wedding.fett.one/schmetts"),
                .init(title: "SearXNG", caption: "Unsere Searchengine ohne Bullshit", href: "https://home.fett.one"),
                .init(title: "Statuspage", caption: "Was ist gerade kaputt?", href: "https://kuma.fett.one/status/homelab"),
            ]
        ),
        .init(
            title: "Infrastructure",
            caption: "Keeping the family happy!",
            sites: [
                .init(title: "Proxmox", caption: "Run virtual machines at home.", href: "https://proxl.fett.one:8006"),
                .init(title: "Pihole", caption: "It's always DNS", href: "https://pihole.fett.one"),
                .init(title: "Uptime Kuma", caption: "Monitor all services", href: "https://kuma.fett.one"),
                .init(title: "Dozzle", caption: "Read Docker logs without cli", href: "https://dozzle.fett.one"),
                .init(title: "Traefik", caption: "Our central loadbalancer", href: "https://traefik.fett.one"),
                .init(title: "Prometheus", caption: "Monitoring on asteriods", href: "https://prometheus.fett.one"),
                .init(title: "ntfy", caption: "Send push notifications", href: "https://ntfy.fett.one"),
            ]
        ),
    ]

    var view: Node {
        html {
            head {
                meta(charset: "UTF-8")
                meta(content: "width=device-width, initial-scale=1.0", name: "viewport")
                link(href: "/output.css", rel: "stylesheet")
            }
            body(class: "bg-white dark:bg-slate-900") {
                div(class: "container mx-auto px-4") {
                    h1(class: "text-4xl py-8 font-semibold text-slate-600") {
                        "Hi."
                    }

                    self.sections.map({ self.makeSection($0) })
                }
            }
        }
    }

    func makeSection(_ section: Section) -> Node {

        div(class: "py-8 border-t border-solid border-slate-200 dark:border-slate-700") {
            if let title = section.title {
                h2(class: "text-2xl text-slate-800 dark:text-slate-300") {
                    title
                }
            }
            if let body = section.caption {
                p(class: "pb-4 text-slate-600 dark:text-slate-500") {
                    body
                }
            }
            ul(class: "grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-16 gap-y-8") {
                section.sites.map({ self.makeSite($0) })
            }
        }
    }

    func makeSite(_ site: Site) -> Node {
        li(class: "relative group") {
            div(class: "py-2") {
                h3(class: "font-semibold text-slate-900 dark:text-slate-100 mb-2") {
                    a(class: "before:absolute before:-inset-x-4 before:-inset-y-2", href: site.href) {
                        site.title
                    }
                }
                p(class: "text-slate-600 dark:text-slate-500 text-sm") {
                    site.caption
                }

                div(class: "absolute -inset-x-4 -inset-y-2 -z-10 bg-slate-100/50 dark:bg-slate-800/50 rounded-xl opacity-0 group-hover:opacity-100") {}
            }
        }
    }
}
