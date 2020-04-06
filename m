Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6BA19F3B3
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgDFKmF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Apr 2020 06:42:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47830 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727104AbgDFKmE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Apr 2020 06:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586169723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNCEzp8Xf9G/EJkWE4iVp8b4/dzBkQfiZaLwTbSfMe4=;
        b=JG4A1RyuCZJyge53KM+EhZWPfMFg76uaEl5fa3bLX/YfkvI+CJFco1sJ0wE8fqs7T7GAB6
        FEDQUw/5OoQqNSDlWhuN+Lf9S5/1I2VwiimqUzV1THgQ4DfzElnTMRSQacTHWda+VSNqyQ
        QjR7Ddk3I8lZ3c2gqiemDt/fXlwDSZM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-k9LJQz7mPIygrjhNbZRMJQ-1; Mon, 06 Apr 2020 06:42:01 -0400
X-MC-Unique: k9LJQz7mPIygrjhNbZRMJQ-1
Received: by mail-wr1-f71.google.com with SMTP id y1so8147571wrn.10
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Apr 2020 03:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNCEzp8Xf9G/EJkWE4iVp8b4/dzBkQfiZaLwTbSfMe4=;
        b=A9j9XkkUG/tzlPuLxUe3qtOxSVRGecc1uAIEyzYbG1a/Iqecc7u9yXcBhN2aIlDQL+
         hJz/Ip2tQ9RtXNKuKxAwvk/glVwrg8iW/nVaxcUjkXDzm5gR6in6OAsMxwWTZ8NOEITK
         GQlUhj8+VfAMz/yaUeHE4SyMJLkS2Oil/69hXhdbBiDkywB8ppGXagDS8fFhwo195gDU
         zVercEnjDyzd5l+zVyhr3qoBhmusckulgtJXVmIUJWplDR2p6bSdy2x+8OOB6zdKOXvm
         r5aMQ0oAhA5+KcymFYo8L2n86sI+gQrdJLmHHxOPHx8AOnem/VOJx4Cp+UmxbR6gxrh/
         /ugg==
X-Gm-Message-State: AGi0PuZ9hvyZfhLzJy/H8OaUxYKINJCMZJGl3emosd1OkhT6eX89YCeK
        G00KnsBlv35bu+aNV3F4Rpi/6E1UH3tknipf26iJkpzVnlXB6jHGgB1MjjEJrLSOiaRrmZJZRVC
        6dHa39Blr9FHQqGVgFcego/oq
X-Received: by 2002:a1c:98c2:: with SMTP id a185mr9801245wme.85.1586169720307;
        Mon, 06 Apr 2020 03:42:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypIVoZ4LLrlXceBRrGrczs27RRHIwL8V1sWT18u9g9ujFzu+ivzbGQ5OvFlPEr0gXDR0iFB7nA==
X-Received: by 2002:a1c:98c2:: with SMTP id a185mr9801222wme.85.1586169720021;
        Mon, 06 Apr 2020 03:42:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a2sm17305337wra.71.2020.04.06.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:41:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 2/5] Drivers: hv: allocate the exact needed memory for messages
Date:   Mon,  6 Apr 2020 12:41:51 +0200
Message-Id: <20200406104154.45010-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406104154.45010-1-vkuznets@redhat.com>
References: <20200406104154.45010-1-vkuznets@redhat.com>
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 943b23beb992..b114bb411d7e 100644
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
@@ -1044,7 +1047,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 		goto msg_handled;
 
 	if (entry->handler_type	== VMHT_BLOCKING) {
-		ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+		ctx = kmalloc(sizeof(*ctx) + msg->header.payload_size,
+			      GFP_ATOMIC);
 		if (ctx == NULL)
 			return;
 
@@ -1098,10 +1102,11 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
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
@@ -1111,7 +1116,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 	ctx->msg.header.payload_size = sizeof(*rescind);
 
 	/* These values are actually used by Linux. */
-	rescind = (struct vmbus_channel_rescind_offer *)ctx->msg.u.payload;
+	rescind = (struct vmbus_channel_rescind_offer *)ctx->msg.payload;
 	rescind->header.msgtype = CHANNELMSG_RESCIND_CHANNELOFFER;
 	rescind->child_relid = channel->offermsg.child_relid;
 
-- 
2.25.1

