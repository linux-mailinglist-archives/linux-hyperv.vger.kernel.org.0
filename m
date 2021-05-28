Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85BF3948D8
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 May 2021 00:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhE1WpY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 May 2021 18:45:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55912 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhE1WpT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 May 2021 18:45:19 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C89F20B802D;
        Fri, 28 May 2021 15:43:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C89F20B802D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622241823;
        bh=XY/Oa0rT1yOGL0Qx61cyq7XOTyStGZF3INCUnDKj6bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3TwIFhIWsfu+fdYS+5stI9U2n95uHfpNVPVkVH5xOkiiXJclbZT5CmOhjxb6ko0n
         SAjjgDPHGUFT/84RBTF0sVaUXh19AmJXe0KMYom6aPar/b0HHR9nX5wEnFD7nDZWg1
         /NZVyk9lHVct7O24nbKc92kBdyDAt/z68thGX5zY=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
Subject: [PATCH 16/19] drivers/hv: mmap vp register page
Date:   Fri, 28 May 2021 15:43:36 -0700
Message-Id: <1622241819-21155-17-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce mmap interface for a virtual processor, exposing a page for
setting and getting common registers while the VP is suspended.

This provides a more performant and convenient way to get and set these
registers in the context of a vmm's run-loop.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst         | 11 ++++
 arch/x86/include/uapi/asm/hyperv-tlfs.h | 74 +++++++++++++++++++++++++
 drivers/hv/hv_call.c                    | 41 ++++++++++++++
 drivers/hv/mshv.h                       |  4 ++
 drivers/hv/mshv_main.c                  | 43 ++++++++++++++
 include/asm-generic/hyperv-tlfs.h       | 10 ++++
 include/linux/mshv.h                    |  1 +
 include/uapi/asm-generic/hyperv-tlfs.h  |  5 ++
 include/uapi/linux/mshv.h               | 12 ++++
 9 files changed, 201 insertions(+)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index 1613ac6e9428..bf3c060bd418 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -149,3 +149,14 @@ HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED
 Get/set various vp state. Currently these can be used to get and set
 emulated LAPIC state, and xsave data.
 
+3.10 mmap(vp)
+-------------
+:Type: vp mmap
+:Parameters: offset should be HV_VP_MMAP_REGISTERS_OFFSET
+:Returns: 0 on success
+
+Maps a page into userspace that can be used to get and set common registers
+while the vp is suspended.
+The page is laid out in struct hv_vp_register_page in asm/hyperv-tlfs.h.
+
+
diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
index 46806227e869..5430f3c98934 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -1072,4 +1072,78 @@ struct hv_vp_state_data_xsave {
 	union hv_x64_xsave_xfem_register states;
 } __packed;
 
+/* Bits for dirty mask of hv_vp_register_page */
+#define HV_X64_REGISTER_CLASS_GENERAL	0
+#define HV_X64_REGISTER_CLASS_IP	1
+#define HV_X64_REGISTER_CLASS_XMM	2
+#define HV_X64_REGISTER_CLASS_SEGMENT	3
+#define HV_X64_REGISTER_CLASS_FLAGS	4
+
+#define HV_VP_REGISTER_PAGE_VERSION_1	1u
+
+struct hv_vp_register_page {
+	__u16 version;
+	__u8 isvalid;
+	__u8 rsvdz;
+	__u32 dirty;
+	union {
+		struct {
+			__u64 rax;
+			__u64 rcx;
+			__u64 rdx;
+			__u64 rbx;
+			__u64 rsp;
+			__u64 rbp;
+			__u64 rsi;
+			__u64 rdi;
+			__u64 r8;
+			__u64 r9;
+			__u64 r10;
+			__u64 r11;
+			__u64 r12;
+			__u64 r13;
+			__u64 r14;
+			__u64 r15;
+		} __packed;
+
+		__u64 gp_registers[16];
+	};
+	__u64 rip;
+	__u64 rflags;
+	union {
+		struct {
+			struct hv_u128 xmm0;
+			struct hv_u128 xmm1;
+			struct hv_u128 xmm2;
+			struct hv_u128 xmm3;
+			struct hv_u128 xmm4;
+			struct hv_u128 xmm5;
+		} __packed;
+
+		struct hv_u128 xmm_registers[6];
+	};
+	union {
+		struct {
+			struct hv_x64_segment_register es;
+			struct hv_x64_segment_register cs;
+			struct hv_x64_segment_register ss;
+			struct hv_x64_segment_register ds;
+			struct hv_x64_segment_register fs;
+			struct hv_x64_segment_register gs;
+		} __packed;
+
+		struct hv_x64_segment_register segment_registers[6];
+	};
+	/* read only */
+	__u64 cr0;
+	__u64 cr3;
+	__u64 cr4;
+	__u64 cr8;
+	__u64 efer;
+	__u64 dr7;
+	union hv_x64_pending_interruption_register pending_interruption;
+	union hv_x64_interrupt_state_register interrupt_state;
+	__u64 instruction_emulation_hints;
+} __packed;
+
 #endif
diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
index 64b7bc16f4ef..a2ae0a31706b 100644
--- a/drivers/hv/hv_call.c
+++ b/drivers/hv/hv_call.c
@@ -599,3 +599,44 @@ int hv_call_set_vp_state(
 	return ret;
 }
 
