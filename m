Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E42BBAF3
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgKUAbK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:31:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51272 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbgKUAax (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:53 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5339C20B800E;
        Fri, 20 Nov 2020 16:30:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5339C20B800E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918650;
        bh=1bryHHQCXD3jnaHpDiG1wJDcALDwQtKwXlrzQT7KiW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h8cxCYr3buyoE1jF5m5EWHODptUeycgVCx0sM4uwtjCwkTTTc63R9Z3oOEagc88wZ
         U/z1dNOZskOdA1hGFxIAl/Je7/3i87+OttYkeqxQKYtwDrdNHGbfj+Xx6Gi03YuCkW
         RY1r36voUFtNBiOhVWZLofWxH1BMuG7BJ2xuvt+M=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 12/18] virt/mshv: run vp ioctl and isr
Date:   Fri, 20 Nov 2020 16:30:31 -0800
Message-Id: <1605918637-12192-13-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce an ioctl for running a vp and an isr to copy messages from
the synic page to the vp data structure.

Add synchronization primitives to ensure that the isr is finished
when the run vp ioctl is entered.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst |  14 ++
 arch/x86/kernel/cpu/mshyperv.c  |  16 ++
 include/asm-generic/mshyperv.h  |   3 +
 include/linux/mshv.h            |   7 +
 include/uapi/linux/mshv.h       |   1 +
 virt/mshv/mshv_main.c           | 270 +++++++++++++++++++++++++++++++-
 6 files changed, 310 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index 20a626ac02d4..f525c81f2bdd 100644
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
index 4795e54550e6..e6ff4ed13233 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -37,6 +37,7 @@ struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
 
 #if IS_ENABLED(CONFIG_HYPERV)
+static void (*mshv_handler)(void);
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
@@ -47,6 +48,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	inc_irq_stat(irq_hv_callback_count);
+	if (mshv_handler)
+		mshv_handler();
+
 	if (vmbus_handler)
 		vmbus_handler();
 
