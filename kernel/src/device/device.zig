const build_options = @import("build_options");

const drivers = @import("root").drivers;

pub const serial = switch (build_options.device) {
    .virt => drivers.uart.pl011,
    .q35 => drivers.q35_serial,
    else => drivers.null_serial,
};

pub fn init() void {

    // TODO device tree will be used later on aarch64

    switch (build_options.device) {
        .virt => {
            drivers.uart.pl011.base_address = 0x09000000;
        },
        .q35 => {},
        else => unreachable,
    }

    serial.init() catch unreachable;

}
