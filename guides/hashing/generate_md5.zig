const std = @import("std");

pub fn main() void {
    var buffer: [std.crypto.hash.Md5.digest_length]u8 = undefined;
    std.crypto.hash.Md5.hash("some data here", &buffer, .{});
    std.debug.print("{s}", .{std.fmt.bytesToHex(buffer, .lower)});
}
