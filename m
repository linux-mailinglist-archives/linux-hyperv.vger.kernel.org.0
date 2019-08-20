Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C00096DDA
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Aug 2019 01:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfHTXjG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Aug 2019 19:39:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37683 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfHTXjG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 19:39:06 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so929988iog.4;
        Tue, 20 Aug 2019 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K6vNNx0KW4YWTm/W7PwoxMoYQobTA64O0AG22feNt8k=;
        b=rojYidA4bucZJL8NXToRSCRLr6RNBF+MwUI6JQcedov6wPJbQvhLxvQENDURLeBm/u
         MsMQ6H5rR3VuLk6A5EKBpNLsw7wtYCZSeqU6avCvkq665Xyw+xmb2Z8m3eo2np3AEa/S
         haQSl10QYxgEgVwCGV4UQehK93Gdc4LFFpaGUm0e+v/xSWMHsPWI5DX+QkCHwGwj6JW7
         GU3ys3ylen8S3bDvl3jkujHJ5cc32+uaF3fVTfDUx9vOyS3a5EXeNwCrDgEH9ro49X6A
         gHymvloV/VfnoB3F/q1WXwLIdWPgvh3J3/BjICdecvcB0HsdJFTbojttf7aqraM+2qVn
         +8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K6vNNx0KW4YWTm/W7PwoxMoYQobTA64O0AG22feNt8k=;
        b=WX0K9uQrp+My4miUjbTgSsSxIs1mShF6RaFD1dMvrHYqEBeAqQYBKfz+4Z3Vb3jcHN
         V39WZWBOTAbOSbXVEzbJssgR6XgrsJt4UGmI8uOIqqsyet7Er4HU3pICNuq347GADf41
         AF5K9gXM3yVsVMNOAuuXFMQ8/K6lwmjN9iKlp7/FfGi6ivmvAZZGiNqWZrncrcI+/YOX
         xTz6GCYmH3nbsh1jMe4d9Si5jYIH8F2qAzbG14vk5jGRa9gT8kxI1hWM0c3xXPjsVMwI
         O7sEg/IDkobYqOH8yQ2sgdZCFIX1NGtL7zUAS42KaCz24FOeTFDZ2wWvdr6ZpEgIkC3Q
         jAmA==
X-Gm-Message-State: APjAAAXlUjNl8pG8ntwYtSwcg06vsp6uybcyPbEV5E+7AlHjchKaFc8v
        b7M2UMcqaxnJ2Zint293xA==
X-Google-Smtp-Source: APXvYqyfO0/faFbUDwCd2PibnsTJKHh8jRJIPtVF9OYiTA3IF34MjVJCiqcFAoEnXy+X0SJQA2Ug7Q==
X-Received: by 2002:a6b:f203:: with SMTP id q3mr1543169ioh.208.1566344345061;
        Tue, 20 Aug 2019 16:39:05 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id c3sm8044045iot.42.2019.08.20.16.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 16:39:04 -0700 (PDT)
Date:   Tue, 20 Aug 2019 19:39:02 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] drivers: hv: vmbus: Introduce latency testing
Message-ID: <ebca54bf70d2af53de419c1b7ac8db5b77b888cb.1566340843.git.brandonbonaby94@gmail.com>
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

Introduce user specified latency in the packet reception path.

Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
---
Changes in v2:
 - Add #ifdef in Kconfig file so test code will not interfere
   with non-test code.
 - Move test code functions for delay to hyperv_vmbus header
   file.
 - Wrap test code under #ifdef statement. 

 drivers/hv/Kconfig        |  7 +++++++
 drivers/hv/connection.c   |  3 +++
 drivers/hv/hyperv_vmbus.h | 20 ++++++++++++++++++++
 drivers/hv/ring_buffer.c  |  7 +++++++
 include/linux/hyperv.h    | 21 +++++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 9a59957922d4..d97437ba0626 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -29,4 +29,11 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+config HYPERV_TESTING
