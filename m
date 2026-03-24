Return-Path: <linux-hyperv+bounces-9743-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIlQN/gkw2l6ogQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9743-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 00:57:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00D31DDAC
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 00:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36DDF305832B
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 23:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8C3CAE81;
	Tue, 24 Mar 2026 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gubIJuDc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AF035C185;
	Tue, 24 Mar 2026 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396662; cv=none; b=ORFr3RPvsF5ZXUAi5D2L6QFGvRN4o1panRVcDcFvzQDwkO+tZXItsjV1EC93Fm1in6xlOAtuduVBaEi8OjWUK0I1C1aUCRevSLJZ8YzAs5m2ghP1Hn1IgVZStEmG1vBlO5m5uB+/OmCkHn49WYQo/iZL93HsqA+VgMGTuyeMVJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396662; c=relaxed/simple;
	bh=jOrLde8b0Czp0L/YYN/cw7bzLCYVj1D2z/bd+yhcemo=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=NqBT7eIoG4LsGz/SQlNHHRswyoXYla/tqkcbJRX6pMUBrwO5AoPaXqNN5CpwoxyGiiQ/QaWvQw1rxR9RoBTpgfKcfw1bR6agqvzUjTY8hCs5PkYQTet2hcTINIWak3wqKZnX53j9xrro+tpO/7D6kt5sfI7N2hxbnJT4/sgOQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gubIJuDc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id A4D4220B7128;
	Tue, 24 Mar 2026 16:57:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4D4220B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774396660;
	bh=k66/n62C5Es92M99w/eV7fWOt5/mRQMgm24aeLulam8=;
	h=Subject:From:To:Cc:Date:From;
	b=gubIJuDcn29Wxqg541I66Xf0Zc8Cn5aCNa0P9igcOmjqEdvhLtydDOur5DEtBE462
	 ZB4klLdyVLt97p3vRNxgLPXzpXJI5Keb1V69sm73H7dCQ1zwBnYdFnj1j74iV4vY8i
	 nsRt4UFh9maf59iFftjVVWZmpt83abB7Q0PspyRk=
Subject: [PATCH] mshv: Fix infinite fault loop on permission-denied GPA
 intercepts
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Mar 2026 23:57:40 +0000
Message-ID: 
 <177439665824.171668.3582744847973205980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9743-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A00D31DDAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Prevent infinite fault loops when guests access memory regions without
proper permissions. Currently, mshv_handle_gpa_intercept() attempts to
remap pages for all faults on movable memory regions, regardless of
whether the access type is permitted. When a guest writes to a read-only
region, the remap succeeds but the region remains read-only, causing
immediate re-fault and spinning the vCPU indefinitely.

Validate intercept access type against region permissions before
attempting remaps. Reject writes to non-writable regions and executes to
non-executable regions early, returning false to let the VMM handle the
intercept appropriately.

This also closes a potential DoS vector where malicious guests could
intentionally trigger these fault loops to consume host resources.

Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   15 ++++++++++++---
 include/hyperv/hvgdk_mini.h |    6 ++++++
 include/hyperv/hvhdk.h      |    4 ++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 9b0acd49c129..bb9fe4985e95 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -657,7 +657,7 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 {
 	struct mshv_partition *p = vp->vp_partition;
 	struct mshv_mem_region *region;
-	bool ret;
+	bool ret = false;
 	u64 gfn;
 #if defined(CONFIG_X86_64)
 	struct hv_x64_memory_intercept_message *msg =
@@ -668,6 +668,8 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 		(struct hv_arm64_memory_intercept_message *)
 		vp->vp_intercept_msg_page->u.payload;
 #endif
+	enum hv_intercept_access_type access_type =
+		msg->header.intercept_access_type;
 
 	gfn = HVPFN_DOWN(msg->guest_physical_address);
 
@@ -675,12 +677,19 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 	if (!region)
 		return false;
 
+	if (access_type == HV_INTERCEPT_ACCESS_WRITE &&
+	    !(region->hv_map_flags & HV_MAP_GPA_WRITABLE))
+		goto put_region;
+
+	if (access_type == HV_INTERCEPT_ACCESS_EXECUTE &&
+	    !(region->hv_map_flags & HV_MAP_GPA_EXECUTABLE))
+		goto put_region;
+
 	/* Only movable memory ranges are supported for GPA intercepts */
 	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
 		ret = mshv_region_handle_gfn_fault(region, gfn);
-	else
-		ret = false;
 
+put_region:
 	mshv_region_put(region);
 
 	return ret;
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 056ef7b6b360..98b15539e467 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1532,4 +1532,10 @@ struct hv_mmio_write_input {
 	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
 } __packed;
 
+enum hv_intercept_access_type {
+	HV_INTERCEPT_ACCESS_READ	= 0,
+	HV_INTERCEPT_ACCESS_WRITE	= 1,
+	HV_INTERCEPT_ACCESS_EXECUTE	= 2
+};
+
 #endif /* _HV_HVGDK_MINI_H */
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 245f3db53bf1..5e83d3714966 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -779,7 +779,7 @@ struct hv_x64_intercept_message_header {
 	u32 vp_index;
 	u8 instruction_length:4;
 	u8 cr8:4; /* Only set for exo partitions */
-	u8 intercept_access_type;
+	u8 intercept_access_type; /* enum hv_intercept_access_type */
 	union hv_x64_vp_execution_state execution_state;
 	struct hv_x64_segment_register cs_segment;
 	u64 rip;
@@ -825,7 +825,7 @@ union hv_arm64_vp_execution_state {
 struct hv_arm64_intercept_message_header {
 	u32 vp_index;
 	u8 instruction_length;
-	u8 intercept_access_type;
+	u8 intercept_access_type; /* enum hv_intercept_access_type */
 	union hv_arm64_vp_execution_state execution_state;
 	u64 pc;
 	u64 cpsr;



