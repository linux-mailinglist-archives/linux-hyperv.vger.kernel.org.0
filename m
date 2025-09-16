Return-Path: <linux-hyperv+bounces-6901-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E951B7E50B
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD1F5831C1
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 23:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BAB2FC03F;
	Tue, 16 Sep 2025 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q7pNdN2W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B883E2F069F;
	Tue, 16 Sep 2025 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066270; cv=none; b=DIUENviUjVvVRVJ1uYtgXQKPKR2o9W4bcpIX08iLRCkWyahStrhe7cl5Fmzm1lRQOOsVN4mRIMJVFXr2YE4n1VIGhjbompDpBfq+1Cju3QroEV+00l8k0AgvrxuBWb54vZiNU8m5xGTULdUgoiwBLKHI1U9f3gBbakWKt1DGyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066270; c=relaxed/simple;
	bh=JKG2hrISRHt0TewSEFAEtrgOmkR+vtp8APLClCnXgmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gxjoYOkJspkqwz0ZCQ2cUw+qtxwA6f0+RSY2ra/BIIx61gpNn5/8CwBbB8g3A0VUJX5muqOc/f9v27b1q2BTBD8CUFWBh05P69iL0UA/u3ajYXav9jijEKOxOsY4CEblIFVgf+BJ6XOpX6Gf1E5vzGDvd9Qp/wMxr068zlXWvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q7pNdN2W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 5261A2018E4F; Tue, 16 Sep 2025 16:44:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5261A2018E4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758066268;
	bh=YCh3wgVuB2vh0c+UXuVPwE26nnFHIhu86EFs4zuEOig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7pNdN2Wr1xiyqcYuI+MMWHFT0TcVQV670LwqRJcmU4N5juRf40xWLB/6LwK5Po1b
	 Xtp8QjcuRvLTZPqdbE38hpYKUUOEvjhqoK1yZZlzFf1OWpAOa0kOwxKWxSniRVtcrv
	 uJxG5BuOcCawDSmQAqSVksIBYB7a2aAVhu6YYLRM=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com,
	anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v3 3/5] mshv: Get the vmm capabilities offered by the hypervisor
Date: Tue, 16 Sep 2025 16:44:20 -0700
Message-Id: <1758066262-15477-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>

Some hypervisor APIs are gated by feature bits in the
"vmm capabilities" partition property. Store the capabilities on
mshv_root module init, using HVCALL_GET_PARTITION_PROPERTY_EX.

This is not supported on all hypervisors. In that case, just set the
capabilities to 0 and proceed as normal.

Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/mshv_root.h      |  1 +
 drivers/hv/mshv_root_main.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 4aeb03bea6b6..0cb1e2589fe1 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -178,6 +178,7 @@ struct mshv_root {
 	struct hv_synic_pages __percpu *synic_pages;
 	spinlock_t pt_ht_lock;
 	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
+	struct hv_partition_property_vmm_capabilities vmm_caps;
 };
 
 /*
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 24df47726363..f7738cefbdf3 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2201,6 +2201,26 @@ static int __init mshv_root_partition_init(struct device *dev)
 	return err;
 }
 
+static void mshv_init_vmm_caps(struct device *dev)
+{
+	int ret;
+
+	memset(&mshv_root.vmm_caps, 0, sizeof(mshv_root.vmm_caps));
+	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
+						HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
+						0, &mshv_root.vmm_caps,
+						sizeof(mshv_root.vmm_caps));
+
+	/*
+	 * HVCALL_GET_PARTITION_PROPERTY_EX or HV_PARTITION_PROPERTY_VMM_CAPABILITIES
+	 * may not be supported. Leave them as 0 in that case.
+	 */
+	if (ret)
+		dev_warn(dev, "Unable to get VMM capabilities\n");
+
+	dev_dbg(dev, "vmm_caps=0x%llx\n", mshv_root.vmm_caps.as_uint64[0]);
+}
+
 static int __init mshv_parent_partition_init(void)
 {
 	int ret;
@@ -2253,6 +2273,8 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto remove_cpu_state;
 
+	mshv_init_vmm_caps(dev);
+
 	ret = mshv_irqfd_wq_init();
 	if (ret)
 		goto exit_partition;
-- 
2.34.1


