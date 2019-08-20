Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE49548B
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 04:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfHTCof (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 22:44:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38306 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHTCof (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 22:44:35 -0400
Received: by mail-io1-f67.google.com with SMTP id p12so6514808iog.5;
        Mon, 19 Aug 2019 19:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K6vNNx0KW4YWTm/W7PwoxMoYQobTA64O0AG22feNt8k=;
        b=J954wI8AI9IN7oWcywM7z7ohepAAccmsgVtSD9yWezJMppzk5YdCzZl2K2Jt/b3vHQ
         nhiqJTqcpBXK/1nB0PklT2QiBAZo0CCYyHH6BuJaME8iLOaiVZuKj9EgVtYGtwsPe5w0
         SCCnTZckAwRAtqqZ23uMUyKZfAlLVrjZ6BXXUUWEgqPUi3c6Qq0dgIynOVnw7Sg93CcV
         JFkYXt1SQ9w8i+gn5uwNx8HEMZZLlOtrG6ViSqe0RPiLbuCpNtHIb/sWeLvM/H72L0SH
         bV5ybVRjRey5KJiSnLZ6u54WHAHzikSbE/k0dGDALi04WZgMYpo0w3uOiAugwCQd/xjR
         tnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K6vNNx0KW4YWTm/W7PwoxMoYQobTA64O0AG22feNt8k=;
        b=IXfeW5F2QCVFv+fVkEqw7e69lxJjyPwGm5xbzW9exb8VqBEeSByS5fQgdw2LU04LqO
         UfESbObWBq22Jj4bV8xKIyAS9y9RK23jqD/V/H4uopd5YprcpUISSOx3VLZk12l5D5vt
         orx/c93H0JWcigGhVe0L6xaVUtJfz9IHDxjCxMFLp672PaPqLi/Q0XDcsEWs/vZgpMGY
         zUaoHBo+L5CW/U/yxJ7WDYSWnfZ3bFOUK4sWfOo0YBwYIkPHpDJrcS8Tgi8Vo3AGNjW4
         xZAeRdAMXHSFwp104kG5eUY5RGLpU44KhR2I6RGEhCkfg9rJMGzX3xKm3uLg4KlSwlUr
         VPbQ==
X-Gm-Message-State: APjAAAU4n5pvv8CIKyJsEHEgO6F+X8AWqadrFmtmbHeujik7wUnxVqq4
        EbR+ejyTIUo5wd/Oru5maQ==
X-Google-Smtp-Source: APXvYqybXonIMhOGExCqhjxlwRwb9bG8ueXqdf0/ytl//IWjuPR25uHm8P6xrEpyQyaNW2kNIjKBOQ==
X-Received: by 2002:a5d:9583:: with SMTP id a3mr3174546ioo.54.1566269073750;
        Mon, 19 Aug 2019 19:44:33 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id i3sm13324968ion.9.2019.08.19.19.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 19:44:33 -0700 (PDT)
Date:   Mon, 19 Aug 2019 22:44:31 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drivers: hv: vmbus: Introduce latency testing
Message-ID: <ebca54bf70d2af53de419c1b7ac8db5b77b888cb.1566266609.git.brandonbonaby94@gmail.com>
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

