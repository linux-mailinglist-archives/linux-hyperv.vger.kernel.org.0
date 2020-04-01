Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B0D19A9B4
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2020 12:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgDAKiZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Apr 2020 06:38:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38387 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727386AbgDAKiY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Apr 2020 06:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpcr33T8rdYuLn7vVzEewQplJUG3Jh5i1Ca9l3KT2Kg=;
        b=Y9rKlwnZTRyCHbp4vSm57cv9Hpdrs7lINSiEfWml2vzdVk6IGFGJn1BYNfqNfRAbiLz1XO
        /9KTBR9EMgX25JczM8ULm+FRKuFF/+RKVF+esY3qYZ6rbSrn7G+qQg3SYWms+2BhJF2e9t
        RalJY+Llg0JqZKUgjyT+1vj78dW8YBI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-RqaF8DWOMJGT8wjMdELFVQ-1; Wed, 01 Apr 2020 06:38:21 -0400
X-MC-Unique: RqaF8DWOMJGT8wjMdELFVQ-1
Received: by mail-wm1-f72.google.com with SMTP id 2so2292937wmf.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Apr 2020 03:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpcr33T8rdYuLn7vVzEewQplJUG3Jh5i1Ca9l3KT2Kg=;
        b=ELfib93Huta1x9Lm8NJorl2PIiHC70TpNZs/mOO0Koi9He3ND1g4renMs0mGG3NZk5
         y68Vh8gtUFB2d8hY0dQOcmUaIo3Q3g2VUIWtZNbXopnX2VlxT+A72cI5YwsBbzY79em/
         BAEvcUSQl5e04VsBDxcSfUc+Ik5TRZ/McxVlki6rptQ76gRr4M+UITco7uHl9NWAxYbV
         1v0eXbWRCTweablOosOaGRUktT3jIH1T7o7QbbZzVKo3iFPFmrEfZrf9RCLmY7wEEExJ
         fLSjXzf6xicSnB3lPuPFroDhsVmtoxQu9B8/fDPe/hO2uhQiJFmr7ebhG7OKSFJa5Bng
         9Evg==
X-Gm-Message-State: AGi0PuZG6WMIA2bsQYKKl5jwDvSZZGyvZrGciyBKc4jAkSwCRlUpGB1M
        jMyb9TyZJzhlCpryHND++juNKFZj156m/fnS7V8BfVxGWSlvHANAeydxgRGr86jY6ecGliXkJF3
        /QNO7RX61uly9ROtXkt6NpO4m
X-Received: by 2002:a05:600c:21cb:: with SMTP id x11mr3717530wmj.111.1585737500058;
        Wed, 01 Apr 2020 03:38:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypI/09ZQOILsbUwfjHlQ3v4i++kt+2dY6I43iMSQ0EpaGIW2mCXDIifdbXrY1VDgOjIo1mV74A==
X-Received: by 2002:a05:600c:21cb:: with SMTP id x11mr3717508wmj.111.1585737499794;
        Wed, 01 Apr 2020 03:38:19 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r3sm2380098wrm.35.2020.04.01.03.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:38:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 5/5] Drivers: hv: check VMBus messages lengths
Date:   Wed,  1 Apr 2020 12:38:16 +0200
Message-Id: <20200401103816.1406642-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401103816.1406642-1-vkuznets@redhat.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
 <20200401103816.1406642-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VMBus message handlers (channel_message_table) receive a pointer to
'struct vmbus_channel_message_header' and cast it to a structure of their
choice, which is sometimes longer than the header. We, however, don't check
that the message is long enough so in case hypervisor screws up we'll be
accessing memory beyond what was allocated for temporary buffer.

Previously, we used to always allocate and copy 256 bytes from message page
to temporary buffer but this is hardly better: in case the message is
shorter than we expect we'll be trying to consume garbage as some real
data and no memory guarding technique will be able to identify an issue.

