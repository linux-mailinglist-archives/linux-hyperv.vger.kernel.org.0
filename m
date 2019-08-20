Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004AC9548D
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 04:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfHTCow (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 22:44:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46177 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHTCow (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 22:44:52 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so8919019iog.13;
        Mon, 19 Aug 2019 19:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b2xhhjgVK+DXu0Mi3xrbWK9K1B+VSKD5toNBjakHNrk=;
        b=pAa9xk9MRQx5iyjZ8THZbiIquWfDRoAqUxbTHZEx4deg7Wfxt2yg5Otu/HlziChFim
         +PQ47YuwMX1okzUmqx2CHjjhigTIEitfpQPavGgME+LqxFYvAl5A2VHgMDHRSwkjPycW
         sg2ePJQp2aaBxgLC8HahKw1Rk98HtV5iJgyGDMnQ1wgsZq7/BCf+RDTuAM4OxY35YJO9
         q2yMGvdUD9xgNvkTtr9zCkXCe6qji9Sriol2SUn12TW/5lPn1lGHdUOOb5xI99rB+yzM
         /waXyB9y5xVcOFzRWUh2yIjX6Cw+xjlrpDtNoXUxCLLLT611CHahaUYfgNzr8Fyr32Xs
         h/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b2xhhjgVK+DXu0Mi3xrbWK9K1B+VSKD5toNBjakHNrk=;
        b=Rzz+ydo9+O3dr2WCXn0rnrEDwo/JCuCUKqhRZgozYfB7Yta2+yZUBfzwGBiFqRvB+Q
         gsv90FKQ8rJ0z34FxNkel88UrJOcTtiBzP/XZyjfhmgr6OgH8hv5kGJLk11jczIC/pkG
         UZdmoqyzHJgXHHjGq+TGc0nbgQbE5J49m3wly09sTSbJGjg+MQN8Np1757Wx6YYsohnF
         xLMjtJxX4oZeECJbuDemmc3xZn4YEethi+mtFt74iyqs4OqupeZ9F4oKZ3LFEzx+ZUa3
         GnSGdoyKBMteJUIii5otTs010pTqG51uJYvcrdgLBM0JjvZ0hp11IiVmk/kRGVn82AqX
         vR9A==
X-Gm-Message-State: APjAAAU8Pel02H9RFD7kiukrfjyjn0F+ZXbn+maHkADT2V8TlhvqSEfg
        UR2JVChQfIyceWddXM4WuArGq8I6dsx5
X-Google-Smtp-Source: APXvYqxtd0ss7ee78BGJjQOzstQC/Cxs63E3e4Foz7dtviKhPw2gwkX6lByBGp/iXzVxOTIZLG6wJw==
X-Received: by 2002:a02:85c7:: with SMTP id d65mr1253111jai.8.1566269090676;
        Mon, 19 Aug 2019 19:44:50 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id k2sm12411241iom.50.2019.08.19.19.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 19:44:50 -0700 (PDT)
Date:   Mon, 19 Aug 2019 22:44:48 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drivers: hv: vmbus: add test attributes to debugfs
Message-ID: <e055f27ffc37a9a6a756a3329a60da608db5a04f.1566266609.git.brandonbonaby94@gmail.com>
References: <cover.1566266609.git.brandonbonaby94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566266609.git.brandonbonaby94@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Expose the test parameters as part of the debugfs channel attributes.
We will control the testing state via these attributes.

Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
---
Changes in v2:
 - Move test attributes to debugfs.
 - Wrap test code under #ifdef statements.
 - Add new documentation file under Documentation/ABI/testing.
 - Make commit message reflect the change from from sysfs to debugfs.
 
 Documentation/ABI/testing/debugfs-hyperv |  21 +++
 MAINTAINERS                              |   1 +
 drivers/hv/vmbus_drv.c                   | 167 +++++++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hyperv

diff --git a/Documentation/ABI/testing/debugfs-hyperv b/Documentation/ABI/testing/debugfs-hyperv
new file mode 100644
index 000000000000..b25f751fafa8
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-hyperv
@@ -0,0 +1,21 @@
+What:           /sys/kernel/debug/hyperv/<UUID>/fuzz_test_state
+Date:           August 2019
+KernelVersion:  5.3
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing status of a vmbus device, whether its in an ON
+                state or a OFF state
+Users:          Debugging tools
+
+What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_buffer_interrupt_delay
+Date:           August 2019
+KernelVersion:  5.3
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing buffer delay value between 0 - 1000
+Users:          Debugging tools
+
+What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_message_delay
+Date:           August 2019
+KernelVersion:  5.3
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing message delay value between 0 - 1000
+Users:          Debugging tools
diff --git a/MAINTAINERS b/MAINTAINERS
index e81e60bd7c26..120284a8185f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7460,6 +7460,7 @@ F:	include/uapi/linux/hyperv.h
 F:	include/asm-generic/mshyperv.h
 F:	tools/hv/
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
+F:	Documentation/ABI/testing/debugfs-hyperv
 
 HYPERBUS SUPPORT
 M:	Vignesh Raghavendra <vigneshr@ti.com>
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index ebd35fc35290..b6d023ae9664 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -919,6 +919,10 @@ static void vmbus_device_release(struct device *device)
 	struct hv_device *hv_dev = device_to_hv_device(device);
 	struct vmbus_channel *channel = hv_dev->channel;
 
+#ifdef CONFIG_HYPERV_TESTING
+	hv_debug_rm_dev_dir(hv_dev);
+#endif /* CONFIG_HYPERV_TESTING */
+
 	mutex_lock(&vmbus_connection.channel_mutex);
 	hv_process_channel_removal(channel);
 	mutex_unlock(&vmbus_connection.channel_mutex);
@@ -1727,6 +1731,9 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 		pr_err("Unable to register primary channeln");
 		goto err_kset_unregister;
 	}
+#ifdef CONFIG_HYPERV_TESTING
+	hv_debug_add_dev_dir(child_device_obj);
+#endif /* CONFIG_HYPERV_TESTING */
 
 	return 0;
 
@@ -2086,6 +2093,159 @@ static void hv_crash_handler(struct pt_regs *regs)
 	hyperv_cleanup();
 };
 
