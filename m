Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAE87E3B4
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2019 22:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbfHAUAq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Aug 2019 16:00:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42162 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbfHAUAq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Aug 2019 16:00:46 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so14142699iob.9;
        Thu, 01 Aug 2019 13:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZ/k1YpqBqPUtIriBQ3SSOsNy8Mu5ImeDRFRPIUUC9s=;
        b=Lc7dAfWCJlmbooSusgOoku7AXiWfCN/2FfB0bwWxDNFgEnHRAgs81XsJ/uRmlz+h77
         yBpE+p/ZhgTUpetgWjOiYDbAP8f8rto0Sz4G3NzHossYId0pb1Gq+QUOkwYwVLUHSHFa
         YC6OQ6iKQ0dTNyUvks0lAFLWfpt0VCnQsSbl+bOvHGCJLhla/VT5XOIPi6DxHPFawiQo
         k8XNMZjFUKyb9AGZb7GObqxHObhU0oErMqZyRd4sdXRWbWWqNDVYTqLSwLcjyvCZW87K
         bazkso/H6eOs/0UB7SOpC/dJBJyXjUDgxm9zR/dOoOCYI/VXzITxnwO+p4WmR1g4ZyEZ
         97/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZ/k1YpqBqPUtIriBQ3SSOsNy8Mu5ImeDRFRPIUUC9s=;
        b=srWkh8xFlvP3e5KMUs81cx4AeZ9ec9YajYBZy+u03UAVPGjoy1fc0injGKieIOGw6+
         z/hsvPPuTwf1oj++MJjszfXYwUrB+acOPkUhHiaMXQqiGmAK+Ib7PsFute2M51QfHBvE
         4FJZ2iOhXjpXXSgt5l5Ch+BuI4IPgS9CiVE65TQJuMQQT3Q6rUMax5eFR9vNujuVtz1x
         bPP5JTvUH/3m0D3CuLre1rVm4PSiIrKXXPUWl2ZSuREgzyJm6g9YaVURqSh86JTORGKu
         94oZcug91WyD/GrurG/vJQ5SeSktD6C0tAuOmil2fwi8VbALKH8z4mX6JwtG4gSIph92
         9LCw==
X-Gm-Message-State: APjAAAW7VXyUZC6c4BkS2JTJFPlBVijJFtWTsbK3Z2r5Iue9CZUR6L+G
        H2NErvkO99oM/Zc7eTvzHHvsdWBPq9Rf
X-Google-Smtp-Source: APXvYqwYa7QQGbGhAG02Au1jpK+hVl3mHis1fnPhvPBVZ701PQdEmTwP4Zc/IifIxnENWOnRrm4XBw==
X-Received: by 2002:a6b:c081:: with SMTP id q123mr45571755iof.210.1564689645008;
        Thu, 01 Aug 2019 13:00:45 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id h8sm65604751ioq.61.2019.08.01.13.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 13:00:44 -0700 (PDT)
Date:   Thu, 1 Aug 2019 16:00:42 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drivers: hv: vmbus: add fuzz test attributes to sysfs
Message-ID: <20f96dba927eaa42fceeebfc7a6a37f3b1a9ee65.1564527684.git.brandonbonaby94@gmail.com>
References: <cover.1564527684.git.brandonbonaby94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1564527684.git.brandonbonaby94@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Expose the test parameters as part of the sysfs channel attributes.
We will control the testing state via these attributes.

Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
---
 Documentation/ABI/stable/sysfs-bus-vmbus | 22 ++++++
 drivers/hv/vmbus_drv.c                   | 97 +++++++++++++++++++++++-
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 8e8d167eca31..239fcb6fdc75 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -185,3 +185,25 @@ Contact:        Michael Kelley <mikelley@microsoft.com>
 Description:    Total number of write operations that encountered an outbound
 		ring buffer full condition
 Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/fuzz_test_state
