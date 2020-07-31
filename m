Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C14234253
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Jul 2020 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbgGaJTP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 31 Jul 2020 05:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22965 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732153AbgGaJTM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 31 Jul 2020 05:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596187151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ITjza8QZs334kZDawRKP4E/FGkviB+rOAxL++W/FFU=;
        b=D/HxuniBO2RN0kp9Zkm3YpHn+w9DEuPfw9K2pbvYWH1mKV4tntKnmq2yQC+y3q4a5W4M2A
        wyz2S6sSz0B4nIqvPCzpOee0ijPcp/TUvX96JrJtuytnVzA7uf6OuDlnZ2S+Sr0PE0ugtT
        jcPgO0U+4y+UWEBRrmiVTyTYQ/z92co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-w-XOsNLgPyeml39HbUP41A-1; Fri, 31 Jul 2020 05:19:06 -0400
X-MC-Unique: w-XOsNLgPyeml39HbUP41A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F36F801504;
        Fri, 31 Jul 2020 09:19:05 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-22.ams2.redhat.com [10.36.113.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 035EC1A835;
        Fri, 31 Jul 2020 09:18:59 +0000 (UTC)
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
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH RFCv1 5/5] hv_balloon:: try to merge "System RAM" resources
Date:   Fri, 31 Jul 2020 11:18:38 +0200
Message-Id: <20200731091838.7490-6-david@redhat.com>
In-Reply-To: <20200731091838.7490-1-david@redhat.com>
References: <20200731091838.7490-1-david@redhat.com>
MIME-Version: 1.0
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
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/hv/hv_balloon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 32e3bc0aa665a..0745f7cc1727b 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -745,6 +745,9 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 			has->covered_end_pfn -=  processed_pfn;
 			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 			break;
+		} else {
+			/* Try to reduce the number of "System RAM" resources. */
+			merge_child_mem_resources(&iomem_resource, "System RAM");
 		}
 
 		/*
-- 
2.26.2

