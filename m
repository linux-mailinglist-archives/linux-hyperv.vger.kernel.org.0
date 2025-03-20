Return-Path: <linux-hyperv+bounces-4649-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42925A6AC57
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 18:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882CC188D99D
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9374441C72;
	Thu, 20 Mar 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rq9KMkCm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F720225A2C;
	Thu, 20 Mar 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492706; cv=none; b=EYmrCiERsI6jCr1QWLPX6GVPG9Y4t27HLWnJXVNz6sGWPTW8ebHwDO1NdxxzkjGBxHoazsJj5ahOVM+53Y/Q3EjVlo1bsSPObuyg5lt37zxGcOz0+jRLXHDnloY0JmIVNkfNPCLV9BnMTvsX9uUlY3sUwWZrJCkR6o/zcO1SvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492706; c=relaxed/simple;
	bh=SjVMPcJ218bHC1cKGE9oOPFfwjcHqWalxFlwpSoyaQU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IpZuX1vW51DCVPSHUAuh5TxGBz2xIx306vlm3VeLnqwAogHUvj6dVOdwOsI/Xfhv4LknpydkXSpOBiBfvoGFWHjvb9gz8jTjjj3tuI6SUstFj239tR9o5d48bbpAylu1u/HgY+VMf85xJj/Dr3YyZ72l8crk+1OiNUGYv5EMnjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rq9KMkCm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 122212116B4D;
	Thu, 20 Mar 2025 10:45:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 122212116B4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742492704;
	bh=VOUurK7bR+Dl03wHfubz8at8czzOK7Dw9N034s/zhjA=;
	h=From:To:Cc:Subject:Date:From;
	b=rq9KMkCmX5fnBhk/+blSWpKjsSS+H0fBKAcYc+Ij6CnXJzO3NbBh57xRguZ9XGEiC
	 Ikb1n7SU3kRyno7Gs0cPQZ/UaI6Q2rfAQpZGsp1ap4DhYpiubnxoTEIQVJ1ZyK0wvp
	 p1ZBA+cc49pz7aYjhNMe9tqwFEpk6BqGxBCxxoP4=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wei.liu@kernel.org,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com
Subject: [PATCH] fixup! Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs
Date: Thu, 20 Mar 2025 10:44:53 -0700
Message-Id: <1742492693-21960-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         |  3 ++
 drivers/hv/mshv_root_hv_call.c |  7 +--
 drivers/hv/mshv_root_main.c    | 91 +++++++++++++---------------------
 drivers/hv/mshv_synic.c        |  2 +-
 include/uapi/linux/mshv.h      | 32 ++++++------
 5 files changed, 60 insertions(+), 75 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index e83b484b8ed8..e3931b0f1269 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -14,6 +14,7 @@
 #include <linux/wait.h>
 #include <linux/hashtable.h>
 #include <linux/dev_printk.h>
+#include <linux/build_bug.h>
 #include <uapi/linux/mshv.h>
 
 /*
@@ -23,6 +24,8 @@
 #define MSHV_HV_MIN_VERSION		(27744)
 #define MSHV_HV_MAX_VERSION		(27751)
 
+static_assert(HV_HYP_PAGE_SIZE == MSHV_HV_PAGE_SIZE);
+
 #define MSHV_MAX_VPS			256
 
 #define MSHV_PARTITIONS_HASH_BITS	9
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index b72b59a5068b..a222a16107f6 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -341,7 +341,7 @@ int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
 	int completed = 0;
 	unsigned long remaining = count;
 	int rep_count, i;
-	u64 status;
+	u64 status = 0;
 	unsigned long flags;
 
 	*written_total = 0;
@@ -731,7 +731,7 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
 	struct hv_input_map_stats_page *input;
 	struct hv_output_map_stats_page *output;
 	u64 status, pfn;
-	int ret;
+	int ret = 0;
 
 	do {
 		local_irq_save(flags);
@@ -747,9 +747,10 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
 
 		local_irq_restore(flags);
 		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			ret = hv_result_to_errno(status);
 			if (hv_result_success(status))
 				break;
-			return hv_result_to_errno(status);
+			return ret;
 		}
 
 		ret = hv_call_deposit_pages(NUMA_NO_NODE,
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 29fa6d5a3994..72df774e410a 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -60,13 +60,13 @@ struct hv_stats_page {
 	};
 } __packed;
 
-struct mshv_root mshv_root = {};
+struct mshv_root mshv_root;
 
 enum hv_scheduler_type hv_scheduler_type;
 
 /* Once we implement the fast extended hypercall ABI they can go away. */
