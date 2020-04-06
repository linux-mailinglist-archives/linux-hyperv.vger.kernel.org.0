Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB8619F3B4
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgDFKmF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Apr 2020 06:42:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52681 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727081AbgDFKmE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Apr 2020 06:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586169722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbIlbCAOndT/p1zcHoZ374KLh6U88poeeD1HrBvG9E4=;
        b=LPWwbOXfrollBY3avjTdFWYFC33DZRK2QkPfDWUYpXTElO+3sfLDvB6Qpjgu5VWYaWoHbD
        ahpFBQa+7qd0ZI74yADNLdXOvtzKTBcBidXOnovcdxd7xXs3uOQ4Wl2uloU40dAb51NZXh
        es+5q/BjUURvG9atF0yTx6Ist6H1Mig=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-7HtG9gAGOgC0XKVaxjlRAQ-1; Mon, 06 Apr 2020 06:42:00 -0400
X-MC-Unique: 7HtG9gAGOgC0XKVaxjlRAQ-1
Received: by mail-wr1-f72.google.com with SMTP id u16so8193911wrp.14
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Apr 2020 03:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbIlbCAOndT/p1zcHoZ374KLh6U88poeeD1HrBvG9E4=;
        b=QjsMSLikybNYbqSGkAbe1AOt0kdqdPWFvqq3fLs2bHp84TQs47jhojFTLzdfBVhzGi
         u3zrNLwNq9IJ2WIkSF8Uu/nrNnCJgF41Jj9ZF0UzPQtEHU8T+0/1W8uEMDdIR4sLRVI9
         +BXyWpQbaZLUvd+wmtPPSGuIqs+802BtEy2JL2hj+lgItDyGCjuuZJnNm1yD/Ve2DvoR
         t4DzJdq4/E1loeTl/O0UEE4DDVE4LiZw+Rvi6GiZ7IkLwJgG7rjsgewYiknYdyhZg3tY
         NpvSu0HPVwtlI/HohyksD1G9UzgO4BWEai9Ej6Lqv81/UvKuH1LkFDNMkFwFQIjOTzor
         dU2A==
X-Gm-Message-State: AGi0PubXbXzOKNKA9cD8Esypz6S1rUXsjGc6sdBnykPDXMCBsuxrIDEx
        4dnB1BSRYxMuuSoCpO63pcg7YD5p5qLW1cc2CaXoIQDPlNR4tBeeikUbzDugTgqXXxXZb9HsNQG
        cH04h1Vm3LPTqOdpUwb2RJES9
X-Received: by 2002:adf:df8a:: with SMTP id z10mr22265708wrl.278.1586169718867;
        Mon, 06 Apr 2020 03:41:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ8Kwp2LMDv2jWv5I1+owW1KhVa8HnP1k5r/OndJsHc/EXWEVpdq3UeZBeqhWQrXxT9poQ/CA==
X-Received: by 2002:adf:df8a:: with SMTP id z10mr22265687wrl.278.1586169718558;
        Mon, 06 Apr 2020 03:41:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a2sm17305337wra.71.2020.04.06.03.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:41:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 1/5] Drivers: hv: copy from message page only what's needed
Date:   Mon,  6 Apr 2020 12:41:50 +0200
Message-Id: <20200406104154.45010-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406104154.45010-1-vkuznets@redhat.com>
References: <20200406104154.45010-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V Interrupt Message Page (SIMP) has 16 256-byte slots for
messages. Each message comes with a header (16 bytes) which specifies the
payload length (up to 240 bytes). vmbus_on_msg_dpc(), however, doesn't
look at the real message length and copies the whole slot to a temporary
buffer before passing it to message handlers. This is potentially dangerous
as hypervisor doesn't have to clean the whole slot when putting a new
message there and a message handler can get access to some data which
belongs to a previous message.

Note, this is not currently a problem because all message handlers are
in-kernel but eventually we may e.g. get this exported to userspace.

Note also, that this is not a performance critical path: messages (unlike
events) represent rare events so it doesn't really matter (from performance
point of view) if we copy too much.

Fix the issue by taking into account the real message length. The temporary
buffer allocated by vmbus_on_msg_dpc() remains fixed size for now. Also,
check that the supplied payload length is valid (<= 240 bytes).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378c27421..943b23beb992 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1032,6 +1032,12 @@ void vmbus_on_msg_dpc(unsigned long data)
 		goto msg_handled;
 	}
 
+	if (msg->header.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
+		WARN_ONCE(1, "payload size is too large (%d)\n",
+			  msg->header.payload_size);
+		goto msg_handled;
+	}
+
 	entry = &channel_message_table[hdr->msgtype];
 
 	if (!entry->message_handler)
@@ -1043,7 +1049,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 			return;
 
 		INIT_WORK(&ctx->work, vmbus_onmessage_work);
-		memcpy(&ctx->msg, msg, sizeof(*msg));
+		memcpy(&ctx->msg, msg, sizeof(msg->header) +
+		       msg->header.payload_size);
 
 		/*
 		 * The host can generate a rescind message while we
-- 
2.25.1

