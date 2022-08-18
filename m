Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3615985AF
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Aug 2022 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbiHROZ0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Aug 2022 10:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245287AbiHROZZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Aug 2022 10:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E41B3B11
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Aug 2022 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660832724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3EBiorc36K9lFac0YV8mycE+/askbIgPzPBST6q2Ao=;
        b=Ha+Ndixj1zdR2BUgY4N76zwHiw5vSTkVVt37O0qTZxyeYHGd0ngKuVVHfZKQJPY3ZnWCRa
        8HPDqEairpwEs22sgEw1vPhQqy4LDhSQm6337QyW3V7fJg+0607HT7X8jkvsBnL75Mblfp
        KNILjyd8KTk41TmSK/1QIz+ujYZ/LXc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-mL-b56yZPmavJRyjnPYJZg-1; Thu, 18 Aug 2022 10:25:21 -0400
X-MC-Unique: mL-b56yZPmavJRyjnPYJZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E22B3C01DE7;
        Thu, 18 Aug 2022 14:25:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EF31C15BB8;
        Thu, 18 Aug 2022 14:25:17 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Wei Liu <wei.liu@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v1 4/4] Drivers: hv: Never allocate anything besides framebuffer from framebuffer memory region
Date:   Thu, 18 Aug 2022 16:25:08 +0200
Message-Id: <20220818142508.402273-5-vkuznets@redhat.com>
In-Reply-To: <20220818142508.402273-1-vkuznets@redhat.com>
References: <20220818142508.402273-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Passed through PCI device sometimes misbehave on Gen1 VMs when Hyper-V
DRM driver is also loaded. Looking at IOMEM assignment, we can see e.g.

$ cat /proc/iomem
...
f8000000-fffbffff : PCI Bus 0000:00
  f8000000-fbffffff : 0000:00:08.0
    f8000000-f8001fff : bb8c4f33-2ba2-4808-9f7f-02f3b4da22fe
...
fe0000000-fffffffff : PCI Bus 0000:00
  fe0000000-fe07fffff : bb8c4f33-2ba2-4808-9f7f-02f3b4da22fe
    fe0000000-fe07fffff : 2ba2:00:02.0
      fe0000000-fe07fffff : mlx4_core

the interesting part is the 'f8000000' region as it is actually the
VM's framebuffer:

$ lspci -v
...
0000:00:08.0 VGA compatible controller: Microsoft Corporation Hyper-V virtual VGA (prog-if 00 [VGA controller])
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
...

 hv_vmbus: registering driver hyperv_drm
 hyperv_drm 5620e0c7-8062-4dce-aeb7-520c7ef76171: [drm] Synthvid Version major 3, minor 5
 hyperv_drm 0000:00:08.0: vgaarb: deactivate vga console
 hyperv_drm 0000:00:08.0: BAR 0: can't reserve [mem 0xf8000000-0xfbffffff]
 hyperv_drm 5620e0c7-8062-4dce-aeb7-520c7ef76171: [drm] Cannot request framebuffer, boot fb still active?

Note: "Cannot request framebuffer" is not a fatal error in
hyperv_setup_gen1() as the code assumes there's some other framebuffer
device there but we actually have some other PCI device (mlx4 in this
case) config space there!

The problem appears to be that vmbus_allocate_mmio() can allocate from
the reserved framebuffer region (fb_overlap_ok), however, if the
request to allocate MMIO comes from some other device before
framebuffer region is taken, it can happily use framebuffer region for
it. Note, Gen2 VMs are usually unaffected by the issue because
framebuffer region is already taken by EFI fb (in case kernel supports
it) but Gen1 VMs may have this region unclaimed by the time Hyper-V PCI
pass-through driver tries allocating MMIO space if Hyper-V DRM/FB drivers
load after it. Devices can be brought up in any sequence so let's
resolve the issue by always ignoring 'fb_mmio' region for non-FB
requests, even if the region is unclaimed.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/vmbus_drv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 6edaeefa2c3c..54ace5c6b990 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2328,7 +2328,7 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			bool fb_overlap_ok)
 {
 	struct resource *iter, *shadow;
-	resource_size_t range_min, range_max, start;
+	resource_size_t range_min, range_max, start, end;
 	const char *dev_n = dev_name(&device_obj->device);
 	int retval;
 
@@ -2363,6 +2363,14 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 		range_max = iter->end;
 		start = (range_min + align - 1) & ~(align - 1);
 		for (; start + size - 1 <= range_max; start += align) {
+			end = start + size - 1;
+
+			/* Skip the whole fb_mmio region if not fb_overlap_ok */
+			if (!fb_overlap_ok && fb_mmio &&
+			    (((start >= fb_mmio->start) && (start <= fb_mmio->end)) ||
+			     ((end >= fb_mmio->start) && (end <= fb_mmio->end))))
+				continue;
+
 			shadow = __request_region(iter, start, size, NULL,
 						  IORESOURCE_BUSY);
 			if (!shadow)
-- 
2.37.1