-static void __percpu **root_scheduler_input;
-static void __percpu **root_scheduler_output;
+static void * __percpu *root_scheduler_input;
+static void * __percpu *root_scheduler_output;
 
 static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
 static int mshv_dev_open(struct inode *inode, struct file *filp);
@@ -80,6 +80,12 @@ static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
 static int mshv_init_async_handler(struct mshv_partition *partition);
 static void mshv_async_hvcall_handler(void *data, u64 *status);
 
+static const union hv_input_vtl input_vtl_zero;
+static const union hv_input_vtl input_vtl_normal = {
+	.target_vtl = HV_NORMAL_VTL,
+	.use_target_vtl = 1,
+};
+
 static const struct vm_operations_struct mshv_vp_vm_ops = {
 	.fault = mshv_vp_fault,
 };
@@ -151,7 +157,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 				      void __user *user_args)
 {
 	u64 status;
-	int ret, i;
+	int ret = 0, i;
 	bool is_async;
 	struct mshv_root_hvcall args;
 	struct page *page;
@@ -265,21 +271,15 @@ static inline bool is_ghcb_mapping_available(void)
 static int mshv_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 				 struct hv_register_assoc *registers)
 {
-	union hv_input_vtl input_vtl;
-
-	input_vtl.as_uint8 = 0;
 	return hv_call_get_vp_registers(vp_index, partition_id,
-					count, input_vtl, registers);
+					count, input_vtl_zero, registers);
 }
 
 static int mshv_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 				 struct hv_register_assoc *registers)
 {
-	union hv_input_vtl input_vtl;
-
-	input_vtl.as_uint8 = 0;
 	return hv_call_set_vp_registers(vp_index, partition_id,
-					count, input_vtl, registers);
+					count, input_vtl_zero, registers);
 }
 
 /*
@@ -297,7 +297,7 @@ static int mshv_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
  * succeeded in either case allows us to reliably identify, if there is a
  * message to receive and deliver to VMM.
  */
-static long
+static int
 mshv_suspend_vp(const struct mshv_vp *vp, bool *message_in_flight)
 {
 	struct hv_register_assoc explicit_suspend = {
@@ -820,11 +820,10 @@ static vm_fault_t mshv_vp_fault(struct vm_fault *vmf)
 		vmf->page = virt_to_page(vp->vp_intercept_msg_page);
 		break;
 	case MSHV_VP_MMAP_OFFSET_GHCB:
-		if (is_ghcb_mapping_available())
-			vmf->page = virt_to_page(vp->vp_ghcb_page);
+		vmf->page = virt_to_page(vp->vp_ghcb_page);
 		break;
 	default:
-		return -EINVAL;
+		return VM_FAULT_SIGBUS;
 	}
 
 	get_page(vmf->page);
@@ -846,7 +845,7 @@ static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma)
 			return -ENODEV;
 		break;
 	case MSHV_VP_MMAP_OFFSET_GHCB:
-		if (is_ghcb_mapping_available() && !vp->vp_ghcb_page)
+		if (!vp->vp_ghcb_page)
 			return -ENODEV;
 		break;
 	default:
@@ -919,7 +918,6 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	struct page *intercept_message_page, *register_page, *ghcb_page;
 	void *stats_pages[2];
 	long ret;