Introduce 'min_payload_len' to 'struct vmbus_channel_message_table_entry'
and check against it in vmbus_on_msg_dpc(). Note, we can't require the
exact length as new hypervisor versions may add extra fields to messages,
we only check that the message is not shorter than we expect.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/channel_mgmt.c | 54 ++++++++++++++++++++++-----------------
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    |  6 +++++
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index c6bcfee6ac99..d4ccc9b203fa 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1329,30 +1329,36 @@ static void vmbus_onversion_response(
 /* Channel message dispatch table */
 const struct vmbus_channel_message_table_entry
 channel_message_table[CHANNELMSG_COUNT] = {
-	{ CHANNELMSG_INVALID,			0, NULL },
-	{ CHANNELMSG_OFFERCHANNEL,		0, vmbus_onoffer },
-	{ CHANNELMSG_RESCIND_CHANNELOFFER,	0, vmbus_onoffer_rescind },
-	{ CHANNELMSG_REQUESTOFFERS,		0, NULL },
-	{ CHANNELMSG_ALLOFFERS_DELIVERED,	1, vmbus_onoffers_delivered },
-	{ CHANNELMSG_OPENCHANNEL,		0, NULL },
-	{ CHANNELMSG_OPENCHANNEL_RESULT,	1, vmbus_onopen_result },
-	{ CHANNELMSG_CLOSECHANNEL,		0, NULL },
-	{ CHANNELMSG_GPADL_HEADER,		0, NULL },
-	{ CHANNELMSG_GPADL_BODY,		0, NULL },
-	{ CHANNELMSG_GPADL_CREATED,		1, vmbus_ongpadl_created },
-	{ CHANNELMSG_GPADL_TEARDOWN,		0, NULL },
-	{ CHANNELMSG_GPADL_TORNDOWN,		1, vmbus_ongpadl_torndown },
-	{ CHANNELMSG_RELID_RELEASED,		0, NULL },
-	{ CHANNELMSG_INITIATE_CONTACT,		0, NULL },
-	{ CHANNELMSG_VERSION_RESPONSE,		1, vmbus_onversion_response },
-	{ CHANNELMSG_UNLOAD,			0, NULL },
-	{ CHANNELMSG_UNLOAD_RESPONSE,		1, vmbus_unload_response },
-	{ CHANNELMSG_18,			0, NULL },
-	{ CHANNELMSG_19,			0, NULL },
-	{ CHANNELMSG_20,			0, NULL },
-	{ CHANNELMSG_TL_CONNECT_REQUEST,	0, NULL },
-	{ CHANNELMSG_22,			0, NULL },
-	{ CHANNELMSG_TL_CONNECT_RESULT,		0, NULL },
+	{ CHANNELMSG_INVALID,			0, NULL, 0},
+	{ CHANNELMSG_OFFERCHANNEL,		0, vmbus_onoffer,
+		sizeof(struct vmbus_channel_offer_channel)},
+	{ CHANNELMSG_RESCIND_CHANNELOFFER,	0, vmbus_onoffer_rescind,
+		sizeof(struct vmbus_channel_rescind_offer) },
+	{ CHANNELMSG_REQUESTOFFERS,		0, NULL, 0},
+	{ CHANNELMSG_ALLOFFERS_DELIVERED,	1, vmbus_onoffers_delivered, 0},
+	{ CHANNELMSG_OPENCHANNEL,		0, NULL, 0},
+	{ CHANNELMSG_OPENCHANNEL_RESULT,	1, vmbus_onopen_result,
+		sizeof(struct vmbus_channel_open_result)},
+	{ CHANNELMSG_CLOSECHANNEL,		0, NULL, 0},
+	{ CHANNELMSG_GPADL_HEADER,		0, NULL, 0},
+	{ CHANNELMSG_GPADL_BODY,		0, NULL, 0},
+	{ CHANNELMSG_GPADL_CREATED,		1, vmbus_ongpadl_created,
+		sizeof(struct vmbus_channel_gpadl_created)},
+	{ CHANNELMSG_GPADL_TEARDOWN,		0, NULL, 0},
+	{ CHANNELMSG_GPADL_TORNDOWN,		1, vmbus_ongpadl_torndown,
+		sizeof(struct vmbus_channel_gpadl_torndown) },
+	{ CHANNELMSG_RELID_RELEASED,		0, NULL, 0},
+	{ CHANNELMSG_INITIATE_CONTACT,		0, NULL, 0},
+	{ CHANNELMSG_VERSION_RESPONSE,		1, vmbus_onversion_response,
+		sizeof(struct vmbus_channel_version_response)},
+	{ CHANNELMSG_UNLOAD,			0, NULL, 0},
+	{ CHANNELMSG_UNLOAD_RESPONSE,		1, vmbus_unload_response, 0},
+	{ CHANNELMSG_18,			0, NULL, 0},
+	{ CHANNELMSG_19,			0, NULL, 0},
+	{ CHANNELMSG_20,			0, NULL, 0},
+	{ CHANNELMSG_TL_CONNECT_REQUEST,	0, NULL, 0},
+	{ CHANNELMSG_22,			0, NULL, 0},
+	{ CHANNELMSG_TL_CONNECT_RESULT,		0, NULL, 0},
 };
 
 /*
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index f5fa3b3c9baf..7fd66a4e2951 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -317,6 +317,7 @@ struct vmbus_channel_message_table_entry {
 	enum vmbus_channel_message_type message_type;
 	enum vmbus_message_handler_type handler_type;
 	void (*message_handler)(struct vmbus_channel_message_header *msg);
+	u32 min_payload_len;
 };
 
 extern const struct vmbus_channel_message_table_entry
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d684cbee7ae6..7b7229199936 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1048,6 +1048,12 @@ void vmbus_on_msg_dpc(unsigned long data)
 	if (!entry->message_handler)
 		goto msg_handled;
 
+	if (msg->header.payload_size < entry->min_payload_len) {
+		WARN_ONCE(1, "message too short: msgtype=%d len=%d\n",
+			  hdr->msgtype, msg->header.payload_size);
+		goto msg_handled;
+	}
+
 	if (entry->handler_type	== VMHT_BLOCKING) {
 		ctx = kmalloc(sizeof(*ctx) + msg->header.payload_size,
 			      GFP_ATOMIC);
-- 
2.25.1

