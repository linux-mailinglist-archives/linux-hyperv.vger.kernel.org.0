Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445B1265E2F
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Sep 2020 12:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgIKKgp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Sep 2020 06:36:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48401 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbgIKKgM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Sep 2020 06:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599820570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YsfsAQ2XAkLrSeK5gDaCbmO+kEOKaYFgY1Wng1dGBy0=;
        b=WCJjup/g4XMJhYHmlOHSzrGCsNzg7sqnGfw2C6J++ic7gJE2MG/90ElFxSHL6J+75ziRiu
        vCjCgrWduwUOal7oIiHfXXliBOu0c6Ovc3Apx7r4ibWp3NyS3VU/GuxEejB4UWgBOBpIQu
        ICk0gEuey9sSDGx93CwgESfhJCHN9gE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-vEEKprzxPqCtphnzsAQlyw-1; Fri, 11 Sep 2020 06:36:07 -0400
X-MC-Unique: vEEKprzxPqCtphnzsAQlyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98CBD6408E;
        Fri, 11 Sep 2020 10:36:04 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-186.ams2.redhat.com [10.36.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 444B481C46;
        Fri, 11 Sep 2020 10:36:01 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Michal Hocko <mhocko@suse.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v4 8/8] hv_balloon: try to merge system ram resources
Date:   Fri, 11 Sep 2020 12:34:59 +0200
Message-Id: <20200911103459.10306-9-david@redhat.com>
In-Reply-To: <20200911103459.10306-1-david@redhat.com>
References: <20200911103459.10306-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Let's try to merge system ram resources we add, to minimize the number
of resources in /proc/iomem. We don't care about the boundaries of
individual chunks we added.

Reviewed-by: Wei Liu <wei.liu@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 3c0d52e244520..b64d2efbefe71 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 
 		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
 		ret = add_memory(nid, PFN_PHYS((start_pfn)),
-				(HA_CHUNK << PAGE_SHIFT), MHP_NONE);
+				(HA_CHUNK << PAGE_SHIFT), MEMHP_MERGE_RESOURCE);
 
 		if (ret) {
 			pr_err("hot_add memory failed error is %d\n", ret);
-- 
2.26.2

