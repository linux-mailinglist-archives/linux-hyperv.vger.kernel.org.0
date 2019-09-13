Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D46B1730
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2019 04:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfIMCcK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Sep 2019 22:32:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42269 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfIMCcJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Sep 2019 22:32:09 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so59758662iod.9;
        Thu, 12 Sep 2019 19:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gFNmXQdYIabhkcmCs+/OjkORihwbxv7qoQdl89TUSZw=;
        b=HWpIyH6BxUTLlBcNFvWrArJKwJv/iSLFFVi+2KzAYaTCUB2tSkaJrOEpNahy6Ho1/Q
         +GWpM6pqiCwEU+yAhS/NVm/Po2GdfsQKVny3cC+MnBEoqrYd696ox+o7QkXyx6lk6IXk
         8wu9gE3JjAxi8OLdLexXwZzjDAGW2tujZzqa8dsFzDZdkni6JDzPFR2zMzhoz5v8l+iu
         2GB0CBYw4cG3GCj6n2QfEML8yZrXuHERZfbYPxrX2NIPRaa4JDx0awL/XjnyEFXhZsmF
         mWqlCaJ0y0dA+Meikb6xuf4siSeN2rUgVcVueb2wFDI9h+it8WRFlUZE9ppk4bANJulL
         NCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gFNmXQdYIabhkcmCs+/OjkORihwbxv7qoQdl89TUSZw=;
        b=lT4wofRn5i8Eu9i91ACvEaCe9eVMRMzlbLAHo7WElYwF+lVfcv+mqfRRmkO2d+m2w0
         GgVjjGsSu+iUsrHuFgh7tUfuQ2lXI6WAYwfGkpJEKs/6CKF0vCcBm8aN3M8kdEdSF6qr
         AAzYNPNuBNdFqFO6gEaMasO+2DmCMTmZNnr4W4UTcP/QQW0va2vtQbLcMT/gvNRTMg/j
         O0VR+Zm5gw34yglBJJeEYosM5URFlqya6heDZ9fVKsHgbOvxFLIcznfvWqvXvRVrFusk
         YncDpwYZscappy3yfj4tOJ8JYwd3956My40XIqhUks1ki1b8+2IFsoaeY6S59huzzz6l
         gZvA==
X-Gm-Message-State: APjAAAX/N3f2y11sSOw3OXVObQnYOrIAegNSIPh1p9ofEnDIQP4P8q+g
        TvOaWY/tfpTT1DC082unXg==
X-Google-Smtp-Source: APXvYqwFEz0cSgzBMa14nx65OdZc03ikMmj4IleCPFUvSME4m0USygjxGeiiteyqP2c85Sw1GixCHg==
X-Received: by 2002:a5d:8599:: with SMTP id f25mr8455861ioj.265.1568341928418;
        Thu, 12 Sep 2019 19:32:08 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id n15sm19491178ioa.70.2019.09.12.19.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 19:32:07 -0700 (PDT)
Date:   Thu, 12 Sep 2019 22:32:05 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] drivers: hv: vmbus: Introduce latency testing
Message-ID: <83b5fc34e8f25c882f2502931f766ef547c6c950.1568320416.git.brandonbonaby94@gmail.com>
References: <cover.1568320416.git.brandonbonaby94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568320416.git.brandonbonaby94@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce user specified latency in the packet reception path
By exposing the test parameters as part of the debugfs channel
attributes. We will control the testing state via these attributes.

Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
---
changes in v5:
 - As per Stephen's suggestion, Moved CONFIG_HYPERV_TESTING
   to lib/Kconfig.debug.

 - Fixed build issue reported by Kbuild, with Michael's
   suggestion to make hv_debugfs part of the hv_vmbus
   module.

 - updated debugfs-hyperv to show kernel version 5.4

changes in v4:
 - Combined v3 patch 2 into this patch, and changed the
   commit description to reflect this.

 - Moved debugfs code from "vmbus_drv.c" that was in
   previous v3 patch 2, into a new file "debugfs.c" in
   drivers/hv.

 - Updated the Makefile to compile "debugfs.c" if
   CONFIG_HYPERV_TESTING is enabled

 - As per Michael's comments, added empty implementations
   of the new functions, so the compiler will not generate
   code when CONFIG_HYPERV_TESTING is not enabled.

 - Added microseconds into description for files in
   Documentation/ABI/testing/debugfs-hyperv.

Changes in v2:
 - Add #ifdef in Kconfig file so test code will not interfere
   with non-test code.
 - Move test code functions for delay to hyperv_vmbus header
   file.
 - Wrap test code under #ifdef statement.
 
