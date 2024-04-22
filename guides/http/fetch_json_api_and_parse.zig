const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var body = std.ArrayList(u8).init(allocator);
    defer body.deinit();
    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();
    _ = try client.fetch(.{
        .location = .{ .url = "https://api.github.com/repos/ziglang/zig" },
        .response_storage = .{ .dynamic = &body },
    });
    const parsed = try std.json.parseFromSlice(std.json.Value, allocator, body.items, .{});
    defer parsed.deinit();
    const response_json = parsed.value.object;
    std.debug.print("{s}\n", .{response_json.get("description").?.string});
}
