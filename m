Return-Path: <linux-hyperv+bounces-10448-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM0GL9Q58WkmewEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10448-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 00:51:00 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0D348CD7E
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 00:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 865CE3055E34
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 22:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F9737E2E1;
	Tue, 28 Apr 2026 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="emXdefd2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600E8372ECB;
	Tue, 28 Apr 2026 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416506; cv=none; b=H5YU4y6GWC6LuwsNQMKKIIJ/O/HE16mBR0mO73xwbtKVQug2iWUTGdMuvBdiiagy/E8atL6eYestJCDptKqzUCMk+UnARaSID43UPzQS7cgcJ3rSCLdMJc90eqGOyjoQ/hCpPbDarezpZtm2Gz7aMVxeGVk5MkC6i+EjKcwVl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416506; c=relaxed/simple;
	bh=4KPPgYtXKWsHqBHqtOFvmbpKKC6wmI/LMEfK8u3KXAk=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Ax/hNZW/u4//BOD9FxfrX+MlWqtA6k7+43PO99rTRGoPub4rcBZHbLaRoAggnOc0VLMG5og+22PY0fEsj3jm+PCy+CWkKXzmCsm5wa+f4UdtDQ9RhivmyGHdflIjHyq6y9usjECYqjdCrjGJFpPovV5+LMEk3L7Rk2wR5Zer4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=emXdefd2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3377B20B716C;
	Tue, 28 Apr 2026 15:48:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3377B20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777416505;
	bh=3K9Hp9CJPvE9Ebyp3t7BvPIjJ02T4FpKVScQ7CESqi8=;
	h=Subject:From:To:Cc:Date:From;
	b=emXdefd2aob48UTpoL8NpMDZTsT/zJbZ61TWcG0kAk2gwkaAO6/Xv8ilWK/WKdAXQ
	 AiRkkOhjTFxRjXWrGzT4guDoqBYEvjC7VizkMjHKVNpLKPovpYD75IIByCHgxSM8EX
	 NijFawU6hRV/GcrYDXtKobf7Xnha4h8E1Dr2XtjU=
Subject: [PATCH] mshv: Add dedicated ioctl for GVA to GPA translation
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 28 Apr 2026 22:48:24 +0000
Message-ID: 
 <177741648871.626779.11067281081219290277.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2E0D348CD7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10448-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add an MSHV_TRANSLATE_GVA ioctl on the VP fd that wraps
HVCALL_TRANSLATE_VIRTUAL_ADDRESS_EX with transparent fault-in handling for
movable memory regions. The passthrough path for this hypercall is retained
for backward compatibility.

When guest-backing pages reside in movable memory regions, the mmu_notifier
invalidation path remaps them to NO_ACCESS in the hypervisor's second-level
address translation tables. If the VMM issues a GVA translation (e.g.
during MMIO emulation) while a page-table page is invalidated, the
hypervisor returns HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS. The VMM cannot
resolve this on its own.

The new ioctl detects this transient GPA access failure, faults the page
back in via mshv_region_handle_gfn_fault(), and retries the translation
until it succeeds or an unrecoverable error occurs.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         |    3 ++
 drivers/hv/mshv_root_hv_call.c |   37 +++++++++++++++++++++
 drivers/hv/mshv_root_main.c    |   69 ++++++++++++++++++++++++++++++++++++++++
 include/hyperv/hvgdk_mini.h    |    1 +
 include/hyperv/hvhdk.h         |   41 ++++++++++++++++++++++++
 include/uapi/linux/mshv.h      |   10 ++++++
 6 files changed, 161 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 1f086dcb7aa1a..2e6c4414740cc 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -290,6 +290,9 @@ int hv_call_delete_vp(u64 partition_id, u32 vp_index);
 int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
 				     u64 dest_addr,
 				     union hv_interrupt_control control);
+int hv_call_translate_virtual_address_ex(u32 vp_index, u64 partition_id,
+					 u64 flags, u64 gva, u64 *gfn,
+					 struct hv_translate_gva_result_ex *result);
 int hv_call_clear_virtual_interrupt(u64 partition_id);
 int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
 				  union hv_gpa_page_access_state_flags state_flags,
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index e5992c324904a..9ff4ba5373f59 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -692,6 +692,43 @@ int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code,
 	return 0;
 }
 