+        bool "Hyper-V testing"
+        default n
+        depends on HYPERV && DEBUG_FS
+        help
+          Select this option to enable Hyper-V vmbus testing.
+
 endmenu
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 09829e15d4a0..c9c63a4033cd 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -357,6 +357,9 @@ void vmbus_on_event(unsigned long data)
 
 	trace_vmbus_on_event(channel);
 
+#ifdef CONFIG_HYPERV_TESTING
+	hv_debug_delay_test(channel, INTERRUPT_DELAY);
+#endif /* CONFIG_HYPERV_TESTING */
 	do {
 		void (*callback_fn)(void *);
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 362e70e9d145..edf14f596d8c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -357,4 +357,24 @@ enum hvutil_device_state {
 	HVUTIL_DEVICE_DYING,     /* driver unload is in progress */
 };
 
+#ifdef CONFIG_HYPERV_TESTING
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#define TESTING "hyperv"
+
+enum delay {
+	INTERRUPT_DELAY	= 0,
+	MESSAGE_DELAY   = 1,
+};
+
+int hv_debug_delay_files(struct hv_device *dev, struct dentry *root);
+int hv_debug_add_dev_dir(struct hv_device *dev);
+void hv_debug_rm_dev_dir(struct hv_device *dev);
+void hv_debug_rm_all_dir(void);
+void hv_debug_set_dir_dentry(struct hv_device *dev, struct dentry *root);
+void hv_debug_delay_test(struct vmbus_channel *channel, enum delay delay_type);
+
+#endif /* CONFIG_HYPERV_TESTING */
+
 #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 9a03b163cbbd..51adda23b398 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -396,6 +396,10 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct vmbus_channel *channel)
 	struct hv_ring_buffer_info *rbi = &channel->inbound;
 	struct vmpacket_descriptor *desc;
 
+#ifdef CONFIG_HYPERV_TESTING
+	hv_debug_delay_test(channel, MESSAGE_DELAY);
+#endif /* CONFIG_HYPERV_TESTING */
+
 	if (hv_pkt_iter_avail(rbi) < sizeof(struct vmpacket_descriptor))
 		return NULL;
 
@@ -421,6 +425,9 @@ __hv_pkt_iter_next(struct vmbus_channel *channel,
 	u32 packetlen = desc->len8 << 3;
 	u32 dsize = rbi->ring_datasize;
 
+#ifdef CONFIG_HYPERV_TESTING
+	hv_debug_delay_test(channel, MESSAGE_DELAY);
+#endif /* CONFIG_HYPERV_TESTING */
 	/* bump offset to next potential packet */
 	rbi->priv_read_index += packetlen + VMBUS_PKT_TRAILER;
 	if (rbi->priv_read_index >= dsize)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 6256cc34c4a6..6bf8ef5c780c 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -926,6 +926,21 @@ struct vmbus_channel {
 	 * full outbound ring buffer.
 	 */
 	u64 out_full_first;
+
+#ifdef CONFIG_HYPERV_TESTING
+	/* enabling/disabling fuzz testing on the channel (default is false)*/
+	bool fuzz_testing_state;
+
+	/* Interrupt delay will delay the guest from emptying the ring buffer
+	 * for a specific amount of time. The delay is in microseconds and will
+	 * be between 1 to a maximum of 1000, its default is 0 (no delay).
+	 * The  Message delay will delay guest reading on a per message basis
+	 * in microseconds between 1 to 1000 with the default being 0
+	 * (no delay).
+	 */
+	u32 fuzz_testing_interrupt_delay;
+	u32 fuzz_testing_message_delay;
+#endif /* CONFIG_HYPERV_TESTING */
 };
 
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
@@ -1166,6 +1181,12 @@ struct hv_device {
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
+
+#ifdef CONFIG_HYPERV_TESTING
+	/* place holder to keep track of the dir for hv device in debugfs */
+	struct dentry *debug_dir;
+#endif /* CONFIG_HYPERV_TESTING */
+
 };
 
 
-- 
2.17.1