-	union hv_input_vtl input_vtl;
 
 	if (copy_from_user(&args, arg, sizeof(args)))
 		return -EFAULT;
@@ -935,19 +933,17 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (ret)
 		return ret;
 
-	input_vtl.as_uint8 = 0;
 	ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
 					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
-					input_vtl,
+					input_vtl_zero,
 					&intercept_message_page);
 	if (ret)
 		goto destroy_vp;
 
 	if (!mshv_partition_encrypted(partition)) {
-		input_vtl.as_uint8 = 0;
 		ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
 						HV_VP_STATE_PAGE_REGISTERS,
-						input_vtl,
+						input_vtl_zero,
 						&register_page);
 		if (ret)
 			goto unmap_intercept_message_page;
@@ -955,12 +951,9 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 
 	if (mshv_partition_encrypted(partition) &&
 	    is_ghcb_mapping_available()) {
-		input_vtl.as_uint8 = 0;
-		input_vtl.use_target_vtl = 1;
-		input_vtl.target_vtl = HV_NORMAL_VTL;
 		ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
 						HV_VP_STATE_PAGE_GHCB,
-						input_vtl,
+						input_vtl_normal,
 						&ghcb_page);
 		if (ret)
 			goto unmap_register_page;
@@ -1022,26 +1015,20 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
 unmap_ghcb_page:
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
-		input_vtl.as_uint8 = 0;
-		input_vtl.use_target_vtl = 1;
-		input_vtl.target_vtl = HV_NORMAL_VTL;
-
 		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
-					    HV_VP_STATE_PAGE_GHCB, input_vtl);
+					    HV_VP_STATE_PAGE_GHCB,
+					    input_vtl_normal);
 	}
 unmap_register_page:
 	if (!mshv_partition_encrypted(partition)) {
-		input_vtl.as_uint8 = 0;
-
 		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
 					    HV_VP_STATE_PAGE_REGISTERS,
-					    input_vtl);
+					    input_vtl_zero);
 	}
 unmap_intercept_message_page:
-	input_vtl.as_uint8 = 0;
 	hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
 				    HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
-				    input_vtl);
+				    input_vtl_zero);
 destroy_vp:
 	hv_call_delete_vp(partition->pt_id, args.vp_index);
 	return ret;
@@ -1051,7 +1038,7 @@ static int mshv_init_async_handler(struct mshv_partition *partition)
 {
 	if (completion_done(&partition->async_hypercall)) {
 		pt_err(partition,
-		       "Cannot issue another async hypercall, while another one in progress!\n");
+		       "Cannot issue async hypercall while another one in progress!\n");
 		return -EPERM;
 	}
 
@@ -1398,9 +1385,6 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
 		return -EINVAL;
 
-	if (hlist_empty(&partition->pt_mem_regions))
-		return -EINVAL;
-
 	region = mshv_partition_region_by_gfn(partition, mem.guest_pfn);
 	if (!region)
 		return -EINVAL;
@@ -1510,7 +1494,7 @@ mshv_partition_ioctl_get_gpap_access_bitmap(struct mshv_partition *partition,
 			hv_flags.clear_accessed = 1;
 			/* not accessed implies not dirty */
 			hv_flags.clear_dirty = 1;
-		} else { // MSHV_GPAP_ACCESS_OP_SET
+		} else { /* MSHV_GPAP_ACCESS_OP_SET */
 			hv_flags.set_accessed = 1;
 		}
 		break;
