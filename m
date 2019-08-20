Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E5196DE0
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Aug 2019 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfHTXkF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Aug 2019 19:40:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45028 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfHTXkF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 19:40:05 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so851897iop.11;
        Tue, 20 Aug 2019 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P0iyTqh26krI16pEQcPNV/5KL5JW20muCXy/cpunlA0=;
        b=aAgr3O+HwAdCnNKvwfYZli7ccxjVweZNHhb0Me4AvQezHWfd8s8GcDJ7bI/9cLsbYr
         WfR9i4gUHUZqsJRtzJSEm+iYarmKdlk2zLsWi1wd6gL+AeLL9A7ccHcSgWmzRCZqrbn7
         gaLREyQkYWBj3B+505CfjoKfpcvjoeH3uH2Y8ix1eFqruMRchNGHkjW78AokWr/DdZ7a
         dLdwSUHeucIFCZFCNBwmu+KFLrR4sJwJBdYix9d6eP4cjle2EeNVFCSzE15hEQilaAS3
         q2aaP9hhZVBcH6PEZXVZXHsHz074EL/pDuhxg9mywzP3ZyRPquS+boiavvPKCCdtgduW
         uZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P0iyTqh26krI16pEQcPNV/5KL5JW20muCXy/cpunlA0=;
        b=lW9RG8NMHFGCmCq7AfCTB4uT+0MIblmtQbdaMv3by/vR+ZV2SnnSfn5ISUg0IcluKS
         Jh653nLVj5edQczl3U8mrMSFmEr0RmM4gshbfURPbZwiaEYw+MNiCBLWd8Zo0Vrjf26A
         uZDMY0OiRfMpJwV6C0NiOCkkXHZX8fFGnSecwj+cioohltcB8zFoKit6rYVgi44Q7YPO
         pvM8u/R9rdEu57UIhuaKr0S6b7sFtFKkOkkJKoIyvpTc5D5mniX1ulGZwnInQhwoZ1hD
         1062w1J33CfWQgAFgyERPOp0tMnd+gcvZY6vdCMMG8kP+9ledXPMG81CvLfndXOVuiQE
         M6Aw==
X-Gm-Message-State: APjAAAU3C0LYlAZzgPKZg/q6X8/4+yZ/suYHK0WMDcpgOX5JsY/6ODAd
        lKzqy/PoD3TxYQZZYFQeMMEzZEDKo6yc
X-Google-Smtp-Source: APXvYqwktECI5OlFhrdFpP5OOs60AMm9jkEebZ8s/hlFhAJmyz0nfpeXA32M1LGkac4YysK+xCu8XQ==
X-Received: by 2002:a5d:9d58:: with SMTP id k24mr23083916iok.289.1566344404277;
        Tue, 20 Aug 2019 16:40:04 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id e22sm14723802iog.2.2019.08.20.16.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 16:40:03 -0700 (PDT)
Date:   Tue, 20 Aug 2019 19:40:01 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] tools: hv: add vmbus testing tool
Message-ID: <c63cae8e916cbfa4a3fe627da3a545736d0b45dc.1566340843.git.brandonbonaby94@gmail.com>
References: <cover.1566340843.git.brandonbonaby94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566340843.git.brandonbonaby94@gmail.com>
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
Changes in v3:
 - Align python tool to match Linux coding style.

Changes in v2:
 - Move testing location to new location in debugfs.

 tools/hv/vmbus_testing | 342 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 342 insertions(+)
 create mode 100644 tools/hv/vmbus_testing