@@ -56,6 +60,18 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
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
 int hv_setup_vmbus_irq(int irq, void (*handler)(void))
 {
 	/*
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c57799684170..3283a8059ed5 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -94,6 +94,9 @@ void hv_remove_vmbus_irq(void);
 void hv_enable_vmbus_irq(void);
 void hv_disable_vmbus_irq(void);
 
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
index 5d53ed655429..5be9e2d23893 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -55,5 +55,6 @@ struct mshv_vp_registers {
 /* vp device */
 #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
 #define MSHV_SET_VP_REGISTERS   _IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
+#define MSHV_RUN_VP		_IOR(MSHV_IOCTL, 0x07, struct hv_message)
 
 #endif
diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
index c9445d2edb37..7ddb66d260ce 100644
--- a/virt/mshv/mshv_main.c
+++ b/virt/mshv/mshv_main.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 #include <linux/cpuhotplug.h>
+#include <linux/random.h>
 #include <linux/mshv.h>
 #include <asm/mshyperv.h>
 
@@ -498,6 +499,240 @@ hv_call_set_vp_registers(u32 vp_index,
 	return -hv_status_to_errno(status);
 }
 
+static void
+mshv_isr(void)
+{
+	struct hv_message_page **msg_page =
+			this_cpu_ptr(mshv.synic_message_page);
+	struct hv_message *msg;
+	enum hv_message_type message_type;
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
+
+static long
+mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_message)
+{
+	long ret;
+	enum hv_message_type msg_type;
+	struct hv_register_assoc set_registers[2] = {
+		{ .name = HV_REGISTER_EXPLICIT_SUSPEND },
+		{ .name = HV_REGISTER_INTERCEPT_SUSPEND }
+	};
+	const enum hv_register_name get_register_names[2] = {
+		HV_REGISTER_EXPLICIT_SUSPEND,
+		HV_REGISTER_INTERCEPT_SUSPEND
+	};
+	union hv_register_value get_register_values[2];
+	/* Pointers to values for convenience */
+	union hv_explicit_suspend_register *set_explicit_suspend =
+				&set_registers[0].value.explicit_suspend;
+	union hv_intercept_suspend_register *set_intercept_suspend =
+				&set_registers[1].value.intercept_suspend;
+	union hv_explicit_suspend_register *get_explicit_suspend =
+				&get_register_values[0].explicit_suspend;
+	union hv_intercept_suspend_register *get_intercept_suspend =
+				&get_register_values[1].intercept_suspend;
+
+	/* Check that the VP is suspended */
+	ret = hv_call_get_vp_registers(
+			vp->index,
+			vp->partition->id,
+			2,
+			get_register_names,
+			get_register_values
+			);
+	if (ret)
+		return ret;
+
+	if (!get_explicit_suspend->suspended &&
+	    !get_intercept_suspend->suspended) {
+		pr_err("%s: vp not suspended!\n", __func__);
+		return -EBADFD;
+	}
+
+	/*
+	 * If intercept_suspend is set, we missed a message and need to
+	 * wait for mshv_isr to complete
+	 */
+	if (get_intercept_suspend->suspended) {
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
+	set_explicit_suspend->suspended = 0;
+	set_intercept_suspend->suspended = 0;
+	ret = hv_call_set_vp_registers(
+			vp->index,
+			vp->partition->id,
+			2,
+			set_registers);
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
+	set_explicit_suspend->suspended = 1;
+	ret = hv_call_set_vp_registers(
+		vp->index,
+		vp->partition->id,
+		1,
+		&set_registers[0]);
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
+	set_intercept_suspend->suspended = 0;
+	ret = hv_call_set_vp_registers(
+		vp->index,
+		vp->partition->id,
+		1,
+		&set_registers[1]);
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
+
+
 static long
 mshv_vp_ioctl_get_regs(struct mshv_vp *vp, void __user *user_args)
 {
@@ -600,6 +835,19 @@ mshv_vp_ioctl_set_regs(struct mshv_vp *vp, void __user *user_args)
 	}
 
 	for (i = 0; i < args.count; i++) {
+
+		/*
+		 * Disallow setting suspend registers to ensure run vp state
+		 * is consistent
+		 */
+		if (names[i] == HV_REGISTER_EXPLICIT_SUSPEND ||
+		    names[i] == HV_REGISTER_INTERCEPT_SUSPEND) {
+			pr_err("%s: not allowed to set suspend registers\n",
+			       __func__);
+			ret = -EINVAL;
+			goto free_return;
+		}
+
 		memcpy(&registers[i].name, &names[i],
 		       sizeof(enum hv_register_name));
 		memcpy(&registers[i].value, &values[i],
@@ -627,6 +875,9 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		return -EINTR;
 
 	switch (ioctl) {
+	case MSHV_RUN_VP:
+		r = mshv_vp_ioctl_run_vp(vp, (void __user *)arg);
+		break;
 	case MSHV_GET_VP_REGISTERS:
 		r = mshv_vp_ioctl_get_regs(vp, (void __user *)arg);
 		break;
@@ -677,12 +928,20 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
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
@@ -720,6 +979,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	put_unused_fd(fd);
 put_partition:
 	mshv_partition_put(partition);
+free_message:
+	free_page((unsigned long)vp->run.intercept_message);
 free_vp:
 	kfree(vp);
 
@@ -939,6 +1200,9 @@ destroy_partition(struct mshv_partition *partition)
 		mshv.partitions.array[i] = NULL;
 	}
 
+	if (!mshv.partitions.count)
+		hv_remove_mshv_irq();
+
 	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
 
 	/*
@@ -958,6 +1222,7 @@ destroy_partition(struct mshv_partition *partition)
 		vp = partition->vps.array[i];
 		if (!vp)
 			continue;
+		free_page((unsigned long)vp->run.intercept_message);
 		kfree(vp);
 	}
 
@@ -1021,6 +1286,9 @@ add_partition(struct mshv_partition *partition)
 	mshv.partitions.count++;
 	mshv.partitions.array[i] = partition;
 
+	if (mshv.partitions.count == 1)
+		hv_setup_mshv_irq(mshv_isr);
+
 out_unlock:
 	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
 
-- 
2.25.1