+int hv_call_map_vp_state_page(
+		u32 vp_index,
+		u64 partition_id,
+		struct page **state_page)
+{
+	struct hv_map_vp_state_page_in *input;
+	struct hv_map_vp_state_page_out *output;
+	u64 status;
+	int ret;
+	unsigned long flags;
+
+	do {
+		local_irq_save(flags);
+		input = (struct hv_map_vp_state_page_in *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+		output = (struct hv_map_vp_state_page_out *)(*this_cpu_ptr(
+			hyperv_pcpu_output_arg));
+
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->type = HV_VP_STATE_PAGE_REGISTERS;
+		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE,
+						   input, output);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (hv_result_success(status))
+				*state_page = pfn_to_page(output->map_location);
+			else
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+			local_irq_restore(flags);
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		local_irq_restore(flags);
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index c8f3919a5cdc..a9215581be6b 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -97,5 +97,9 @@ int hv_call_set_vp_state(
 		struct page **pages,
 		u32 num_bytes,
 		u8 *bytes);
+int hv_call_map_vp_state_page(
+		u32 vp_index,
+		u64 partition_id,
+		struct page **state_page);
 
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 57d233a61b10..bc1df1f6e737 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -37,11 +37,18 @@ static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned
 static int mshv_dev_open(struct inode *inode, struct file *filp);
 static int mshv_dev_release(struct inode *inode, struct file *filp);
 static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
+static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma);
+static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
+
+static const struct vm_operations_struct mshv_vp_vm_ops = {
+	.fault = mshv_vp_fault,
+};
 
 static const struct file_operations mshv_vp_fops = {
 	.release = mshv_vp_release,
 	.unlocked_ioctl = mshv_vp_ioctl,
 	.llseek = noop_llseek,
+	.mmap = mshv_vp_mmap,
 };
 
 static const struct file_operations mshv_partition_fops = {
@@ -428,6 +435,42 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	return r;
 }
 
+static vm_fault_t mshv_vp_fault(struct vm_fault *vmf)
+{
+	struct mshv_vp *vp = vmf->vma->vm_file->private_data;
+	vmf->page = vp->register_page;
+	get_page(vp->register_page);
+
+	return 0;
+}
+
+static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int ret;
+	struct mshv_vp *vp = file->private_data;
+
+	if (vma->vm_pgoff != MSHV_VP_MMAP_REGISTERS_OFFSET)
+		return -EINVAL;
+
+	if (mutex_lock_killable(&vp->mutex))
+		return -EINTR;
+
+	if (!vp->register_page) {
+		ret = hv_call_map_vp_state_page(vp->index,
+						vp->partition->id,
+						&vp->register_page);
+		if (ret) {
+			mutex_unlock(&vp->mutex);
+			return ret;
+		}
+	}
+
+	mutex_unlock(&vp->mutex);
+
+	vma->vm_ops = &mshv_vp_vm_ops;
+	return 0;
+}
+
 static int
 mshv_vp_release(struct inode *inode, struct file *filp)
 {
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 504d5a7472b6..8d4750d19c9d 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -872,4 +872,14 @@ struct hv_set_vp_state_in {
 	union hv_input_set_vp_state_data data[];
 } __packed;
 
+struct hv_map_vp_state_page_in {
+	u64 partition_id;
+	u32 vp_index;
+	u32 type; /* enum hv_vp_state_page_type */
+} __packed;
+
+struct hv_map_vp_state_page_out {
+	u64 map_location; /* page number */
+} __packed;
+
 #endif
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index 3933d80294f1..33f4d0cfee11 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -20,6 +20,7 @@ struct mshv_vp {
 	u32 index;
 	struct mshv_partition *partition;
 	struct mutex mutex;
+	struct page *register_page;
 	struct {
 		struct semaphore sem;
 		struct task_struct *task;
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index f4d8e9d148c3..a1bc77e463dd 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -131,4 +131,9 @@ enum hv_get_set_vp_state_type {
 	HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS	= 4,
 };
 
+enum hv_vp_state_page_type {
+	HV_VP_STATE_PAGE_REGISTERS = 0,
+	HV_VP_STATE_PAGE_COUNT
+};
+
 #endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 73c24478e87e..718a3617e1f1 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -14,6 +14,8 @@
 
 #define MSHV_CAP_CORE_API_STABLE    0x0
 
+#define MSHV_VP_MMAP_REGISTERS_OFFSET (HV_VP_STATE_PAGE_REGISTERS * 0x1000)
+
 struct mshv_create_partition {
 	__u64 flags;
 	struct hv_partition_creation_properties partition_creation_properties;
@@ -84,4 +86,14 @@ struct mshv_vp_state {
 #define MSHV_GET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0A, struct mshv_vp_state)
 #define MSHV_SET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0B, struct mshv_vp_state)
 
+/* register page mapping example:
+ * struct hv_vp_register_page *regs = mmap(NULL,
+ *					   4096,
+ *					   PROT_READ | PROT_WRITE,
+ *					   MAP_SHARED,
+ *					   vp_fd,
+ *					   HV_VP_MMAP_REGISTERS_OFFSET);
+ * munmap(regs, 4096);
+ */
+
 #endif
-- 
2.25.1

