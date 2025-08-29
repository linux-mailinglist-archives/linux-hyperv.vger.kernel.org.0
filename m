Return-Path: <linux-hyperv+bounces-6672-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0952B3C3B3
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 22:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB403B3971
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B63242D7B;
	Fri, 29 Aug 2025 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MiNy11tt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF0F2566;
	Fri, 29 Aug 2025 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756498676; cv=none; b=D8uemco9DvCTOgnowuGnpRTCgOSr8+zhCHYOL5l1I1Ph77HPRQZ1V0A/eHQC6FEGJTPKP7nbuktm0rPVJ9LhFLUxQlTxntqVp5/Y/3HQe1QdPjse/ol6OohIg8JD6zZMyUjYplJQujxt4ydumh4fQPj5Y+rPItELwH1sF8E523Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756498676; c=relaxed/simple;
	bh=s+ql7if4KLlDtTRh5Ni6oTPtRWgmXlXfuBfY0wGCS/k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FBg4e1U7vYqjdLxud2JtRgM+/oOjZWSlx7+oefHvEHPsLYCTId6UwiOlvmkv7CDZshVlk/fMpcP68AS/OjVVQb8+80HRzcGCTKNKQYHeBnYySOjSHiKgvWzNoOIctTs1iV3zfeDjZDPLvJcv4XwTDtPLELBZGVbHY0tdeIXxCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MiNy11tt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id D9E732116275; Fri, 29 Aug 2025 13:17:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9E732116275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756498673;
	bh=sTxGBh5YMiWKA7aBFHaNwTlo52IFXxOgPVZ+70Rg42o=;
	h=From:To:Cc:Subject:Date:From;
	b=MiNy11ttEBJwUu+27qWwB3uFXJrTfqzcVkCLHPMIpVxnRcPhzrSvXAC53ZDtXS7tA
	 PiRpfgcoHy0pkqaZYFrnn9PJYXlaCCISFbpRFD5VUUMlTencOqDOJzWEqGdWIHitaV
	 hdVSkB8zoaZ65DBX7glVpMTzXjQ1aDc/MmvJrAGU=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH] fixup! mshv: Add support for a new parent partition configuration
Date: Fri, 29 Aug 2025 13:17:52 -0700
Message-Id: <1756498672-17603-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

---
 drivers/hv/hv_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 8836cf9fad40..e109a620c83f 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -257,7 +257,7 @@ static void hv_kmsg_dump_register(void)
 
 static inline bool hv_output_page_exists(void)
 {
-	return hv_root_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
+	return hv_parent_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
 }
 
 void __init hv_get_partition_id(void)
-- 
2.34.1


