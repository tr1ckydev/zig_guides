const std = @import("std");

pub fn main() !void {
    try createLib();

    var lib = try std.DynLib.open("libadd.so");
    defer lib.close();
    const add_fn = *const fn (a: i32, b: i32) i32;
    const add = lib.lookup(add_fn, "add") orelse return error.FunctionNotFound;
    const result = add(1, 2);
    std.debug.print("1 + 2 = {}\n", .{result});
}

fn createLib() !void {
    // Create add.zig
    const file = try std.fs.cwd().createFile("add.zig", .{});
    defer file.close();
    try file.writeAll(
        \\pub export fn add(a: i32, b: i32) i32 {
        \\    return a + b;
        \\}
    );
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    // Compile add.zig into a dynamic library
    const proc = try std.process.Child.run(.{
        .allocator = allocator,
        .argv = &.{ "zig", "build-lib", "add.zig", "-dynamic", "-OReleaseFast" },
    });
    defer allocator.free(proc.stdout);
    defer allocator.free(proc.stderr);
}
