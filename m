Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD7C3948D4
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 May 2021 00:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhE1WpW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 May 2021 18:45:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55852 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhE1WpS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 May 2021 18:45:18 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 35C8720B8022;
        Fri, 28 May 2021 15:43:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35C8720B8022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622241823;
        bh=zdC7eE3fzv1COoeFnFMxjUEwKjPXq18KyPAtQi4mJIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KaQDz/MRPwjpuvcSzyBf2J2OExKnDGwL0NdweBxMZHGhinJQMsLqOrLcoJqkcbbRt
         5lzKDxYcI4TiWAO+pr5cK5LXZDawbfB90wd0NHkvIKr3xl7C+KNq1NQQ/jEfc+18cw
         tlS+PyYFCZszdlIK7PtekpyY3HmKVj6uYSARJOY4=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
Subject: [PATCH 12/19] drivers/hv: run vp ioctl and isr
Date:   Fri, 28 May 2021 15:43:32 -0700
Message-Id: <1622241819-21155-13-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce an ioctl for running a vp and an isr to copy messages from
the synic page to the vp data structure.

Add synchronization primitives to ensure that the isr is finished
when the run vp ioctl is entered.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst |  14 +++
 arch/x86/kernel/cpu/mshyperv.c  |  16 ++++
 drivers/hv/hv_synic.c           |  98 ++++++++++++++++++-
 drivers/hv/mshv.h               |   1 +
 drivers/hv/mshv_main.c          | 162 +++++++++++++++++++++++++++++++-
 include/asm-generic/mshyperv.h  |   3 +
 include/linux/mshv.h            |   7 ++
 include/uapi/linux/mshv.h       |   1 +
 8 files changed, 300 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index f0631236c063..9deddcd7de54 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -106,4 +106,18 @@ Get/set vp registers. See asm/hyperv-tlfs.h for the complete set of registers.
 Includes general purpose platform registers, MSRs, and virtual registers that
 are part of Microsoft Hypervisor platform and not directly exposed to the guest.
 
+3.6 MSHV_RUN_VP
+---------------
+:Type: vp ioctl
+:Parameters: struct hv_message
+:Returns: 0 on success
+
+Run the vp, returning when it triggers an intercept, or if the calling thread
+is interrupted by a signal. In this case errno will be set to EINTR.
+
+On return, the vp will be suspended.
+This ioctl will fail on any vp that's already running (not suspended).
+
+Information about the intercept is returned in the hv_message struct.
+
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 22f13343b5da..a80058bc128f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -41,6 +41,7 @@ struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
 
 #if IS_ENABLED(CONFIG_HYPERV)
+static void (*mshv_handler)(void);
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
@@ -51,6 +52,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	inc_irq_stat(irq_hv_callback_count);
+	if (mshv_handler)
+		mshv_handler();
+
 	if (vmbus_handler)
 		vmbus_handler();
 
@@ -60,6 +64,18 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	set_irq_regs(old_regs);
 }
 
