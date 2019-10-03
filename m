Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F59CB0BF
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2019 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfJCVBx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Oct 2019 17:01:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42149 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfJCVBw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Oct 2019 17:01:52 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so8780060iod.9;
        Thu, 03 Oct 2019 14:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0z+NsNFbeCfNLWMInd8Bqsjq6CUDesjwxPFVKSb4B4Y=;
        b=NbtvPnrEb0Gz9ZFaMOHN/QoBqbhXjKC/3E3JiP0qfluYa4zuAl25r4fd1VCS20/C04
         V27/KRN/gZsYQxCug8NSLUsrewQP+VSFSgWzln9EmE7N0lMMQZm7JODCS6LSVgvNxz7G
         3gUOblFS1LwEiVEkYkg4ySHUXnVPbZJrTe/BseUusQkQi5SJ+3E+ybg4ctQeKUxwVPNL
         utQt4S0jZGaBtcE72gYuhzsmCyVNxcBvmHuDFUISEI+8f7PxgtHKUOBUTWmH65EqCMFc
         NsNnwjTpLkx9HuB/eKnAeMnnCbBX3n3zlJSsIRLbHFDqZITnVpQvmBdhs7EZXyNMREi7
         Pi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0z+NsNFbeCfNLWMInd8Bqsjq6CUDesjwxPFVKSb4B4Y=;
        b=SvUJQrvQ7dCcOkPa4z7PCuZXYtOqriRM82CEF4YTSB8G6QusPwxi1qLKXWarFpDtsZ
         uX1y1jfnO/zJEb1vvAKQPXl41Oe8nPa+JRvI15RRtc9Tpf2Mttb2LjPesl3+Wl5YZCPE
         3DD5sPSvVL05ywsYkCXBxyArMwGB9n+9sNRrxTGBcRy2AAIrLTAUWCOAmEhg9IbF5JUp
         L2EVwO+uN29ObIWlqHTTnX47jvdGJG9alTmpVw5llZNT5tma1xoLnU5Pq7hrJNya7lrJ
         HxaQFrqoS0GCd7yqHoNgKBamI7T6Ze6SuAtPZCcGslBtJBkIQL9q1TPYoUQDnp/grie8
         +0bw==
X-Gm-Message-State: APjAAAW21Knf5agvcic+oRVD8qBDev8udqWXAhxiWXto45dT9ZYVByhb
        w5d5DQSvrXVRGJqhmZK4knNUzgo/PM7v
X-Google-Smtp-Source: APXvYqz81WS68aqRN2OJRbSOqnS32oDZFSpg2Cb9qaGEOaM3NuRNOhp7A0VIh6nlDKUvSvo7wUGvBw==
X-Received: by 2002:a92:8f93:: with SMTP id r19mr11755742ilk.94.1570136511435;
        Thu, 03 Oct 2019 14:01:51 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id i26sm1465635iol.84.2019.10.03.14.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 14:01:51 -0700 (PDT)
Date:   Thu, 3 Oct 2019 17:01:49 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] drivers: hv: vmbus: Introduce latency testing
Message-ID: <d3e32c4995c8e4992fab91c3e43c2b0d6a3ef0f2.1570130325.git.brandonbonaby94@gmail.com>
References: <cover.1570130325.git.brandonbonaby94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570130325.git.brandonbonaby94@gmail.com>
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
changes in v6:
 - changed kernel version in
   Documentation/ABI/testing/debugfs-hyperv to 5.5

 - removed less than 0 if statement when dealing with
   u64 datatype, as suggested by Michael.

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
 drivers/hv/hv_debugfs.c                  | 178 +++++++++++++++++++++++
 drivers/hv/hyperv_vmbus.h                |  31 ++++
 drivers/hv/ring_buffer.c                 |   2 +
 drivers/hv/vmbus_drv.c                   |   6 +
 include/linux/hyperv.h                   |  19 +++
 lib/Kconfig.debug                        |   7 +
 10 files changed, 269 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hyperv
 create mode 100644 drivers/hv/hv_debugfs.c

