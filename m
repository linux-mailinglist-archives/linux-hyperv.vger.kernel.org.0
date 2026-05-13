Return-Path: <linux-hyperv+bounces-10859-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GF2H+zKBGp2OwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10859-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:03:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBB539810
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A5F5311B049
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C083AE6FD;
	Wed, 13 May 2026 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JeKWe1BR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0293B1032;
	Wed, 13 May 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698281; cv=none; b=ilD9VVJAP1kRPhsuu729ChCfAl7hskrOv93anXZGbK1UK4oLj1QMILTeA5dBfUJRysmgV6Vzcwj7N1dC8lrEanp6AcnSwoXoyhbMUse/IfjNsDuOUuQ9q/z8v0oBXVvPk2yd4cRMTZP8b2EE31m7LttKzBI+4fDqR/2yk1auGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698281; c=relaxed/simple;
	bh=9gaG6m3IJ3Zx6LaJ0kh50lVBZm8TZZ7pMp9GTsREOkg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRt+K6ro3kw0GeBvWLVzOgtmRPaNDAiSgsOMCazPZrdEPNoNZXZrT+qDARbtjbIwIAqdOHh2IawbLV8pLIof7wn6wTDk/6qutsTw9OlLSF9X7YFA85XKF/8AV2hT/LEaVWGNz4nzu3EuOsgiTbefbTumRf2lWeXtSbfJWWupxnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JeKWe1BR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B6CF920B7166;
	Wed, 13 May 2026 11:51:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6CF920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698276;
	bh=GD4pbVn2rJ6iAXjMrdJpfPayT9LJbZe7f+51aLpsZxk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JeKWe1BR/Hz0ZwU/P/irAqdP7YvRvBbDLWg/QaOju07gepVGOsdxdy4YtDOyQFuxC
	 Qvwg298Sg/O7UTmw5FZ/RjhuVgKIBfOixsmM5tkC5WpHwZsTY08fjKRZ8Hm6NmZ08H
	 jAWmJNQoxfPI/8/N5q/S8AEmyE2CFID7ArEuSIhE=
Subject: [PATCH v3 11/11] mshv: Add tracepoint for map GPA hypercall
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:51:19 +0000
Message-ID: 
 <177869827938.18773.10391260955566776029.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C7EBB539810
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10859-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

Add tracing for GPA mapping hypercalls to aid in debugging memory
management issues in child partitions. The tracepoint captures both
successful and failed mapping attempts, including the number of pages
successfully mapped before any failure occurred.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c |    3 +++
 drivers/hv/mshv_trace.h        |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 00d37c39cbf26..ccf297fbfae3a 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -250,6 +250,9 @@ static int hv_do_map_pfns(u64 partition_id, u64 gfn, u64 pfns_count,
 		}
 	}
 
+	trace_mshv_map_pfns(partition_id, gfn, pfns_count, page_count,
+			    flags, mmio_spa, done, ret);
+
 	if (ret && done) {
 		u32 unmap_flags = 0;
 
diff --git a/drivers/hv/mshv_trace.h b/drivers/hv/mshv_trace.h
index e7280c47e579a..619c4563d4211 100644
--- a/drivers/hv/mshv_trace.h
+++ b/drivers/hv/mshv_trace.h
@@ -538,6 +538,42 @@ TRACE_EVENT(mshv_handle_gpa_intercept,
 	    )
 );
 
+TRACE_EVENT(mshv_map_pfns,
+	    TP_PROTO(u64 partition_id, u64 gfn, u64 pfn_count, u64 page_count, u32 flags,
+		     u64 mmio_spa, u64 done, int ret),
+	    TP_ARGS(partition_id, gfn, pfn_count, page_count, flags, mmio_spa, done, ret),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u64, gfn)
+		    __field(u64, pfn_count)
+		    __field(u64, page_count)
+		    __field(u32, flags)
+		    __field(u64, mmio_spa)
+		    __field(u64, done)
+		    __field(int, ret)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->gfn = gfn;
+		    __entry->pfn_count = pfn_count;
+		    __entry->page_count = page_count;
+		    __entry->flags = flags;
+		    __entry->mmio_spa = mmio_spa;
+		    __entry->done = done;
+		    __entry->ret = ret;
+	    ),
+	    TP_printk("partition_id=%llu gfn=0x%llx pfn_count=%llu page_count=%llu flags=0x%x mmio_spa=0x%llx done=%llu ret=%d",
+		    __entry->partition_id,
+		    __entry->gfn,
+		    __entry->pfn_count,
+		    __entry->page_count,
+		    __entry->flags,
+		    __entry->mmio_spa,
+		    __entry->done,
+		    __entry->ret
+	    )
+);
+
 #endif /* _MSHV_TRACE_H_ */
 
 /* This part must be outside protection */