diff --git a/tools/hv/vmbus_testing b/tools/hv/vmbus_testing
new file mode 100644
index 000000000000..0f249f6ee698
--- /dev/null
+++ b/tools/hv/vmbus_testing
@@ -0,0 +1,342 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Program to allow users to fuzz test Hyper-V drivers
+# by interfacing with Hyper-V debugfs directories
+# author: Branden Bonaby
+
+import os
+import cmd
+import argparse
+from collections import defaultdict
+from argparse import RawDescriptionHelpFormatter
+
+# debugfs paths for vmbus must exist (same as in lsvmbus)
+debugfs_sys_path = "/sys/kernel/debug/hyperv"
+if not os.path.isdir(debugfs_sys_path):
+        print("{} doesn't exist/check permissions".format(debugfs_sys_path))
+        exit(-1)
+# Do not change unless, you change the debugfs attributes
+# in "/sys/kernel/debug/hyperv/<UUID>/". All fuzz testing
+# attributes will start with "fuzz_test".
+pathlen = len(debugfs_sys_path)
+fuzz_state_location = "fuzz_test_state"
+fuzz_states = {
+        0 : "Disable",
+        1 : "Enable"
+}
+
+fuzz_methods = {
+        1 : "Delay_testing"
+}
+
+fuzz_delay_types = {
+        1 : "fuzz_test_buffer_interrupt_delay",
+        2 : "fuzz_test_message_delay"
+}
+
+def parse_args():
+        parser = argparse.ArgumentParser(description = "vmbus_testing "
+                "[-s] [0|1] [-q] [-p] <debugfs-path>\n""vmbus_testing [-s]"
+                " [0|1] [-q][-p] <debugfs-path> delay [-d] [val][val] [-E|-D]\n"
+                "vmbus_testing [-q] disable-all\n"
+                "vmbus_testing [-q] view [-v|-V]\n"
+                "vmbus_testing --version",
+                epilog = "Current testing options {}".format(fuzz_methods),
+                prog = 'vmbus_testing',
+                formatter_class = RawDescriptionHelpFormatter)
+        subparsers = parser.add_subparsers(dest = "action")
+        parser.add_argument("--version", action = "version",
+                        version = '%(prog)s 1.0')
+        parser.add_argument("-q","--quiet", action = "store_true",
+                        help = "silence none important test messages")
+        parser.add_argument("-s","--state", metavar = "", type = int,
+                        choices = range(0, 2),
+                        help = "Turn testing ON or OFF for a single device."
+                        " The value (1) will turn testing ON. The value"
+                        " of (0) will turn testing OFF with the default set"
+                        " to (0).")
+        parser.add_argument("-p","--path", metavar = "",
+                        help = "Refers to the debugfs path to a vmbus device."
+                        " If the path is not a valid path to a vmbus device,"
+                        " the program will exit. The path must be the"
+                        " absolute path; use the lsvmbus command to find"
+                        " the path.")
+        parser_delay = subparsers.add_parser("delay",
+                        help = "Delay buffer/message reads in microseconds.",
+                        description = "vmbus_testing -s [0|1] [-q] -p "
+                        "<debugfs-path> delay -d "
+                        "[buffer-delay-value] [message-delay-value]\n"
+                        "vmbus_testing [-q] delay [buffer-delay-value] "
+                                "[message-delay-value] -E\n"
+                        "vmbus_testing [-q] delay [buffer-delay-value] "
+                                "[message-delay-value] -D",
+                        formatter_class = RawDescriptionHelpFormatter)
+        delay_group = parser_delay.add_mutually_exclusive_group()
+        delay_group.add_argument("-E", "--en_all", action = "store_true",
+                        help = "Enable Buffer/Message Delay testing on ALL"
+                        " devices. Use -d option with this to set the values"
+                        " for both the buffer delay and the message delay. No"
+                        " value can be (0) or less than (-1). If testing is"
+                        " disabled on a device prior to running this command,"
+                        " testing will be enabled on the device as a result"
+                        " of this command.")
+        delay_group.add_argument("-D", "--dis_all", action = "store_true",
+                        help = "Disable Buffer/Message delay testing on ALL"
+                        " devices. A  value equal to (-1) will keep the"
+                        " current delay value, and a value equal to (0) will"
+                        " remove delay testing for the specfied delay column."
+                        " only values (-1) and (0) will be accepted but at"
+                        " least one value must be a (0) or a (-1).")
+        parser_delay.add_argument("-d", "--delay_time", metavar = "", nargs = 2,
+                        type = check_range, default = [0, 0], required = (True),
+                        help = "Buffer/message delay time. A value of (0) will"
+                        "disable delay testing on the specified delay column,"
+                        " while a value of (-1) will ignore the specified"
+                        " delay column. The default values are [0] & [0]."
+                        " The first column represents the buffer delay value"
+                        " and the second represents the message delay value."
+                        " Value constraints: -1 <= value <= 1000.")
+        parser_dis_all = subparsers.add_parser("disable-all",
+                        help = "Disable ALL testing on all vmbus devices.",
+                        description = "vmbus_testing disable-all",
+                        formatter_class = RawDescriptionHelpFormatter)
+        parser_view = subparsers.add_parser("view",
+                        help = "View testing on vmbus devices.",
+                        description = "vmbus_testing view -V\n"
+                        "vmbus_testing -p <debugfs-path> view -v",
+                        formatter_class = RawDescriptionHelpFormatter)
+        view_group = parser_view.add_mutually_exclusive_group()
+        view_group.add_argument("-V", "--view_all", action = "store_true",
+                        help = "View the test status for all vmbus devices.")
+        view_group.add_argument("-v", "--view_single", action = "store_true",
+                        help = "View test values for a single vmbus device.")
+
+        return  parser.parse_args()
+
+# value checking for range checking input in parser
+def check_range(arg1):
+        try:
+                val = int(arg1)
+        except ValueError as err:
+                raise argparse.ArgumentTypeError(str(err))
+        if val < -1 or val > 1000:
+                message = ("\n\nExpected -1 <= value <= 1000, got value"
+                            " {}\n").format(val)
+                raise argparse.ArgumentTypeError(message)
+        return val
+
+def main():
+        try:
+                dev_list = []
+                for dir in os.listdir(debugfs_sys_path):
+                        dev_list.append(os.path.join(debugfs_sys_path, dir))
+                #key value, pairs
+                #key = debugfs device path
+                #value = list of fuzz testing attributes.
+                dev_files = defaultdict(list)
+                for dev in dev_list:
+                        path = os.path.join(dev, "delay")
+                        for f in os.listdir(path):
+                                if (f.startswith("fuzz_test")):
+                                        dev_files[path].append(f)
+
+                dev_files.default_factory = None
+                args = parse_args()
+                path = args.path
+                state = args.state
+                quiet = args.quiet
+                if (not quiet):
+                        print("*** Use lsvmbus to get vmbus device type"
+                                " information.*** ")
+                if (state is not None and validate_args_path(path, dev_list)):
+                        if (state is not get_test_state(path)):
+                                change_test_state(path, quiet)
+                        state = get_test_state(path)
+                if (state == 0 and path is not None):
+                        disable_testing_single_device(path, 0, quiet)
+                        return
+                #Use subparsers as the key for different fuzz testing methods
+                if (args.action == "delay"):
+                        delay = args.delay_time
+                        if (validate_delay_values(args, delay)):
+                                delay_test_all_devices(dev_list, delay, quiet)
+                        elif (validate_args_path(path, dev_list)):
+                                if(get_test_state(path) == 1):
+                                        delay_test_store(path, delay, quiet)
+                                        return
+                                print("device testing OFF, use -s 1 to turn ON")
+                elif (args.action == "disable-all"):
+                        disable_all_testing(dev_list, quiet)
+                elif (args.action == "view"):
+                        if (args.view_all):
+                                all_devices_test_status(dev_list)
+                        elif (args.view_single):
+                                if (validate_args_path(path, dev_list)):
+                                        device_test_values(dev_files, path)
+                                        return
+                                print("Error,(check path) usage: -p"\
+                                            " <debugfs device path> view -v")
+        except AttributeError:
+                print("check usage, 1 or more elements not provided")
+                exit(-1)
+
+# Validate delay values to make sure they are acceptable to
+# to either enable all delays on a device or disable all
+# delays on a device
+def validate_delay_values(args, delay):
+        if (args.en_all):
+                for i in delay:
+                        if (i < -1 or i == 0):
+                                print("\nError, Values must be"
+                                        " equal to -1 or be > 0, use"
+                                        " -d option")
+                                exit(-1)
+                return True
+        elif (args.dis_all):
+                for i in delay:
+                        if (i < -1 or i > 0):
+                                print("\nError, at least 1 value"
+                                        " is not a (0) or a (-1)")
+                                exit(-1)
+                return True
+        else:
+                return False
+
+
+# Validate argument path
+def validate_args_path(path, dev_list):
+        if (path in dev_list):
+                return True
+        else:
+                return False
+
+# display Testing status of single device
+def device_test_values(dev_files, path):
+
+        delay_path = os.path.join(path, 'delay')
+        for test in dev_files.get(delay_path):
+                print("{}".format(test), end = '')
+                print((" value =  {}")\
+                        .format(read_test_files(os.path.join(delay_path, test))))
+
+# display Testing state of devices
+def all_devices_test_status(dev_list):
+    for device in dev_list:
+        if (get_test_state(device) is 1):
+                print("Testing = ON for: {}".format(device.split("/")[5]))
+        else:
+                print("Testing = OFF for: {}".format(device.split("/")[5]))
+
+# read the vmbus device files, path must be absolute path before calling
+def read_test_files(path):
+        try:
+                with open(path,"r") as f:
+                        state = f.readline().strip()
+                        if (state == 'N'):
+                                state = 0
+                        elif (state == 'Y'):
+                                state = 1
+                return int(state)
+
+        except IOError as e:
+                errno, strerror = e.args
+                print("I/O error({0}): {1} on file {2}"
+                        .format(errno, strerror, path))
+                exit(-1)
+        except ValueError:
+                print ("Element to int conversion error in: \n{}".format(path))
+                exit(-1)
+
+# writing to vmbus device files, path must be absolute path before calling
+def write_test_files(path, value):
+        try:
+                with open(path,"w") as f:
+                        f.write("{}".format(value))
+        except IOError as e:
+                errno, strerror = e.args
+                print("I/O error({0}): {1} on file {2}"
+                        .format(errno, strerror, path))
+                exit(-1)
+
+# change testing state of device
+def change_test_state(device, quiet):
+        state_path = os.path.join(device, fuzz_state_location)
+        if (get_test_state(device) is 0):
+                write_test_files(state_path, 1)
+                if (not quiet):
+                            print("Testing = ON for device: {}"
+                                    .format(state_path.split("/")[5]))
+        else:
+                write_test_files(state_path, 0)
+                if (not quiet):
+                            print("Testing = OFF for device: {}"
+                                    .format(state_path.split("/")[5]))
+
+# get testing state of device
+def get_test_state(device):
+        #state == 1 - test = ON
+        #state == 0 - test = OFF
+        return  read_test_files(os.path.join(device, fuzz_state_location))
+
+# Enter 1 - 1000 microseconds, into a single device using the
+# fuzz_test_buffer_interrupt_delay and fuzz_test_message_delay
+# debugfs attributes
+def delay_test_store(device,delay_length, quiet):
+
+        try:
+                # delay[0]- buffer delay, delay[1]- message delay
+                buff_test = os.path.join(os.path.sep,device, 'delay',
+                                            fuzz_delay_types.get(1))
+                mess_test = os.path.join(os.path.sep,device, 'delay',
+                                            fuzz_delay_types.get(2))
+
+                if (delay_length[0] >= 0):
+                        write_test_files(buff_test, delay_length[0])
+                if (delay_length[1] >= 0):
+                        write_test_files(mess_test, delay_length[1])
+                if (not quiet):
+                        print("Buffer delay testing = {} for: {}"
+                                .format(read_test_files(buff_test),
+                                buff_test.split("/")[5]))
+                        print("Message delay testing = {} for: {}"
+                                .format(read_test_files(mess_test),
+                                mess_test.split("/")[5]))
+        except IOError as e:
+                errno, strerror = e.args
+                print("I/O error({0}): {1} on files {2}{3}"
+                        .format(errno, strerror, buff_test, mess_test))
+                exit(-1)
+
+#enabling/disabling delay testing on all devices
+def delay_test_all_devices(dev_list,delay,quiet):
+
+        for device in (dev_list):
+                if (get_test_state(device) is 0):
+                        change_test_state(device,quiet)
+                delay_test_store(device, delay, quiet)
+
+#disabling testing on single device
+def disable_testing_single_device(device,test_type,quiet):
+
+        #test_type represents corresponding key
+        #delay method in delay_methods dict.
+        #special type 0 , used to disable all
+        #testing on SINGLE device.
+
+        if (test_type is 1 or test_type is 0):
+                #disable list [buffer,message]
+                disable_delay = [0, 0]
+                if (get_test_state(device) is 1):
+                        change_test_state(device, quiet)
+                delay_test_store(device, disable_delay, quiet)
+
+#disabling testing on ALL devices
+def disable_all_testing(dev_list,quiet):
+
+        #delay disable list [buffer,message]
+        for device in dev_list:
+                disable_testing_single_device(device, 0, quiet)
+
+if __name__ == "__main__":
+        main()
-- 
2.17.1

