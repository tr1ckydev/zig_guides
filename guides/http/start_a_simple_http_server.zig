const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var server = std.http.Server.init(allocator, .{ .reuse_address = true });
    defer server.deinit();
    const address = try std.net.Address.parseIp("127.0.0.1", 8080);
    try server.listen(address);
    std.log.info("listening at http://localhost:{}/", .{address.getPort()});
    while (true) {
        var res = try server.accept(.{ .allocator = allocator });
        const thread = try std.Thread.spawn(.{}, handler, .{&res});
        thread.detach();
    }
}

fn handler(res: *std.http.Server.Response) !void {
    defer _ = res.reset();
    try res.wait();
    res.transfer_encoding = .{ .content_length = 14 };
    try res.send();
    try res.writeAll("Hello, world!\n");
    try res.finish();
}
