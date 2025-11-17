Return-Path: <linux-hyperv+bounces-7620-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A605C63623
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 11:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFBC1348F88
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 09:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF331D379;
	Mon, 17 Nov 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="erqX9u9B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C125F79A;
	Mon, 17 Nov 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373151; cv=pass; b=Fr7l3JPcssqXlfHz7AIvgZARD/eoU3vKul0dqhI42qMuvayEZDmqR8TeIpfpkKqK052fTP5x+c4Msu5tMieaJfJl6Su/F3HNQ220v3p0Kfx9N4KLJ0MSofE3Z/uFvU+FeZNoDG5u1Mcj+AXoaef+jJmLrCRrlXCKXPaW73uCrVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373151; c=relaxed/simple;
	bh=hLj++5oQdcrmg6levfgXYQKy+iSVfXnNReaSf63PmCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qW13SZ7vMhvzYAHN0ZQ79T+cGPxGWF/WQC8mC8Bb8aBRCyZrR+b3GpErri6D5Fz8maW2Ux8pTkJkUjh+6lH5oKeWk1gvZGgEQmfAJ3Bx46NZvCKDtm3dnTkc7gv0K3s8X+w97A/rT5PiXjPV/+ZajwS/mKvA7MI2lGu0nI9CToo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=erqX9u9B; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1763373142; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DkR5CRn3x2MMtTZ3LX+byLfoclnKJr8bkW9l/F38+dyWk8t4zGKx9m+dUt3O6H7Q/5+V9cJCKwGBDgJgfldxzQ8ldipDnvMOyEunp9YB5xLvsV8lMaRKCdy4rHsyWmq/dmrtGTegnR/X9zoJH+fgtrqbr9+yHnCHfsCSkvMUKhA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763373142; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Rqzuy/XSzIM71EfODnX+nlxKJELQk5hH7AQGsX5DJd8=; 
	b=m1Sx6LCu0HudY7u4RFoJ4U6YD7Tt67k+nPSWLt/aRmgWcMrangeovQr2WQPYowczDAgMbxRj8z7So1eTuNhaK+oajg7gAiBaC6AcuGWNlDxBGJvFEj3h2tWEdLXiy/5+ypJw8AQc0XXRAiZNygn5DFXqFoSaWPAlvl53sKscAik=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763373142;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Rqzuy/XSzIM71EfODnX+nlxKJELQk5hH7AQGsX5DJd8=;
	b=erqX9u9B1Ca4uORBnTsJs2CDSinuCtd9TonSgBBfbgHSwnAcCjd1Mx5616OvoavF
	mjm6N/XiAN0q9CuP3rBtk3c9VvvNzgj+NTEtpIFJ2fZIAR9CZLgd4A0/i+wxwoJRQSX
	jF9FltX/DH3baym+4IYsx+zJYU6iaPUiK5NQn3q0=
Received: by mx.zohomail.com with SMTPS id 1763373138896550.4781148900805;
	Mon, 17 Nov 2025 01:52:18 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: anirudh@anirudhrb.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Drivers: hv: ioctl for self targeted passthrough hvcalls
Date: Mon, 17 Nov 2025 09:52:06 +0000
Message-Id: <20251117095207.113502-1-anirudh@anirudhrb.com>
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

v2: rebased on latest hyperv-next

---
 drivers/hv/mshv_root_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 45c7a5fea1cf..671c4d18520a 100644
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
@@ -160,6 +161,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	void *input_pg = NULL;
 	void *output_pg = NULL;
 	u16 reps_completed;
+	u64 pt_id = partition ? partition->pt_id : HV_PARTITION_ID_SELF;
 
 	if (copy_from_user(&args, user_args, sizeof(args)))
 		return -EFAULT;
@@ -181,7 +183,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	is_async = mshv_hvcall_is_async(args.code);
 	if (is_async) {
 		/* async hypercalls can only be called from partition fd */
-		if (!partition_locked)
+		if (!partition || !partition_locked)
 			return -EINVAL;
 		ret = mshv_init_async_handler(partition);
 		if (ret)
@@ -209,7 +211,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	 * NOTE: This only works because all the allowed hypercalls' input
 	 * structs begin with a u64 partition_id field.
 	 */
-	*(u64 *)input_pg = partition->pt_id;
+	*(u64 *)input_pg = pt_id;
 
 	reps_completed = 0;
 	do {
@@ -238,7 +240,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 			ret = hv_result_to_errno(status);
 		else
 			ret = hv_call_deposit_pages(NUMA_NO_NODE,
-						    partition->pt_id, 1);
+						    pt_id, 1);
 	} while (!ret);
 
 	args.status = hv_result(status);
@@ -2050,6 +2052,9 @@ static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl,
 	case MSHV_CREATE_PARTITION:
 		return mshv_ioctl_create_partition((void __user *)arg,
 						misc->this_device);
+	case MSHV_ROOT_HVCALL:
+		return mshv_ioctl_passthru_hvcall(NULL, false,
+					(void __user *)arg);
 	}
 
 	return -ENOTTY;

base-commit: db7df69995ffbe806d60ad46d5fb9d959da9e549
-- 
2.34.1