Documentation/ABI/testing/debugfs-hyperv |  23 +++
 MAINTAINERS                              |   1 +
 drivers/hv/Makefile                      |   1 +
 drivers/hv/connection.c                  |   1 +
 drivers/hv/hv_debugfs.c                  | 185 +++++++++++++++++++++++
 drivers/hv/hyperv_vmbus.h                |  31 ++++
 drivers/hv/ring_buffer.c                 |   2 +
 drivers/hv/vmbus_drv.c                   |   6 +
 include/linux/hyperv.h                   |  19 +++
 lib/Kconfig.debug                        |   7 +
 10 files changed, 276 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hyperv
 create mode 100644 drivers/hv/hv_debugfs.c

diff --git a/Documentation/ABI/testing/debugfs-hyperv b/Documentation/ABI/testing/debugfs-hyperv
new file mode 100644
index 000000000000..4427503ec762
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-hyperv
@@ -0,0 +1,23 @@
+What:           /sys/kernel/debug/hyperv/<UUID>/fuzz_test_state
+Date:           August 2019
+KernelVersion:  5.4
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing status of a vmbus device, whether its in an ON
+                state or a OFF state
+Users:          Debugging tools
+
+What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_buffer_interrupt_delay
+Date:           August 2019
+KernelVersion:  5.4
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing buffer interrupt delay value between 0 - 1000
+		 microseconds (inclusive).
+Users:          Debugging tools
+
+What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_message_delay
+Date:           August 2019
+KernelVersion:  5.4
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing message delay value between 0 - 1000 microseconds
+		 (inclusive).
+Users:          Debugging tools
diff --git a/MAINTAINERS b/MAINTAINERS
index e7a47b5210fd..00831931eb22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7468,6 +7468,7 @@ F:	include/uapi/linux/hyperv.h
 F:	include/asm-generic/mshyperv.h
 F:	tools/hv/
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
+F:	Documentation/ABI/testing/debugfs-hyperv
 
 HYPERBUS SUPPORT
 M:	Vignesh Raghavendra <vigneshr@ti.com>
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index a1eec7177c2d..94daf8240c95 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -9,4 +9,5 @@ CFLAGS_hv_balloon.o = -I$(src)
 hv_vmbus-y := vmbus_drv.o \
 		 hv.o connection.o channel.o \
 		 channel_mgmt.o ring_buffer.o hv_trace.o
+hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 09829e15d4a0..4d4d40832846 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -357,6 +357,7 @@ void vmbus_on_event(unsigned long data)
 
 	trace_vmbus_on_event(channel);
 