+#ifdef CONFIG_HYPERV_TESTING
+
+struct dentry *hv_root;
+
+static int hv_debugfs_delay_get(void *data, u64 *val)
+{
+	*val = *(u32 *)data;
+	return 0;
+}
+
+static int hv_debugfs_delay_set(void *data, u64 val)
+{
+	if (val >= 1 && val <= 1000)
+		*(u32 *)data = val;
+	/*Best to not use else statement here since we want
+	 * the delay to remain the same if val > 1000
+	 */
+	else if (val <= 0)
+		*(u32 *)data = 0;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(hv_debugfs_delay_fops, hv_debugfs_delay_get,
+			 hv_debugfs_delay_set, "%llu\n");
+
+/* Setup delay files to store test values */
+int hv_debug_delay_files(struct hv_device *dev, struct dentry *root)
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
+int hv_debug_set_test_state(struct hv_device *dev, struct dentry *root)
+{
+	struct vmbus_channel *channel = dev->channel;
+	bool *state = &channel->fuzz_testing_state;
+	char *status = "fuzz_test_state";
+	struct dentry *test_state;
+
+	test_state = debugfs_create_bool(status, 0644, root, state);
+	if (IS_ERR(test_state)) {
+		pr_debug("debugfs_hyperv: file %s not created\n", status);
+		return PTR_ERR(test_state);
+	}
+
+	return 0;
+}
+
+/* Bind hv device to a dentry for debugfs */
+void hv_debug_set_dir_dentry(struct hv_device *dev, struct dentry *root)
+{
+	if (hv_root)
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
+	if (!IS_ERR(hv_root)) {
+		dev_root = debugfs_create_dir(device, hv_root);
+		if (IS_ERR_OR_NULL(dev_root)) {
+			pr_debug("debugfs_hyperv: %s/%s/ not created\n",
+				 TESTING, device);
+			return PTR_ERR(dev_root);
+		}
+
+		hv_debug_set_test_state(dev, dev_root);
+		hv_debug_set_dir_dentry(dev, dev_root);
+		delay = debugfs_create_dir(delay_name, dev_root);
+
+		if (IS_ERR(delay)) {
+			pr_debug("debugfs_hyperv: %s/%s/%s/ not created\n",
+				 TESTING, device, delay_name);
+			return PTR_ERR(delay);
+		}
+		ret = hv_debug_delay_files(dev, delay);
+
+		return ret;
+	}
+	pr_debug("debugfs_hyperv: %s/ not in root debugfs path\n", TESTING);
+	return PTR_ERR(hv_root);
+}
+
+/* Remove dentry associated with released hv device */
+void hv_debug_rm_dev_dir(struct hv_device *dev)
+{
+	if (!IS_ERR(hv_root))
+		debugfs_remove_recursive(dev->debug_dir);
+}
+
+/* Remove all dentrys associated with vmbus testing */
+void hv_debug_rm_all_dir(void)
+{
+	debugfs_remove_recursive(hv_root);
+}
+
+/* Delay buffer/message reads on a vmbus channel */
+void hv_debug_delay_test(struct vmbus_channel *channel, enum delay delay_type)
+{
+	struct vmbus_channel *test_channel =	channel->primary_channel ?
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
+	hv_root = debugfs_create_dir(TESTING, NULL);
+	if (IS_ERR(hv_root)) {
+		pr_debug("debugfs_hyperv: %s/ not created\n", TESTING);
+		return PTR_ERR(hv_root);
+	}
+
+	return 0;
+}
+#endif /* CONFIG_HYPERV_TESTING */
+
 static int __init hv_acpi_init(void)
 {
 	int ret, t;
@@ -2108,6 +2268,9 @@ static int __init hv_acpi_init(void)
 		ret = -ETIMEDOUT;
 		goto cleanup;
 	}
+#ifdef CONFIG_HYPERV_TESTING
+	hv_debug_init();
+#endif /* CONFIG_HYPERV_TESTING */
 
 	ret = vmbus_bus_init();
 	if (ret)
@@ -2140,6 +2303,10 @@ static void __exit vmbus_exit(void)
 
 		tasklet_kill(&hv_cpu->msg_dpc);
 	}
+#ifdef CONFIG_HYPERV_TESTING
+	hv_debug_rm_all_dir();
+#endif /* CONFIG_HYPERV_TESTING */
+
 	vmbus_free_channels();
 
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
-- 
2.17.1

