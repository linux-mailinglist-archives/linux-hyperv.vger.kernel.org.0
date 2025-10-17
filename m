Return-Path: <linux-hyperv+bounces-7254-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2EBEB584
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 21:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA8B1AE4239
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A5C332EA1;
	Fri, 17 Oct 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KY5H7t8H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B320833506F;
	Fri, 17 Oct 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727500; cv=none; b=CcRC72a+9aqGqQYsj4LX4KT7kZEAlfL4rxXBcS87j6u4XFQZCVdS6s+aLW5gfQuWK9UMU4mNanhiEo9ZOuhkuVXNOn749Mp2MgJVdDk95IUb8orwyXBWiR30PaZ6xvOx0losmd6bzz/+HMBsxQRZBPbG1fPbHYBiYO8l6f5+2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727500; c=relaxed/simple;
	bh=4ug6qqoqVRA1LBi/xSaf5h1E1/MeVjCP/DrgemLJmp0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=l4Cq1j9pRAql5n19NeIijx67w79GEjh6F95z8SrRJRE1Qs6gmH9FXTAmPtvOgplvo4I5RjZxT5VIO8hTuyyIM7lehuRlWCZmYmS23kA18Rnk4WHg80hzCZ8Kud9R7+k4mXHoFZjo0v7DcKzqrkVa64w52oiMm7x7tFvMdD6jimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KY5H7t8H; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 3DB2E2017247; Fri, 17 Oct 2025 11:58:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DB2E2017247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760727498;
	bh=5eVlAgQPegevoQZ7UoS18YxnCMHqHm6zo/5HXQP1WjQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KY5H7t8HygH5t9EqNvNdF/UlSSpJOglb3P745gIdLHeybrUE0A71eOtRAnfskCzGh
	 nHz77p8/VzlkF7/w/ZWVtBDkWLWYnhqkWybnpY2cNyOmul66HHyTYuRhsklEtjDeJf
	 PR9TH70fqVQBUumeLWEZDo+dCY1NIbN8YUYkZeS0=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	arnd@arndb.de,
	mrathor@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Date: Fri, 17 Oct 2025 11:58:17 -0700
Message-Id: <1760727497-21158-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

When the MSHV_ROOT_HVCALL ioctl is executing a hypercall, and gets
HV_STATUS_INSUFFICIENT_MEMORY, it deposits memory and then returns
-EAGAIN to userspace. The expectation is that the VMM will retry.

However, some VMM code in the wild doesn't do this and simply fails.
Rather than force the VMM to retry, change the ioctl to deposit
memory on demand and immediately retry the hypercall as is done with
all the other hypercall helper functions.

In addition to making the ioctl easier to use, removing the need for
multiple syscalls improves performance.

There is a complication: unlike the other hypercall helper functions,
in MSHV_ROOT_HVCALL the input is opaque to the kernel. This is
problematic for rep hypercalls, because the next part of the input
list can't be copied on each loop after depositing pages (this was
the original reason for returning -EAGAIN in this case).

Introduce hv_do_rep_hypercall_ex(), which adds a 'rep_start'
parameter. This solves the issue, allowing the deposit loop in
MSHV_ROOT_HVCALL to restart a rep hypercall after depositing pages
partway through.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---

Changes in v2:
- Improve commit message [Michael]
- Fix up some incorrect/incomplete comments [Michael]

---
 drivers/hv/mshv_root_main.c    | 58 ++++++++++++++++++----------------
 include/asm-generic/mshyperv.h | 17 ++++++++--
 2 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 9ae67c6e9f60..64e1bdf3b57c 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -159,6 +159,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	unsigned int pages_order;
 	void *input_pg = NULL;
 	void *output_pg = NULL;
+	u16 reps_completed;
 
 	if (copy_from_user(&args, user_args, sizeof(args)))
 		return -EFAULT;
@@ -210,41 +211,42 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	 */
 	*(u64 *)input_pg = partition->pt_id;
 
-	if (args.reps)
-		status = hv_do_rep_hypercall(args.code, args.reps, 0,
-					     input_pg, output_pg);
-	else
-		status = hv_do_hypercall(args.code, input_pg, output_pg);
-
-	if (hv_result(status) == HV_STATUS_CALL_PENDING) {
-		if (is_async) {
-			mshv_async_hvcall_handler(partition, &status);
-		} else { /* Paranoia check. This shouldn't happen! */
-			ret = -EBADFD;
-			goto free_pages_out;
+	reps_completed = 0;
+	do {
+		if (args.reps) {
+			status = hv_do_rep_hypercall_ex(args.code, args.reps,
+							0, reps_completed,
+							input_pg, output_pg);
+			reps_completed = hv_repcomp(status);
+		} else {
+			status = hv_do_hypercall(args.code, input_pg, output_pg);
 		}
-	}
 
-	if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
-		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id, 1);
-		if (!ret)
-			ret = -EAGAIN;
-	} else if (!hv_result_success(status)) {
-		ret = hv_result_to_errno(status);
-	}
+		if (hv_result(status) == HV_STATUS_CALL_PENDING) {
+			if (is_async) {
+				mshv_async_hvcall_handler(partition, &status);
+			} else { /* Paranoia check. This shouldn't happen! */
+				ret = -EBADFD;
+				goto free_pages_out;
+			}
+		}
+
+		if (hv_result_success(status))
+			break;
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
+			ret = hv_result_to_errno(status);
+		else
+			ret = hv_call_deposit_pages(NUMA_NO_NODE,
+						    partition->pt_id, 1);
+	} while (!ret);
 
-	/*
-	 * Always return the status and output data regardless of result.
-	 * The VMM may need it to determine how to proceed. E.g. the status may
-	 * contain the number of reps completed if a rep hypercall partially
-	 * succeeded.
-	 */
 	args.status = hv_result(status);
-	args.reps = args.reps ? hv_repcomp(status) : 0;
+	args.reps = reps_completed;
 	if (copy_to_user(user_args, &args, sizeof(args)))
 		ret = -EFAULT;
 
-	if (output_pg &&
+	if (!ret && output_pg &&
 	    copy_to_user((void __user *)args.out_ptr, output_pg, args.out_sz))
 		ret = -EFAULT;
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index ebf458dbcf84..ecedab554c80 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -126,10 +126,12 @@ static inline unsigned int hv_repcomp(u64 status)
 
 /*
  * Rep hypercalls. Callers of this functions are supposed to ensure that
- * rep_count and varhead_size comply with Hyper-V hypercall definition.
+ * rep_count, varhead_size, and rep_start comply with Hyper-V hypercall
+ * definition.
  */
-static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
-				      void *input, void *output)
+static inline u64 hv_do_rep_hypercall_ex(u16 code, u16 rep_count,
+					 u16 varhead_size, u16 rep_start,
+					 void *input, void *output)
 {
 	u64 control = code;
 	u64 status;
@@ -137,6 +139,7 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 
 	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
 	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
+	control |= (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
 
 	do {
 		status = hv_do_hypercall(control, input, output);
@@ -154,6 +157,14 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 	return status;
 }
 
+/* For the typical case where rep_start is 0 */
+static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
+				      void *input, void *output)
+{
+	return hv_do_rep_hypercall_ex(code, rep_count, varhead_size, 0,
+				      input, output);
+}
+
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
 static inline u64 hv_generate_guest_id(u64 kernel_version)
 {
-- 
2.34.1


