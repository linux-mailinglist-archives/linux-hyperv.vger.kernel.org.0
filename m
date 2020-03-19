Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C5018B78F
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgCSNeV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 09:34:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39551 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729056AbgCSNNC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 09:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584623581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkDlvPR98RYVAd3dirKd0Pp/jfVah/NRA54g1n1dohY=;
        b=bpyxCaNdZLiQ7yy3/OptL55Qlod7p9uUzLFc1zkjvBRac9IV8EQ58D2K2yxFdkmxJwEtDr
        7lbP8BC7gG0KY/IzRWoSdskSvMwQRwmMxlLnzSnkbMhbFfLAuD09MQExi8ZYOEnqUOTaNQ
        44aj4gadVZRXY5/Fb5CN3zUiH5OOaqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-lQFdwT1bMsG7zSRvaB2cXA-1; Thu, 19 Mar 2020 09:12:57 -0400
X-MC-Unique: lQFdwT1bMsG7zSRvaB2cXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1090D107ACC4;
        Thu, 19 Mar 2020 13:12:55 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD6260BF7;
        Thu, 19 Mar 2020 13:12:49 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3 5/8] hv_balloon: don't check for memhp_auto_online manually
Date:   Thu, 19 Mar 2020 14:12:18 +0100
Message-Id: <20200319131221.14044-6-david@redhat.com>
In-Reply-To: <20200319131221.14044-1-david@redhat.com>
References: <20200319131221.14044-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We get the MEM_ONLINE notifier call if memory is added right from the
kernel via add_memory() or later from user space.

Let's get rid of the "ha_waiting" flag - the wait event has an inbuilt
mechanism (->done) for that. Initialize the wait event only once and
reinitialize before adding memory. Unconditionally call complete() and
wait_for_completion_timeout().

If there are no waiters, complete() will only increment ->done - which
will be reset by reinit_completion(). If complete() has already been
called, wait_for_completion_timeout() will not wait.

There is still the chance for a small race between concurrent
reinit_completion() and complete(). If complete() wins, we would not
wait - which is tolerable (and the race exists in current code as well).

Note: We only wait for "some" memory to get onlined, which seems to be
      good enough for now.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-hyperv@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/hv/hv_balloon.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index a02ce43d778d..32e3bc0aa665 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -533,7 +533,6 @@ struct hv_dynmem_device {
 	 * State to synchronize hot-add.
 	 */
 	struct completion  ol_waitevent;
-	bool ha_waiting;
 	/*
 	 * This thread handles hot-add
 	 * requests from the host as well as notifying
@@ -634,10 +633,7 @@ static int hv_memory_notifier(struct notifier_block =
*nb, unsigned long val,
 	switch (val) {
 	case MEM_ONLINE:
 	case MEM_CANCEL_ONLINE:
-		if (dm_device.ha_waiting) {
-			dm_device.ha_waiting =3D false;
-			complete(&dm_device.ol_waitevent);
-		}
+		complete(&dm_device.ol_waitevent);
 		break;
=20
 	case MEM_OFFLINE:
@@ -726,8 +722,7 @@ static void hv_mem_hot_add(unsigned long start, unsig=
ned long size,
 		has->covered_end_pfn +=3D  processed_pfn;
 		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
=20
-		init_completion(&dm_device.ol_waitevent);
-		dm_device.ha_waiting =3D !memhp_auto_online;
+		reinit_completion(&dm_device.ol_waitevent);
=20
 		nid =3D memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
 		ret =3D add_memory(nid, PFN_PHYS((start_pfn)),
@@ -753,15 +748,14 @@ static void hv_mem_hot_add(unsigned long start, uns=
igned long size,
 		}
=20
 		/*
-		 * Wait for the memory block to be onlined when memory onlining
-		 * is done outside of kernel (memhp_auto_online). Since the hot
-		 * add has succeeded, it is ok to proceed even if the pages in
-		 * the hot added region have not been "onlined" within the
-		 * allowed time.
+		 * Wait for memory to get onlined. If the kernel onlined the
+		 * memory when adding it, this will return directly. Otherwise,
+		 * it will wait for user space to online the memory. This helps
+		 * to avoid adding memory faster than it is getting onlined. As
+		 * adding succeeded, it is ok to proceed even if the memory was
+		 * not onlined in time.
 		 */
-		if (dm_device.ha_waiting)
-			wait_for_completion_timeout(&dm_device.ol_waitevent,
-						    5*HZ);
+		wait_for_completion_timeout(&dm_device.ol_waitevent, 5 * HZ);
 		post_status(&dm_device);
 	}
 }
@@ -1706,6 +1700,7 @@ static int balloon_probe(struct hv_device *dev,
=20
 #ifdef CONFIG_MEMORY_HOTPLUG
 	set_online_page_callback(&hv_online_page);
+	init_completion(&dm_device.ol_waitevent);
 	register_memory_notifier(&hv_memory_nb);
 #endif
=20
--=20
2.24.1

