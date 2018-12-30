#include <chrono>
#include <pistache/client.h>
#include <pistache/endpoint.h>
#include <pistache/http.h>

int main(int /*_argc*/, char ** /*_argv*/)
{
    std::string URL = "httpbin.org:80/anything";

    Pistache::Http::Client client;
    client.init();

    auto req = client.get(URL);
    auto res = req.send();
    res.then(
        [&](Pistache::Http::Response hr)
        {
            std::cout << "code = " << hr.code() << std::endl;
            auto body = hr.body();
            if (!body.empty())
            {
                std::cout << "body = " << body << std::endl;
            }
        }, Pistache::Async::IgnoreException);

    Pistache::Async::Barrier<Pistache::Http::Response> barrier(res);
    barrier.wait_for(std::chrono::seconds(10));

    client.shutdown();

    return 0;
}
