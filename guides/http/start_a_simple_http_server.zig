const std = @import("std");

pub fn main() !void {
    const address = try std.net.Address.parseIp("127.0.0.1", 8080);
    var net_server = try address.listen(.{ .reuse_address = true });
    defer net_server.deinit();
    std.log.info("listening at http://localhost:{}/", .{address.getPort()});
    while (true) {
        var connection = try net_server.accept();
        const thread = try std.Thread.spawn(.{}, handler, .{&connection});
        thread.detach();
    }
}

fn handler(connection: *std.net.Server.Connection) !void {
    defer connection.stream.close();
    var read_buffer: [1024]u8 = undefined;
    var server = std.http.Server.init(connection.*, &read_buffer);
    var request = try server.receiveHead();
    std.debug.print("{s}\t{s}\n", .{ @tagName(request.head.method), request.head.target });
    try request.respond("Hello world!", .{});
}
