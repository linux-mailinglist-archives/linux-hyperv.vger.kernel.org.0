Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E9EC950
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2019 21:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKAUBh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Nov 2019 16:01:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbfKAUBh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Nov 2019 16:01:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D6D5B2CB;
        Fri,  1 Nov 2019 20:01:35 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] drivers/hv: Replace binary semaphore with mutex
Date:   Fri,  1 Nov 2019 13:00:04 -0700
Message-Id: <20191101200004.20318-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

At a slight footprint cost (24 vs 32 bytes), mutexes are more optimal
than semaphores; it's also a nicer interface for mutual exclusion,
which is why they are encouraged over binary semaphores, when possible.

Replace the hyperv_mmio_lock, its semantics implies traditional lock
ownership; that is, the lock owner is the same for both lock/unlock
operations. Therefore it is safe to convert.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
This is part of reducing the amount of semaphore users in the kernel.
Compile-tested only.

 drivers/hv/vmbus_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 391f0b225c9a..5c606dc4a3f7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -79,7 +79,7 @@ static struct notifier_block hyperv_panic_block = {
 static const char *fb_mmio_name = "fb_range";
 static struct resource *fb_mmio;
 static struct resource *hyperv_mmio;
-static DEFINE_SEMAPHORE(hyperv_mmio_lock);
+static DEFINE_MUTEX(hyperv_mmio_lock);
 
 static int vmbus_exists(void)
 {
@@ -2011,7 +2011,7 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 	int retval;
 
 	retval = -ENXIO;
-	down(&hyperv_mmio_lock);
+	mutex_lock(&hyperv_mmio_lock);
 
 	/*
 	 * If overlaps with frame buffers are allowed, then first attempt to
@@ -2058,7 +2058,7 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 	}
 
 exit:
-	up(&hyperv_mmio_lock);
+	mutex_unlock(&hyperv_mmio_lock);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(vmbus_allocate_mmio);
@@ -2075,7 +2075,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 {
 	struct resource *iter;
 
-	down(&hyperv_mmio_lock);
+	mutex_lock(&hyperv_mmio_lock);
 	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
 		if ((iter->start >= start + size) || (iter->end <= start))
 			continue;
@@ -2083,7 +2083,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 		__release_region(iter, start, size);
 	}
 	release_mem_region(start, size);
-	up(&hyperv_mmio_lock);
+	mutex_unlock(&hyperv_mmio_lock);
 
 }
 EXPORT_SYMBOL_GPL(vmbus_free_mmio);
-- 
2.16.4

