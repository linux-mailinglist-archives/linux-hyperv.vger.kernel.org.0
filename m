Return-Path: <linux-hyperv+bounces-6661-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5902B3AFF6
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 02:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDBF7B408D
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 00:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E580A1E3DCD;
	Fri, 29 Aug 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S02XrYNT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1921C2DB2;
	Fri, 29 Aug 2025 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756428237; cv=none; b=IdLTT4WaMBjsivsHUK1xyr+DahgqS419Zc0+5z1IrkCCBqbp1h34R3TmNOUE5WBRSt4pk3LlV53todB0apTNIFoX49NxQGNTx1aKiGHh6eD47xk/w7bUJVtQMZ3ID4vYer/0uVedHoYDUnNdb+nzl/AwNL/Pefxlqlzx3sfpEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756428237; c=relaxed/simple;
	bh=cGLz6masQCHPzXFZiijiETIRFdxtVgkLlgMyR1xHjzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HQWhgv5Gf4npcym4RECRuzMR15HYeaUlunT3CKCwV4ySrquJoVbal2h89QKVFQzzF5HJZztp2gZ4IB1BAqImEmPYZAAhy0GS8tNNZmwYoqMrb9CeTlVEV0Mg4SYWvwUq60mJKaGpBtGVJgoYXNiusdWE1+mh4NgBVoCZNi7xgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S02XrYNT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 31BAA211081A; Thu, 28 Aug 2025 17:43:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 31BAA211081A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756428236;
	bh=VhpuWdBSJ3WZBkJsf9ecfjzZYk1xDVSwNpg0AI8FOoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S02XrYNTunHU09V+hCPffoRxJqcUkAcFqbPG1MziRveGo3g+eyqSJR4hqMI0JfBXc
	 NE8dvXCfGu/noc0ngmmrIg2UlxzlgPTzKBwfydDC2lG55nIlPSHh/C3P5p+nbqx1G9
	 Sr/FvmoMMm+Ov43ybBh9yUzCOdh8L1mjT/m8ioT4=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 4/6] mshv: Get the vmm capabilities offered by the hypervisor
Date: Thu, 28 Aug 2025 17:43:48 -0700
Message-Id: <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>

Some newer hypervisor APIs are gated by feature bits in the so-called
"vmm capabilities" partition property. Store the capabilities on
mshv_root module init, using HVCALL_GET_PARTITION_PROPERTY_EX.

Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root.h      |  1 +
 drivers/hv/mshv_root_main.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

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
index 56ababab57ce..29f61ecc9771 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2327,6 +2327,28 @@ static int __init mshv_root_partition_init(struct device *dev)
 	return err;
 }
 
+static int mshv_init_vmm_caps(struct device *dev)
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
+	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES is not supported in
+	 * older hyperv. Ignore the -EIO error code.
+	 */
+	if (ret && ret != -EIO)
+		return ret;
+
+	dev_dbg(dev, "vmm_caps=0x%llx\n", mshv_root.vmm_caps.as_uint64[0]);
+
+	return 0;
+}
+
 static int __init mshv_parent_partition_init(void)
 {
 	int ret;
@@ -2377,6 +2399,12 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto remove_cpu_state;
 
+	ret = mshv_init_vmm_caps(dev);
+	if (ret) {
+		dev_err(dev, "Failed to get VMM capabilities\n");
+		goto exit_partition;
+	}
+
 	ret = mshv_irqfd_wq_init();
 	if (ret)
 		goto exit_partition;
-- 
2.34.1