@@ -1518,7 +1502,7 @@ mshv_partition_ioctl_get_gpap_access_bitmap(struct mshv_partition *partition,
 		hv_type_mask = 2;
 		if (args.access_op == MSHV_GPAP_ACCESS_OP_CLEAR) {
 			hv_flags.clear_dirty = 1;
-		} else { // MSHV_GPAP_ACCESS_OP_SET
+		} else { /* MSHV_GPAP_ACCESS_OP_SET */
 			hv_flags.set_dirty = 1;
 			/* dirty implies accessed */
 			hv_flags.set_accessed = 1;
@@ -1541,15 +1525,13 @@ mshv_partition_ioctl_get_gpap_access_bitmap(struct mshv_partition *partition,
 	 * correspond to bitfields in hv_gpa_page_access_state
 	 */
 	for (i = 0; i < written; ++i)
-		assign_bit(i, (ulong *)states,
-			   states[i].as_uint8 & hv_type_mask);
+		__assign_bit(i, (ulong *)states,
+			     states[i].as_uint8 & hv_type_mask);
 
-	args.page_count = written;
+	/* zero the unused bits in the last byte(s) of the returned bitmap */
+	for (i = written; i < bitmap_buf_sz * 8; ++i)
+		__clear_bit(i, (ulong *)states);
 
-	if (copy_to_user(user_args, &args, sizeof(args))) {
-		ret = -EFAULT;
-		goto free_return;
-	}
 	if (copy_to_user((void __user *)args.bitmap_ptr, states, bitmap_buf_sz))
 		ret = -EFAULT;
 
@@ -1762,7 +1744,6 @@ static void destroy_partition(struct mshv_partition *partition)
 	struct mshv_mem_region *region;
 	int i, ret;
 	struct hlist_node *n;
-	union hv_input_vtl input_vtl;
 
 	if (refcount_read(&partition->pt_ref_count)) {
 		pt_err(partition,
@@ -1788,28 +1769,24 @@ static void destroy_partition(struct mshv_partition *partition)
 				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
 
 			if (vp->vp_register_page) {
-				input_vtl.as_uint8 = 0;
 				(void)hv_call_unmap_vp_state_page(partition->pt_id,
 								  vp->vp_index,
 								  HV_VP_STATE_PAGE_REGISTERS,
-								  input_vtl);
+								  input_vtl_zero);
 				vp->vp_register_page = NULL;
 			}
 
-			input_vtl.as_uint8 = 0;
 			(void)hv_call_unmap_vp_state_page(partition->pt_id,
 							  vp->vp_index,
 							  HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
-							  input_vtl);
+							  input_vtl_zero);
 			vp->vp_intercept_msg_page = NULL;
 
 			if (vp->vp_ghcb_page) {
-				input_vtl.use_target_vtl = 1;
-				input_vtl.target_vtl = HV_NORMAL_VTL;
 				(void)hv_call_unmap_vp_state_page(partition->pt_id,
 								  vp->vp_index,
 								  HV_VP_STATE_PAGE_GHCB,
-								  input_vtl);
+								  input_vtl_normal);
 				vp->vp_ghcb_page = NULL;
 			}
 
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index a3daedd680ff..b9f74df0db93 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -226,7 +226,7 @@ handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 			if (vp_bank_idx == vp_bank_size)
 				break;
 
-			vp_index = (bank_idx << HV_GENERIC_SET_SHIFT) + vp_bank_idx;
+			vp_index = (bank_idx * vp_bank_size) + vp_bank_idx;
 
 			/* This shouldn't happen, but just in case. */
 			if (unlikely(vp_index >= MSHV_MAX_VPS)) {
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 9468f66c5658..876bfe4e4227 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -74,12 +74,16 @@ enum {
 
 #define MSHV_SET_MEM_FLAGS_MASK ((1 << MSHV_SET_MEM_BIT_COUNT) - 1)
 
+/* The hypervisor's "native" page size */
+#define MSHV_HV_PAGE_SIZE	0x1000
+
 /**
  * struct mshv_user_mem_region - arguments for MSHV_SET_GUEST_MEMORY
- * @size: Size of the memory region (bytes). Must be aligned to PAGE_SIZE
+ * @size: Size of the memory region (bytes). Must be aligned to
+ *        MSHV_HV_PAGE_SIZE
  * @guest_pfn: Base guest page number to map
  * @userspace_addr: Base address of userspace memory. Must be aligned to
- *                  PAGE_SIZE
+ *                  MSHV_HV_PAGE_SIZE
  * @flags: Bitmask of 1 << MSHV_SET_MEM_BIT_*. If (1 << MSHV_SET_MEM_BIT_UNMAP)
  *         is set, ignore other bits.
  * @rsvd: MBZ
@@ -143,13 +147,13 @@ struct mshv_user_irq_table {
 };
 
 enum {
-	MSHV_GPAP_ACCESS_TYPE_ACCESSED = 0,
+	MSHV_GPAP_ACCESS_TYPE_ACCESSED,
 	MSHV_GPAP_ACCESS_TYPE_DIRTY,
 	MSHV_GPAP_ACCESS_TYPE_COUNT		/* Count of enum members */
 };
 
 enum {
-	MSHV_GPAP_ACCESS_OP_NOOP = 0,
+	MSHV_GPAP_ACCESS_OP_NOOP,
 	MSHV_GPAP_ACCESS_OP_CLEAR,
 	MSHV_GPAP_ACCESS_OP_SET,
 	MSHV_GPAP_ACCESS_OP_COUNT		/* Count of enum members */
@@ -163,8 +167,7 @@ enum {
  *             the access states in the range, after retrieving the current
  *             states.
  * @rsvd: MBZ
- * @page_count: in: number of pages
- *              out: on error, number of states successfully written to bitmap
+ * @page_count: Number of pages
  * @gpap_base: Base gpa page number
  * @bitmap_ptr: Output buffer for bitmap, at least (page_count + 7) / 8 bytes
  *
@@ -185,8 +188,8 @@ struct mshv_gpap_access_bitmap {
  * @code: Hypercall code (HVCALL_*)
  * @reps: in: Rep count ('repcount')
  *	  out: Reps completed ('repcomp'). MBZ unless rep hvcall
- * @in_sz: Size of input incl rep data. <= HV_HYP_PAGE_SIZE
- * @out_sz: Size of output buffer. <= HV_HYP_PAGE_SIZE. MBZ if out_ptr is 0
+ * @in_sz: Size of input incl rep data. <= MSHV_HV_PAGE_SIZE
+ * @out_sz: Size of output buffer. <= MSHV_HV_PAGE_SIZE. MBZ if out_ptr is 0
  * @status: in: MBZ
  *	    out: HV_STATUS_* from hypercall
  * @rsvd: MBZ
@@ -225,13 +228,14 @@ struct mshv_root_hvcall {
 #define MSHV_RUN_VP_BUF_SZ 256
 
 /*
- * Map various VP state pages to userspace.
- * Multiply the offset by PAGE_SIZE before being passed as the 'offset'
- * argument to mmap().
+ * VP state pages may be mapped to userspace via mmap().
+ * To specify which state page, use MSHV_VP_MMAP_OFFSET_ values multiplied by
+ * the system page size.
  * e.g.
- * void *reg_page = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
+ * long page_size = sysconf(_SC_PAGE_SIZE);
+ * void *reg_page = mmap(NULL, MSHV_HV_PAGE_SIZE, PROT_READ|PROT_WRITE,
  *                       MAP_SHARED, vp_fd,
- *                       MSHV_VP_MMAP_OFFSET_REGISTERS * PAGE_SIZE);
+ *                       MSHV_VP_MMAP_OFFSET_REGISTERS * page_size);
  */
 enum {
 	MSHV_VP_MMAP_OFFSET_REGISTERS,
@@ -259,7 +263,7 @@ enum {
 };
 
 /**
- * struct mshv_get_set_vp_hvcall - arguments for MSHV_[GET,SET]_VP_STATE
+ * struct mshv_get_set_vp_state - arguments for MSHV_[GET,SET]_VP_STATE
  * @type: MSHV_VP_STATE_*
  * @rsvd: MBZ
  * @buf_sz: in: 4k page-aligned size of buffer
-- 
2.34.1


