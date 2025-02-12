#! /bin/bash

#turn off trace first
echo 0 > /sys/kernel/debug/tracing/tracing_on

#check current tracer
echo "current_tracer are belows:"
echo > /sys/kernel/debug/tracing/set_event
echo "nop" > /sys/kernel/debug/tracing/current_tracer

echo "add all lru_gen tracers below: "
echo 1 > /sys/kernel/debug/tracing/events/lru_gen/folio_ws_chg/enable
echo 1 > /sys/kernel/debug/tracing/events/lru_gen/folio_ws_chg_se/enable