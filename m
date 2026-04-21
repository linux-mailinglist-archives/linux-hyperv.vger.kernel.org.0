Return-Path: <linux-hyperv+bounces-10281-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNi1NqeN52m89wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10281-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:45:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B143C43D
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE641305A264
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322EF3D9DC5;
	Tue, 21 Apr 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pVvDAMvS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0923D9052;
	Tue, 21 Apr 2026 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782155; cv=none; b=p8Sg7m9axlLZqKGn9MGSBiEMvPvL/Dz6BtyHNotEbubx/oyOP6aNVaGe9Ur5LkRutL4wyVFx8DexBpnv9aoDOL0eYQ54knqEjp87KF4sgsTVlQmUiRbY7Yexn1KCFbBbAUOowP4tUS5X5rSFkvB/Msz4RjCNHLutu3xbgkoMC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782155; c=relaxed/simple;
	bh=ABOy4gdsJh1vQ2VNuMAfLDMQ/eYW84ibI++4rt5B3UY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpT5VlDCaWWTf+F4VLMaFdxQu+4YDxxXgozZkZSUHGqdpb2i8i6HYqpLO5gAAbtyyfDDSI3uY17K8qblO6ZxQ9bPgsRCsa4sOYiOEwkFWMgqOU0sd6kKg+o9fGAHamh933NKeBAbyY2KQNkoJcYFMUhXHdlHviZsGp2oDqDtBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pVvDAMvS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id E0B3A20B6F01;
	Tue, 21 Apr 2026 07:35:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0B3A20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776782153;
	bh=8j1HQvIjedHKdZDd/HvnflprlAcYRf2Md2miqmlhs4k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pVvDAMvSu5HRRql4AxllQrsCCuxoWqx9Jok8hvyLwxS3vH1vjX8tlknpqpRBQmfdo
	 mZs6rm7RqsE28BR1vrAKqLl+78ZBHCiP6BdsH6dD25Xt+q22DWlmAZNPma0PQ1hiR4
	 0dx8vEXIGXtzHHtkrdvCNQwo7s4xEvQLW8pcpM4U=
Subject: [PATCH v2 7/7] mshv: Add tracepoint for map GPA hypercall
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Apr 2026 14:35:53 +0000
Message-ID: 
 <177678215337.13344.10573778271917726667.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	TAGGED_FROM(0.00)[bounces-10281-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: 547B143C43D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index a95f2cfc5da5..7ed623668c8e 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -260,6 +260,9 @@ static int hv_do_map_pfns(u64 partition_id, u64 gfn, u64 pfns_count,
 		done += completed;
 	}
 
+	trace_mshv_map_pfns(partition_id, gfn, pfns_count, page_count,
+			    flags, mmio_spa, done, ret);
+
 	if (ret && done) {
 		u32 unmap_flags = 0;
 
diff --git a/drivers/hv/mshv_trace.h b/drivers/hv/mshv_trace.h
index 6b8fa477fa3b..efd2b5d4ab73 100644
--- a/drivers/hv/mshv_trace.h
+++ b/drivers/hv/mshv_trace.h
@@ -538,6 +538,42 @@ TRACE_EVENT(mshv_handle_gpa_intercept,
 	    )
 );
 
+TRACE_EVENT(mshv_map_pfns,
+	    TP_PROTO(u64 partition_id, u64 gfn, u64 pfn_count, u64 page_count, u32 flags,
+		     u64 mmio_spa, int done, int ret),
+	    TP_ARGS(partition_id, gfn, pfn_count, page_count, flags, mmio_spa, done, ret),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u64, gfn)
+		    __field(u64, pfn_count)
+		    __field(u64, page_count)
+		    __field(u32, flags)
+		    __field(u64, mmio_spa)
+		    __field(int, done)
+		    __field(int, ret)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->gfn = gfn;
+		    __entry->page_count = page_count;
+		    __entry->pfn_count = pfn_count;
+		    __entry->flags = flags;
+		    __entry->mmio_spa = mmio_spa;
+		    __entry->done = done;
+		    __entry->ret = ret;
+	    ),
+	    TP_printk("partition_id=%llu gfn=0x%llx pfn_count=%llu page_count=%llu flags=0x%x mmio_spa=0x%llx done=%d ret=%d",
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