+void hv_setup_mshv_irq(void (*handler)(void))
+{
+	mshv_handler = handler;
+}
+
+void hv_remove_mshv_irq(void)
+{
+	mshv_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(hv_setup_mshv_irq);
+EXPORT_SYMBOL_GPL(hv_remove_mshv_irq);
+
 void hv_setup_vmbus_handler(void (*handler)(void))
 {
 	vmbus_handler = handler;
diff --git a/drivers/hv/hv_synic.c b/drivers/hv/hv_synic.c
index 8065f3598001..9800ae6693a9 100644
--- a/drivers/hv/hv_synic.c
+++ b/drivers/hv/hv_synic.c
@@ -11,11 +11,107 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/random.h>
 #include <linux/mshv.h>
 #include <asm/mshyperv.h>
 
 #include "mshv.h"
 
+void mshv_isr(void)
+{
+	struct hv_message_page **msg_page =
+			this_cpu_ptr(mshv.synic_message_page);
+	struct hv_message *msg;
+	u32 message_type;
+	struct mshv_partition *partition;
+	struct mshv_vp *vp;
+	u64 partition_id;
+	u32 vp_index;
+	int i;
+	unsigned long flags;
+	struct task_struct *task;
+
+	if (unlikely(!(*msg_page))) {
+		pr_err("%s: Missing synic page!\n", __func__);
+		return;
+	}
+
+	msg = &((*msg_page)->sint_message[HV_SYNIC_INTERCEPTION_SINT_INDEX]);
+
+	/*
+	 * If the type isn't set, there isn't really a message;
+	 * it may be some other hyperv interrupt
+	 */
+	message_type = msg->header.message_type;
+	if (message_type == HVMSG_NONE)
+		return;
+
+	/* Look for the partition */
+	partition_id = msg->header.sender;
+
+	/* Hold this lock for the rest of the isr, because the partition could
+	 * be released anytime.
+	 * e.g. the MSHV_RUN_VP thread could wake on another cpu; it could
+	 * release the partition unless we hold this!
+	 */
+	spin_lock_irqsave(&mshv.partitions.lock, flags);
+
+	for (i = 0; i < MSHV_MAX_PARTITIONS; i++) {
+		partition = mshv.partitions.array[i];
+		if (partition && partition->id == partition_id)
+			break;
+	}
+
+	if (unlikely(i == MSHV_MAX_PARTITIONS)) {
+		pr_err("%s: failed to find partition\n", __func__);
+		goto unlock_out;
+	}
+
+	/*
+	 * Since we directly index the vp, and it has to exist for us to be here
+	 * (because the vp is only deleted when the partition is), no additional
+	 * locking is needed here
+	 */
+	vp_index = ((struct hv_x64_intercept_message_header *)msg->u.payload)->vp_index;
+	vp = partition->vps.array[vp_index];
+	if (unlikely(!vp)) {
+		pr_err("%s: failed to find vp\n", __func__);
+		goto unlock_out;
+	}
+
+	memcpy(vp->run.intercept_message, msg, sizeof(struct hv_message));
+
+	if (unlikely(!vp->run.task)) {
+		pr_err("%s: vp run task not set\n", __func__);
+		goto unlock_out;
+	}
+
+	/* Save the task and reset it so we can wake without racing */
+	task = vp->run.task;
+	vp->run.task = NULL;
+
+	/*
+	 * up the semaphore before waking so that we don't race with
+	 * down_trylock
+	 */
+	up(&vp->run.sem);
+
+	/*
+	 * Finally, wake the process. If it wakes the vp and generates
+	 * another intercept then the message will be queued by the hypervisor
+	 */
+	wake_up_process(task);
+
+unlock_out:
+	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
+
+	/* Acknowledge message with hypervisor */
+	msg->header.message_type = HVMSG_NONE;
+	wrmsrl(HV_X64_MSR_EOM, 0);
+
+	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
+}
+
 int mshv_synic_init(unsigned int cpu)
 {
 	union hv_synic_simp simp;
@@ -30,7 +126,7 @@ int mshv_synic_init(unsigned int cpu)
 	*msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
 			     HV_HYP_PAGE_SIZE,
                              MEMREMAP_WB);
-	if (!msg_page) {
+	if (!(*msg_page)) {
 		pr_err("%s: memremap failed\n", __func__);
 		return -EFAULT;
 	}
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index b8fece9fe80d..014352a11190 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -29,6 +29,7 @@
 
 extern struct mshv mshv;
 
+void mshv_isr(void);
 int mshv_synic_init(unsigned int cpu);
 int mshv_synic_cleanup(unsigned int cpu);
 
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index a3e6cd15f9ed..478c7be29153 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 #include <linux/cpuhotplug.h>
+#include <linux/random.h>
 #include <linux/mshv.h>
 #include <asm/mshyperv.h>
 
@@ -64,6 +65,130 @@ static struct miscdevice mshv_dev = {
 	.mode = 600,
 };
 
+static long
+mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_message)
+{
+	long ret;
+	u32 msg_type;
+	struct hv_register_assoc suspend_registers[2] = {
+		{ .name = HV_REGISTER_EXPLICIT_SUSPEND },
+		{ .name = HV_REGISTER_INTERCEPT_SUSPEND }
+	};
+	/* Pointers to values for convenience */
+	union hv_explicit_suspend_register *explicit_suspend =
+				&suspend_registers[0].value.explicit_suspend;
+	union hv_intercept_suspend_register *intercept_suspend =
+				&suspend_registers[1].value.intercept_suspend;
+
+	/* Check that the VP is suspended */
+	ret = hv_call_get_vp_registers(
+			vp->index,
+			vp->partition->id,
+			2,
+			suspend_registers);
+	if (ret)
+		return ret;
+
+	if (!explicit_suspend->suspended &&
+	    !intercept_suspend->suspended) {
+		pr_err("%s: vp not suspended!\n", __func__);
+		return -EBADFD;
+	}
+
+	/*
+	 * If intercept_suspend is set, we missed a message and need to
+	 * wait for mshv_isr to complete
+	 */
+	if (intercept_suspend->suspended) {
+		if (down_interruptible(&vp->run.sem))
+			return -EINTR;
+		if (copy_to_user(ret_message, vp->run.intercept_message,
+				 sizeof(struct hv_message)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/*
+	 * At this point the semaphore ensures that mshv_isr is done,
+	 * and the mutex ensures that no other threads are touching this vp
+	 */
+	vp->run.task = current;
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	/* Now actually start the vp running */
+	explicit_suspend->suspended = 0;
+	intercept_suspend->suspended = 0;
+	ret = hv_call_set_vp_registers(
+			vp->index,
+			vp->partition->id,
+			2,
+			suspend_registers);
+	if (ret) {
+		pr_err("%s: failed to clear suspend bits\n", __func__);
+		set_current_state(TASK_RUNNING);
+		vp->run.task = NULL;
+		return ret;
+	}
+
+	schedule();
+
+	/* Explicitly suspend the vp to make sure it's stopped */
+	explicit_suspend->suspended = 1;
+	ret = hv_call_set_vp_registers(
+		vp->index,
+		vp->partition->id,
+		1,
+		&suspend_registers[0]);
+	if (ret) {
+		pr_err("%s: failed to set explicit suspend bit\n", __func__);
+		return -EBADFD;
+	}
+
+	/*
+	 * Check if woken up by a signal
+	 * Note that if the signal came after being woken by mshv_isr(),
+	 * we will still get the message correctly on re-entry
+	 */
+	if (signal_pending(current)) {
+		pr_debug("%s: woke up, received signal\n", __func__);
+		return -EINTR;
+	}
+
+	/*
+	 * No signal pending, so we were woken by hv_host_isr()
+	 * The isr can't be running now, and the intercept_suspend bit is set
+	 * We use it as a flag to tell if we missed a message due to a signal,
+	 * so we must clear it here and reset the semaphore
+	 */
+	intercept_suspend->suspended = 0;
+	ret = hv_call_set_vp_registers(
+		vp->index,
+		vp->partition->id,
+		1,
+		&suspend_registers[1]);
+	if (ret) {
+		pr_err("%s: failed to clear intercept suspend bit\n", __func__);
+		return -EBADFD;
+	}
+	if (down_trylock(&vp->run.sem)) {
+		pr_err("%s: semaphore in unexpected state\n", __func__);
+		return -EBADFD;
+	}
+
+	msg_type = vp->run.intercept_message->header.message_type;
+
+	if (msg_type == HVMSG_NONE) {
+		pr_err("%s: woke up, but no message\n", __func__);
+		return -ENOMSG;
+	}
+
+	if (copy_to_user(ret_message, vp->run.intercept_message,
+			 sizeof(struct hv_message)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long
 mshv_vp_ioctl_get_regs(struct mshv_vp *vp, void __user *user_args)
 {
@@ -110,6 +235,7 @@ mshv_vp_ioctl_set_regs(struct mshv_vp *vp, void __user *user_args)
 	struct mshv_vp_registers args;
 	struct hv_register_assoc *registers;
 	long ret;
+	int i;
 
 	if (copy_from_user(&args, user_args, sizeof(args)))
 		return -EFAULT;
@@ -130,6 +256,20 @@ mshv_vp_ioctl_set_regs(struct mshv_vp *vp, void __user *user_args)
 		goto free_return;
 	}
 
+	for (i = 0; i < args.count; i++) {
+		/*
+		 * Disallow setting suspend registers to ensure run vp state
+		 * is consistent
+		 */
+		if (registers[i].name == HV_REGISTER_EXPLICIT_SUSPEND ||
+		    registers[i].name == HV_REGISTER_INTERCEPT_SUSPEND) {
+			pr_err("%s: not allowed to set suspend registers\n",
+			       __func__);
+			ret = -EINVAL;
+			goto free_return;
+		}
+	}
+
 	ret = hv_call_set_vp_registers(vp->index, vp->partition->id,
 				       args.count, registers);
 
@@ -148,6 +288,9 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		return -EINTR;
 
 	switch (ioctl) {
+	case MSHV_RUN_VP:
+		r = mshv_vp_ioctl_run_vp(vp, (void __user *)arg);
+		break;
 	case MSHV_GET_VP_REGISTERS:
 		r = mshv_vp_ioctl_get_regs(vp, (void __user *)arg);
 		break;
@@ -198,12 +341,20 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 		return -ENOMEM;
 
 	mutex_init(&vp->mutex);
+	sema_init(&vp->run.sem, 0);
+
+	vp->run.intercept_message =
+		(struct hv_message *)get_zeroed_page(GFP_KERNEL);
+	if (!vp->run.intercept_message) {
+		ret = -ENOMEM;
+		goto free_vp;
+	}
 
 	vp->index = args.vp_index;
 	vp->partition = mshv_partition_get(partition);
 	if (!vp->partition) {
 		ret = -EBADF;
-		goto free_vp;
+		goto free_message;
 	}
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
@@ -241,6 +392,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	put_unused_fd(fd);
 put_partition:
 	mshv_partition_put(partition);
+free_message:
+	free_page((unsigned long)vp->run.intercept_message);
 free_vp:
 	kfree(vp);
 
@@ -457,6 +610,9 @@ destroy_partition(struct mshv_partition *partition)
 		mshv.partitions.array[i] = NULL;
 	}
 
+	if (!mshv.partitions.count)
+		hv_remove_mshv_irq();
+
 	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
 
 	/*
@@ -476,6 +632,7 @@ destroy_partition(struct mshv_partition *partition)
 		vp = partition->vps.array[i];
 		if (!vp)
 			continue;
+		free_page((unsigned long)vp->run.intercept_message);
 		kfree(vp);
 	}
 
@@ -539,6 +696,9 @@ add_partition(struct mshv_partition *partition)
 	mshv.partitions.count++;
 	mshv.partitions.array[i] = partition;
 
+	if (mshv.partitions.count == 1)
+		hv_setup_mshv_irq(mshv_isr);
+
 out_unlock:
 	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 21fb71ca1ba9..ec9afca749f0 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -151,6 +151,9 @@ void hv_remove_vmbus_handler(void);
 void hv_setup_stimer0_handler(void (*handler)(void));
 void hv_remove_stimer0_handler(void);
 
+void hv_setup_mshv_irq(void (*handler)(void));
+void hv_remove_mshv_irq(void);
+
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index 7709aaa1e064..3933d80294f1 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -8,6 +8,8 @@
 
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/semaphore.h>
+#include <linux/sched.h>
 #include <uapi/linux/mshv.h>
 
 #define MSHV_MAX_PARTITIONS		128
@@ -18,6 +20,11 @@ struct mshv_vp {
 	u32 index;
 	struct mshv_partition *partition;
 	struct mutex mutex;
+	struct {
+		struct semaphore sem;
+		struct task_struct *task;
+		struct hv_message *intercept_message;
+	} run;
 };
 
 struct mshv_mem_region {
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 7a4e0c340dd4..229abac9502f 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -55,5 +55,6 @@ struct mshv_vp_registers {
 /* vp device */
 #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
 #define MSHV_SET_VP_REGISTERS   _IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
+#define MSHV_RUN_VP		_IOR(MSHV_IOCTL, 0x07, struct hv_message)
 
 #endif
-- 
2.25.1

