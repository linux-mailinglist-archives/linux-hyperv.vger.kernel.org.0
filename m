Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1225234251
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Jul 2020 11:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbgGaJTH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 31 Jul 2020 05:19:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54024 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732176AbgGaJTG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 31 Jul 2020 05:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596187145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXo92L6xzVp7lbkKaGhQOH5PjMjS2UMyqhJq+SqZmjU=;
        b=eKz2GmRzt71ZPjgS2zsWodplxYWV8Uzf3VNCS/zSN/Ixo1Sf06HXasBEzxNvRSR6NI5iBj
        tYpCPWqZft+a7ljcRaO0FmaQrcFBIvLYbJPkPOnFrHjoTJSgq6YOthrjZn2m2ZFGiSD1FH
        TBP6Q25KFwaqg7pQ276qpbNqxVmDjLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-Vj_nV24LO0GNaNZsmopdDQ-1; Fri, 31 Jul 2020 05:19:01 -0400
X-MC-Unique: Vj_nV24LO0GNaNZsmopdDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A93C718C63C0;
        Fri, 31 Jul 2020 09:18:59 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-22.ams2.redhat.com [10.36.113.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39C481A835;
        Fri, 31 Jul 2020 09:18:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>
Subject: [PATCH RFCv1 4/5] xen/balloon: try to merge "System RAM" resources
Date:   Fri, 31 Jul 2020 11:18:37 +0200
Message-Id: <20200731091838.7490-5-david@redhat.com>
In-Reply-To: <20200731091838.7490-1-david@redhat.com>
References: <20200731091838.7490-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Let's reuse the new mechanism to merge "System RAM" resources below the
root. We are the only one hotplugging "System RAM" and DIMMs don't apply,
so this is safe to use.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: Julien Grall <julien@xen.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/xen/balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 77c57568e5d7f..644ae2e3798e2 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -353,6 +353,10 @@ static enum bp_state reserve_additional_memory(void)
 	if (rc) {
 		pr_warn("Cannot add additional memory (%i)\n", rc);
 		goto err;
+	} else {
+		resource = NULL;
+		/* Try to reduce the number of "System RAM" resources. */
+		merge_child_mem_resources(&iomem_resource, "System RAM");
 	}
 
 	balloon_stats.total_pages += balloon_hotplug;
-- 
2.26.2

