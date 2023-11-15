const std = @import("std");

const Location = struct {
    name: []const u8,
    lat: f32,
    long: f32,
};

pub fn main() !void {
    const location = Location{
        .name = "Zigland",
        .lat = 40.684540,
        .long = -74.401422,
    };
    var buffer: [150]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    var json_string = std.ArrayList(u8).init(allocator);
    defer json_string.deinit();
    try std.json.stringify(location, .{}, json_string.writer());
    std.debug.print("{s}\n", .{json_string.items});
}
