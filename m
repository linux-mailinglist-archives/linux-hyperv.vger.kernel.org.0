Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D752824D28F
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 12:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHUKfc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 06:35:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728089AbgHUKfW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 06:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598006121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AeL7eQMcuzDtJ58y3twR8woldx1f2g3cujVSMwGjGgg=;
        b=f4atkxJjlh77DKACdy22VoaPcQ4vopSeQEfqAo5J39GRHCWAzLROVSfcT8RWbIR7mWwxSV
        XgVcYhG9gGdInbUWja9cYVT545jqAjeR2C7lUpEbK40+SZUdrvt/aV8hMoMTDPbxhsK+n5
        49BUXBFodelVyqVOsqjgwmGd/7TEq/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-Fg8UITSqMl-wo432KovFmA-1; Fri, 21 Aug 2020 06:35:17 -0400
X-MC-Unique: Fg8UITSqMl-wo432KovFmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DF0281F02D;
        Fri, 21 Aug 2020 10:35:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5684C60BF1;
        Fri, 21 Aug 2020 10:35:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v1 5/5] hv_balloon: try to merge system ram resources
Date:   Fri, 21 Aug 2020 12:34:31 +0200
Message-Id: <20200821103431.13481-6-david@redhat.com>
In-Reply-To: <20200821103431.13481-1-david@redhat.com>
References: <20200821103431.13481-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Let's use the new mechanism to merge system ram resources below the
root. We are the only one hotplugging system ram, e.g., DIMMs don't apply,
so this is safe to be used.

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
 drivers/hv/hv_balloon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 32e3bc0aa665a..49a6305f0fb73 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -745,6 +745,9 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 			has->covered_end_pfn -=  processed_pfn;
 			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 			break;
+		} else {
+			/* Try to reduce the number of system ram resources. */
+			merge_system_ram_resources(&iomem_resource);
 		}
 
 		/*
-- 
2.26.2

