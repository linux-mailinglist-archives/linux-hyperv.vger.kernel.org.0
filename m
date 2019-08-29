Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A123A1043
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2019 06:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfH2EYc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Aug 2019 00:24:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41416 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfH2EYc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Aug 2019 00:24:32 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so4140893ioj.8;
        Wed, 28 Aug 2019 21:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FJ0hCDSXGfFNrfC1PBNAE7sy9qEEpPHhtJvi0Wd+cIU=;
        b=h0ToyJeoa3kCbFHdfcGVtVpXwclXpUNzFipzLpOLVot8aQ2Xc3ixLAWFfXvYevS3pu
         SnTNcSQtz40AqvrME0X6YaJ0hwnS37drTugaRlLVr4N9aAYjBteU6DFg3G3g6qbvwz3X
         jrvSb11bSu0I7s8TbyAvKDACHCloq2xvGpr+NnkiLTmU/Q1pTk380B8Nzdn8AcpcfZJ9
         GZeffEJW758nQRLj2hSZHCLwx/Q79xnVayhZDVjOTeBxoKCiQTKo6DXrVOpY9K+RScCD
         i+FCQiGA7PBSO9WafrrXwb6pYGfRgnbAClVG3aPTk3V+FOcKJ//EshUZyjBbXmcO4AGy
         9dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FJ0hCDSXGfFNrfC1PBNAE7sy9qEEpPHhtJvi0Wd+cIU=;
        b=F6E83dZN9xTO2aoQ6hGeBss6oT+QM0HpmP12cw9hNEw7GVIlLN160og0P6e+QoNBJh
         GgiR2uva/vqW07vA8JZkiB7AYqE5JsV36g75Q1O/h5godPVZ/b7jWfIooG9OFbBsLbm8
         xiqruLnfgVTNLDiMl/6n6M7Je/fEOHdV+B5YdsIstQ46M7KsSpHTuNZI77nfTpc1hSE4
         7e5So/GagN/8OP9WB0G8kMY7PBcNtn9HTm1aGa6cqrA7PedilK4onR7agMdAks+/rD6a
         ZzmVG6xRBQ5yCvqnewyooRMupfhu7/Ll2pIRKwp3wCHhKDj/wL8AtDWlPsPpcmoKrx2H
         pw3w==
X-Gm-Message-State: APjAAAXHvT2VUcL0ecCfI5KisSgQf/ov/dIpQHx3g2hkAP8Zmam0IqVr
        sQJfT7cT9TynhVPZqwosyA==
X-Google-Smtp-Source: APXvYqwAnUA/QyyKGxM/SlMU64xdS/74AaCFN9sGn65A0iLembSHXs++1NCyetbtjFzVrbmukWLcNA==
X-Received: by 2002:a02:9f94:: with SMTP id a20mr3307813jam.138.1567052670710;
        Wed, 28 Aug 2019 21:24:30 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id e22sm2303655iog.2.2019.08.28.21.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 21:24:30 -0700 (PDT)
Date:   Thu, 29 Aug 2019 00:24:28 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] tools: hv: add vmbus testing tool
Message-ID: <68395ea66ebd4ee02b3a192ee913312af65f5d64.1567047549.git.brandonbonaby94@gmail.com>
References: <cover.1567047549.git.brandonbonaby94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567047549.git.brandonbonaby94@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is a userspace tool to drive the testing. Currently it supports
introducing user specified delay in the host to guest communication
path on a per-channel basis.

Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
---
Changes in v4:
- Based on Harrys comments, made the tool more
  user friendly and added more error checking.

Changes in v3:
- Align python tool to match Linux coding style.

Changes in v2:
 - Move testing location to new location in debugfs.
 
 tools/hv/vmbus_testing | 376 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 376 insertions(+)
 create mode 100644 tools/hv/vmbus_testing

