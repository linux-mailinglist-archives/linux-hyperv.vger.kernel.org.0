Return-Path: <linux-hyperv+bounces-8742-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEEhB6/khGlf6QMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8742-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:42:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBBAF687D
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93773302A6FF
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803C3033F2;
	Thu,  5 Feb 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KjLMgwB3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD13033CA;
	Thu,  5 Feb 2026 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316931; cv=none; b=uXINFTAhpMbHKclJ0S+nJnAMVgXEXXDNDt9vbwATuVYvoJIItfRfeeo77OGYwhK1SFFsjCOB/S8JhUBPuIM7eFqNdwXGxB+zQV/rnkZ8hJfNDqXTw3PZv8YRFrG7S9loBBgks1IWhLy561hDUlFXW2FsCJY1jCASyHRt7CwdKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316931; c=relaxed/simple;
	bh=u9EF78OWdrz3BKZFEylwzHj7k2SQAXQYND4TDMHfLcI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZdIQ45fhYz81DYDf04NeWNSk3g2YltgykKQJ6Rd3aGGJgr4KaGsZsgS9/BpNNoriVR9gV3yBb2xc5AC8EKNqTMrwVDnkMkXxrJbXLo5upm8slxYgKDtk8mgSeQWlHfnZbJtFbr3f2EImIDDfaLyVXMxd2wVxsH7DebNGBD9ZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KjLMgwB3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B8E4C20B716B;
	Thu,  5 Feb 2026 10:42:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8E4C20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770316930;
	bh=nCktl/BnD9/thtb6S3AKNyqz4Felai/D50+jCCtbtGA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KjLMgwB3Z6voAO5yqlqzl7PFKsnOjqsLer1G+TZAYG/uor8CCbmtyzM0vZ4Doz7Sw
	 J0e4ewQyUCAtEsWmQLrnkgExJPlIT09ULJTOsB5lbpr/91uNiV2h2ATnunkqB9diE7
	 icDjSqa7aIdh1y+nmKneulFi1uXaJg8KNCj0QNh4=
Subject: [PATCH v3 1/4] mshv: Introduce hv_result_needs_memory() helper
 function
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Feb 2026 18:42:10 +0000
Message-ID: 
 <177031693032.186911.1039899915987684479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8742-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DBBAF687D
X-Rspamd-Action: no action

Replace direct comparisons of hv_result(status) against
HV_STATUS_INSUFFICIENT_MEMORY with a new hv_result_needs_memory() helper
function.
This improves code readability and provides a consistent and extendable
interface for checking out-of-memory conditions in hypercall results.

No functional changes intended.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_proc.c           |   14 ++++++++++++--
 drivers/hv/mshv_root_hv_call.c |   25 ++++++++++++-------------
 drivers/hv/mshv_root_main.c    |    2 +-
 include/asm-generic/mshyperv.h |    3 +++
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index fbb4eb3901bb..e53204b9e05d 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -110,6 +110,16 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 }
 EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
+bool hv_result_needs_memory(u64 status)
+{
+	switch (hv_result(status)) {
+	case HV_STATUS_INSUFFICIENT_MEMORY:
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_result_needs_memory);
+
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 {
 	struct hv_input_add_logical_processor *input;
@@ -137,7 +147,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 					 input, output);
 		local_irq_restore(flags);
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			if (!hv_result_success(status)) {
 				hv_status_err(status, "cpu %u apic ID: %u\n",
 					      lp_index, apic_id);
@@ -179,7 +189,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
 		local_irq_restore(irq_flags);
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			if (!hv_result_success(status)) {
 				hv_status_err(status, "vcpu: %u, lp: %u\n",
 					      vp_index, flags);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index daee036e48bc..1c4a2dbf49c0 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -115,7 +115,7 @@ int hv_call_create_partition(u64 flags,
 		status = hv_do_hypercall(HVCALL_CREATE_PARTITION,
 					 input, output);
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			if (hv_result_success(status))
 				*partition_id = output->partition_id;
 			local_irq_restore(irq_flags);
@@ -147,7 +147,7 @@ int hv_call_initialize_partition(u64 partition_id)
 		status = hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
 					       *(u64 *)&input);
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			ret = hv_result_to_errno(status);
 			break;
 		}
@@ -239,7 +239,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 
 		completed = hv_repcomp(status);
 
-		if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (hv_result_needs_memory(status)) {
 			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
 						    HV_MAP_GPA_DEPOSIT_PAGES);
 			if (ret)
@@ -455,7 +455,7 @@ int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
 
 		status = hv_do_hypercall(control, input, output);
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			if (hv_result_success(status) && ret_output)
 				memcpy(ret_output, output, sizeof(*output));
 
@@ -518,7 +518,7 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
 
 		status = hv_do_hypercall(control, input, NULL);
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			local_irq_restore(flags);
 			ret = hv_result_to_errno(status);
 			break;
@@ -563,7 +563,7 @@ static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input,
 					 output);
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			if (hv_result_success(status))
 				*state_page = pfn_to_page(output->map_location);
 			local_irq_restore(flags);
@@ -718,7 +718,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
 		if (hv_result_success(status))
 			break;
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			ret = hv_result_to_errno(status);
 			break;
 		}
@@ -772,7 +772,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
 		if (hv_result_success(status))
 			break;
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			ret = hv_result_to_errno(status);
 			break;
 		}
@@ -850,7 +850,7 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 		if (!ret)
 			break;
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			hv_status_debug(status, "\n");
 			break;
 		}
@@ -899,7 +899,7 @@ hv_call_map_stats_page(enum hv_stats_object_type type,
 	struct hv_input_map_stats_page *input;
 	struct hv_output_map_stats_page *output;
 	u64 status, pfn;
-	int hv_status, ret = 0;
+	int ret = 0;
 
 	do {
 		local_irq_save(flags);
@@ -915,13 +915,12 @@ hv_call_map_stats_page(enum hv_stats_object_type type,
 
 		local_irq_restore(flags);
 
-		hv_status = hv_result(status);
-		if (hv_status != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			if (hv_result_success(status))
 				break;
 
 			if (hv_stats_get_area_type(type, identity) == HV_STATS_AREA_PARENT &&
-			    hv_status == HV_STATUS_INVALID_PARAMETER) {
+			    hv_result(status) == HV_STATUS_INVALID_PARAMETER) {
 				*addr = NULL;
 				return 0;
 			}
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index b429bb1fdffa..f5525651a565 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -251,7 +251,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 		if (hv_result_success(status))
 			break;
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
+		if (!hv_result_needs_memory(status))
 			ret = hv_result_to_errno(status);
 		else
 			ret = hv_call_deposit_pages(NUMA_NO_NODE,
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index ecedab554c80..452426d5b2ab 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -342,6 +342,8 @@ static inline bool hv_parent_partition(void)
 {
 	return hv_root_partition() || hv_l1vh_partition();
 }
+
+bool hv_result_needs_memory(u64 status);
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
@@ -350,6 +352,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 static inline bool hv_root_partition(void) { return false; }
 static inline bool hv_l1vh_partition(void) { return false; }
 static inline bool hv_parent_partition(void) { return false; }
+static inline bool hv_result_needs_memory(u64 status) { return false; }
 static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 {
 	return -EOPNOTSUPP;



