Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7767119A9A7
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2020 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbgDAKgs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Apr 2020 06:36:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21919 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732174AbgDAKgs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Apr 2020 06:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95SLTRxzNA6I7Qs5MDcrqUNSgYhms1oIYNK1Km/D7+g=;
        b=Q025UPL7rkd/gpPIMX9a3RAtbQ1uCsb+v/IzS3zKfRFZ0J0Bi3nHwtw/2QJgC6ZAm0X3vu
        fVwK234unpToF3LHyacL782Vj7l1LbpHb8IBjC1xu848ZZj2XP6ZvgBCmLcQueywMsz4MG
        BV+9FCoeeEvvJC7rebtNKhJ8V4FU0hA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-SgpLIXhlOnSN7mr_m1Wq-w-1; Wed, 01 Apr 2020 06:36:45 -0400
X-MC-Unique: SgpLIXhlOnSN7mr_m1Wq-w-1
Received: by mail-wm1-f71.google.com with SMTP id w8so2279201wmk.5
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Apr 2020 03:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95SLTRxzNA6I7Qs5MDcrqUNSgYhms1oIYNK1Km/D7+g=;
        b=FlWI+6ntGYfzPUW43fcjPuGlyimTraaYN7dCOrwY3ctLkX+bllJHZSkkx0gySzowWK
         JhikSK1njPM1V6ahxoZw9XMqQqngRZl8E4h6Yg+ywNKj6ilb2P50G6MWOZYmiJGoXzho
         ng1W8LdtOM1zquymOWWXoD34g11JE4OnIi7oYFcWIXxkjkIMS4dMN2ycwjmYFvwwQBM1
         /MmZ2YWRB2Md51Pu02f219TbbEk78W0qF4VSxOhmRSSQGvmhPACBFTrK1F15+tasF4e9
         jM2OGqOMY+LsBjA7z0TJ4hRCBsja0lUmuIRzHL5pY8GCBOaS02o61i6S9SH2Kn2EuAlh
         JuBg==
X-Gm-Message-State: ANhLgQ3EFaahiJM3yncA4dIo3+AW0H0kGbOy2gyX4qnzpylvDnkbCgZz
        3/xu9W1qMh/U0n8IkpjTa8obf6f0d3qsJ37RSx0GNZHlgMboEedvzvFyiKtgd4A8DMLjnlz/QRg
        n300wDLn16YruAQIGSvw9YjBm
X-Received: by 2002:adf:f68b:: with SMTP id v11mr24104978wrp.270.1585737404486;
        Wed, 01 Apr 2020 03:36:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vupbXj+AHoPKJR8dpFDHt1zLdiYOWj2Qkuu2LQbrdXTWCGsIkDoKHFfZUzBvnLpI5KUmjLZPQ==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr24104958wrp.270.1585737404297;
        Wed, 01 Apr 2020 03:36:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b187sm2247522wmc.14.2020.04.01.03.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:36:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 2/5] Drivers: hv: allocate the exact needed memory for messages
Date:   Wed,  1 Apr 2020 12:36:35 +0200
Message-Id: <20200401103638.1406431-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401103638.1406431-1-vkuznets@redhat.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When we need to pass a buffer with Hyper-V message we don't need to always
allocate 256 bytes for the message: the real message length is known from
the header. Change 'struct onmessage_work_context' to make it possible to
not over-allocate.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/vmbus_drv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2b5572146358..642782bef863 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -991,7 +991,10 @@ static struct bus_type  hv_bus = {
 
 struct onmessage_work_context {
 	struct work_struct work;
-	struct hv_message msg;
+	struct {
+		struct hv_message_header header;
+		u8 payload[];
+	} msg;
 };
 
 static void vmbus_onmessage_work(struct work_struct *work)
@@ -1038,7 +1041,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 		goto msg_handled;
 
 	if (entry->handler_type	== VMHT_BLOCKING) {
-		ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+		ctx = kmalloc(sizeof(*ctx) + msg->header.payload_size,
+			      GFP_ATOMIC);
 		if (ctx == NULL)
 			return;
 
@@ -1092,10 +1096,11 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 	WARN_ON(!is_hvsock_channel(channel));
 
 	/*
-	 * sizeof(*ctx) is small and the allocation should really not fail,
+	 * Allocation size is small and the allocation should really not fail,
 	 * otherwise the state of the hv_sock connections ends up in limbo.
 	 */
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | __GFP_NOFAIL);
+	ctx = kzalloc(sizeof(*ctx) + sizeof(*rescind),
+		      GFP_KERNEL | __GFP_NOFAIL);
 
 	/*
 	 * So far, these are not really used by Linux. Just set them to the
@@ -1105,7 +1110,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 	ctx->msg.header.payload_size = sizeof(*rescind);
 
 	/* These values are actually used by Linux. */
-	rescind = (struct vmbus_channel_rescind_offer *)ctx->msg.u.payload;
+	rescind = (struct vmbus_channel_rescind_offer *)ctx->msg.payload;
 	rescind->header.msgtype = CHANNELMSG_RESCIND_CHANNELOFFER;
 	rescind->child_relid = channel->offermsg.child_relid;
 
-- 
2.25.1

