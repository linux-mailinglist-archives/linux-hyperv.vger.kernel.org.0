Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DEB3F7603
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Aug 2021 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbhHYNjx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Aug 2021 09:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240182AbhHYNjw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Aug 2021 09:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629898746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A/htP7MQwE1WocRnDXZywGTa4cGcMJaiiSpZCc7Gsg0=;
        b=IJpcVZi/zn0O3biHCD/tJD0H1GPoqOCTbZIJFSXWfaIomV+Gn9u6TzYqTMtdNHkjGrWhmc
        U/o8QaInD1UJkQ9QlLLDIRWitUZMnyFKcu1dWsveRiqcYRvI7DloarwqJr1EuAzOp0lvMQ
        UwGJHTRiHj8kyRGkCiuy+Urc1s+95JE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-Grq60voaP_KvWG_1_PFfog-1; Wed, 25 Aug 2021 09:39:02 -0400
X-MC-Unique: Grq60voaP_KvWG_1_PFfog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F71F1082921;
        Wed, 25 Aug 2021 13:39:01 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84CE51970F;
        Wed, 25 Aug 2021 13:38:58 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     Andres Beltran <lkmlabelt@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hv_utils: Set the maximum packet size for VSS driver to the length of the receive buffer
Date:   Wed, 25 Aug 2021 15:38:57 +0200
Message-Id: <20210825133857.847866-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Commit adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out
of the ring buffer") introduced a notion of maximum packet size and for
KVM and FCOPY drivers set it to the length of the receive buffer. VSS
driver wasn't updated, this means that the maximum packet size is now
VMBUS_DEFAULT_MAX_PKT_SIZE (4k). Apparently, this is not enough. I'm
observing a packet of 6304 bytes which is being truncated to 4096. When
VSS driver tries to read next packet from ring buffer it starts from the
wrong offset and receives garbage.

Set the maximum packet size to 'HV_HYP_PAGE_SIZE * 2' in VSS driver. This
matches the length of the receive buffer and is in line with other utils
drivers.

Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/hv_snapshot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 2267bd4c3472..6018b9d1b1fb 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -375,6 +375,7 @@ hv_vss_init(struct hv_util_service *srv)
 	}
 	recv_buffer = srv->recv_buffer;
 	vss_transaction.recv_channel = srv->channel;
+	vss_transaction.recv_channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
 
 	/*
 	 * When this driver loads, the user level daemon that
-- 
2.31.1

