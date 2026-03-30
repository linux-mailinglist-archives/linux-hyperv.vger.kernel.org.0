Return-Path: <linux-hyperv+bounces-9840-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG+dHc7YymmWAgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9840-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:10:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC09F360D64
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D142E306798A
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E4B398905;
	Mon, 30 Mar 2026 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XaJiTA3+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E4393DC1;
	Mon, 30 Mar 2026 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901093; cv=none; b=FQkgNlisgx6vBKzTdBukgJmU8WY58fOn2oGmHe4oMeQhlab6fhAbcjtewWtcU3fnqOC/3SovgfJiE4nQUT6CyRUdpDBveFDd0o9Pdq3+s9zWrsHN7YLsJjlG6hnZbMW2WCDWzy33en2n7yUhtlWN1qHWniK4ewsw2a9LLLG7DC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901093; c=relaxed/simple;
	bh=ABOy4gdsJh1vQ2VNuMAfLDMQ/eYW84ibI++4rt5B3UY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qx3DKtAH1n478r0wjl/OPhDbjuD44D5BMl77zI871J1SGkUqoFvP4CnZ0YOaSAXlE7XczKbCr5rQTKO6pQ6C/7S+mWUJvxwgxUSXeEAqKZZLARoDHfaNS5COZsduMuF9+0u2uU/HlabsnuJr1gYjqcjOgo4RB29e6CLGW+RVw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XaJiTA3+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id A8C9B20B6F08;
	Mon, 30 Mar 2026 13:04:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8C9B20B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774901092;
	bh=8j1HQvIjedHKdZDd/HvnflprlAcYRf2Md2miqmlhs4k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XaJiTA3+BvpSiK/uWoJK4vCn90qTTndlw1dIvoUqtTDi9FGHzNDc0WF4JIIAmHtkt
	 tzqDhdTqPTaSGWCupxVl6z8h20IuV1FJYcSF+20p/76lo+KckkhgRkFqaW9EC9MuRg
	 CfMmcVGb/ZiqlTbBwv0pzjofY6cBkwmt8XoyKjlM=
Subject: [PATCH 7/7] mshv: Add tracepoint for map GPA hypercall
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Mar 2026 20:04:52 +0000
Message-ID: 
 <177490109217.81669.2462215672010156740.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[linux.microsoft.com:server fail,skinsburskii-cloud-desktop.internal.cloudapp.net:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9840-lists,linux-hyperv=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: CC09F360D64
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



