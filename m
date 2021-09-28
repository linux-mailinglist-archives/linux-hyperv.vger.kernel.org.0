Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2693141B644
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Sep 2021 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbhI1SdK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Sep 2021 14:33:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50904 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242223AbhI1SdB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Sep 2021 14:33:01 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1CD2F20B4844;
        Tue, 28 Sep 2021 11:31:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CD2F20B4844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632853882;
        bh=8OnqP21uLRlmd1ldf6V9VuJ1l75eaGia0Y0BEP7Pgbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6tcTFF7jTypWVQFtAjSTouN01+2p/K4BfjB0Txo5vdsChxz1mQE/MN85ZIMUOM0m
         nwc7rADlkS1ndMC4F9OYuC+rmEVmdHdUG3BF+5ZfOv2JjJNQoF1T9FXalv3jUKCW+G
         zxoS/fRD2C+SRKfiRrtTf+zdZdyCtAedUScu2HFk=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH v3 15/19] drivers/hv: get and set vp state ioctls
Date:   Tue, 28 Sep 2021 11:31:11 -0700
Message-Id: <1632853875-20261-16-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce ioctls for getting and setting guest vcpu emulated LAPIC
state, and xsave data.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst         |   8 ++
 arch/x86/include/uapi/asm/hyperv-tlfs.h |  59 ++++++++++
 drivers/hv/hv_call.c                    | 138 +++++++++++++++++++++++-
 drivers/hv/mshv.h                       |  25 +++++
 drivers/hv/mshv_main.c                  | 122 +++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h       |  40 +++++++
 include/uapi/asm-generic/hyperv-tlfs.h  |  28 +++++
 include/uapi/linux/mshv.h               |  13 +++
 8 files changed, 432 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index 76f98485cd93..1613ac6e9428 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -140,4 +140,12 @@ Assert interrupts in partitions that use Microsoft Hypervisor's internal
 emulated LAPIC. This must be enabled on partition creation with the flag:
 HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED
 
+3.9 MSHV_GET_VP_STATE and MSHV_SET_VP_STATE
+--------------------------
+:Type: vp ioctl
+:Parameters: struct mshv_vp_state
+:Returns: 0 on success
+
+Get/set various vp state. Currently these can be used to get and set
+emulated LAPIC state, and xsave data.
 
diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
index e234297521a3..46806227e869 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -1013,4 +1013,63 @@ union hv_interrupt_control {
 	__u64 as_uint64;
 };
 
+struct hv_local_interrupt_controller_state {
+	__u32 apic_id;
+	__u32 apic_version;
+	__u32 apic_ldr;
+	__u32 apic_dfr;
+	__u32 apic_spurious;
+	__u32 apic_isr[8];
+	__u32 apic_tmr[8];
+	__u32 apic_irr[8];
+	__u32 apic_esr;
+	__u32 apic_icr_high;
+	__u32 apic_icr_low;
+	__u32 apic_lvt_timer;
+	__u32 apic_lvt_thermal;
+	__u32 apic_lvt_perfmon;
+	__u32 apic_lvt_lint0;
+	__u32 apic_lvt_lint1;
+	__u32 apic_lvt_error;
+	__u32 apic_lvt_cmci;
+	__u32 apic_error_status;
+	__u32 apic_initial_count;
+	__u32 apic_counter_value;
+	__u32 apic_divide_configuration;
+	__u32 apic_remote_read;
+} __packed;
+
+#define HV_XSAVE_DATA_NO_XMM_REGISTERS 1
+
+union hv_x64_xsave_xfem_register {
+	__u64 as_uint64;
+	struct {
+		__u32 low_uint32;
+		__u32 high_uint32;
+	} __packed;
+	struct {
+		__u64 legacy_x87: 1;
+		__u64 legacy_sse: 1;
+		__u64 avx: 1;
+		__u64 mpx_bndreg: 1;
+		__u64 mpx_bndcsr: 1;
+		__u64 avx_512_op_mask: 1;
+		__u64 avx_512_zmmhi: 1;
+		__u64 avx_512_zmm16_31: 1;
+		__u64 rsvd8_9: 2;
+		__u64 pasid: 1;
+		__u64 cet_u: 1;
+		__u64 cet_s: 1;
+		__u64 rsvd13_16: 4;
+		__u64 xtile_cfg: 1;
+		__u64 xtile_data: 1;
+		__u64 rsvd19_63: 45;
+	} __packed;
+};
+
+struct hv_vp_state_data_xsave {
+	__u64 flags;
+	union hv_x64_xsave_xfem_register states;
+} __packed;
+
 #endif
diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
index 72e93d13d8ee..c358a2b51ba1 100644
--- a/drivers/hv/hv_call.c
+++ b/drivers/hv/hv_call.c
@@ -426,7 +426,6 @@ int hv_call_install_intercept(
 		}
 
 		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
-
 	} while (!ret);
 
 	return ret;
@@ -461,3 +460,140 @@ int hv_call_assert_virtual_interrupt(
 	return 0;
 }
 
+int hv_call_get_vp_state(
+		u32 vp_index,
+		u64 partition_id,
+		enum hv_get_set_vp_state_type type,
+		struct hv_vp_state_data_xsave xsave,
+		/* Choose between pages and ret_output */
+		u64 page_count,
+		struct page **pages,
+		union hv_get_vp_state_out *ret_output)
+{
+	struct hv_get_vp_state_in *input;
+	union hv_get_vp_state_out *output;
+	u64 status;
+	int i;
+	u64 control;
+	unsigned long flags;
+	int ret = 0;
+
+	if (page_count > HV_GET_VP_STATE_BATCH_SIZE)
+		return -EINVAL;
+
+	if (!page_count && !ret_output)
+		return -EINVAL;
+
+	do {
+		local_irq_save(flags);
+		input = (struct hv_get_vp_state_in *)
+				(*this_cpu_ptr(hyperv_pcpu_input_arg));
+		output = (union hv_get_vp_state_out *)
+				(*this_cpu_ptr(hyperv_pcpu_output_arg));
+		memset(input, 0, sizeof(*input));
+		memset(output, 0, sizeof(*output));
+
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->state_data.type = type;
+		memcpy(&input->state_data.xsave, &xsave, sizeof(xsave));
+		for (i = 0; i < page_count; i++)
+			input->output_data_pfns[i] = page_to_pfn(pages[i]);
+
+		control = (HVCALL_GET_VP_STATE) |
+			  (page_count << HV_HYPERCALL_VARHEAD_OFFSET);
+
+		status = hv_do_hypercall(control, input, output);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status))
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+			else if (ret_output)
+				memcpy(ret_output, output, sizeof(*output));
+
+			local_irq_restore(flags);
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		local_irq_restore(flags);
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_set_vp_state(
+		u32 vp_index,
+		u64 partition_id,
+		enum hv_get_set_vp_state_type type,
+		struct hv_vp_state_data_xsave xsave,
+		/* Choose between pages and bytes */
+		u64 page_count,
+		struct page **pages,
+		u32 num_bytes,
+		u8 *bytes)
+{
+	struct hv_set_vp_state_in *input;
+	u64 status;
+	int i;
+	u64 control;
+	unsigned long flags;
+	int ret = 0;
+	u16 varhead_sz;
+
+	if (page_count > HV_SET_VP_STATE_BATCH_SIZE)
+		return -EINVAL;
+	if (sizeof(*input) + num_bytes > HV_HYP_PAGE_SIZE)
+		return -EINVAL;
+
+	if (num_bytes)
+		/* round up to 8 and divide by 8 */
+		varhead_sz = (num_bytes + 7) >> 3;
+	else if (page_count)
+		varhead_sz =  page_count;
+	else
+		return -EINVAL;
+
+	do {
+		local_irq_save(flags);
+		input = (struct hv_set_vp_state_in *)
+				(*this_cpu_ptr(hyperv_pcpu_input_arg));
+		memset(input, 0, sizeof(*input));
+
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->state_data.type = type;
+		memcpy(&input->state_data.xsave, &xsave, sizeof(xsave));
+		if (num_bytes) {
+			memcpy((u8 *)input->data, bytes, num_bytes);
+		} else {
+			for (i = 0; i < page_count; i++)
+				input->data[i].pfns = page_to_pfn(pages[i]);
+		}
+
+		control = (HVCALL_SET_VP_STATE) |
+			  (varhead_sz << HV_HYPERCALL_VARHEAD_OFFSET);
+
+		status = hv_do_hypercall(control, input, NULL);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status))
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+
+			local_irq_restore(flags);
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		local_irq_restore(flags);
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index c0a0ccb3626a..c8f3919a5cdc 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -26,6 +26,12 @@
 #define HV_SET_REGISTER_BATCH_SIZE	\
 	((HV_HYP_PAGE_SIZE - sizeof(struct hv_set_vp_registers)) \
 		/ sizeof(struct hv_register_assoc))
+#define HV_GET_VP_STATE_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_get_vp_state_in)) \
+		/ sizeof(u64))
+#define HV_SET_VP_STATE_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_set_vp_state_in)) \
+		/ sizeof(u64))
 
 extern struct mshv mshv;
 
