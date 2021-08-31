Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166153FC9EF
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Aug 2021 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbhHaOkV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Aug 2021 10:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236942AbhHaOkV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Aug 2021 10:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630420765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bfeMT4q3hgyi5YOGkW7eJihxmb4hf3hntPENAmZwmcE=;
        b=D5An7x/bUkIzgh1xWT1tr4FRc6x8/woDsake5KPPBfv7yPh4goMEvfWf1twjOX5gm6Uks7
        fIcYngFVsfBKS7SmTX0rwjJCSgRsoRtARJegEeG2OZaterJDrgWwBcQB3Bh4UtsITSBAxH
        oHFYEmC9eXYRdlYmikRvIZMB+r49P7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-T406k6JaPSuOPpwtun3Xuw-1; Tue, 31 Aug 2021 10:39:22 -0400
X-MC-Unique: T406k6JaPSuOPpwtun3Xuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A652C7440;
        Tue, 31 Aug 2021 14:39:20 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.192.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACB8C1017E27;
        Tue, 31 Aug 2021 14:39:17 +0000 (UTC)
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
Subject: [PATCH] Drivers: hv: vmbus: Fix kernel crash upon unbinding a device from uio_hv_generic driver
Date:   Tue, 31 Aug 2021 16:39:16 +0200
Message-Id: <20210831143916.144983-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The following crash happens when a never-used device is unbound from
uio_hv_generic driver:

 kernel BUG at mm/slub.c:321!
 invalid opcode: 0000 [#1] SMP PTI
 CPU: 0 PID: 4001 Comm: bash Kdump: loaded Tainted: G               X --------- ---  5.14.0-0.rc2.23.el9.x86_64 #1
 Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
 RIP: 0010:__slab_free+0x1d5/0x3d0
...
 Call Trace:
  ? pick_next_task_fair+0x18e/0x3b0
  ? __cond_resched+0x16/0x40
  ? vunmap_pmd_range.isra.0+0x154/0x1c0
  ? __vunmap+0x22d/0x290
  ? hv_ringbuffer_cleanup+0x36/0x40 [hv_vmbus]
  kfree+0x331/0x380
  ? hv_uio_remove+0x43/0x60 [uio_hv_generic]
  hv_ringbuffer_cleanup+0x36/0x40 [hv_vmbus]
  vmbus_free_ring+0x21/0x60 [hv_vmbus]
  hv_uio_remove+0x4f/0x60 [uio_hv_generic]
  vmbus_remove+0x23/0x30 [hv_vmbus]
  __device_release_driver+0x17a/0x230
  device_driver_detach+0x3c/0xa0
  unbind_store+0x113/0x130
...

The problem appears to be that we free 'ring_info->pkt_buffer' twice:
first, when the device is unbound from in-kernel driver (netvsc in this
case) and second from hv_uio_remove(). Normally, ring buffer is supposed
to be re-initialized from hv_uio_open() but this happens when UIO device
is being opened and this is not guaranteed to happen.

Generally, it is OK to call hv_ringbuffer_cleanup() twice for the same
channel (which is being handed over between in-kernel drivers and UIO) even
if we didn't call hv_ringbuffer_init() in between. We, however, need to
avoid kfree() call for an already freed pointer.

Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 2aee356840a2..314015d9e912 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -245,6 +245,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
 	mutex_unlock(&ring_info->ring_buffer_mutex);
 
 	kfree(ring_info->pkt_buffer);
+	ring_info->pkt_buffer = NULL;
 	ring_info->pkt_buffer_size = 0;
 }
 
-- 
2.31.1

