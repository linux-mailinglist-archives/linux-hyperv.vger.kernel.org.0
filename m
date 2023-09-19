Return-Path: <linux-hyperv+bounces-110-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7717A5954
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Sep 2023 07:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF711C2088E
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Sep 2023 05:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BDC8495;
	Tue, 19 Sep 2023 05:30:19 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA048480
	for <linux-hyperv@vger.kernel.org>; Tue, 19 Sep 2023 05:30:17 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69A0BFC;
	Mon, 18 Sep 2023 22:30:16 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4FBE2212C48B;
	Mon, 18 Sep 2023 22:30:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FBE2212C48B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695101415;
	bh=bS/lJoH3L9FxG8X53V4Tq19fvrqY0he1EUARIKyLRGo=;
	h=From:To:Cc:Subject:Date:From;
	b=EEp9YaUYM3qMkV/+XK91LIsy7m5DWZKxbbsCsJen8UCzhrHF8ID+QDqMrsOCjT/+q
	 xdUka3yi+1ZTVZRtpkLWceIho2Dgu5dH1K5ot7f6GQH0C4cY4mQa+DsgC1SRkMaLpW
	 fEyiXgC1Bmta6EQEyM4OjTMZHV4rocdXsw3lcoRA=
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
	mikelley@microsoft.com,
	vkuznets@redhat.com
Cc: ssengar@microsoft.com
Subject: [PATCH v2] x86/hyperv: Restrict get_vtl to only VTL platforms
Date: Mon, 18 Sep 2023 22:30:08 -0700
Message-Id: <1695101408-22432-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
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
[V2]
 - Put the if else at function definition rather then at the caller

 arch/x86/hyperv/hv_init.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 783ed339f341..f0128fd4031d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -394,6 +394,7 @@ static void __init hv_get_partition_id(void)
 	local_irq_restore(flags);
 }
 
+#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
 static u8 __init get_vtl(void)
 {
 	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
@@ -416,13 +417,16 @@ static u8 __init get_vtl(void)
 	if (hv_result_success(ret)) {
 		ret = output->as64.low & HV_X64_VTL_MASK;
 	} else {
-		pr_err("Failed to get VTL(%lld) and set VTL to zero by default.\n", ret);
-		ret = 0;
+		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
+		BUG();
 	}
 
 	local_irq_restore(flags);
 	return ret;
 }
+#else
+static inline u8 get_vtl(void) { return 0; }
+#endif
 
 /*
  * This function is to be invoked early in the boot sequence after the
@@ -604,8 +608,7 @@ void __init hyperv_init(void)
 	hv_query_ext_cap(0);
 
 	/* Find the VTL */
-	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp())
-		ms_hyperv.vtl = get_vtl();
+	ms_hyperv.vtl = get_vtl();
 
 	return;
 
-- 
2.34.1


