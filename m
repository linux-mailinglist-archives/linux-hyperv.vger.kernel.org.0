Return-Path: <linux-hyperv+bounces-8648-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K6tLI3ngGleCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8648-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:06:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3780ECFEAB
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B2C730952CB
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C7F389473;
	Mon,  2 Feb 2026 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EljRO3qb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4006388846;
	Mon,  2 Feb 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055140; cv=none; b=YCIt+W7dasn6DhZiba3psRXaEIHm6M81v1XmSCI6+QSzWdW3Jo+loWgeeOGh9iP3EXQ+UOumS0aER44ZpqcWfED076pvhQircH2SkblJHKTr1ITvtN9j6ASfgxiwSMYbU2gy1I9kDy7qRruO6iAEcQq0RpmjrjAd3hrfT2oONpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055140; c=relaxed/simple;
	bh=+47aa04q+Jb3tbNYgS28gUwQdWJOOHwkd/5ogDPX+V0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCmU5B3P3GL465U9BKuPa7BgruNzkr/XvB08zVHR43kRcqVK83uGtVA70FHD4udvcNb8tG7ZBkQDLgTWS83iWguzzDbZhhhf6/3xO+jtesYz6wozZNysTKuXcGLw0qOrcPZE/tYZnbu22YkIG50Ft8/EYghAcWu5VsiPqGsA2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EljRO3qb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 282EC20B7168;
	Mon,  2 Feb 2026 09:58:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 282EC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770055138;
	bh=a60+23i9z4m18jjZI1FP3dFkx3Rlv61BJYTh4rYs6nk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EljRO3qbZ0/gydPMht4ZIOBhHp1aOIIShGGaqg4ht1yBixBtwlDcR7DLhN1AOOBce
	 Rp7avv08qILe2mlbhCASuvoc9GU87KGos8DA5y9kmNOqPShbigaxayz4k/iT+a0iTa
	 FEX2kH6r6t9IhDjL9EZ/GVVyIADS9Zqpvp7fUhNQ=
Subject: [PATCH v2 1/4] mshv: Introduce hv_result_needs_memory() helper
 function
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 17:58:57 +0000
Message-ID: 
 <177005513775.120041.4894134857240187839.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8648-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 3780ECFEAB
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
 drivers/hv/mshv_root_hv_call.c |   20 ++++++++++----------
 drivers/hv/mshv_root_main.c    |    2 +-
 include/asm-generic/mshyperv.h |    3 +++
 4 files changed, 26 insertions(+), 13 deletions(-)

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
index 598eaff4ff29..89afeeda21dd 100644
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
@@ -843,7 +843,7 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 		if (!ret)
 			break;
 
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			hv_status_debug(status, "\n");
 			break;
 		}
@@ -878,7 +878,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
 		pfn = output->map_location;
 
 		local_irq_restore(flags);
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+		if (!hv_result_needs_memory(status)) {
 			ret = hv_result_to_errno(status);
 			if (hv_result_success(status))
 				break;
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 6a6bf641b352..ee30bfa6bb2e 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -261,7 +261,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
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



