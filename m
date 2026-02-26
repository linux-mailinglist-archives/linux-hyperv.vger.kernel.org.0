Return-Path: <linux-hyperv+bounces-9014-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH/4NX6coGlVlAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9014-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 20:18:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F51AE431
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 20:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C83CB3004DDE
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869A44CF2C;
	Thu, 26 Feb 2026 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ECiNNeNH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B41044A706;
	Thu, 26 Feb 2026 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133500; cv=none; b=iXl51MklgStwLpmNPldxd4s7fUn2khpW2+sNq7aZYwKltzQx8/fmkPKtxl4oEvVFaQh87rbXNNLUd60TY6K7/bQ7UNo9pxrutCEi8mjfolVXANTPpfa8N9o2LX0yYw8fOEROSOuAXWDWtDMqwmbQm9HuD/8B0lfclbI2jWqJ+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133500; c=relaxed/simple;
	bh=vCDiT3eglnX4+iyp1WDCa2DXW+T8B8MgHOFi8DKNvoc=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=d5nbM/x6TApRMr7x1qc8854KxH0poFQL9MAO5tBBOQfHFwsAra2xlrW0SL5ijcvvfvzxgWnmfMp5M9iL/wcuYe7BARgWakEeC4i3YqFjEO+Q4i9afaJxfBbuBehbVoex32iA5+3GRl8yB7SqlwjDy4KmTO/Z9I7tqh/KuaKDqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ECiNNeNH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1865A20B6F02;
	Thu, 26 Feb 2026 11:18:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1865A20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772133491;
	bh=OGj2pdq2vlQm6hNcEuQkhSV5OQ23bRp4AmiUjlh3Z6g=;
	h=Subject:From:To:Cc:Date:From;
	b=ECiNNeNHYlYoXCTbjmwy60v7Jh3sE2g6A5WSrG2bPFqj3Uy6H/jq1W+uL7g/dgsQU
	 Fthg8J7mmBqS2KUKrGO5M1o6DeP3S3S4AR99eBYg8YQ6DbPfXzAZCLaUz4NzhS4x1J
	 0sp++nMkeGNg5VNfKfYWP/5pDmgpceCvKBWPQRA0=
Subject: [PATCH] mshv: Introduce tracing support
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Feb 2026 19:18:10 +0000
Message-ID: 
 <177213348504.92223.5330421592610811972.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9014-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B8F51AE431
X-Rspamd-Action: no action

Introduces various trace events and use them in the corresponding places
in the driver.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/Makefile            |    1 
 drivers/hv/mshv_eventfd.c      |   14 +
 drivers/hv/mshv_irq.c          |    4 
 drivers/hv/mshv_root.h         |    1 
 drivers/hv/mshv_root_hv_call.c |   22 +-
 drivers/hv/mshv_root_main.c    |   78 +++++-
 drivers/hv/mshv_trace.c        |    9 +
 drivers/hv/mshv_trace.h        |  515 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 629 insertions(+), 15 deletions(-)
 create mode 100644 drivers/hv/mshv_trace.c
 create mode 100644 drivers/hv/mshv_trace.h

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 2593711c3628..888a748cc7cb 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -16,6 +16,7 @@ hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
 	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
 mshv_root-$(CONFIG_DEBUG_FS) += mshv_debugfs.o
+mshv_root-$(CONFIG_TRACEPOINTS) += mshv_trace.o
 mshv_vtl-y := mshv_vtl_main.o
 
 # Code that must be built-in
diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 492c6258045c..d2efe248ca9b 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -733,6 +733,14 @@ static int mshv_assign_ioeventfd(struct mshv_partition *pt,
 	ret = mshv_register_doorbell(pt->pt_id, ioeventfd_mmio_write,
 				     (void *)pt, p->iovntfd_addr,
 				     p->iovntfd_datamatch, doorbell_flags);
+
+	trace_mshv_assign_ioeventfd(pt->pt_id, p->iovntfd_addr,
+				    p->iovntfd_length,
+				    p->iovntfd_datamatch,
+				    p->iovntfd_wildcard,
+				    p->iovntfd_eventfd,
+				    ret);
+
 	if (ret < 0)
 		goto unlock_fail;
 
@@ -780,6 +788,12 @@ static int mshv_deassign_ioeventfd(struct mshv_partition *pt,
 		    p->iovntfd_datamatch != args->datamatch)
 			continue;
 
+		trace_mshv_deassign_ioeventfd(pt->pt_id, p->iovntfd_addr,
+					      p->iovntfd_length,
+					      p->iovntfd_datamatch,
+					      p->iovntfd_wildcard,
+					      p->iovntfd_eventfd);
+
 		hlist_del_rcu(&p->iovntfd_hnode);
 		synchronize_rcu();
 		ioeventfd_release(p, pt->pt_id);
diff --git a/drivers/hv/mshv_irq.c b/drivers/hv/mshv_irq.c
index 798e7e1ab06e..aba7d3c431b8 100644
--- a/drivers/hv/mshv_irq.c
+++ b/drivers/hv/mshv_irq.c
@@ -71,6 +71,10 @@ int mshv_update_routing_table(struct mshv_partition *partition,
 	mutex_unlock(&partition->pt_irq_lock);
 
 	synchronize_srcu_expedited(&partition->pt_irq_srcu);
+
+	trace_mshv_update_routing_table(partition->pt_id,
+					old, new, numents);
+
 	new = old;
 
 out:
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 04c2a1910a8a..947dfb76bb19 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -17,6 +17,7 @@
 #include <linux/build_bug.h>
 #include <linux/mmu_notifier.h>
 #include <uapi/linux/mshv.h>
+#include "mshv_trace.h"
 
 /*
  * Hypervisor must be between these version numbers (inclusive)
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 317191462b63..bdcb8de7fb47 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -44,8 +44,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 	struct hv_output_withdraw_memory *output_page;
 	struct page *page;
 	u16 completed;
-	unsigned long remaining = count;
-	u64 status;
+	u64 status, withdrawn = 0;
 	int i;
 	unsigned long flags;
 
@@ -54,7 +53,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 		return -ENOMEM;
 	output_page = page_address(page);
 
-	while (remaining) {
+	while (withdrawn < count) {
 		local_irq_save(flags);
 
 		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -62,7 +61,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 		memset(input_page, 0, sizeof(*input_page));
 		input_page->partition_id = partition_id;
 		status = hv_do_rep_hypercall(HVCALL_WITHDRAW_MEMORY,
-					     min(remaining, HV_WITHDRAW_BATCH_SIZE),
+					     min(count - withdrawn, HV_WITHDRAW_BATCH_SIZE),
 					     0, input_page, output_page);
 
 		local_irq_restore(flags);
@@ -78,10 +77,12 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 			break;
 		}
 
-		remaining -= completed;
+		withdrawn += completed;
 	}
 	free_page((unsigned long)output_page);
 
+	trace_mshv_hvcall_withdraw_memory(partition_id, withdrawn, status);
+
 	return hv_result_to_errno(status);
 }
 
@@ -125,6 +126,8 @@ int hv_call_create_partition(u64 flags,
 		ret = hv_deposit_memory(hv_current_partition_id, status);
 	} while (!ret);
 
+	trace_mshv_hvcall_create_partition(flags, ret ? ret : *partition_id);
+
 	return ret;
 }
 
@@ -152,6 +155,8 @@ int hv_call_initialize_partition(u64 partition_id)
 		ret = hv_deposit_memory(partition_id, status);
 	} while (!ret);
 
+	trace_mshv_hvcall_initialize_partition(partition_id, status);
+
 	return ret;
 }
 
@@ -164,6 +169,8 @@ int hv_call_finalize_partition(u64 partition_id)
 	status = hv_do_fast_hypercall8(HVCALL_FINALIZE_PARTITION,
 				       *(u64 *)&input);
 
+	trace_mshv_hvcall_finalize_partition(partition_id, status);
+
 	return hv_result_to_errno(status);
 }
 
@@ -175,6 +182,8 @@ int hv_call_delete_partition(u64 partition_id)
 	input.partition_id = partition_id;
 	status = hv_do_fast_hypercall8(HVCALL_DELETE_PARTITION, *(u64 *)&input);
 
+	trace_mshv_hvcall_delete_partition(partition_id, status);
+
 	return hv_result_to_errno(status);
 }
 
@@ -571,6 +580,9 @@ static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 		ret = hv_deposit_memory(partition_id, status);
 	} while (!ret);
 
+	trace_mshv_hvcall_map_vp_state_page(partition_id, vp_index,
+					    type, status);
+
 	return ret;
 }
 
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e6509c980763..53dbe151de7b 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -430,6 +430,17 @@ mshv_vp_dispatch(struct mshv_vp *vp, u32 flags,
 	status = hv_do_hypercall(HVCALL_DISPATCH_VP, input, output);
 	vp->run.flags.root_sched_dispatched = 0;
 
+	trace_mshv_hvcall_dispatch_vp(vp->vp_partition->pt_id,
+				      vp->vp_index, flags,
+				      output->dispatch_state,
+				      output->dispatch_event,
+#if defined(CONFIG_X86_64)
+				      vp->vp_register_page->interrupt_vectors.as_uint64,
+#else
+				      0,
+#endif
+				      status);
+
 	*res = *output;
 	preempt_enable();
 
@@ -452,6 +463,9 @@ mshv_vp_clear_explicit_suspend(struct mshv_vp *vp)
 	ret = mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
 				    1, &explicit_suspend);
 
+	trace_mshv_vp_clear_explicit_suspend(vp->vp_partition->pt_id,
+					     vp->vp_index, ret);
+
 	if (ret)
 		vp_err(vp, "Failed to unsuspend\n");
 
@@ -494,6 +508,12 @@ mshv_vp_wait_for_hv_kick(struct mshv_vp *vp)
 	if (ret)
 		return -EINTR;
 
+	trace_mshv_vp_wait_for_hv_kick(vp->vp_partition->pt_id,
+				       vp->vp_index,
+				       vp->run.kicked_by_hv,
+				       mshv_vp_dispatch_thread_blocked(vp),
+				       mshv_vp_interrupt_pending(vp));
+
 	vp->run.flags.root_sched_blocked = 0;
 	vp->run.kicked_by_hv = 0;
 
@@ -522,6 +542,12 @@ static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
 
 		if (__xfer_to_guest_mode_work_pending()) {
 			ret = xfer_to_guest_mode_handle_work();
+
+			trace_mshv_xfer_to_guest_mode_work(vp->vp_partition->pt_id,
+							   vp->vp_index,
+							   read_thread_flags(),
+							   ret);
+
 			if (ret)
 				break;
 		}
@@ -673,6 +699,8 @@ static long mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_msg)
 {
 	long rc;
 
+	trace_mshv_run_vp_entry(vp->vp_partition->pt_id, vp->vp_index);
+
 	do {
 		if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 			rc = mshv_run_vp_with_root_scheduler(vp);
@@ -680,6 +708,10 @@ static long mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_msg)
 			rc = mshv_run_vp_with_hyp_scheduler(vp);
 	} while (rc == 0 && mshv_vp_handle_intercept(vp));
 
+	trace_mshv_run_vp_exit(vp->vp_partition->pt_id, vp->vp_index,
+			       vp->vp_intercept_msg_page->header.message_type,
+			       rc);
+
 	if (rc)
 		return rc;
 
@@ -941,6 +973,8 @@ mshv_vp_release(struct inode *inode, struct file *filp)
 {
 	struct mshv_vp *vp = filp->private_data;
 
+	trace_mshv_vp_release(vp->vp_partition->pt_id, vp->vp_index);
+
 	/* Rest of VP cleanup happens in destroy_partition() */
 	mshv_partition_put(vp->vp_partition);
 	return 0;
@@ -1113,7 +1147,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	partition->pt_vp_count++;
 	partition->pt_vp_array[args.vp_index] = vp;
 
-	return ret;
+	goto out;
 
 remove_debugfs_vp:
 	mshv_debugfs_vp_remove(vp);
@@ -1139,6 +1173,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 			       intercept_msg_page, input_vtl_zero);
 destroy_vp:
 	hv_call_delete_vp(partition->pt_id, args.vp_index);
+out:
+	trace_mshv_create_vp(partition->pt_id, vp->vp_index, ret);
 	return ret;
 }
 
