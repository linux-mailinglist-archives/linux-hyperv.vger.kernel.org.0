Return-Path: <linux-hyperv+bounces-6819-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD4CB52493
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 01:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F4E58238C
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Sep 2025 23:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E45312802;
	Wed, 10 Sep 2025 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AuGqc7Tw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D179E3064BA;
	Wed, 10 Sep 2025 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546095; cv=none; b=VeAaQUAYDuntwl3MauDk0zmiQXF31xwuuZ4GrFRTSKEOT0xjaO5Mm1o6KmQA1/xVloR1Avnz/Jqas7CetwCYGupjtKltWl1qBbQre8eHvTMv3KfYi6w0//ouXYffUFUJiTMwpxHtpfv7xSnKZ99dTfwdkHVumsLif02/Npw7uO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546095; c=relaxed/simple;
	bh=JKG2hrISRHt0TewSEFAEtrgOmkR+vtp8APLClCnXgmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bsEPqQofEUcN9kxmBOITMthY5R1KvHZzR2RtI3zkkcCT7eU4WKNQiSBMiZyBE0JSNoevNvN+dTJ6xsq3pOEZOPyQ++85dAZ9qg82cJa27gKy8lbE7fNKFe4H8MuU5PZQlsKof34xAKCwG/oigf6V7XhROlmsOslEqUmfbgAsTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AuGqc7Tw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 9F47A2018E71; Wed, 10 Sep 2025 16:14:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F47A2018E71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757546093;
	bh=YCh3wgVuB2vh0c+UXuVPwE26nnFHIhu86EFs4zuEOig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AuGqc7TwHV3NW9CxbpgutRESHvI6kN3x1xW65SOx0A/hn5jPrkpwmzv3OamnTOdoo
	 wA6GgAX/+hfX1RYiK0SmvYYP06sMZ0wdFXCQz6VNbHXU9C+af/Ijw94la0kaYVsuYX
	 FrIAA2gsG+77I0MHIz4wlspu+pgnJq27qJnHYECA=
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
Subject: [PATCH v2 3/5] mshv: Get the vmm capabilities offered by the hypervisor
Date: Wed, 10 Sep 2025 16:14:47 -0700
Message-Id: <1757546089-2002-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com>
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