@@ -72,5 +78,24 @@ int hv_call_assert_virtual_interrupt(
 		u32 vector,
 		u64 dest_addr,
 		union hv_interrupt_control control);
+int hv_call_get_vp_state(
+		u32 vp_index,
+		u64 partition_id,
+		enum hv_get_set_vp_state_type type,
+		struct hv_vp_state_data_xsave xsave,
+		/* Choose between pages and ret_output */
+		u64 page_count,
+		struct page **pages,
+		union hv_get_vp_state_out *ret_output);
+int hv_call_set_vp_state(
+		u32 vp_index,
+		u64 partition_id,
+		enum hv_get_set_vp_state_type type,
+		struct hv_vp_state_data_xsave xsave,
+		/* Choose between pages and bytes */
+		u64 page_count,
+		struct page **pages,
+		u32 num_bytes,
+		u8 *bytes);
 
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index ee41b59cc922..cef77f53d7c7 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -288,6 +288,122 @@ mshv_vp_ioctl_set_regs(struct mshv_vp *vp, void __user *user_args)
 	return ret;
 }
 
+static long
+mshv_vp_ioctl_get_set_state_pfn(struct mshv_vp *vp,
+				struct mshv_vp_state *args,
+				bool is_set)
+{
+	u64 page_count, remaining;
+	int completed;
+	struct page **pages;
+	long ret;
+	unsigned long u_buf;
+
+	/* Buffer must be page aligned */
+	if (!PAGE_ALIGNED(args->buf_size) ||
+	    !PAGE_ALIGNED(args->buf.bytes))
+		return -EINVAL;
+
+	if (!access_ok(args->buf.bytes, args->buf_size))
+		return -EFAULT;
+
+	/* Pin user pages so hypervisor can copy directly to them */
+	page_count = args->buf_size >> HV_HYP_PAGE_SHIFT;
+	pages = kcalloc(page_count, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	remaining = page_count;
+	u_buf = (unsigned long)args->buf.bytes;
+	while (remaining) {
+		completed = pin_user_pages_fast(
+				u_buf,
+				remaining,
+				FOLL_WRITE,
+				&pages[page_count - remaining]);
+		if (completed < 0) {
+			pr_err("%s: failed to pin user pages error %i\n",
+			       __func__, completed);
+			ret = completed;
+			goto unpin_pages;
+		}
+		remaining -= completed;
+		u_buf += completed * HV_HYP_PAGE_SIZE;
+	}
+
+	if (is_set)
+		ret = hv_call_set_vp_state(vp->index,
+					   vp->partition->id,
+					   args->type, args->xsave,
+					   page_count, pages,
+					   0, NULL);
+	else
+		ret = hv_call_get_vp_state(vp->index,
+					   vp->partition->id,
+					   args->type, args->xsave,
+					   page_count, pages,
+					   NULL);
+
+unpin_pages:
+	unpin_user_pages(pages, page_count - remaining);
+	kfree(pages);
+	return ret;
+}
+
+static long
+mshv_vp_ioctl_get_set_state(struct mshv_vp *vp, void __user *user_args, bool is_set)
+{
+	struct mshv_vp_state args;
+	long ret = 0;
+	union hv_get_vp_state_out vp_state;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	/* For now just support these */
+	if (args.type != HV_GET_SET_VP_STATE_LOCAL_INTERRUPT_CONTROLLER_STATE &&
+	    args.type != HV_GET_SET_VP_STATE_XSAVE)
+		return -EINVAL;
+
+	/* If we need to pin pfns, delegate to helper */
+	if (args.type & HV_GET_SET_VP_STATE_TYPE_PFN)
+		return mshv_vp_ioctl_get_set_state_pfn(vp, &args, is_set);
+
+	if (args.buf_size < sizeof(vp_state))
+		return -EINVAL;
+
+	if (is_set) {
+		if (copy_from_user(
+				&vp_state,
+				args.buf.lapic,
+				sizeof(vp_state)))
+			return -EFAULT;
+
+		return hv_call_set_vp_state(vp->index,
+					    vp->partition->id,
+					    args.type, args.xsave,
+					    0, NULL,
+					    sizeof(vp_state),
+					    (u8 *)&vp_state);
+	}
+
+	ret = hv_call_get_vp_state(vp->index,
+				   vp->partition->id,
+				   args.type, args.xsave,
+				   0, NULL,
+				   &vp_state);
+
+	if (ret)
+		return ret;
+
+	if (copy_to_user(args.buf.lapic,
+			 &vp_state.interrupt_controller_state,
+			 sizeof(vp_state.interrupt_controller_state)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long
 mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -307,6 +423,12 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_SET_VP_REGISTERS:
 		r = mshv_vp_ioctl_set_regs(vp, (void __user *)arg);
 		break;
+	case MSHV_GET_VP_STATE:
+		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, false);
+		break;
+	case MSHV_SET_VP_STATE:
+		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, true);
+		break;
 	default:
 		r = -ENOTTY;
 		break;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index d1cc5dbc78b5..55a957436813 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -168,6 +168,9 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_ASSERT_VIRTUAL_INTERRUPT		0x0094
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
+#define HVCALL_MAP_VP_STATE_PAGE			0x00e1
+#define HVCALL_GET_VP_STATE				0x00e3
+#define HVCALL_SET_VP_STATE				0x00e4
 
 /* Extended hypercalls */
 #define HV_EXT_CALL_QUERY_CAPABILITIES		0x8001
@@ -832,4 +835,41 @@ struct hv_assert_virtual_interrupt {
 	u16 rsvd_z1;
 } __packed;
 
+struct hv_vp_state_data {
+	u32 type;
+	u32 rsvd;
+	struct hv_vp_state_data_xsave xsave;
+} __packed;
+
+struct hv_get_vp_state_in {
+	u64 partition_id;
+	u32 vp_index;
+	u8 input_vtl;
+	u8 rsvd0;
+	u16 rsvd1;
+	struct hv_vp_state_data state_data;
+	u64 output_data_pfns[];
+} __packed;
+
+union hv_get_vp_state_out {
+	struct hv_local_interrupt_controller_state interrupt_controller_state;
+	/* Not supported yet */
+	/* struct hv_synthetic_timers_state synthetic_timers_state; */
+} __packed;
+
+union hv_input_set_vp_state_data {
+	u64 pfns;
+	u8 bytes;
+} __packed;
+
+struct hv_set_vp_state_in {
+	u64 partition_id;
+	u32 vp_index;
+	u8 input_vtl;
+	u8 rsvd0;
+	u16 rsvd1;
+	struct hv_vp_state_data state_data;
+	union hv_input_set_vp_state_data data[];
+} __packed;
+
 #endif
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index 4ecb29fe1a0e..f4d8e9d148c3 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -103,4 +103,32 @@ struct hv_register_assoc {
 	union hv_register_value value;
 } __packed;
 
+/*
+ * For getting and setting VP state, there are two options based on the state type:
+ *
+ *     1.) Data that is accessed by PFNs in the input hypercall page. This is used
+ *         for state which may not fit into the hypercall pages.
+ *     2.) Data that is accessed directly in the input\output hypercall pages.
+ *         This is used for state that will always fit into the hypercall pages.
+ *
+ * In the future this could be dynamic based on the size if needed.
+ *
+ * Note these hypercalls have an 8-byte aligned variable header size as per the tlfs
+ */
+
+#define HV_GET_SET_VP_STATE_TYPE_PFN	BIT(31)
+
+enum hv_get_set_vp_state_type {
+	HV_GET_SET_VP_STATE_LOCAL_INTERRUPT_CONTROLLER_STATE = 0,
+
+	HV_GET_SET_VP_STATE_XSAVE		= 1 | HV_GET_SET_VP_STATE_TYPE_PFN,
+	/* Synthetic message page */
+	HV_GET_SET_VP_STATE_SIM_PAGE		= 2 | HV_GET_SET_VP_STATE_TYPE_PFN,
+	/* Synthetic interrupt event flags page. */
+	HV_GET_SET_VP_STATE_SIEF_PAGE		= 3 | HV_GET_SET_VP_STATE_TYPE_PFN,
+
+	/* Synthetic timers. */
+	HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS	= 4,
+};
+
 #endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index f65248a1ee89..73c24478e87e 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -53,6 +53,17 @@ struct mshv_assert_interrupt {
 	__u32 vector;
 };
 
+struct mshv_vp_state {
+	enum hv_get_set_vp_state_type type;
+	struct hv_vp_state_data_xsave xsave; /* only for xsave request */
+
+	__u64 buf_size; /* If xsave, must be page-aligned */
+	union {
+		struct hv_local_interrupt_controller_state *lapic;
+		__u8 *bytes; /* Xsave data. must be page-aligned */
+	} buf;
+};
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
@@ -70,5 +81,7 @@ struct mshv_assert_interrupt {
 #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
 #define MSHV_SET_VP_REGISTERS   _IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
 #define MSHV_RUN_VP		_IOR(MSHV_IOCTL, 0x07, struct hv_message)
+#define MSHV_GET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0A, struct mshv_vp_state)
+#define MSHV_SET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0B, struct mshv_vp_state)
 
 #endif
-- 
2.23.4