+int hv_call_translate_virtual_address_ex(u32 vp_index, u64 partition_id,
+					 u64 flags, u64 gva, u64 *gfn,
+					 struct hv_translate_gva_result_ex *result)
+{
+	struct hv_input_translate_virtual_address *input;
+	struct hv_output_translate_virtual_address_ex *output;
+	unsigned long irq_flags;
+	u64 status;
+
+	local_irq_save(irq_flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->vp_index = vp_index;
+	input->control_flags = flags;
+	input->gva_page = gva >> HV_HYP_PAGE_SHIFT;
+
+	status = hv_do_hypercall(HVCALL_TRANSLATE_VIRTUAL_ADDRESS_EX,
+				 input, output);
+
+	if (!hv_result_success(status)) {
+		local_irq_restore(irq_flags);
+		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
+		return hv_result_to_errno(status);
+	}
+
+	*result = output->translation_result;
+	*gfn = output->gpa_page;
+
+	local_irq_restore(irq_flags);
+
+	return 0;
+}
+
 int
 hv_call_clear_virtual_interrupt(u64 partition_id)
 {
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index bd1359eb58dd4..2d7b6923415a8 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -898,6 +898,72 @@ mshv_vp_ioctl_get_set_state(struct mshv_vp *vp,
 	return 0;
 }
 
+static bool mshv_gpa_fault_retryable(u32 result_code)
+{
+	/*
+	 * Note: HV_TRANSLATE_GVA_GPA_UNMAPPED is intentionally not handled
+	 * here. The guest page table cannot be unmapped under normal
+	 * operation. It may be mapped with no access during page moves,
+	 * but a truly unmapped state indicates a kernel driver bug.
+	 * Retrying in this case would only mask the underlying problem of
+	 * an unmapped guest page table.
+	 */
+	return result_code == HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS;
+}
+
+static long
+mshv_vp_ioctl_translate_gva(struct mshv_vp *vp, void __user *user_args)
+{
+	struct mshv_partition *partition = vp->vp_partition;
+	struct mshv_translate_gva args;
+	struct hv_translate_gva_result_ex result;
+	u64 gfn, gpa;
+	int ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	do {
+		ret = hv_call_translate_virtual_address_ex(vp->vp_index,
+							   partition->pt_id,
+							   args.flags, args.gva,
+							   &gfn, &result);
+		if (ret)
+			return ret;
+
+		if (mshv_gpa_fault_retryable(result.result_code)) {
+			struct mshv_mem_region *region;
+			bool faulted;
+
+			region = mshv_partition_region_by_gfn_get(partition,
+								  gfn);
+			if (!region)
+				return -EFAULT;
+
+			faulted = false;
+			if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
+				faulted = mshv_region_handle_gfn_fault(region,
+								       gfn);
+			mshv_region_put(region);
+
+			if (!faulted)
+				return -EFAULT;
+
+			cond_resched();
+		}
+	} while (mshv_gpa_fault_retryable(result.result_code));
+
+	gpa = (gfn << PAGE_SHIFT) | (args.gva & ~PAGE_MASK);
+
+        if (copy_to_user(args.result, &result, sizeof(*args.result)))
+                return -EFAULT;
+
+	if (copy_to_user(args.gpa, &gpa, sizeof(*args.gpa)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long
 mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -917,6 +983,9 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_SET_VP_STATE:
 		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, true);
 		break;
+	case MSHV_TRANSLATE_GVA:
+		r = mshv_vp_ioctl_translate_gva(vp, (void __user *)arg);
+		break;
 	case MSHV_ROOT_HVCALL:
 		r = mshv_ioctl_passthru_hvcall(vp->vp_partition, false,
 					       (void __user *)arg);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 6a4e8b9d570fd..ac901801fd397 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -484,6 +484,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_CONNECT_PORT				0x0096
 #define HVCALL_START_VP					0x0099
 #define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
+#define HVCALL_TRANSLATE_VIRTUAL_ADDRESS_EX		0x00ac
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
 #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 5e83d37149662..08eede666762e 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -952,4 +952,45 @@ struct hv_input_modify_sparse_spa_page_host_access {
 #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
 #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
 
+enum hv_translate_gva_result_code {
+	HV_TRANSLATE_GVA_SUCCESS			= 0,
+
+	/* Translation failures */
+	HV_TRANSLATE_GVA_PAGE_NOT_PRESENT		= 1,
+	HV_TRANSLATE_GVA_PRIVILEGE_VIOLATION		= 2,
+	HV_TRANSLATE_GVA_INVALID_PAGE_TABLE_FLAGS	= 3,
+
+	/* GPA access failures */
+	HV_TRANSLATE_GVA_GPA_UNMAPPED			= 4,
+	HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS		= 5,
+	HV_TRANSLATE_GVA_GPA_NO_WRITE_ACCESS		= 6,
+	HV_TRANSLATE_GVA_GPA_ILLEGAL_OVERLAY_ACCESS	= 7,
+
+	HV_TRANSLATE_GVA_INTERCEPT			= 8,
+	HV_TRANSLATE_GVA_GPA_UNACCEPTED			= 9,
+};
+
+struct hv_input_translate_virtual_address {
+	u64 partition_id;
+	u32 vp_index;
+	u32 padding;
+	u64 control_flags;
+	u64 gva_page;
+} __packed;
+
+struct hv_translate_gva_result_ex {
+	u32 result_code; /* enum hv_translate_gva_result_code */
+	u32 cache_type : 8;
+	u32 overlay_page : 1;
+	u32 reserved : 23;
+#if IS_ENABLED(CONFIG_X86)
+	char event_info[40]; /* HV_X64_PENDING_EVENT */
+#endif
+} __packed;
+
+struct hv_output_translate_virtual_address_ex {
+	struct hv_translate_gva_result_ex translation_result;
+	u64 gpa_page;
+} __packed;
+
 #endif /* _HV_HVHDK_H */
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 32ff92b6342b2..29892013a4752 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -318,6 +318,16 @@ struct mshv_get_set_vp_state {
 #define MSHV_RUN_VP			_IOR(MSHV_IOCTL, 0x00, struct mshv_run_vp)
 #define MSHV_GET_VP_STATE		_IOWR(MSHV_IOCTL, 0x01, struct mshv_get_set_vp_state)
 #define MSHV_SET_VP_STATE		_IOWR(MSHV_IOCTL, 0x02, struct mshv_get_set_vp_state)
+
+struct mshv_translate_gva {
+	__u64 gva;
+	__u64 flags;
+	enum hv_translate_gva_result_code *result;
+	__u64 *gpa;
+};
+
+#define MSHV_TRANSLATE_GVA		_IOWR(MSHV_IOCTL, 0xF2, struct mshv_translate_gva)
+
 /*
  * Generic hypercall
  * Defined above in partition IOCTLs, avoid redefining it here