+	hv_debug_delay_test(channel, INTERRUPT_DELAY);
 	do {
 		void (*callback_fn)(void *);
 
diff --git a/drivers/hv/hv_debugfs.c b/drivers/hv/hv_debugfs.c
new file mode 100644
index 000000000000..933080b51410
--- /dev/null
+++ b/drivers/hv/hv_debugfs.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Authors:
+ *   Branden Bonaby <brandonbonaby94@gmail.com>
+ */
+
+#include <linux/hyperv.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+
+#include "hyperv_vmbus.h"
+
+struct dentry *hv_debug_root;
+
+static int hv_debugfs_delay_get(void *data, u64 *val)
+{
+	*val = *(u32 *)data;
+	return 0;
+}
+
+static int hv_debugfs_delay_set(void *data, u64 val)
+{
+	int ret = 0;
+
+	if (val >= 0 && val <= 1000)
+		*(u32 *)data = val;
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(hv_debugfs_delay_fops, hv_debugfs_delay_get,
+			 hv_debugfs_delay_set, "%llu\n");
+
+static int hv_debugfs_state_get(void *data, u64 *val)
+{
+	*val = *(bool *)data;
+	return 0;
+}
+
+static int hv_debugfs_state_set(void *data, u64 val)
+{
+	int ret = 0;
+
+	if (val == 1)
+		*(bool *)data = true;
+	else if (val == 0)
+		*(bool *)data = false;
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(hv_debugfs_state_fops, hv_debugfs_state_get,
+			 hv_debugfs_state_set, "%llu\n");
+
+/* Setup delay files to store test values */
+static int hv_debug_delay_files(struct hv_device *dev, struct dentry *root)
+{
+	struct vmbus_channel *channel = dev->channel;
+	char *buffer = "fuzz_test_buffer_interrupt_delay";
+	char *message = "fuzz_test_message_delay";
+	int *buffer_val = &channel->fuzz_testing_interrupt_delay;
+	int *message_val = &channel->fuzz_testing_message_delay;
+	struct dentry *buffer_file, *message_file;
+
+	buffer_file = debugfs_create_file(buffer, 0644, root,
+					  buffer_val,
+					  &hv_debugfs_delay_fops);
+	if (IS_ERR(buffer_file)) {
+		pr_debug("debugfs_hyperv: file %s not created\n", buffer);
+		return PTR_ERR(buffer_file);
+	}
+
+	message_file = debugfs_create_file(message, 0644, root,
+					   message_val,
+					   &hv_debugfs_delay_fops);
+	if (IS_ERR(message_file)) {
+		pr_debug("debugfs_hyperv: file %s not created\n", message);
+		return PTR_ERR(message_file);
+	}
+
+	return 0;
+}
+
+/* Setup test state value for vmbus device */
+static int hv_debug_set_test_state(struct hv_device *dev, struct dentry *root)
+{
+	struct vmbus_channel *channel = dev->channel;
+	bool *state = &channel->fuzz_testing_state;
+	char *status = "fuzz_test_state";
+	struct dentry *test_state;
+
+	test_state = debugfs_create_file(status, 0644, root,
+					 state,
+					 &hv_debugfs_state_fops);
+	if (IS_ERR(test_state)) {
+		pr_debug("debugfs_hyperv: file %s not created\n", status);
+		return PTR_ERR(test_state);
+	}
+
+	return 0;
+}
+
+/* Bind hv device to a dentry for debugfs */
+static void hv_debug_set_dir_dentry(struct hv_device *dev, struct dentry *root)
+{
+	if (hv_debug_root)
+		dev->debug_dir = root;
+}
+
+/* Create all test dentry's and names for fuzz testing */
+int hv_debug_add_dev_dir(struct hv_device *dev)
+{
+	const char *device = dev_name(&dev->device);
+	char *delay_name = "delay";
+	struct dentry *delay, *dev_root;
+	int ret;
+
+	if (!IS_ERR(hv_debug_root)) {
+		dev_root = debugfs_create_dir(device, hv_debug_root);
+		if (IS_ERR(dev_root)) {
+			pr_debug("debugfs_hyperv: hyperv/%s/ not created\n",
+				 device);
+			return PTR_ERR(dev_root);
+		}
+		hv_debug_set_test_state(dev, dev_root);
+		hv_debug_set_dir_dentry(dev, dev_root);
+		delay = debugfs_create_dir(delay_name, dev_root);
+
+		if (IS_ERR(delay)) {
+			pr_debug("debugfs_hyperv: hyperv/%s/%s/ not created\n",
+				 device, delay_name);
+			return PTR_ERR(delay);
+		}
+		ret = hv_debug_delay_files(dev, delay);
+
+		return ret;
+	}
+	pr_debug("debugfs_hyperv: hyperv/ not in root debugfs path\n");
+	return PTR_ERR(hv_debug_root);
+}
+
+/* Remove dentry associated with released hv device */
+void hv_debug_rm_dev_dir(struct hv_device *dev)
+{
+	if (!IS_ERR(hv_debug_root))
+		debugfs_remove_recursive(dev->debug_dir);
+}
+
+/* Remove all dentrys associated with vmbus testing */
+void hv_debug_rm_all_dir(void)
+{
+	debugfs_remove_recursive(hv_debug_root);
+}
+
+/* Delay buffer/message reads on a vmbus channel */
+void hv_debug_delay_test(struct vmbus_channel *channel, enum delay delay_type)
+{
+	struct vmbus_channel *test_channel =    channel->primary_channel ?
+						channel->primary_channel :
+						channel;
+	bool state = test_channel->fuzz_testing_state;
+
+	if (state) {
+		if (delay_type == 0)
+			udelay(test_channel->fuzz_testing_interrupt_delay);
+		else
+			udelay(test_channel->fuzz_testing_message_delay);
+	}
+}
+
+/* Initialize top dentry for vmbus testing */
+int hv_debug_init(void)
+{
+	hv_debug_root = debugfs_create_dir("hyperv", NULL);
+	if (IS_ERR(hv_debug_root)) {
+		pr_debug("debugfs_hyperv: hyperv/ not created\n");
+		return PTR_ERR(hv_debug_root);
+	}
+	return 0;
+}
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index fb16a622e8ab..642f609b0e26 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -355,4 +355,35 @@ enum hvutil_device_state {
 	HVUTIL_DEVICE_DYING,     /* driver unload is in progress */
 };
 
+enum delay {
+	INTERRUPT_DELAY = 0,
+	MESSAGE_DELAY   = 1,
+};
+
+#ifdef CONFIG_HYPERV_TESTING
+
+int hv_debug_add_dev_dir(struct hv_device *dev);
+void hv_debug_rm_dev_dir(struct hv_device *dev);
+void hv_debug_rm_all_dir(void);
+int hv_debug_init(void);
+void hv_debug_delay_test(struct vmbus_channel *channel, enum delay delay_type);
+
+#else /* CONFIG_HYPERV_TESTING */
+
+static inline void hv_debug_rm_dev_dir(struct hv_device *dev) {};
+static inline void hv_debug_rm_all_dir(void) {};
+static inline void hv_debug_delay_test(struct vmbus_channel *channel,
+				       enum delay delay_type) {};
+static inline int hv_debug_init(void)
+{
+	return -1;
+}
+
+static inline int hv_debug_add_dev_dir(struct hv_device *dev)
+{
+	return -1;
+}
+
+#endif /* CONFIG_HYPERV_TESTING */
+
 #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 9a03b163cbbd..356e22159e83 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -396,6 +396,7 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct vmbus_channel *channel)
 	struct hv_ring_buffer_info *rbi = &channel->inbound;
 	struct vmpacket_descriptor *desc;
 
+	hv_debug_delay_test(channel, MESSAGE_DELAY);
 	if (hv_pkt_iter_avail(rbi) < sizeof(struct vmpacket_descriptor))
 		return NULL;
 
@@ -421,6 +422,7 @@ __hv_pkt_iter_next(struct vmbus_channel *channel,
 	u32 packetlen = desc->len8 << 3;
 	u32 dsize = rbi->ring_datasize;
 
+	hv_debug_delay_test(channel, MESSAGE_DELAY);
 	/* bump offset to next potential packet */
 	rbi->priv_read_index += packetlen + VMBUS_PKT_TRAILER;
 	if (rbi->priv_read_index >= dsize)
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index ebd35fc35290..8b2e2352fc6c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -919,6 +919,8 @@ static void vmbus_device_release(struct device *device)
 	struct hv_device *hv_dev = device_to_hv_device(device);
 	struct vmbus_channel *channel = hv_dev->channel;
 
+	hv_debug_rm_dev_dir(hv_dev);
+
 	mutex_lock(&vmbus_connection.channel_mutex);
 	hv_process_channel_removal(channel);
 	mutex_unlock(&vmbus_connection.channel_mutex);
@@ -1727,6 +1729,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 		pr_err("Unable to register primary channeln");
 		goto err_kset_unregister;
 	}
+	hv_debug_add_dev_dir(child_device_obj);
 
 	return 0;
 
@@ -2108,6 +2111,7 @@ static int __init hv_acpi_init(void)
 		ret = -ETIMEDOUT;
 		goto cleanup;
 	}
+	hv_debug_init();
 
 	ret = vmbus_bus_init();
 	if (ret)
@@ -2140,6 +2144,8 @@ static void __exit vmbus_exit(void)
 
 		tasklet_kill(&hv_cpu->msg_dpc);
 	}
+	hv_debug_rm_all_dir();
+
 	vmbus_free_channels();
 
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 6256cc34c4a6..6d815f14d97f 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -926,6 +926,21 @@ struct vmbus_channel {
 	 * full outbound ring buffer.
 	 */
 	u64 out_full_first;
+
+	/* enabling/disabling fuzz testing on the channel (default is false)*/
+	bool fuzz_testing_state;
+
+	/*
+	 * Interrupt delay will delay the guest from emptying the ring buffer
+	 * for a specific amount of time. The delay is in microseconds and will
+	 * be between 1 to a maximum of 1000, its default is 0 (no delay).
+	 * The  Message delay will delay guest reading on a per message basis
+	 * in microseconds between 1 to 1000 with the default being 0
+	 * (no delay).
+	 */
+	u32 fuzz_testing_interrupt_delay;
+	u32 fuzz_testing_message_delay;
+
 };
 
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
@@ -1166,6 +1181,10 @@ struct hv_device {
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
+
+	/* place holder to keep track of the dir for hv device in debugfs */
+	struct dentry *debug_dir;
+
 };
 
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..2965ac8257f7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2144,4 +2144,11 @@ config IO_STRICT_DEVMEM
 
 source "arch/$(SRCARCH)/Kconfig.debug"
 
+config HYPERV_TESTING
+	bool "Microsoft Hyper-V driver testing"
+	default n
+	depends on HYPERV && DEBUG_FS
+	help
+	  Select this option to enable Hyper-V vmbus testing.
+
 endmenu # Kernel hacking
-- 
2.17.1

