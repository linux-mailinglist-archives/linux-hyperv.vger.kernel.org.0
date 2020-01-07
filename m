Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07378132742
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgAGNKj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:10:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37878 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNKi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so28582481pfn.4;
        Tue, 07 Jan 2020 05:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t/hIgT0hLhsLlrQ5H9Za0DwQ5sLSM+KtbwF9tV3iU+M=;
        b=lHyKBaV0kKXkTefQP0T8FzfwSAs4NthEFDNhYnJTtMLcQDQ0Rp+8xGRt0p88s4b2yu
         KWzm9FEd4NuJMeCQVlpBBEiRnMFsKaaCFNjpEWbLT1TEP1+31B+4gNX8gmXdndFZ68Ev
         s8VrBAWDWbsshvPP3gtmSe3zXTkTBl3Q4iGYd9v9WVyBapkD1wu4psJsoxSrbpC1er1o
         Wk1EdQymP0WW8+AbR84wiMJr6IiXqWsLO1fnl1BaMUqtTBoAFljrTxzXCQeYilD8itxg
         7BmdjrgSy71JeVf+OaxIUgdjobRS7LMALZ9UqTUuL5Y/GqVF8ELak3jvm+lXSvkmnY93
         ceHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t/hIgT0hLhsLlrQ5H9Za0DwQ5sLSM+KtbwF9tV3iU+M=;
        b=PCs/k7e3JpLgyTKNw6RA4TgIWmbeYhjoZ4V3d6kpDJAz1AGWgHsPoYGdTfYORN2zZD
         XVilsrc2+mqp3GR+Q+Ocj41utM0ZRtdseIG9bUwuJOodGq4zmLjqLs4wYlyX/jjeY+vD
         LvrReqyIr6Y0PnQ8PRQXjsqWgCGO/WlVOAsAcBH84xfEmXcWctzdI2rJpCs4vUrGIlYF
         8RR/4XRo2HfVBuRFLn9RBrfQyRJXWWAxPzVI6ozlPiLus5s1FUDh4LwKF3pWIpgFNIMU
         nHPLkHfiGuGWI/+H+wDPjW+4plh6g+XgJDo/MT82TO1rx6z0fdSaTUsxwmAgLLXwhO27
         mU3w==
X-Gm-Message-State: APjAAAUvrvtoLdWjuBsGGouHRtfPpVPSy8GtL8ehaAt0OM/1QJkmdFJO
        J1+w2BD3lYKFwtZLP/HM+G4=
X-Google-Smtp-Source: APXvYqxobsBjF7xbFl66RNeVqJzvcLDPbSq+bse2vo4RhHeY96CYuxF6b+y75BLNY6EOPtId0YMGmw==
X-Received: by 2002:aa7:90cc:: with SMTP id k12mr92364710pfk.105.1578402637626;
        Tue, 07 Jan 2020 05:10:37 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:37 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, michael.h.kelley@microsoft.com, david@redhat.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH V2 9/10] x86/Hyper-V/Balloon: Hot add mem in the gaps of hot add region
Date:   Tue,  7 Jan 2020 21:09:49 +0800
Message-Id: <20200107130950.2983-10-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Mem hot remove operation may find memory in the hot add region
and create gaps in ha region list if there is hot-add memory
at that point. The following hot add msg may contain memory range
in these gaps. Handle such request and change gap range after
adding memory.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv_balloon.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index f76c9bd7fe2f..5aaae62955bf 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -907,10 +907,11 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 			continue;
 
 		/*
-		 * If the current start pfn is not where the covered_end
-		 * is, create a gap and update covered_end_pfn.
+		 * If the current start pfn is greater than covered_end_pfn,
+		 * create a gap and update covered_end_pfn. Start pfn may
+		 * locate at gap rangs which is created during mem hot remove.
 		 */
