Return-Path: <linux-hyperv+bounces-10593-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AQcCNnt+Gla3QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10593-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:04:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7453C4C2DE0
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0353D30209CC
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A323EE1F2;
	Mon,  4 May 2026 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XLxevOit"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE893EE1D0;
	Mon,  4 May 2026 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921493; cv=none; b=FwKV4huBbgvf7Vig/bGAvwmj8Y7rKVddhhTBqYbkv97r/xd9HpRKkq9YdOl9eu/UI2NARjC0Px3MpboW/+qokBXZWszU4GQa4muaK7XQowWYGK8tymsO9dSNFo7rjfhMrrJna7/0v0eiKgBQ5UDfu4EJfDPi4xfohUPSNWNOLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921493; c=relaxed/simple;
	bh=yhEZldU2zYAARv6dKYHhii2B0GthR85Izt7+jGi5yJ8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBHAI4s+bFG2dbXKCmAC38l/L4xtNFRPfrKhRedcmNqgHKqfFGntjaxcIu40pK+evx4p3YSN5VX8/46NSMOP0lUckXosRW70qdibwnUW3WufSfigv4BREwy6fAW3dUqAZdp2xv+xhiX7+Xx4DFvw/tSpnlBhUTVpVResMRCzBsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XLxevOit; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF88820B7168;
	Mon,  4 May 2026 12:04:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF88820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921485;
	bh=FkRA9VCDqKl/X8ObG2fk9lDRmh+cWFXRwvVw0bw480Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XLxevOit8pW9X87olvmpJwoHnoVGUNtn2w8ILkNfKyM0sIEkQycZ50Y7EuluAk63m
	 6PJjWC3qcjeFDpe+F3HHrvMK16jAAKwyD9JAAuf704C7N4whF1154A5fCvaMc1ySkb
	 Yop1LBjDfl9qzfbUybDxlKIrfdFKlvhW2Lgusl/E=
Subject: [PATCH v3] mshv: Fix IRQ leak and type hazards in
 hv_call_modify_spa_host_access
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:04:47 +0000
Message-ID: 
 <177792148718.90466.12661100641142863093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177792097254.89142.47656055124497980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177792097254.89142.47656055124497980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7453C4C2DE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10593-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]

The bounds check inside the PFN-filling loop can return -EINVAL while
interrupts are disabled via local_irq_save(), leaking IRQ state.

Remove the check — it is redundant because the loop invariant
(done + i < page_count == page_struct_count >> large_shift) guarantees
(done + i) << large_shift < page_struct_count always holds.

While here, fix type mismatches: change 'int done' to 'u64 done' and
use u64 for loop and batch-size variables so they match the u64
page_count they are compared against.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 129456bd72aba..cc580225e9e45 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -1042,7 +1042,7 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 {
 	struct hv_input_modify_sparse_spa_page_host_access *input_page;
 	u64 status;
-	int done = 0;
+	u64 done = 0;
 	unsigned long irq_flags, large_shift = 0;
 	u64 page_count = page_struct_count;
 	u16 code = acquire ? HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS :
@@ -1059,9 +1059,9 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 	}
 
 	while (done < page_count) {
-		ulong i, completed, remain = page_count - done;
-		int rep_count = min(remain,
-				    HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
+		u64 i, completed, remain = page_count - done;
+		u64 rep_count = min_t(u64, remain,
+				      HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
 
 		local_irq_save(irq_flags);
 		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -1075,15 +1075,9 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 		input_page->flags = flags;
 		input_page->host_access = host_access;
 
-		for (i = 0; i < rep_count; i++) {
-			u64 index = (done + i) << large_shift;
-
-			if (index >= page_struct_count)
-				return -EINVAL;
-
+		for (i = 0; i < rep_count; i++)
 			input_page->spa_page_list[i] =
-						page_to_pfn(pages[index]);
-		}
+				page_to_pfn(pages[(done + i) << large_shift]);
 
 		status = hv_do_rep_hypercall(code, rep_count, 0, input_page,
 					     NULL);



