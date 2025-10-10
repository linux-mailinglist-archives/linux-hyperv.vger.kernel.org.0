Return-Path: <linux-hyperv+bounces-7183-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3C1BCEA5D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 23:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5174C4EA117
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DAE303CBB;
	Fri, 10 Oct 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L/Hki0z0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C8303C87;
	Fri, 10 Oct 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760133356; cv=none; b=NTolcHrrsQcCP8DcZEs89V96UFrd9zvI7JnYY2r0pqO+dywTiWntlkGZ46ZGp/cTiUzRtA5RG7quQ8punqgXSbGnTwyO3hoPmW5jBpoZQ9M74FIocTVX3ivZbtW9ziMB5kke+d3RwQNgCtS422KqjMGp5/9T9tPgA7Er1Dc0uaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760133356; c=relaxed/simple;
	bh=8qXBCsPX0os3fZTIyeifEQ3tY/cGqU8KItsMFrLORWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZSHCkqBIhUwoLo1u0EpBo+gK7/ucKRwVL7Wi3BwYfZAbx2WWb6PxkuAUxXFwbBvPTclHuarCaGmzs8rp1kPbNBsoMezmyck8MIKz9SKJBd6FQcvsuxyBcI2+GeceBZKQO40yjeo80UXuUCxcLqqIokj5IBZJ/oHu5kuJ7wI7Rl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L/Hki0z0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 0D9D6211C26C; Fri, 10 Oct 2025 14:55:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D9D6211C26C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760133355;
	bh=nnUwJWljs6FM3DFsilZMh5du+IY+KgoQsHP4KO1Cbn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/Hki0z08XOw/08KbRb9bmt/yqgLTgXS6gYwiLwG+aP6i+IHYEUXvKskI05+I6Y77
	 QUc7P5hEtMTZYBUdQktO9xh7co28FiZGP/Ix91//s3M7YlAvDd7+fT0m6cA7+cjb/j
	 1djNbp/ZPdJjTWbR+D06x2GFdLY+UsvHf9PZ1mHI=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com,
	anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v5 3/5] mshv: Get the vmm capabilities offered by the hypervisor
Date: Fri, 10 Oct 2025 14:55:49 -0700
Message-Id: <1760133351-6643-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1760133351-6643-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1760133351-6643-1-git-send-email-nunodasneves@linux.microsoft.com>
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
 drivers/hv/mshv_root_main.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

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
index 24df47726363..94cc482c6c26 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2201,6 +2201,22 @@ static int __init mshv_root_partition_init(struct device *dev)
 	return err;
 }
 
+static void mshv_init_vmm_caps(struct device *dev)
+{
+	/*
+	 * This can only fail here if HVCALL_GET_PARTITION_PROPERTY_EX or
+	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES are not supported. In that
+	 * case it's valid to proceed as if all vmm_caps are disabled (zero).
+	 */
+	if (hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
+					      HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
+					      0, &mshv_root.vmm_caps,
+					      sizeof(mshv_root.vmm_caps)))
+		dev_warn(dev, "Unable to get VMM capabilities\n");
+
+	dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
+}
+
 static int __init mshv_parent_partition_init(void)
 {
 	int ret;
@@ -2253,6 +2269,8 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto remove_cpu_state;
 
+	mshv_init_vmm_caps(dev);
+
 	ret = mshv_irqfd_wq_init();
 	if (ret)
 		goto exit_partition;
-- 
2.34.1