-		if (has->covered_end_pfn != start_pfn) {
+		if (has->covered_end_pfn < start_pfn) {
 			gap = kzalloc(sizeof(struct hv_hotadd_gap), GFP_ATOMIC);
 			if (!gap) {
 				ret = -ENOMEM;
@@ -949,6 +950,91 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 	return ret;
 }
 
+static int handle_hot_add_in_gap(unsigned long start, unsigned long pg_cnt,
+			  struct hv_hotadd_state *has)
+{
+	struct hv_hotadd_gap *gap, *new_gap, *tmp_gap;
+	unsigned long pfn_cnt = pg_cnt;
+	unsigned long start_pfn = start;
+	unsigned long end_pfn;
+	unsigned long pages;
+	unsigned long pgs_ol;
+	unsigned long block_pages = HA_CHUNK;
+	unsigned long pfn;
+	int nid;
+	int ret;
+
+	list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
+
+		if ((start_pfn < gap->start_pfn)
+		    || (start_pfn >= gap->end_pfn))
+			continue;
+
+		end_pfn = min(gap->end_pfn, start_pfn + pfn_cnt);
+		pgs_ol = end_pfn - start_pfn;
+
+		/*
+		 * hv_bring_pgs_online() identifies whether pfn
+		 * should be online or not via checking pfn is in
+		 * hot add covered range or gap range(Detail see
+		 * has_pfn_is_backed()). So adjust gap before bringing
+		 * online or add memory.
+		 */
+		if (gap->end_pfn - gap->start_pfn == pgs_ol) {
+			list_del(&gap->list);
+			kfree(gap);
+		} else if (gap->start_pfn < start && gap->end_pfn == end_pfn) {
+			gap->end_pfn = start_pfn;
+		} else if (gap->end_pfn > end_pfn
+		   && gap->start_pfn == start_pfn) {
+			gap->start_pfn = end_pfn;
+		} else {
+			gap->end_pfn = start_pfn;
+
+			new_gap = kzalloc(sizeof(struct hv_hotadd_gap),
+					GFP_ATOMIC);
+			if (!new_gap) {
+				do_hot_add = false;
+				return -ENOMEM;
+			}
+
+			INIT_LIST_HEAD(&new_gap->list);
+			new_gap->start_pfn = end_pfn;
+			new_gap->end_pfn = gap->end_pfn;
+			list_add_tail(&gap->list, &has->gap_list);
+		}
+
+		/* Bring online or add memmory in gaps. */
+		for (pfn = start_pfn; pfn < end_pfn;
+		     pfn = round_up(pfn + 1, block_pages)) {
+			pages = min(round_up(pfn + 1, block_pages),
+				    end_pfn) - pfn;
+
+			if (online_section_nr(pfn_to_section_nr(pfn))) {
+				hv_bring_pgs_online(has, pfn, pages);
+			} else {
+				nid = memory_add_physaddr_to_nid(PFN_PHYS(pfn));
+				ret = add_memory(nid, PFN_PHYS(pfn),
+						 round_up(pages, block_pages)
+						 << PAGE_SHIFT);
+				if (ret) {
+					pr_err("Fail to add memory in gaps(error=%d).\n",
+					       ret);
+					do_hot_add = false;
+					return ret;
+				}
+			}
+		}
+
+		start_pfn += pgs_ol;
+		pfn_cnt -= pgs_ol;
+		if (!pfn_cnt)
+			break;
+	}
+
+	return pg_cnt - pfn_cnt;
+}
+
 static unsigned long handle_pg_range(unsigned long pg_start,
 					unsigned long pg_count)
 {
@@ -975,6 +1061,22 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 
 		old_covered_state = has->covered_end_pfn;
 
+		/*
+		 * If start_pfn is less than cover_end_pfn, the hot-add memory
+		 * area is in the gap range.
+		 */
+		if (start_pfn < has->covered_end_pfn) {
+			pgs_ol = handle_hot_add_in_gap(start_pfn, pfn_cnt, has);
+
+			pfn_cnt -= pgs_ol;
+			if (!pfn_cnt) {
+				res = pgs_ol;
+				break;
+			}
+
+			start_pfn += pgs_ol;
+		}
+
 		if (start_pfn < has->ha_end_pfn) {
 			/*
 			 * This is the case where we are backing pages
-- 
2.14.5

