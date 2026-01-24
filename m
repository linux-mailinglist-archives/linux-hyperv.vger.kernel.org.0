Return-Path: <linux-hyperv+bounces-8518-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gApzEaISdWkAAgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8518-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 19:42:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A605C7E827
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 19:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D36183023A7B
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 18:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9012259C92;
	Sat, 24 Jan 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="noer5zTu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F25B20B7ED;
	Sat, 24 Jan 2026 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280142; cv=none; b=hb/e5AEF3tUZeqjHUo1d+Lh6qCU7Y9U+pVZ/d5pzFIcbkkTRV0yaxhBV3jvVqyY1aKmv55ogEPiPjJV57Ls967vRkDAj9Zja0DJyxq2x4kmO3dQq7CscqMknRjVbgsq072VXbsqGWBEm470asq5SQ0jQL0bjHZ/FaBjqNyHfhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280142; c=relaxed/simple;
	bh=ZRwrc7QpnZW/HRScmuYmlYRK3LwcR3DVyz9vBxxmvLg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGVjvRu20qX7PdIZNwy1jNiP/ghyZPCFHURjpb3TwV9yBdsXdMANoDpYx1B5lLMSYDVMOIG9QvZnp7GS8GVYT+HoIrhNqkey73Oun/mtskl2WIR4/cyV5Q+hJW1BsQLehQnvKJib+o6PSTmhl83xssljh676V6KmnPnhOT0iye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=noer5zTu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 01B3320B716C;
	Sat, 24 Jan 2026 10:42:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 01B3320B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769280141;
	bh=eA+nG3vfeFyTZ0Mk5bJOxocYpGx9J5hYxQHB/ecszXA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=noer5zTuLJehxqp1VEWQQxDhUG3iA1/Yuqzb6StLDcLL8dQEe2+ASdXjqTHNKdWbs
	 3kYBa19qnATbBglS2A+FKfp4xo7pYMJxJCFdJlaIU6fY59A8ZdGQcmnMj1doN+Zd/L
	 qTdXhgy6u2/B6kQG0a5w143ulmh3SxX0QlDPnOeE=
Subject: [RFC PATCH 2/3] mshv: Account pages deposited to hypervisor
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 24 Jan 2026 18:42:20 +0000
Message-ID: 
 <176928014080.26405.17823443762395754699.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176927917602.26405.4149319776242398706.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176927917602.26405.4149319776242398706.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-8518-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: A605C7E827
X-Rspamd-Action: no action

This is a preparatory change for blocking kexec is there are any pages
deposited, as this information is lost after kexec and the pages aren't
accessible by kernel.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_proc.c           |    4 ++++
 drivers/hv/mshv_root.h         |    1 +
 drivers/hv/mshv_root_hv_call.c |    2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 89870c1b0087..39bbbedb0340 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -15,6 +15,8 @@
  */
 #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
 
+atomic_t hv_pages_deposited;
+
 /* Deposits exact number of pages. Must be called with interrupts enabled.  */
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 {
@@ -93,6 +95,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 		goto err_free_allocations;
 	}
 
+	atomic_add(page_count, &hv_pages_deposited);
+
 	ret = 0;
 	goto free_buf;
 
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 3c1d88b36741..c792afce0839 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -319,6 +319,7 @@ int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 a
 extern struct mshv_root mshv_root;
 extern enum hv_scheduler_type hv_scheduler_type;
 extern u8 * __percpu *hv_synic_eventring_tail;
+extern atomic_t hv_pages_deposited;
 
 struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 					   u64 uaddr, u32 flags);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 06f2bac8039d..4203af5190ee 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -73,6 +73,8 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 		for (i = 0; i < completed; i++)
 			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
 
+		atomic_sub(completed, &hv_pages_deposited);
+
 		if (!hv_result_success(status)) {
 			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
 				status = HV_STATUS_SUCCESS;



