Return-Path: <linux-hyperv+bounces-7230-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9E7BE548D
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 21:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E69C1358CFD
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 19:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F42D5C68;
	Thu, 16 Oct 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c66TZi/4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6FB22068F;
	Thu, 16 Oct 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644439; cv=none; b=eF6k2UHmn6WvBuPgwMjfApZtSR12U0sQ/0gp2k8AByF9NLzF0Smj7vB//wbfT9JpZc7gswAMCak9FEkhkpqYJ9qMVHvf0MMLu3f0BmrDAWYZFqnGEw/uzSIUJexMOqoU6pHXmRsqSJA7nfHSOslUsRzZQhyEYnyz6MIGDW0r5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644439; c=relaxed/simple;
	bh=baHR73HIxTnuxzdhcaeU3Rexag85uxe3e8b1VP8bZ58=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Xvz8IdK/VmUwun2KKf6wfDYtiqhdeD0VVXChoDkFH3e8iFjtcleHwk0P0/BaN1q+24+TtVqXJ49swsHDUDn5dKwXbnP31scmDGe2ZKoU+IPOACQARMbjBCJ6Lovflxud68otrZU86n4GxK2t/Z+HkEYSNT/FM2weKhITWohBMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c66TZi/4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id DA079201602B; Thu, 16 Oct 2025 12:53:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA079201602B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760644437;
	bh=zWft35H89D/+LKFs3704BEc+PRsLYDYPz+l0DFqfdGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=c66TZi/4sYA5lvsY9Qv0EDN8VJcA5ipB1gh6JuVTWOVVocot3hNcwHddS7L7LCQQC
	 SeSgbN0XnQfBVMijWl/0k0Q4jNKq3OJ0tV+gfwuDgfLB3ZG77WS0auG4EuKXC0h/NV
	 nSWyfosA/GD2CHcMJ9CeuIqpdJ+Ukzc3ErrDFoGE=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	arnd@arndb.de,
	mhklinux@outlook.com,
	mrathor@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Date: Thu, 16 Oct 2025 12:53:56 -0700
Message-Id: <1760644436-19937-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

When the MSHV_ROOT_HVCALL ioctl is executing a hypercall, and gets
HV_STATUS_INSUFFICIENT_MEMORY, it deposits memory and then returns
-EAGAIN to userspace.

However, it's much easier and efficient if the driver simply deposits
memory on demand and immediately retries the hypercall as is done with
all the other hypercall helper functions.

But unlike those, in MSHV_ROOT_HVCALL the input is opaque to the
kernel. This is problematic for rep hypercalls, because the next part
of the input list can't be copied on each loop after depositing pages
(this was the original reason for returning -EAGAIN in this case).

Introduce hv_do_rep_hypercall_ex(), which adds a 'rep_start'
parameter. This solves the issue, allowing the deposit loop in
MSHV_ROOT_HVCALL to restart a rep hypercall after depositing pages
partway through.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c    | 52 ++++++++++++++++++++--------------
 include/asm-generic/mshyperv.h | 14 +++++++--
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 9ae67c6e9f60..731ec8cbbd63 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -159,6 +159,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	unsigned int pages_order;
 	void *input_pg = NULL;
 	void *output_pg = NULL;
+	u16 reps_completed;
 
 	if (copy_from_user(&args, user_args, sizeof(args)))
 		return -EFAULT;
@@ -210,28 +211,35 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
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
 
 	/*
 	 * Always return the status and output data regardless of result.
@@ -240,11 +248,11 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	 * succeeded.
 	 */
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
index ebf458dbcf84..31a209f0e18f 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -128,8 +128,9 @@ static inline unsigned int hv_repcomp(u64 status)
  * Rep hypercalls. Callers of this functions are supposed to ensure that
  * rep_count and varhead_size comply with Hyper-V hypercall definition.
  */
-static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
-				      void *input, void *output)
+static inline u64 hv_do_rep_hypercall_ex(u16 code, u16 rep_count,
+					 u16 varhead_size, u16 rep_start,
+					 void *input, void *output)
 {
 	u64 control = code;
 	u64 status;
@@ -137,6 +138,7 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 
 	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
 	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
+	control |= (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
 
 	do {
 		status = hv_do_hypercall(control, input, output);
@@ -154,6 +156,14 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
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