@@ -1338,6 +1374,10 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		break;
 	}
 
+	trace_mshv_map_user_memory(partition->pt_id, region->start_uaddr,
+				   region->start_gfn, region->nr_pages,
+				   region->hv_map_flags, ret);
+
 	if (ret)
 		goto errout;
 
@@ -1633,6 +1673,9 @@ disable_vp_dispatch(struct mshv_vp *vp)
 	if (ret)
 		vp_err(vp, "failed to suspend\n");
 
+	trace_mshv_disable_vp_dispatch(vp->vp_partition->pt_id,
+				       vp->vp_index, ret);
+
 	return ret;
 }
 
@@ -1681,6 +1724,8 @@ drain_vp_signals(struct mshv_vp *vp)
 		vp->run.kicked_by_hv = 0;
 		vp_signal_count = atomic64_read(&vp->run.vp_signaled_count);
 	}
+
+	trace_mshv_drain_vp_signals(vp->vp_partition->pt_id, vp->vp_index);
 }
 
 static void drain_all_vps(const struct mshv_partition *partition)
@@ -1734,6 +1779,8 @@ static void destroy_partition(struct mshv_partition *partition)
 		return;
 	}
 
+	trace_mshv_destroy_partition(partition->pt_id);
+
 	if (partition->pt_initialized) {
 		/*
 		 * We only need to drain signals for root scheduler. This should be
@@ -1840,6 +1887,8 @@ mshv_partition_release(struct inode *inode, struct file *filp)
 {
 	struct mshv_partition *partition = filp->private_data;
 
+	trace_mshv_partition_release(partition->pt_id);
+
 	mshv_eventfd_release(partition);
 
 	cleanup_srcu_struct(&partition->pt_irq_srcu);
@@ -1969,6 +2018,7 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 	struct hv_partition_creation_properties creation_properties;
 	union hv_partition_isolation_properties isolation_properties;
 	struct mshv_partition *partition;
+	u64 pt_id = -1;
 	long ret;
 
 	ret = mshv_ioctl_process_pt_flags(user_arg, &creation_flags,
@@ -2008,22 +2058,29 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 	ret = hv_call_create_partition(creation_flags,
 				       creation_properties,
 				       isolation_properties,
-				       &partition->pt_id);
+				       &pt_id);
 	if (ret)
 		goto cleanup_irq_srcu;
 
+	partition->pt_id = pt_id;
+
 	ret = add_partition(partition);
 	if (ret)
 		goto delete_partition;
 
 	ret = mshv_init_async_handler(partition);
-	if (!ret) {
-		ret = FD_ADD(O_CLOEXEC, anon_inode_getfile("mshv_partition",
-							   &mshv_partition_fops,
-							   partition, O_RDWR));
-		if (ret >= 0)
-			return ret;
-	}
+	if (ret)
+		goto remove_partition;
+
+	ret = FD_ADD(O_CLOEXEC, anon_inode_getfile("mshv_partition",
+						   &mshv_partition_fops,
+						   partition, O_RDWR));
+	if (ret < 0)
+		goto remove_partition;
+
+	goto out;
+
+remove_partition:
 	remove_partition(partition);
 delete_partition:
 	hv_call_delete_partition(partition->pt_id);
@@ -2031,7 +2088,8 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 	cleanup_srcu_struct(&partition->pt_irq_srcu);
 free_partition:
 	kfree(partition);
-
+out:
+	trace_mshv_create_partition(pt_id, ret);
 	return ret;
 }
 
diff --git a/drivers/hv/mshv_trace.c b/drivers/hv/mshv_trace.c
new file mode 100644
index 000000000000..0936b2f95edd
--- /dev/null
+++ b/drivers/hv/mshv_trace.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026, Microsoft Corporation.
+ *
+ * Tracepoint definitions for mshv driver.
+ */
+
+#define CREATE_TRACE_POINTS
+#include "mshv_trace.h"
diff --git a/drivers/hv/mshv_trace.h b/drivers/hv/mshv_trace.h
new file mode 100644
index 000000000000..ba3b3f575983
--- /dev/null
+++ b/drivers/hv/mshv_trace.h
@@ -0,0 +1,515 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, Microsoft Corporation.
+ *
+ * Tracepoint declarations for mshv driver.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mshv
+
+#if !defined(__MSHV_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _MSHV_TRACE_H_
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../drivers/hv
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE mshv_trace
+
+TRACE_EVENT(mshv_create_partition,
+	    TP_PROTO(u64 partition_id, int vm_fd),
+	    TP_ARGS(partition_id, vm_fd),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(int, vm_fd)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vm_fd = vm_fd;
+	    ),
+	    TP_printk("partition_id=%llu vm_fd=%d",
+		    __entry->partition_id,
+		    __entry->vm_fd
+	    )
+);
+
+TRACE_EVENT(mshv_hvcall_create_partition,
+	    TP_PROTO(u64 flags, s64 partition_id),
+	    TP_ARGS(flags, partition_id),
+	    TP_STRUCT__entry(
+		    __field(u64, flags)
+		    __field(s64, partition_id)
+	    ),
+	    TP_fast_assign(
+		    __entry->flags = flags;
+		    __entry->partition_id = partition_id;
+	    ),
+	    TP_printk("flags=%#llx partition_id=%lld",
+		    __entry->flags,
+		    __entry->partition_id
+	    )
+);
+
+TRACE_EVENT(mshv_hvcall_initialize_partition,
+	    TP_PROTO(u64 partition_id, u64 status),
+	    TP_ARGS(partition_id, status),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u64, status)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->status = status;
+	    ),
+	    TP_printk("partition_id=%llu status=%#llx",
+		    __entry->partition_id,
+		    __entry->status
+	    )
+);
+
+TRACE_EVENT(mshv_partition_release,
+	    TP_PROTO(u64 partition_id),
+	    TP_ARGS(partition_id),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+	    ),
+	    TP_printk("partition_id=%llu",
+		    __entry->partition_id
+	    )
+);
+
+TRACE_EVENT(mshv_destroy_partition,
+	    TP_PROTO(u64 partition_id),
+	    TP_ARGS(partition_id),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+	    ),
+	    TP_printk("partition_id=%llu",
+		    __entry->partition_id
+	    )
+);
+
+TRACE_EVENT(mshv_hvcall_finalize_partition,
+	    TP_PROTO(u64 partition_id, u64 status),
+	    TP_ARGS(partition_id, status),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u64, status)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->status = status;
+	    ),
+	    TP_printk("partition_id=%llu status=%#llx ",
+		    __entry->partition_id,
+		    __entry->status
+	    )
+);
+
+TRACE_EVENT(mshv_hvcall_withdraw_memory,
+	    TP_PROTO(u64 partition_id, u64 withdrawn, u64 status),
+	    TP_ARGS(partition_id, withdrawn, status),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u64, withdrawn)
+		    __field(u64, status)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->withdrawn = withdrawn;
+		    __entry->status = status;
+	    ),
+	    TP_printk("partition_id=%llu withdrawn=%llu status=%#llx",
+		    __entry->partition_id,
+		    __entry->withdrawn,
+		    __entry->status
+	    )
+);
+
+TRACE_EVENT(mshv_hvcall_delete_partition,
+	    TP_PROTO(u64 partition_id, u64 status),
+	    TP_ARGS(partition_id, status),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u64, status)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->status = status;
+	    ),
+	    TP_printk("partition_id=%llu status=%#llx",
+		    __entry->partition_id,
+		    __entry->status
+	    )
+);
+
+TRACE_EVENT(mshv_create_vp,
+	    TP_PROTO(u64 partition_id, u32 vp_index, long vp_fd),
+	    TP_ARGS(partition_id, vp_index, vp_fd),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+		    __field(long, vp_fd)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+		    __entry->vp_fd = vp_fd;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u vp_fd=%ld",
+		    __entry->partition_id,
+		    __entry->vp_index,
+		    __entry->vp_fd
+	    )
+);
+
+TRACE_EVENT(mshv_hvcall_map_vp_state_page,
+	    TP_PROTO(u64 partition_id, u32 vp_index, u32 page_type, u64 status),
+	    TP_ARGS(partition_id, vp_index, page_type, status),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+		    __field(u32, page_type)
+		    __field(u64, status)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+		    __entry->page_type = page_type;
+		    __entry->status = status;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u page_type=%u status=%#llx",
+		    __entry->partition_id,
+		    __entry->vp_index,
+		    __entry->page_type,
+		    __entry->status
+	    )
+);
+
+TRACE_EVENT(mshv_drain_vp_signals,
+	    TP_PROTO(u64 partition_id, u32 vp_index),
+	    TP_ARGS(partition_id, vp_index),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u",
+		    __entry->partition_id,
+		    __entry->vp_index
+	    )
+);
+
+TRACE_EVENT(mshv_disable_vp_dispatch,
+	    TP_PROTO(u64 partition_id, u32 vp_index, int ret),
+	    TP_ARGS(partition_id, vp_index, ret),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+		    __field(int, ret)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+		    __entry->ret = ret;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u ret=%d",
+		    __entry->partition_id,
+		    __entry->vp_index,
+		    __entry->ret
+	    )
+);
+
+TRACE_EVENT(mshv_vp_release,
+	    TP_PROTO(u64 partition_id, u32 vp_index),
+	    TP_ARGS(partition_id, vp_index),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u",
+		    __entry->partition_id,
+		    __entry->vp_index
+	    )
+);
+
+TRACE_EVENT(mshv_run_vp_entry,
+	    TP_PROTO(u64 partition_id, u32 vp_index),
+	    TP_ARGS(partition_id, vp_index),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u",
+		    __entry->partition_id,
+		    __entry->vp_index
+	    )
+);
+
+TRACE_EVENT(mshv_run_vp_exit,
+	    TP_PROTO(u64 partition_id, u32 vp_index, u64 hv_message_type, long ret),
+	    TP_ARGS(partition_id, vp_index, hv_message_type, ret),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+		    __field(u64, hv_message_type)
+		    __field(long, ret)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+		    __entry->hv_message_type = hv_message_type;
+		    __entry->ret = ret;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u hv_message_type=%#llx ret=%ld",
+		    __entry->partition_id,
+		    __entry->vp_index,
+		    __entry->hv_message_type,
+		    __entry->ret
+	    )
+);
+
+TRACE_EVENT(mshv_vp_clear_explicit_suspend,
+	    TP_PROTO(u64 partition_id, u32 vp_index, int ret),
+	    TP_ARGS(partition_id, vp_index, ret),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+		    __field(int, ret)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+		    __entry->ret = ret;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u ret=%d",
+		    __entry->partition_id,
+		    __entry->vp_index,
+		    __entry->ret
+	    )
+);
+
+TRACE_EVENT(mshv_xfer_to_guest_mode_work,
+	    TP_PROTO(u64 partition_id, u32 vp_index, unsigned long thread_info_flag, long ret),
+	    TP_ARGS(partition_id, vp_index, thread_info_flag, ret),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+		    __field(unsigned long, thread_info_flag)
+		    __field(long, ret)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+		    __entry->thread_info_flag = thread_info_flag;
+		    __entry->ret = ret;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u thread_info_flag=%#lx ret=%ld",
+		    __entry->partition_id,
+		    __entry->vp_index,
+		    __entry->thread_info_flag,
+		    __entry->ret
+	    )
+);
+
+TRACE_EVENT(mshv_hvcall_dispatch_vp,
+	    TP_PROTO(u64 partition_id, u32 vp_index, u32 flags,
+		     u32 dispatch_state, u32 dispatch_event, u64 irq_vectors, u64 status),
+	    TP_ARGS(partition_id, vp_index, flags, dispatch_state, dispatch_event, irq_vectors,
+		    status),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+		    __field(u32, flags)
+		    __field(u32, dispatch_state)
+		    __field(u32, dispatch_event)
+		    __field(u64, irq_vectors)
+		    __field(u64, status)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+		    __entry->flags = flags;
+		    __entry->dispatch_state = dispatch_state;
+		    __entry->dispatch_event = dispatch_event;
+		    __entry->irq_vectors = irq_vectors;
+		    __entry->status = status;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u flags=%#x dispatch_state=%#x dispatch_event=%#x irq_vectors=%#016llx status=%#llx",
+		    __entry->partition_id,
+		    __entry->vp_index,
+		    __entry->flags,
+		    __entry->dispatch_state,
+		    __entry->dispatch_event,
+		    __entry->irq_vectors,
+		    __entry->status
+	     )
+);
+
+TRACE_EVENT(mshv_update_routing_table,
+	    TP_PROTO(u64 partition_id, void *old, void *new, u32 numents),
+	    TP_ARGS(partition_id, old, new, numents),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(struct mshv_girq_routing_table *, old)
+		    __field(struct mshv_girq_routing_table *, new)
+		    __field(u32, numents)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->old = old;
+		    __entry->new = new;
+		    __entry->numents = numents;
+	    ),
+	    TP_printk("partition_id=%llu old=%p new=%p numents=%u",
+		    __entry->partition_id,
+		    __entry->old,
+		    __entry->new,
+		    __entry->numents
+	    )
+);
+
+TRACE_EVENT(mshv_map_user_memory,
+	    TP_PROTO(u64 partition_id, u64 start_uaddr, u64 start_gfn, u64 nr_pages, u32 map_flags,
+		     long ret),
+	    TP_ARGS(partition_id, start_uaddr, start_gfn, nr_pages, map_flags, ret),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u64, start_uaddr)
+		    __field(u64, start_gfn)
+		    __field(u64, nr_pages)
+		    __field(u32, map_flags)
+		    __field(long, ret)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->start_uaddr = start_uaddr;
+		    __entry->start_gfn = start_gfn;
+		    __entry->nr_pages = nr_pages;
+		    __entry->map_flags = map_flags;
+		    __entry->ret = ret;
+	    ),
+	    TP_printk("partition_id=%llu start_uaddr=%#llx start_gfn=%#llx nr_pages=%llu map_flags=%#x ret=%ld",
+		    __entry->partition_id,
+		    __entry->start_uaddr,
+		    __entry->start_gfn,
+		    __entry->nr_pages,
+		    __entry->map_flags,
+		    __entry->ret
+	     )
+);
+
+TRACE_EVENT(mshv_assign_ioeventfd,
+	    TP_PROTO(u64 partition_id, u64 addr, u64 length, u64 datamatch, bool wildcard,
+		     void *eventfd, int ret),
+	    TP_ARGS(partition_id, addr, length, datamatch, wildcard, eventfd, ret),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u64, addr)
+		    __field(u64, length)
+		    __field(u64, datamatch)
+		    __field(bool, wildcard)
+		    __field(struct eventfd_ctx *, eventfd)
+		    __field(int, ret)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->addr = addr;
+		    __entry->length = length;
+		    __entry->datamatch = datamatch;
+		    __entry->wildcard = wildcard;
+		    __entry->eventfd = eventfd;
+		    __entry->ret = ret;
+	    ),
+	    TP_printk("partition_id=%llu addr=%#016llx length=%#llx datamatch=%#llx wildcard=%d eventfd=%p ret=%d",
+		    __entry->partition_id,
+		    __entry->addr,
+		    __entry->length,
+		    __entry->datamatch,
+		    __entry->wildcard,
+		    __entry->eventfd,
+		    __entry->ret
+	     )
+);
+
+TRACE_EVENT(mshv_deassign_ioeventfd,
+	    TP_PROTO(u64 partition_id, u64 addr, u64 length, u64 datamatch, bool wildcard,
+		     void *eventfd),
+	    TP_ARGS(partition_id, addr, length, datamatch, wildcard, eventfd),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u64, addr)
+		    __field(u64, length)
+		    __field(u64, datamatch)
+		    __field(bool, wildcard)
+		    __field(struct eventfd_ctx *, eventfd)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->addr = addr;
+		    __entry->length = length;
+		    __entry->datamatch = datamatch;
+		    __entry->wildcard = wildcard;
+		    __entry->eventfd = eventfd;
+	    ),
+	    TP_printk("partition_id=%llu addr=%#016llx length=%#llx datamatch=%#llx wildcard=%d eventfd=%p",
+		    __entry->partition_id,
+		    __entry->addr,
+		    __entry->length,
+		    __entry->datamatch,
+		    __entry->wildcard,
+		    __entry->eventfd
+	     )
+);
+
+TRACE_EVENT(mshv_vp_wait_for_hv_kick,
+	    TP_PROTO(u64 partition_id, u32 vp_index, bool kicked_by_hv, bool blocked,
+		     bool irq_pending),
+	    TP_ARGS(partition_id, vp_index, kicked_by_hv, blocked, irq_pending),
+	    TP_STRUCT__entry(
+		    __field(u64, partition_id)
+		    __field(u32, vp_index)
+		    __field(bool, kicked_by_hv)
+		    __field(bool, blocked)
+		    __field(bool, irq_pending)
+	    ),
+	    TP_fast_assign(
+		    __entry->partition_id = partition_id;
+		    __entry->vp_index = vp_index;
+		    __entry->kicked_by_hv = kicked_by_hv;
+		    __entry->blocked = blocked;
+		    __entry->irq_pending = irq_pending;
+	    ),
+	    TP_printk("partition_id=%llu vp_index=%u kicked_by_hv=%d blocked=%d irq_pending=%d",
+		    __entry->partition_id,
+		    __entry->vp_index,
+		    __entry->kicked_by_hv,
+		    __entry->blocked,
+		    __entry->irq_pending
+	    )
+);
+
+#endif /* _MSHV_TRACE_H_ */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>



