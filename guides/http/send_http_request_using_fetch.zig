const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var body = std.ArrayList(u8).init(allocator);
    defer body.deinit();
    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();
    _ = try client.fetch(.{
        .location = .{ .url = "http://example.com/" },
        .response_storage = .{ .dynamic = &body },
    });
    std.debug.print("{s}", .{body.items});
}
