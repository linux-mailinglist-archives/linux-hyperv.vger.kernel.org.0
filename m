Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9C1CFC8A
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 16:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfJHOhH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 10:37:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40258 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHOhH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 10:37:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so10348098pgl.7;
        Tue, 08 Oct 2019 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/LkLNZyXllVODaNA4v6SjRbRTQO3k0FhwJL3ACT+pc8=;
        b=mz4tTuSopA61Uk2c4cwTxPD1ttgQPVt23a8s2ab5wZNvSsN58+xofcbe8p2AlOqMvb
         q0ClxaWzdCAX/ZztkYIusI1VP7spYpRsUEOay6if9370EKjvHasB+I5mypjmn9UPxdYJ
         4nCJ0s1uvUBHMfthAvg+E+SrYLAfbZwlB+3K/THlXoNXtIuQf3UBLxuGPnnpoSZO0TRh
         /4pEiyVn8CBlYUBVgJloR5A405qAtMBHasSYUesTHSYrn7qfIqt9AihFG2SMmHG0J6jj
         7BIY5SQiUQvIAUaGSCYbHkSsTWihgp/2ggOh3m7dISP6JA9Q7Jyy5LXLyFjyRjSpxWih
         R/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/LkLNZyXllVODaNA4v6SjRbRTQO3k0FhwJL3ACT+pc8=;
        b=iWDSQd7LYvFcCOdYNpSrHvSp3VsY4rAGISEYANchJIgLL69QRHv2/YTE+ZGay6JQuo
         CtZHjnCBvvTGO6qcuCnSwLNPOYupVOYsi4lMwTbUUsQDh0iK3Sd++nVb8wdZQkBa7XUu
         AjCeCDZmvpHflVW/x/ot62Nf9AfCEx5RNNxUIAR5Yj+2vgRKvOvfdjSHAJprqJY2vdK1
         7lziHxp5rUfJrmYVqjSs66q8CSPp4HPo722PSalV/UfPULAvXSkc7MymA9WKO8udu4IA
         sCPSZFZU+MkrtrSJApGBkzzkJESIN4DXDihCig6eeEsmxPE3ZHyHcpLpmbimiQDEq9oN
         affw==
X-Gm-Message-State: APjAAAVo5px36GXSMEkd1IHz5oikgkWsBSkLQgNtggqy29zWjYwjmqio
        cwWEBpNsnxSNZmjbMiNcryY=
X-Google-Smtp-Source: APXvYqzVmLYxVnf7lMb8Y0OcU8us4+UeXkrqpUjxJeb+iLiGDzZdEaRy3btAdo69l4i1EIElQVrmLw==
X-Received: by 2002:a63:a48:: with SMTP id z8mr19160809pgk.328.1570545426091;
        Tue, 08 Oct 2019 07:37:06 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.39])
        by smtp.googlemail.com with ESMTPSA id 74sm20603109pfy.78.2019.10.08.07.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 07:37:05 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, akpm@linux-foundation.org, rppt@linux.ibm.com,
        jgross@suse.com, mhocko@suse.com, paul.burton@mips.com,
        m.mizuma@jp.fujitsu.com, huang.zijiang@zte.com.cn,
        karahmed@amazon.de, dan.j.williams@intel.com, bhelgaas@google.com,
        osalvador@suse.de, rdunlap@infradead.org,
        richardw.yang@linux.intel.com, david@redhat.com,
        pavel.tatashin@microsoft.com, cai@lca.pw, arunks@codeaurora.org,
        vbabka@suse.cz, mgorman@techsingularity.net,
        alexander.h.duyck@linux.intel.com, glider@google.com,
        logang@deltatee.com, bsingharora@gmail.com, bhe@redhat.com,
        Tianyu.Lan@microsoft.com, michael.h.kelley@microsoft.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-mm@kvack.org,
        vkuznets@redhat.com
Subject: [RFC PATCH] mm: set memory section offline when all its pages are offline.
Date:   Tue,  8 Oct 2019 22:36:48 +0800
Message-Id: <20191008143648.11882-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

If size of offline memory region passed to offline_pages() is
not aligned with PAGES_PER_SECTION, memory section will be set
to offline in the offline_mem_sections() with some pages of
memory section online. Fix it, Update memory section status after
marking offline pages as "reserved" in __offline_isolated_pages()
and check all pages in memory are reserved or not before setting
memory section offline.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
This patch is to prepare for hot remove memory function in Hyper-V
balloon driver. It requests to offline memory with random size.
---
 mm/page_alloc.c |  3 ++-
 mm/sparse.c     | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dbd0d5cbbcbb..cc02866924ae 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8540,7 +8540,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 	if (pfn == end_pfn)
 		return offlined_pages;
 
-	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
 	spin_lock_irqsave(&zone->lock, flags);
 	pfn = start_pfn;
@@ -8576,6 +8575,8 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 
+	offline_mem_sections(pfn, end_pfn);
+
 	return offlined_pages;
 }
 #endif
diff --git a/mm/sparse.c b/mm/sparse.c
index fd13166949b5..eb5860487b84 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -571,6 +571,7 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
+	int i;
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
@@ -583,6 +584,15 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 		if (WARN_ON(!valid_section_nr(section_nr)))
 			continue;
 
+		/*
+		 * Check whether all pages in the section are reserverd before
+		 * setting setction offline.
+		 */
+		for (i = 0; i < PAGES_PER_SECTION; i++)
+			if (!PageReserved(pfn_to_page(
+			    SECTION_ALIGN_DOWN(pfn + i))))
+				continue;
+
 		ms = __nr_to_section(section_nr);
 		ms->section_mem_map &= ~SECTION_IS_ONLINE;
 	}
-- 
2.14.5

