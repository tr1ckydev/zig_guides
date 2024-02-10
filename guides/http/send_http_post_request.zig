const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // Stringifying 'data' into JSON
    const data = .{
        .name = "Ziguana",
        .id = 1234,
        .is_active = true,
    };
    var json_string = std.ArrayList(u8).init(allocator);
    defer json_string.deinit();
    try std.json.stringify(data, .{}, json_string.writer());

    // Sending the JSON to a server
    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();
    var headers = std.http.Headers.init(allocator);
    defer headers.deinit();
    try headers.append("Accept", "application/json");
    try headers.append("Content-Type", "application/json");
    const options = std.http.Client.RequestOptions{};
    const uri = try std.Uri.parse("https://reqbin.com/echo/post/json");
    var request = try client.open(.POST, uri, headers, options);
    request.transfer_encoding = .chunked;
    defer request.deinit();
    try request.send(.{});
    try request.writeAll(json_string.items);
    try request.finish();
    try request.wait();

    // Reading the response
    const body = try request.reader().readAllAlloc(allocator, 1024);
    std.debug.print("{s}", .{body});
}
