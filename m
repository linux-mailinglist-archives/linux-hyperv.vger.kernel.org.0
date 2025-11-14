Return-Path: <linux-hyperv+bounces-7584-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F0C5C79A
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 11:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 387504E9173
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936B3090E2;
	Fri, 14 Nov 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="qz0jwtVr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223DC30AD10;
	Fri, 14 Nov 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114357; cv=pass; b=EzEf08JFKrVbz+6TSGN9CKEDS6Yu8bmxFRb0IeEXOn5tKu9ePt0YKR4Y6IpzVIGt+mNJcNDHgyvWlAg7ITSeuKUMx75KLMKrkrYgMWQrhcX5gcND79uRr64kZxONOwSSJYGIxPoLQRadPCs4VfsnY1Vxxt+lhIQgSxHrpWjkqfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114357; c=relaxed/simple;
	bh=WSs0rxI9GVn0hN7gewuYxuXXdtoCsE8OqBvyO/fP6C4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rndFFSdFWQOXWefkAqDBRFGtGkqM3khj4lzFco4G5m91Cg+Iqg2kREsVlHxb7mHfz47lby1foqurE+XWj8D2GO575Ms0YHIgBBTpKmvpVwh86fUu6y/A6IECdVcQ0BYlhF2b4oxjXWs+9S5url2Iwd7x7qaQ2pwlU4/0bEQZZKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=qz0jwtVr; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1763114346; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aQkPY3PIGam7yrq0vJ4HSOndjJBA8+glmWOrVKflI93DlHQ37UwSu/cFAVwuZr5nMNnSPiJ5yqPIOFRzkxpe8TllyW17wESu0CX03UaFJ+sYINi5GhcP4tlxweT9xtJUnd9XxyyFwmhTBPF8PQzISbeJbzH1Jcog1W7Qv4ehE+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763114346; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AzoPLY9CrgY8G4tygYxOXwpC9YnA+G/QnUNKnHdDU6Q=; 
	b=BY8tc7auSR/JmBZDRQkL566svVJbWGpFvLqIOGcMKNeQ49bA4RhVHkx1wf1/7xs44zUl+2TCdL7KrbH6ogc/BckLR/pT+xFmIDw4QR7WpHdQJ5RQyHgtkHIvODRgCdurNh38qQQQ4/ms6smCmnnIkjbzW4PMUFLHWurysxpBCYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763114346;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=AzoPLY9CrgY8G4tygYxOXwpC9YnA+G/QnUNKnHdDU6Q=;
	b=qz0jwtVr8lgRVW8FNU8Ttx+y5kkBBN9+LKElsmpSaD/X4mZovDKy33ormcVzdvq+
	V/mf/ojf7OKIaaP/eiZN1zZOoHvq/HkA/n5qdmWygRqowZsejSy3/aINc40uBhwG1Dl
	Ryvhvrby5CVadHUYtC0DgO9Fno+OmUIxIcN8Zacg=
Received: by mx.zohomail.com with SMTPS id 1763114344426113.05096660782806;
	Fri, 14 Nov 2025 01:59:04 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: anirudh@anirudhrb.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
Date: Fri, 14 Nov 2025 09:58:52 +0000
Message-Id: <20251114095853.3482596-1-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
execute a passthrough hypercall targeting the root/parent partition
i.e. HV_PARTITION_ID_SELF.

This will be useful for the VMM to query things like supported
synthetic processor features, supported VMM capabiliites etc.

While at it, add HVCALL_GET_PARTITION_PROPERTY_EX to the allowed list of
passthrough hypercalls.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_root_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 20eda00a1b5a..98f56322cd19 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -122,6 +122,7 @@ static struct miscdevice mshv_dev = {
  */
 static u16 mshv_passthru_hvcalls[] = {
 	HVCALL_GET_PARTITION_PROPERTY,
+	HVCALL_GET_PARTITION_PROPERTY_EX,
 	HVCALL_SET_PARTITION_PROPERTY,
 	HVCALL_INSTALL_INTERCEPT,
 	HVCALL_GET_VP_REGISTERS,
@@ -159,6 +160,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	unsigned int pages_order;
 	void *input_pg = NULL;
 	void *output_pg = NULL;
+	u64 pt_id = partition ? partition->pt_id : HV_PARTITION_ID_SELF;
 
 	if (copy_from_user(&args, user_args, sizeof(args)))
 		return -EFAULT;
@@ -180,7 +182,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	is_async = mshv_hvcall_is_async(args.code);
 	if (is_async) {
 		/* async hypercalls can only be called from partition fd */
-		if (!partition_locked)
+		if (!partition || !partition_locked)
 			return -EINVAL;
 		ret = mshv_init_async_handler(partition);
 		if (ret)
@@ -208,7 +210,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	 * NOTE: This only works because all the allowed hypercalls' input
 	 * structs begin with a u64 partition_id field.
 	 */
-	*(u64 *)input_pg = partition->pt_id;
+	*(u64 *)input_pg = pt_id;
 
 	if (args.reps)
 		status = hv_do_rep_hypercall(args.code, args.reps, 0,
@@ -226,7 +228,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	}
 
 	if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
-		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id, 1);
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, pt_id, 1);
 		if (!ret)
 			ret = -EAGAIN;
 	} else if (!hv_result_success(status)) {
@@ -2048,6 +2050,9 @@ static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl,
 	case MSHV_CREATE_PARTITION:
 		return mshv_ioctl_create_partition((void __user *)arg,
 						misc->this_device);
+	case MSHV_ROOT_HVCALL:
+		return mshv_ioctl_passthru_hvcall(NULL, false,
+					(void __user *)arg);
 	}
 
 	return -ENOTTY;
-- 
2.34.1


