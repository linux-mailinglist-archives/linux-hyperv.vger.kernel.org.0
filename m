Return-Path: <linux-hyperv+bounces-10451-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFY4Ke5A8Wl0fQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10451-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:21:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BE448CF74
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6D9330358AB
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7856388391;
	Tue, 28 Apr 2026 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V2fF395h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E207382F32;
	Tue, 28 Apr 2026 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418474; cv=none; b=j1ALLBq/AwFAvBlcRSG2Ib3c/Z9ynXWlVRP/waPkEK0pK/1S0mCfyp+UDjuRS/f4gIyf5ciXo2uX8RDzUdUXhwgiEgZUYfGy3O5QFHQGnTYkKj4GkkFYET7h1cl3NB5+SlhaoC3BDoDg159n03G0In0BIb2eBgBv6tRjfYOnVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418474; c=relaxed/simple;
	bh=NQ6GloC2Fhcq1DTePp31FCbmdGI3SEJ9V+7VY/6THo8=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=dlGJo4/4aI/ssIKNbkUtWd4tKiYQf/PqM1VwvzKH9g0iXVuo2R8F0I9Z2OU+kZPgLKrIx1GDWpuMx19sdDeBCjjIzWK+vVPYfjraKeNHjHWFpQuOTBlr4NGkXNWh1wAEXP5/LO8bnF0PwvWEc20dyZYfWvHVkxlsaXdAavcgEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V2fF395h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C98120B716C;
	Tue, 28 Apr 2026 16:21:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C98120B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777418473;
	bh=2OecspBy3uZ2KETfX3E1pZuh4ad0Bit6nEz+AG2RbNY=;
	h=Subject:From:To:Cc:Date:From;
	b=V2fF395hFfbbfjD+7+zM4vjOUmNlZKO8ErMySmxt0ZBrFcaPCjWUrZh8N6TjS4uGg
	 eQ/EBwlNQlsfw3DP1G309Y7ykzRg7Gg8CZA9rIrwZiyAPnCrJEtDjH/OZNwEtLgNfR
	 GWnnJ2/FqtgyFNsNgy2CEZNMCRQ3kRr3uJVTcKa8=
Subject: [PATCH] mshv: Simplify GPA map/unmap hypercall helpers
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 28 Apr 2026 23:21:12 +0000
Message-ID: 
 <177741845948.632922.14128507833980339307.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 15BE448CF74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10451-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim]

Clean up hv_do_map_gpa_hcall() and hv_call_unmap_gpa_pages() after the
preceding bug-fix patches:

Move "done += completed" before the status checks so that pages mapped
by a partially-successful batch are included in the error cleanup unmap.
Previously these mappings were leaked on failure.

While here, improve type safety and readability:
 - Change "int done" to "u64 done" to match the u64 page_count it is
   compared against, avoiding signed/unsigned comparison hazards.
 - Use u64 for loop iteration and batch size variables consistently.
 - Add proper braces to the for-loop body in hv_do_map_gpa_hcall().
 - Remove unnecessary "ret" variable from hv_call_unmap_gpa_pages().
 - Simplify the error-path unmap to use "done << large_shift" directly
   instead of mutating done in place.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c |   55 +++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index e5992c324904a..f5f205a397834 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -195,8 +195,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 	struct hv_input_map_gpa_pages *input_page;
 	u64 status, *pfnlist;
 	unsigned long irq_flags, large_shift = 0;
-	int ret = 0, done = 0;
-	u64 page_count = page_struct_count;
+	u64 done = 0, page_count = page_struct_count;
+	int ret = 0;
 
 	if (page_count == 0 || (pages && mmio_spa))
 		return -EINVAL;
@@ -213,8 +213,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 	}
 
 	while (done < page_count) {
-		ulong i, completed, remain = page_count - done;
-		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
+		u64 i, completed, remain = page_count - done;
+		u64 rep_count = min(remain, (u64)HV_MAP_GPA_BATCH_SIZE);
 
 		local_irq_save(irq_flags);
 		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -224,23 +224,13 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 		input_page->map_flags = flags;
 		pfnlist = input_page->source_gpa_page_list;
 
-		for (i = 0; i < rep_count; i++)
-			if (flags & HV_MAP_GPA_NO_ACCESS) {
+		for (i = 0; i < rep_count; i++) {
+			if (flags & HV_MAP_GPA_NO_ACCESS)
 				pfnlist[i] = 0;
-			} else if (pages) {
-				u64 index = (done + i) << large_shift;
-
-				if (index >= page_struct_count) {
-					ret = -EINVAL;
-					break;
-				}
-				pfnlist[i] = page_to_pfn(pages[index]);
-			} else {
+			else if (pages)
+				pfnlist[i] = page_to_pfn(pages[(done + i) << large_shift]);
+			else
 				pfnlist[i] = mmio_spa + done + i;
-			}
-		if (ret) {
-			local_irq_restore(irq_flags);
-			break;
 		}
 
 		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
@@ -248,29 +238,26 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 		local_irq_restore(irq_flags);
 
 		completed = hv_repcomp(status);
+		done += completed;
 
 		if (hv_result_needs_memory(status)) {
 			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
 						    HV_MAP_GPA_DEPOSIT_PAGES);
 			if (ret)
 				break;
-
 		} else if (!hv_result_success(status)) {
 			ret = hv_result_to_errno(status);
 			break;
 		}
-
-		done += completed;
 	}
 
 	if (ret && done) {
 		u32 unmap_flags = 0;
 
-		if (flags & HV_MAP_GPA_LARGE_PAGE) {
+		if (flags & HV_MAP_GPA_LARGE_PAGE)
 			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
-			done <<= large_shift;
-		}
-		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
+		hv_call_unmap_gpa_pages(partition_id, gfn,
+					done << large_shift, unmap_flags);
 	}
 
 	return ret;
@@ -305,7 +292,7 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
 	struct hv_input_unmap_gpa_pages *input_page;
 	u64 status, page_count = page_count_4k;
 	unsigned long irq_flags, large_shift = 0;
-	int ret = 0, done = 0;
+	u64 done = 0;
 
 	if (page_count == 0)
 		return -EINVAL;
@@ -319,8 +306,8 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
 	}
 
 	while (done < page_count) {
-		ulong completed, remain = page_count - done;
-		int rep_count = min(remain, HV_UMAP_GPA_PAGES);
+		u64 completed, remain = page_count - done;
+		u64 rep_count = min(remain, (u64)HV_UMAP_GPA_PAGES);
 
 		local_irq_save(irq_flags);
 		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -333,15 +320,13 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
 		local_irq_restore(irq_flags);
 
 		completed = hv_repcomp(status);
-		if (!hv_result_success(status)) {
-			ret = hv_result_to_errno(status);
-			break;
-		}
-
 		done += completed;
+
+		if (!hv_result_success(status))
+			return hv_result_to_errno(status);
 	}
 
-	return ret;
+	return 0;
 }
 
 int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,



