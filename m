Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882592CC1DB
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgLBQOc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 11:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730667AbgLBQOb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 11:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606925585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZG0IaP7lxvBzgG5lqt7RoK3LK3aNw0DkDp+YEz1Y/0=;
        b=BddX60hiiMzh/NtFD6xYxZFgjTbCIzljWMjSpNFhFjDWF7cBfPCNBzjUk+Nzg31MXqk5z/
        /w8TDmQVur0EKboKuL7ctCKCMIqiuFgpJkruupiL1xg0gJN5xhKxD6I4TgJ9mMi+0yV+Hv
        u4Frb/MtGnM2WnhSBY0Qm7DvjzhHW78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-eGdF3qlHNkCsp6VIUssoiQ-1; Wed, 02 Dec 2020 11:13:01 -0500
X-MC-Unique: eGdF3qlHNkCsp6VIUssoiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9A0A1006C9E;
        Wed,  2 Dec 2020 16:12:59 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.192.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BED0F5C1BD;
        Wed,  2 Dec 2020 16:12:57 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] hv_balloon: do adjust_managed_page_count() when ballooning/un-ballooning
Date:   Wed,  2 Dec 2020 17:12:45 +0100
Message-Id: <20201202161245.2406143-3-vkuznets@redhat.com>
In-Reply-To: <20201202161245.2406143-1-vkuznets@redhat.com>
References: <20201202161245.2406143-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Unlike virtio_balloon/virtio_mem/xen balloon drivers, Hyper-V balloon driver
does not adjust managed pages count when ballooning/un-ballooning and this leads
to incorrect stats being reported, e.g. unexpected 'free' output.

Note, the calculation in post_status() seems to remain correct: ballooned out
pages are never 'available' and we manually add dm->num_pages_ballooned to
'commited'.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/hv_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index da3b6bd2367c..8c471823a5af 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1198,6 +1198,7 @@ static void free_balloon_pages(struct hv_dynmem_device *dm,
 		__ClearPageOffline(pg);
 		__free_page(pg);
 		dm->num_pages_ballooned--;
+		adjust_managed_page_count(pg, 1);
 	}
 }
 
@@ -1238,8 +1239,10 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 			split_page(pg, get_order(alloc_unit << PAGE_SHIFT));
 
 		/* mark all pages offline */
-		for (j = 0; j < alloc_unit; j++)
+		for (j = 0; j < alloc_unit; j++) {
 			__SetPageOffline(pg + j);
+			adjust_managed_page_count(pg + j, -1);
+		}
 
 		bl_resp->range_count++;
 		bl_resp->range_array[i].finfo.start_page =
-- 
2.26.2

