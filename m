Return-Path: <linux-hyperv+bounces-7702-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A547EC7064A
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2148B2F38D
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E58830170C;
	Wed, 19 Nov 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="ZCyv2dDR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender3-of-o52.zoho.com (sender3-of-o52.zoho.com [136.143.184.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273830147A;
	Wed, 19 Nov 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572651; cv=pass; b=f5tl6aM68JO5ta9JRDTxkdsIj8wMGfSqzHGxDD4baCkDJTnECoAtBvtYAS9IqIcDdw0NgABlziDuVXSyvz0AdVVZX1bxsbOm+BiK4LcjJjxG7Cv7f+KcR+Pa+9tVy4FSvEYlDtdl0vYooR6sHoWQ70K/aI7VpF41+9Qx/fdiDdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572651; c=relaxed/simple;
	bh=Qu+2pKTonT+tNuNcwlQSadUEXruudgu0miazKjiT1M8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c2c8hzA0iTvcdkdtsMVlakLlSPEdJ4fCkpRPzmbz2ko4hU1Xx+vNSh1Vb4Mv95VoBB+8pRk1R+mynjifwsN77glcYfdTu7A9Gz0+8WUOdnjA+tujIx0xYjsCjjVTS1galPxOz+fFa3VuyUsjkBhUiruZT6QLBQNItDfyfKOehMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=ZCyv2dDR; arc=pass smtp.client-ip=136.143.184.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1763572641; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WyEgywdDMpGFM5eOCI0qjCisl4jIxVlxFrBEAX24aNKtLlwYZkx+RQLvixTMw/toFol9nE/dPLZ09ocnxHcvcnzDlq1M1PASK3yxGHIUZ75jdsLklI6J4PNEogwJeG0FwLYuXrzmHiRz5XZgzrSGyEUcZn4kQU1LPFK4mNAbjnk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763572641; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CnqwBiOXNHUItkhxV/bgOaHNyWOYT9BVSfpRkQucGYo=; 
	b=PA+dclY4IqU4knpa1TXqZFnc174t0M1g/H4c927WV4LIlKJ64Q57lnUQO2alDYRCXztWSFH8NhrSO0RObBiimPTAjBv616gKyez+XgQTxHlX6Op1CyNJWUKaMZu1JDGb9hU0YbLEMHH2mYIQLknL9lGSTSOoWkGMFwpSQnUA1Nw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763572641;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=CnqwBiOXNHUItkhxV/bgOaHNyWOYT9BVSfpRkQucGYo=;
	b=ZCyv2dDRS7X1uLrOjceRux9UuNv84EUtG/ou83K9vx86NsbL+IuDlVH4o1Drmj5T
	b9x/1bgpCjd3wLanthr6BPjHgkBt71bF7AAri+kdQgVg4UAhTwm7+SS4aOgtv5ZamCO
	+ED4A46G+QHRyh5sKVVYFhaIxOgxgC1cFtv80Yo8=
Received: by mx.zohomail.com with SMTPS id 176357263736197.144016026916;
	Wed, 19 Nov 2025 09:17:17 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: anirudh@anirudhrb.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Drivers: hv: ioctl for self targeted passthrough hvcalls
Date: Wed, 19 Nov 2025 17:17:08 +0000
Message-Id: <20251119171708.819072-1-anirudh@anirudhrb.com>
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

Since hypercalls targeting the host partition could potentially perform
privileged operations, allow only a limited set of hypercalls. To begin
with, allow only:

	HVCALL_GET_PARTITION_PROPERTY
	HVCALL_GET_PARTITION_PROPERTY_EX

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---

v3: restricted the allowed self-targeted passthrough hypercalls to
    smaller, carefully selected list.
v2: rebased on latest hyperv-next

---
 drivers/hv/mshv_root_main.c | 47 ++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 45c7a5fea1cf..acbcd9c151a8 100644
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
@@ -136,6 +137,16 @@ static u16 mshv_passthru_hvcalls[] = {
 	HVCALL_GET_VP_CPUID_VALUES,
 };
 
+/*
+ * Only allow hypercalls that are safe to be called by the VMM with the host
+ * partition as target (i.e. HV_PARTITION_ID_SELF). Carefully audit that a
+ * hypercall cannot be misused by the VMM before adding it to this list.
+ */
+static u16 mshv_self_passthru_hvcalls[] = {
+	HVCALL_GET_PARTITION_PROPERTY,
+	HVCALL_GET_PARTITION_PROPERTY_EX,
+};
+
 static bool mshv_hvcall_is_async(u16 code)
 {
 	switch (code) {
@@ -147,12 +158,30 @@ static bool mshv_hvcall_is_async(u16 code)
 	return false;
 }
 
+static inline bool mshv_passthru_hvcall_allowed(u16 code, u64 pt_id)
+{
+	int i;
+	int n = ARRAY_SIZE(mshv_passthru_hvcalls);
+	u16 *allowed_hvcalls = mshv_passthru_hvcalls;
+
+	if (pt_id == HV_PARTITION_ID_SELF) {
+		n = ARRAY_SIZE(mshv_self_passthru_hvcalls);
+		allowed_hvcalls = mshv_self_passthru_hvcalls;
+	}
+
+	for (i = 0; i < n; ++i)
+		if (allowed_hvcalls[i] == code)
+			return true;
+
+	return false;
+}
+
 static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 				      bool partition_locked,
 				      void __user *user_args)
 {
 	u64 status;
-	int ret = 0, i;
+	int ret = 0;
 	bool is_async;
 	struct mshv_root_hvcall args;
 	struct page *page;
@@ -160,6 +189,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	void *input_pg = NULL;
 	void *output_pg = NULL;
 	u16 reps_completed;
+	u64 pt_id = partition ? partition->pt_id : HV_PARTITION_ID_SELF;
 
 	if (copy_from_user(&args, user_args, sizeof(args)))
 		return -EFAULT;
@@ -171,17 +201,13 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	if (args.out_ptr && (!args.out_sz || args.out_sz > HV_HYP_PAGE_SIZE))
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(mshv_passthru_hvcalls); ++i)
-		if (args.code == mshv_passthru_hvcalls[i])
-			break;
-
-	if (i >= ARRAY_SIZE(mshv_passthru_hvcalls))
+	if (!mshv_passthru_hvcall_allowed(args.code, pt_id))
 		return -EINVAL;
 
 	is_async = mshv_hvcall_is_async(args.code);
 	if (is_async) {
 		/* async hypercalls can only be called from partition fd */
-		if (!partition_locked)
+		if (!partition || !partition_locked)
 			return -EINVAL;
 		ret = mshv_init_async_handler(partition);
 		if (ret)
@@ -209,7 +235,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	 * NOTE: This only works because all the allowed hypercalls' input
 	 * structs begin with a u64 partition_id field.
 	 */
-	*(u64 *)input_pg = partition->pt_id;
+	*(u64 *)input_pg = pt_id;
 
 	reps_completed = 0;
 	do {
@@ -238,7 +264,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 			ret = hv_result_to_errno(status);
 		else
 			ret = hv_call_deposit_pages(NUMA_NO_NODE,
-						    partition->pt_id, 1);
+						    pt_id, 1);
 	} while (!ret);
 
 	args.status = hv_result(status);
@@ -2050,6 +2076,9 @@ static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl,
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


