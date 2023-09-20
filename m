Return-Path: <linux-hyperv+bounces-120-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E257A7168
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Sep 2023 06:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7522280E8C
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Sep 2023 04:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E61FDF;
	Wed, 20 Sep 2023 04:04:46 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80C1FC1
	for <linux-hyperv@vger.kernel.org>; Wed, 20 Sep 2023 04:04:45 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7FAAAC;
	Tue, 19 Sep 2023 21:04:43 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E28B2212C4AC;
	Tue, 19 Sep 2023 21:04:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E28B2212C4AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695182682;
	bh=mLN2bn4JjfkyYmq8OaE11aXc6Fms0dmnNK2B2velDMo=;
	h=From:To:Cc:Subject:Date:From;
	b=PtNVtm3zZx27iw5h//0Uhikal2u4g7eMDbVVkP01fUkuTLzWMKwg5mlyNYqk8ZiXg
	 KIHJzaiCc8lhaI72rsyZCFdQsheJFWzZFKmv4rjQ34TibIQDv4rNv4wBIq8yjGgA6l
	 Xt2NorulcN6BJJNrpndToxJLYOKolxlIKTq7jdrs=
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
Subject: [PATCH v3] x86/hyperv: Restrict get_vtl to only VTL platforms
Date: Tue, 19 Sep 2023 21:04:35 -0700
Message-Id: <1695182675-13405-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

When Linux runs in a non-default VTL (CONFIG_HYPERV_VTL_MODE=y),
get_vtl() must never fail as its return value is used in negotiations
with the host. In the more generic case, (CONFIG_HYPERV_VTL_MODE=n) the
VTL is always zero so there's no need to do the hypercall.

Make get_vtl() BUG() in case of failure and put the implementation under
"if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)" to avoid the call altogether in
the most generic use case.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
[V3]
 - Modified commit message
 - Added reviewed-by

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


