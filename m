Return-Path: <linux-hyperv+bounces-27-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4B79E6B9
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Sep 2023 13:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9E128285E
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Sep 2023 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1151E536;
	Wed, 13 Sep 2023 11:29:13 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53F1E530
	for <linux-hyperv@vger.kernel.org>; Wed, 13 Sep 2023 11:29:13 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1AEC173E;
	Wed, 13 Sep 2023 04:29:12 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4E111212BE49;
	Wed, 13 Sep 2023 04:29:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E111212BE49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1694604552;
	bh=X1hXmesGa1C0q7JmU/DTDthFjHfS3J6LpW/sEYzdfT8=;
	h=From:To:Cc:Subject:Date:From;
	b=kNLzHaD2k3wBpj5CyBUU0Yr7i2kb8O+dpC6iwbNqB6L0xb5jmJkJWEzlGb48C65d6
	 2oL/h3Jt7jW5cKXtk9kLv3aofJjUtIMUjdaZ5pTdZlFRsVNryqPgYncD01S1sooz6a
	 8aJPcOgGBJTcZ1/4aJ1pByGgLIpKws/8jxz2ZweQ=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mikelley@microsoft.com
Cc: ssengar@microsoft.com
Subject: [PATCH] x86/hyperv: Restrict get_vtl to only VTL platforms
Date: Wed, 13 Sep 2023 04:28:51 -0700
Message-Id: <1694604531-17128-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

For non VTL platforms vtl is always 0, and there is no need of
get_vtl function. For VTL platforms get_vtl should always succeed
and should return the correct VTL.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 783ed339f341..e589c240565a 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -416,8 +416,8 @@ static u8 __init get_vtl(void)
 	if (hv_result_success(ret)) {
 		ret = output->as64.low & HV_X64_VTL_MASK;
 	} else {
-		pr_err("Failed to get VTL(%lld) and set VTL to zero by default.\n", ret);
-		ret = 0;
+		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
+		BUG();
 	}
 
 	local_irq_restore(flags);
@@ -604,8 +604,10 @@ void __init hyperv_init(void)
 	hv_query_ext_cap(0);
 
 	/* Find the VTL */
-	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp())
+	if (IS_ENABLED(CONFIG_HYPERV_VTL_MODE))
 		ms_hyperv.vtl = get_vtl();
+	else
+		ms_hyperv.vtl = 0;
 
 	return;
 
-- 
2.34.1


