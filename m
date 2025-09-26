Return-Path: <linux-hyperv+bounces-6992-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E972CBA499F
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 18:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9F3B90DE
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E31261B7F;
	Fri, 26 Sep 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rKuv+xwQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90261258EE0;
	Fri, 26 Sep 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903806; cv=none; b=n0iDIuEZ1HesfKg6DAgjlyh7D2LXa+tY+5JM28yuuKkkoGCbC7xu+WmIAbhRbcsB1gDZC4WN3z2DNihJ3ThcODtK0R4LF1NeDs6EbC//Srq8LU/meAa9yo27aB3uuuprZnKAzecXD6E/4w34Z7Sxp5coYcEBkMfMamF6SNISQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903806; c=relaxed/simple;
	bh=FsDdKwCMqTABgOU+0KZfVkac48eymIJV4GoA81z0p+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K8Bb8FgxxQViNZfAXA6ZBJ+MTvAL3amOvp6pFOuPjIye7Vi4VOBlZ5I8poVo5qMSPQ1Q2ufEsjHjWk4j3/RzPqnTd4ZDq/2BllsxiziH8QyXo0Cvp/TwQ8/JLtbgnG3Vc/JOY6uy+NMuEN2nSfNFxGNVxKoGkNt4OYyaCDQXvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rKuv+xwQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id CA5C12124F6F; Fri, 26 Sep 2025 09:23:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA5C12124F6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758903798;
	bh=tWfyl8/jJ38C1AnsDNtGxPJggw4ujw1MyZ8mJDXpanU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKuv+xwQSdDDosAcXNYnh0v2B6Nvhl1MiIC8Odl/F+JKzb95pbqDmqSs72K9fAt3+
	 AILQHo1xcfHXxdWKw5aX3enDpqk05M9mtk0J9r5/mhA6sCaDkYbmrRyOXKBpFkggGZ
	 3MZksK+YIJrE8N6qO1YG8vkPZcWbwzN2WnnCxms4=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com,
	anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v4 3/5] mshv: Get the vmm capabilities offered by the hypervisor
Date: Fri, 26 Sep 2025 09:23:13 -0700
Message-Id: <1758903795-18636-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
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
 drivers/hv/mshv_root_main.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

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
index 24df47726363..e199770ecdfa 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2201,6 +2201,21 @@ static int __init mshv_root_partition_init(struct device *dev)
 	return err;
 }
 
+static void mshv_init_vmm_caps(struct device *dev)
+{
+	/*
+	 * HVCALL_GET_PARTITION_PROPERTY_EX or HV_PARTITION_PROPERTY_VMM_CAPABILITIES
+	 * may not be supported. Leave them as 0 in that case.
+	 */
+	if (hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
+					      HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
+					      0, &mshv_root.vmm_caps,
+					      sizeof(mshv_root.vmm_caps)))
+		dev_warn(dev, "Unable to get VMM capabilities\n");
+
+	dev_dbg(dev, "vmm_caps=0x%llx\n", mshv_root.vmm_caps.as_uint64[0]);
+}
+
 static int __init mshv_parent_partition_init(void)
 {
 	int ret;
@@ -2253,6 +2268,8 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto remove_cpu_state;
 
+	mshv_init_vmm_caps(dev);
+
 	ret = mshv_irqfd_wq_init();
 	if (ret)
 		goto exit_partition;
-- 
2.34.1


