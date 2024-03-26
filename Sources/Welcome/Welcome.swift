
import Hummingbird
import ServiceLifecycle
import Logging
import UnixSignals

@main
enum Welcome {

    static func main() async throws {
        let logger = Logger(label: "welcome")

        // create router and add a single GET /hello route
        let router = Router()
        router.get("/") { request, _ -> Response in
            let page = WelcomePage()
            return Response(
                status: .ok,
                headers: [.contentType: "text/html; charset=utf-8"],
                body: .init(byteBuffer: .init(string: "\(page.view)"))
            )
        }
        router.middlewares.add(FileMiddleware())

        // create application using router
        let app = Application(
            responder: router.buildResponder(),
            configuration: .init(address: .hostname("0.0.0.0", port: 3000 ))
        )

        let serviceLifecycle = ServiceGroup(
            configuration: .init(
                services: [app],
                gracefulShutdownSignals: [.sigint, .sigterm],
                logger: logger
            )
        )

        // run hummingbird application
        try await serviceLifecycle.run()
    }
}