diff --git a/Documentation/ABI/testing/debugfs-hyperv b/Documentation/ABI/testing/debugfs-hyperv
new file mode 100644
index 000000000000..9185e1b06bba
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-hyperv
@@ -0,0 +1,23 @@
+What:           /sys/kernel/debug/hyperv/<UUID>/fuzz_test_state
+Date:           October 2019
+KernelVersion:  5.5
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing status of a vmbus device, whether its in an ON
+                state or a OFF state
+Users:          Debugging tools
+
+What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_buffer_interrupt_delay
+Date:           October 2019
+KernelVersion:  5.5
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing buffer interrupt delay value between 0 - 1000
+		 microseconds (inclusive).
+Users:          Debugging tools
+
+What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_message_delay
+Date:           October 2019
+KernelVersion:  5.5
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing message delay value between 0 - 1000 microseconds
+		 (inclusive).
+Users:          Debugging tools
diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef7fa74..9801b1924213 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7581,6 +7581,7 @@ F:	include/uapi/linux/hyperv.h
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
index 6e4c015783ff..7001b1ab4cdd 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -361,6 +361,7 @@ void vmbus_on_event(unsigned long data)
 
 	trace_vmbus_on_event(channel);
 
+	hv_debug_delay_test(channel, INTERRUPT_DELAY);
 	do {
 		void (*callback_fn)(void *);
 
diff --git a/drivers/hv/hv_debugfs.c b/drivers/hv/hv_debugfs.c
new file mode 100644
index 000000000000..8a2878573582
--- /dev/null
+++ b/drivers/hv/hv_debugfs.c
@@ -0,0 +1,178 @@
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
+	if (val > 1000)
+		return -EINVAL;
+	*(u32 *)data = val;
+	return 0;
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
+	if (val == 1)
+		*(bool *)data = true;
+	else if (val == 0)
+		*(bool *)data = false;
+	else
+		return -EINVAL;
+	return 0;
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
index af9379a3bf89..20edcfd3b96c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -385,4 +385,35 @@ enum hvutil_device_state {
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
index 391f0b225c9a..e785dd485b9b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -958,6 +958,8 @@ static void vmbus_device_release(struct device *device)
 	struct hv_device *hv_dev = device_to_hv_device(device);
 	struct vmbus_channel *channel = hv_dev->channel;
 
+	hv_debug_rm_dev_dir(hv_dev);
+
 	mutex_lock(&vmbus_connection.channel_mutex);
 	hv_process_channel_removal(channel);
 	mutex_unlock(&vmbus_connection.channel_mutex);
@@ -1810,6 +1812,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 		pr_err("Unable to register primary channeln");
 		goto err_kset_unregister;
 	}
+	hv_debug_add_dev_dir(child_device_obj);
 
 	return 0;
 
@@ -2369,6 +2372,7 @@ static int __init hv_acpi_init(void)
 		ret = -ETIMEDOUT;
 		goto cleanup;
 	}
+	hv_debug_init();
 
 	ret = vmbus_bus_init();
 	if (ret)
@@ -2405,6 +2409,8 @@ static void __exit vmbus_exit(void)
 
 		tasklet_kill(&hv_cpu->msg_dpc);
 	}
+	hv_debug_rm_all_dir();
+
 	vmbus_free_channels();
 
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index b4a017093b69..ac66577852d1 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -932,6 +932,21 @@ struct vmbus_channel {
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
@@ -1180,6 +1195,10 @@ struct hv_device {
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
+
+	/* place holder to keep track of the dir for hv device in debugfs */
+	struct dentry *debug_dir;
+
 };
 
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 93d97f9b0157..55eebbc0b0fb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2127,4 +2127,11 @@ config IO_STRICT_DEVMEM
 
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

