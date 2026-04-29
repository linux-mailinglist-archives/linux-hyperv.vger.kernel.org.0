Return-Path: <linux-hyperv+bounces-10481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHBSBlZL8mnNpQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10481-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:17:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1CD498E2E
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 983F5301ECC3
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4897D41C2F4;
	Wed, 29 Apr 2026 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZiRZzATB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1940241C2F8;
	Wed, 29 Apr 2026 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486665; cv=none; b=q7CNQ6eSoyQRNNidAqRZJCKyQKpudFg6cK8B84WUyZivOYIM/aluBKvzqrkpt+P6ln2W1b4dqEzLT3/gEHr4iM2o6FnSrEd2OnSxPXhjujYCbU+s6L3MjC6IeLHToW/Ngkyak9ygnaEsMTqV7cbx30jCCPW3YD0mtMKkrBpQnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486665; c=relaxed/simple;
	bh=o5JlmCpybjG5MsNTz398tJEvJkMBx6TNi+duEkrtSAU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KENJXRiOSlU16URgNzuSvrtWKZksaz8E8Ih8Cel5r0f9H2+rMn9OjaYUNSEs1NWiBbb/WOr8lyrjwqtNAXapRYEFMD18b5bqvu+JHBbZn7MqNgOfIz+Tlt000mKzZnShnraGrxDuFfSie5ZqjG8khYVAr7eah7ypvetx79W/uPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZiRZzATB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4073C20B716C;
	Wed, 29 Apr 2026 11:17:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4073C20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777486663;
	bh=axEPjyZjszH/nsZL/jAz0dfh6x8UCU6e4D5+z4jm83I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZiRZzATBErg1iTx0O43m99UZpgSTeyvYvfByIwXoexjQh6z5eOVU7S76lN67pczpl
	 SVwLPHV2IF8HoGfwF1PGz8s9q0FXEM7Fwl5MLyhjPUh0oOk9PGX5B9Mk5yXWg0srtW
	 2v3qcvH8npAdrgq4YCxYEiJ1FeoTPYOPaBCwY468=
Subject: [PATCH 01/10] mshv: Fix IRQ leak and type hazards in
 hv_call_modify_spa_host_access
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Apr 2026 18:17:42 +0000
Message-ID: 
 <177748666255.144491.18203407729614032415.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C1CD498E2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10481-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]

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
index f8c2341193da5..61871ad131b4b 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -1041,7 +1041,7 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 {
 	struct hv_input_modify_sparse_spa_page_host_access *input_page;
 	u64 status;
-	int done = 0;
+	u64 done = 0;
 	unsigned long irq_flags, large_shift = 0;
 	u64 page_count = page_struct_count;
 	u16 code = acquire ? HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS :
@@ -1058,9 +1058,9 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
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
@@ -1074,15 +1074,9 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
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