+Date:           July 2019
+KernelVersion:  5.2
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing status of a vmbus device, whether its in an ON
+		 state or a OFF state
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/fuzz_test_buffer_delay
+Date:           July 2019
+KernelVersion:  5.2
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing buffer delay value between 0 - 1000
+Users:          Debugging tools
+
+What:           /sys/bus/vmbus/devices/<UUID>/fuzz_test_message_delay
+Date:           July 2019
+KernelVersion:  5.2
+Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
+Description:    Fuzz testing message delay value between 0 - 1000
+Users:          Debugging tools
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 92b1874b3eb3..0c71fd66ef81 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -22,7 +22,7 @@
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/sched/task_stack.h>
-
+#include <linux/kernel.h>
 #include <asm/mshyperv.h>
 #include <linux/notifier.h>
 #include <linux/ptrace.h>
@@ -584,6 +584,98 @@ static ssize_t driver_override_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
+static ssize_t fuzz_test_state_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+	struct vmbus_channel *channel = hv_dev->channel;
+	int state;
+	int delay = kstrtoint(buf, 0, &state);
+
+	if (delay)
+		return count;
+	if (state)
+		channel->fuzz_testing_state = 1;
+	else
+		channel->fuzz_testing_state = 0;
+	return count;
+}
+
+static ssize_t fuzz_test_state_show(struct device *dev,
+				    struct device_attribute *dev_attr,
+				    char *buf)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+	struct vmbus_channel *channel = hv_dev->channel;
+
+	return sprintf(buf, "%u\n", channel->fuzz_testing_state);
+}
+static DEVICE_ATTR_RW(fuzz_test_state);
+
+static ssize_t fuzz_test_buffer_delay_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+	struct vmbus_channel *channel = hv_dev->channel;
+	int val;
+	int delay = kstrtoint(buf, 0, &val);
+
+	if (delay)
+		return count;
+	if (val >= 1 && val <= 1000)
+		channel->fuzz_testing_buffer_delay = val;
+	/*Best to not use else statement here since we want
+	 *the buffer delay to remain the same if val > 1000
+	 */
+	else if (val <= 0)
+		channel->fuzz_testing_buffer_delay = 0;
+	return count;
+}
+
+static ssize_t fuzz_test_buffer_delay_show(struct device *dev,
+					   struct device_attribute *dev_attr,
+					   char *buf)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+	struct vmbus_channel *channel = hv_dev->channel;
+
+	return sprintf(buf, "%u\n", channel->fuzz_testing_buffer_delay);
+}
+static DEVICE_ATTR_RW(fuzz_test_buffer_delay);
+
+static ssize_t fuzz_test_message_delay_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+	struct vmbus_channel *channel = hv_dev->channel;
+	int val;
+	int delay = kstrtoint(buf, 0, &val);
+
+	if (delay)
+		return count;
+	if (val >= 1 && val <= 1000)
+		channel->fuzz_testing_message_delay = val;
+	/*Best to not use else statement here since we want
+	 *the message delay to remain the same if val > 1000
+	 */
+	else if (val <= 0)
+		channel->fuzz_testing_message_delay = 0;
+	return count;
+}
+
+static ssize_t fuzz_test_message_delay_show(struct device *dev,
+					    struct device_attribute *dev_attr,
+					    char *buf)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+	struct vmbus_channel *channel = hv_dev->channel;
+
+	return sprintf(buf, "%u\n", channel->fuzz_testing_message_delay);
+}
+static DEVICE_ATTR_RW(fuzz_test_message_delay);
 /* Set up per device attributes in /sys/bus/vmbus/devices/<bus device> */
 static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_id.attr,
@@ -615,6 +707,9 @@ static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
 	&dev_attr_driver_override.attr,
+	&dev_attr_fuzz_test_state.attr,
+	&dev_attr_fuzz_test_buffer_delay.attr,
+	&dev_attr_fuzz_test_message_delay.attr,
 	NULL,
 };
 
-- 
2.17.1

