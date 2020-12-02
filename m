Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22C2CC1D9
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 17:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgLBQO3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 11:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730567AbgLBQO3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 11:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606925582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaFhXQZtQXCRojqbjwjt4qssxuRxO0wtxwWehTIiNaU=;
        b=LvFIKl1RIpYKetfpeT3bF9Du7tceAUjVifvhFq4KEb2m2T0WWXvdq8V6mCEKFiWnzahpyj
        WqqtFp3VYQtjeL/3equgUuyg8h+PoiWLjdt6gckxk8ApzI30lCuq8LquIyWZuo03Yx8h7q
        st1MKwgrjz2XQsionPf+1TaeWR0juhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-1xUc7NQWP-yOwR6TKZlV3Q-1; Wed, 02 Dec 2020 11:12:58 -0500
X-MC-Unique: 1xUc7NQWP-yOwR6TKZlV3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 705901006C81;
        Wed,  2 Dec 2020 16:12:57 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.192.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 709145C1B4;
        Wed,  2 Dec 2020 16:12:52 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] hv_balloon: simplify math in alloc_balloon_pages()
Date:   Wed,  2 Dec 2020 17:12:44 +0100
Message-Id: <20201202161245.2406143-2-vkuznets@redhat.com>
In-Reply-To: <20201202161245.2406143-1-vkuznets@redhat.com>
References: <20201202161245.2406143-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

'alloc_unit' in alloc_balloon_pages() is either '512' for 2M allocations or
'1' for 4k allocations. So

1 << get_order(alloc_unit << PAGE_SHIFT)

equals to 'alloc_unit' and the for loop basically sets all them offline.
Simplify the math to improve the readability.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index eb56e09ae15f..da3b6bd2367c 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1238,7 +1238,7 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 			split_page(pg, get_order(alloc_unit << PAGE_SHIFT));
 
 		/* mark all pages offline */
-		for (j = 0; j < (1 << get_order(alloc_unit << PAGE_SHIFT)); j++)
+		for (j = 0; j < alloc_unit; j++)
 			__SetPageOffline(pg + j);
 
 		bl_resp->range_count++;
-- 
2.26.2