diff --git a/tools/hv/vmbus_testing b/tools/hv/vmbus_testing
new file mode 100644
index 000000000000..e7212903dd1d
--- /dev/null
+++ b/tools/hv/vmbus_testing
@@ -0,0 +1,376 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Program to allow users to fuzz test Hyper-V drivers
+# by interfacing with Hyper-V debugfs attributes.
+# Current test methods available:
+#       1. delay testing
+#
+# Current file/directory structure of hyper-V debugfs:
+#       /sys/kernel/debug/hyperv/UUID
+#       /sys/kernel/debug/hyperv/UUID/<test-state filename>
+#       /sys/kernel/debug/hyperv/UUID/<test-method sub-directory>
+#
+# author: Branden Bonaby <brandonbonaby94@gmail.com>
+
+import os
+import cmd
+import argparse
+import glob
+from argparse import RawDescriptionHelpFormatter
+from argparse import RawTextHelpFormatter
+from enum import Enum
+
+# Do not change unless, you change the debugfs attributes
+# in /drivers/hv/debugfs.c. All fuzz testing
+# attributes will start with "fuzz_test".
+
+# debugfs path for hyperv must exist before proceeding
+debugfs_hyperv_path = "/sys/kernel/debug/hyperv"
+if not os.path.isdir(debugfs_hyperv_path):
+        print("{} doesn't exist/check permissions".format(debugfs_hyperv_path))
+        exit(-1)
+
+class dev_state(Enum):
+        off = 0
+        on = 1
+
+# File names, that correspond to the files created in
+# /drivers/hv/debugfs.c
+class f_names(Enum):
+        state_f = "fuzz_test_state"
+        buff_f =  "fuzz_test_buffer_interrupt_delay"
+        mess_f =  "fuzz_test_message_delay"
+
+# Both single_actions and all_actions are used
+# for error checking and to allow for some subparser
+# names to be abbreviated. Do not abbreviate the
+# test method names, as it will become less intuitive
+# as to what the user can do. If you do decide to
+# abbreviate the test method name, make sure the main
+# function reflects this change.
+
+all_actions = [
+        "disable_all",
+        "D",
+        "enable_all",
+        "view_all",
+        "V"
+]
+
+single_actions = [
+        "disable_single",
+        "d",
+        "enable_single",
+        "view_single",
+        "v"
+]
+
+def main():
+
+        file_map = recursive_file_lookup(debugfs_hyperv_path, dict())
+        args = parse_args()
+        if (not args.action):
+                print ("Error, no options selected...exiting")
+                exit(-1)
+        arg_set = { k for (k,v) in vars(args).items() if v and k != "action" }
+        arg_set.add(args.action)
+        path = args.path if "path" in arg_set else None
+        if (path and path[-1] == "/"):
+                path = path[:-1]
+        validate_args_path(path, arg_set, file_map)
+        if (path and "enable_single" in arg_set):
+            state_path = locate_state(path, file_map)
+            set_test_state(state_path, dev_state.on.value, args.quiet)
+
+        # Use subparsers as the key for different actions
+        if ("delay" in arg_set):
+                validate_delay_values(args.delay_time)
+                if (args.enable_all):
+                        set_delay_all_devices(file_map, args.delay_time,
+                                              args.quiet)
+                else:
+                        set_delay_values(path, file_map, args.delay_time,
+                                         args.quiet)
+        elif ("disable_all" in arg_set or "D" in arg_set):
+                disable_all_testing(file_map)
+        elif ("disable_single" in arg_set or "d" in arg_set):
+                disable_testing_single_device(path, file_map)
+        elif ("view_all" in arg_set or "V" in arg_set):
+                get_all_devices_test_status(file_map)
+        elif ("view_single" in arg_set or  "v" in arg_set):
+                get_device_test_values(path, file_map)
+
+# Get the state location
+def locate_state(device, file_map):
+        return file_map[device][f_names.state_f.value]
+
+# Validate delay values to make sure they are acceptable to
+# enable delays on a device
+def validate_delay_values(delay):
+
+        if (delay[0]  == -1 and delay[1] == -1):
+                print("\nError, At least 1 value must be greater than 0")
+                exit(-1)
+        for i in delay:
+                if (i < -1 or i == 0 or i > 1000):
+                        print("\nError, Values must be  equal to -1 "
+                              "or be > 0 and <= 1000")
+                        exit(-1)
+
+# Validate argument path
+def validate_args_path(path, arg_set, file_map):
+
+        if (not path and any(element in arg_set for element in single_actions)):
+                print("Error, path (-p) REQUIRED for the specified option. "
+                      "Use (-h) to check usage.")
+                exit(-1)
+        elif (path and any(item in arg_set for item in all_actions)):
+                print("Error, path (-p) NOT REQUIRED for the specified option. "
+                      "Use (-h) to check usage." )
+                exit(-1)
+        elif (path not in file_map and any(item in arg_set
+                                           for item in single_actions)):
+                print("Error, path '{}' not a valid vmbus device".format(path))
+                exit(-1)
+
+# display Testing status of single device
+def get_device_test_values(path, file_map):
+
+        for name in file_map[path]:
+                file_location = file_map[path][name]
+                print( name + " = " + str(read_test_files(file_location)))
+
+# Create a map of the vmbus devices and their associated files
+# [key=device, value = [key = filename, value = file path]]
+def recursive_file_lookup(path, file_map):
+
+        for f_path in glob.iglob(path + '**/*'):
+                if (os.path.isfile(f_path)):
+                        if (f_path.rsplit("/",2)[0] == debugfs_hyperv_path):
+                                directory = f_path.rsplit("/",1)[0]
+                        else:
+                                directory = f_path.rsplit("/",2)[0]
+                        f_name = f_path.split("/")[-1]
+                        if (file_map.get(directory)):
+                                file_map[directory].update({f_name:f_path})
+                        else:
+                                file_map[directory] = {f_name:f_path}
+                elif (os.path.isdir(f_path)):
+                        recursive_file_lookup(f_path,file_map)
+        return file_map
+
+# display Testing state of devices
+def get_all_devices_test_status(file_map):
+
+        for device in file_map:
+                if (get_test_state(locate_state(device, file_map)) is 1):
+                        print("Testing = ON for: {}"
+                              .format(device.split("/")[5]))
+                else:
+                        print("Testing = OFF for: {}"
+                              .format(device.split("/")[5]))
+
+# read the vmbus device files, path must be absolute path before calling
+def read_test_files(path):
+        try:
+                with open(path,"r") as f:
+                        file_value = f.readline().strip()
+                return int(file_value)
+
+        except IOError as e:
+                errno, strerror = e.args
+                print("I/O error({0}): {1} on file {2}"
+                      .format(errno, strerror, path))
+                exit(-1)
+        except ValueError:
+                print ("Element to int conversion error in: \n{}".format(path))
+                exit(-1)
+
+# writing to vmbus device files, path must be absolute path before calling
+def write_test_files(path, value):
+
+        try:
+                with open(path,"w") as f:
+                        f.write("{}".format(value))
+        except IOError as e:
+                errno, strerror = e.args
+                print("I/O error({0}): {1} on file {2}"
+                      .format(errno, strerror, path))
+                exit(-1)
+
+# set testing state of device
+def set_test_state(state_path, state_value, quiet):
+
+        write_test_files(state_path, state_value)
+        if (get_test_state(state_path) is 1):
+                if (not quiet):
+                        print("Testing = ON for device: {}"
+                              .format(state_path.split("/")[5]))
+        else:
+                if (not quiet):
+                        print("Testing = OFF for device: {}"
+                              .format(state_path.split("/")[5]))
+
+# get testing state of device
+def get_test_state(state_path):
+        #state == 1 - test = ON
+        #state == 0 - test = OFF
+        return  read_test_files(state_path)
+
+# write 1 - 1000 microseconds, into a single device using the
+# fuzz_test_buffer_interrupt_delay and fuzz_test_message_delay
+# debugfs attributes
+def set_delay_values(device, file_map, delay_length, quiet):
+
+        try:
+                interrupt = file_map[device][f_names.buff_f.value]
+                message = file_map[device][f_names.mess_f.value]
+
+                # delay[0]- buffer interrupt delay, delay[1]- message delay
+                if (delay_length[0] >= 0 and delay_length[0] <= 1000):
+                        write_test_files(interrupt, delay_length[0])
+                if (delay_length[1] >= 0 and delay_length[1] <= 1000):
+                        write_test_files(message, delay_length[1])
+                if (not quiet):
+                        print("Buffer delay testing = {} for: {}"
+                              .format(read_test_files(interrupt),
+                                      interrupt.split("/")[5]))
+                        print("Message delay testing = {} for: {}"
+                              .format(read_test_files(message),
+                                      message.split("/")[5]))
+        except IOError as e:
+                errno, strerror = e.args
+                print("I/O error({0}): {1} on files {2}{3}"
+                      .format(errno, strerror, interrupt, message))
+                exit(-1)
+
+# enabling delay testing on all devices
+def set_delay_all_devices(file_map, delay, quiet):
+
+        for device in (file_map):
+                set_test_state(locate_state(device, file_map),
+                               dev_state.on.value,
+                               quiet)
+                set_delay_values(device, file_map, delay, quiet)
+
+# disable all testing on a SINGLE device.
+def disable_testing_single_device(device, file_map):
+
+        for name in file_map[device]:
+                file_location = file_map[device][name]
+                write_test_files(file_location, dev_state.off.value)
+        print("ALL testing now OFF for {}".format(device.split("/")[-1]))
+
+# disable all testing on ALL devices
+def disable_all_testing(file_map):
+
+        for device in file_map:
+                disable_testing_single_device(device, file_map)
+
+def parse_args():
+        parser = argparse.ArgumentParser(prog = "vmbus_testing",usage ="\n"
+                "%(prog)s [delay]   [-h] [-e|-E] -t [-p]\n"
+                "%(prog)s [view_all       | V]      [-h]\n"
+                "%(prog)s [disable_all    | D]      [-h]\n"
+                "%(prog)s [disable_single | d]      [-h|-p]\n"
+                "%(prog)s [view_single    | v]      [-h|-p]\n"
+                "%(prog)s --version\n",
+                description = "\nUse lsvmbus to get vmbus device type "
+                "information.\n" "\nThe debugfs root path is "
+                "/sys/kernel/debug/hyperv",
+                formatter_class = RawDescriptionHelpFormatter)
+        subparsers = parser.add_subparsers(dest = "action")
+        parser.add_argument("--version", action = "version",
+                version = '%(prog)s 0.1.0')
+        parser.add_argument("-q","--quiet", action = "store_true",
+                help = "silence none important test messages."
+                       " This will only work when enabling testing"
+                       " on a device.")
+        # Use the path parser to hold the --path attribute so it can
+        # be shared between subparsers. Also do the same for the state
+        # parser, as all testing methods will use --enable_all and
+        # enable_single.
+        path_parser = argparse.ArgumentParser(add_help=False)
+        path_parser.add_argument("-p","--path", metavar = "",
+                help = "Debugfs path to a vmbus device. The path "
+                "must be the absolute path to the device.")
+        state_parser = argparse.ArgumentParser(add_help=False)
+        state_group = state_parser.add_mutually_exclusive_group(required = True)
+        state_group.add_argument("-E", "--enable_all", action = "store_const",
+                                 const = "enable_all",
+                                 help = "Enable the specified test type "
+                                 "on ALL vmbus devices.")
+        state_group.add_argument("-e", "--enable_single",
+                                 action = "store_const",
+                                 const = "enable_single",
+                                 help = "Enable the specified test type on a "
+                                 "SINGLE vmbus device.")
+        parser_delay = subparsers.add_parser("delay",
+                        parents = [state_parser, path_parser],
+                        help = "Delay the ring buffer interrupt or the "
+                        "ring buffer message reads in microseconds.",
+                        prog = "vmbus_testing",
+                        usage = "%(prog)s [-h]\n"
+                        "%(prog)s -E -t [value] [value]\n"
+                        "%(prog)s -e -t [value] [value] -p",
+                        description = "Delay the ring buffer interrupt for "
+                        "vmbus devices, or delay the ring buffer message "
+                        "reads for vmbus devices (both in microseconds). This "
+                        "is only on the host to guest channel.")
+        parser_delay.add_argument("-t", "--delay_time", metavar = "", nargs = 2,
+                        type = check_range, default =[0,0], required = (True),
+                        help = "Set [buffer] & [message] delay time. "
+                        "Value constraints: -1 == value "
+                        "or 0 < value <= 1000.\n"
+                        "Use -1 to keep the previous value for that delay "
+                        "type, or a value > 0 <= 1000 to change the delay "
+                        "time.")
+        parser_dis_all = subparsers.add_parser("disable_all",
+                        aliases = ['D'], prog = "vmbus_testing",
+                        usage = "%(prog)s [disable_all | D] -h\n"
+                        "%(prog)s [disable_all | D]\n",
+                        help = "Disable ALL testing on ALL vmbus devices.",
+                        description = "Disable ALL testing on ALL vmbus "
+                        "devices.")
+        parser_dis_single = subparsers.add_parser("disable_single",
+                        aliases = ['d'],
+                        parents = [path_parser], prog = "vmbus_testing",
+                        usage = "%(prog)s [disable_single | d] -h\n"
+                        "%(prog)s [disable_single | d] -p\n",
+                        help = "Disable ALL testing on a SINGLE vmbus device.",
+                        description = "Disable ALL testing on a SINGLE vmbus "
+                        "device.")
+        parser_view_all = subparsers.add_parser("view_all", aliases = ['V'],
+                        help = "View the test state for ALL vmbus devices.",
+                        prog = "vmbus_testing",
+                        usage = "%(prog)s [view_all | V] -h\n"
+                        "%(prog)s [view_all | V]\n",
+                        description = "This shows the test state for ALL the "
+                        "vmbus devices.")
+        parser_view_single = subparsers.add_parser("view_single",
+                        aliases = ['v'],parents = [path_parser],
+                        help = "View the test values for a SINGLE vmbus "
+                        "device.",
+                        description = "This shows the test values for a SINGLE "
+                        "vmbus device.", prog = "vmbus_testing",
+                        usage = "%(prog)s [view_single | v] -h\n"
+                        "%(prog)s [view_single | v] -p")
+
+        return  parser.parse_args()
+
+# value checking for range checking input in parser
+def check_range(arg1):
+
+        try:
+                val = int(arg1)
+        except ValueError as err:
+                raise argparse.ArgumentTypeError(str(err))
+        if val < -1 or val > 1000:
+                message = ("\n\nvalue must be -1 or  0 < value <= 1000. "
+                           "Value program received: {}\n").format(val)
+                raise argparse.ArgumentTypeError(message)
+        return val
+
+if __name__ == "__main__":
+        main()
-- 
2.17.1

