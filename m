Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594627E3B2
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2019 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbfHAUAd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Aug 2019 16:00:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38984 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbfHAUAd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Aug 2019 16:00:33 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so147142679ioh.6;
        Thu, 01 Aug 2019 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Lb+Pq2jwJQ7awOjuGweslww6JM25aY6jPlQz/V9q0s=;
        b=Fwco4aGrJWl8l01Y0z0ZntCfsHSFYEL/GWFLRxjcLQfSTkOJmRYLdLkffYRS5ZmPde
         7I+2TqzxYXfrV1/KOORN6Sz/K7ML9dk345gi0L5MGeixJ+vGEky5PFExIwGON2bdf0y4
         nzHqnwy5JcqF+oTiba/WEwiCQkwU5taU/dutUwUBTdCMpirbBhlyHZTPVL4bS9+SLoiB
         GLRz4NbdRSOrrS+0fKRM2H7No3C/jHWSFooSYjfFsdfsX3tAr1Xct3byoSqp6Pe++Wnf
         yDePurn2Ay2aSdrOaDBenCEf5aoTaX6liYwW36+yNCYlaNCzg01/zxsRQgaNM97DhHee
         7jHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Lb+Pq2jwJQ7awOjuGweslww6JM25aY6jPlQz/V9q0s=;
        b=VipEA9TnfaEhoxFPrTNCWgbbgOK6xhnO+0V8ajdTUmHGwQYGo6uk0rySLizd1Fa018
         Zuh+4V8dCyTlSKxeaRQ/UxZVAJPAZgWznluusesNs4dYl8o3Tmufyq3bY7O9yRYQjO7H
         IRE7yq4GDQ9lrolAuWUFKCGhpHIS27fOhwMpz/5+o+Y3h53/D9UeY4i/Yl0/opMra1Jf
         F3147oBS7uTOafNzol+UT2LMOhMbou11JpDJVoTlQkGOgKye0TS3mIwmZk5+ZwOZkgc7
         xaMlsQuMrzKE2ZgwlxWmDe9JZbb2L2BajqCvXWxSks8OANetS9E5UOJ+Y7WzwgMfUNU2
         fH6Q==
X-Gm-Message-State: APjAAAXHc3YJRr/atAPY6ROTLLdfGnJyxKLseIrgZFeIf5SCyMrcDxEh
        kh6hLG75RZ42IpT3KGzrlw==
X-Google-Smtp-Source: APXvYqwKDaPSbztgstVW+smW+CLBlad+S2WjOMNFaUeXTCprvv7xXlVBeWq4EhtLLYLlaWAHN/1ucA==
X-Received: by 2002:a02:cb96:: with SMTP id u22mr134108087jap.118.1564689632477;
        Thu, 01 Aug 2019 13:00:32 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id m20sm70505118ioh.4.2019.08.01.13.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 13:00:32 -0700 (PDT)
Date:   Thu, 1 Aug 2019 16:00:30 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drivers: hv: vmbus: Introduce latency testing
Message-ID: <18193677a879c402d00955c445ae7ce461b4198f.1564527684.git.brandonbonaby94@gmail.com>
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

Introduce user specified latency in the packet reception path.

Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
---
 drivers/hv/connection.c  |  5 +++++
 drivers/hv/ring_buffer.c | 10 ++++++++++
 include/linux/hyperv.h   | 14 ++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 09829e15d4a0..2a2c22f5570e 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -354,9 +354,14 @@ void vmbus_on_event(unsigned long data)
 {
 	struct vmbus_channel *channel = (void *) data;
 	unsigned long time_limit = jiffies + 2;
+	struct vmbus_channel *test_channel = !channel->primary_channel ?
+						channel :
+						channel->primary_channel;
 
 	trace_vmbus_on_event(channel);
 
+	if (unlikely(test_channel->fuzz_testing_buffer_delay > 0))
+		udelay(test_channel->fuzz_testing_buffer_delay);
 	do {
 		void (*callback_fn)(void *);
 
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 9a03b163cbbd..d7627c9023d6 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -395,7 +395,12 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct vmbus_channel *channel)
 {
 	struct hv_ring_buffer_info *rbi = &channel->inbound;
 	struct vmpacket_descriptor *desc;
+	struct vmbus_channel *test_channel = !channel->primary_channel ?
+						channel :
+						channel->primary_channel;
 
+	if (unlikely(test_channel->fuzz_testing_message_delay > 0))
+		udelay(test_channel->fuzz_testing_message_delay);
 	if (hv_pkt_iter_avail(rbi) < sizeof(struct vmpacket_descriptor))
 		return NULL;
 
@@ -420,7 +425,12 @@ __hv_pkt_iter_next(struct vmbus_channel *channel,
 	struct hv_ring_buffer_info *rbi = &channel->inbound;
 	u32 packetlen = desc->len8 << 3;
 	u32 dsize = rbi->ring_datasize;
+	struct vmbus_channel *test_channel = !channel->primary_channel ?
+						channel :
+						channel->primary_channel;
 
+	if (unlikely(test_channel->fuzz_testing_message_delay > 0))
+		udelay(test_channel->fuzz_testing_message_delay);
 	/* bump offset to next potential packet */
 	rbi->priv_read_index += packetlen + VMBUS_PKT_TRAILER;
 	if (rbi->priv_read_index >= dsize)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 6256cc34c4a6..8d068956dd67 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -23,6 +23,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/reciprocal_div.h>
+#include <linux/delay.h>
 
 #define MAX_PAGE_BUFFER_COUNT				32
 #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
@@ -926,6 +927,19 @@ struct vmbus_channel {
 	 * full outbound ring buffer.
 	 */
 	u64 out_full_first;
+
+	/* enabling/disabling fuzz testing on the channel (default is false)*/
+	bool fuzz_testing_state;
+
+	/* Buffer delay will delay the guest from emptying the ring buffer
+	 * for a specific amount of time. The delay is in microseconds and will
+	 * be between 1 to a maximum of 1000, its default is 0 (no delay).
+	 * The  Message delay will delay guest reading on a per message basis
+	 * in microseconds between 1 to 1000 with the default being 0
+	 * (no delay).
+	 */
+	u32 fuzz_testing_buffer_delay;
+	u32 fuzz_testing_message_delay;
 };
 
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
-- 
2.17.1

