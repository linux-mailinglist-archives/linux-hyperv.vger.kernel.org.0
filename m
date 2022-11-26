Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2972D639414
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Nov 2022 07:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiKZGPE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 26 Nov 2022 01:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKZGPC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 26 Nov 2022 01:15:02 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CBFC201A1
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Nov 2022 22:15:01 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id E1C5720B6C40;
        Fri, 25 Nov 2022 22:15:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1C5720B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669443300;
        bh=GYrbe4iO7Wj+wXd+nOKIxw3VhZ8cjRmLQ09+73y0s+s=;
        h=From:To:Cc:Subject:Date:From;
        b=T9/bmjFn5smEk/AWjRHuPYqTECLppe8RrZzbvzfcuZEiLvvcAA4ky0fmvQ4hSKb9J
         A9/9afT66mHpYx/ldyePsKr7wi7CO2oQfNAjN5eIABJ3wFV9PFWlNOUL/7ISl7L4YA
         CQKiNPEpVLvEbaOHbgsVbQrVezg2H52fwwGWTLdY=
From:   Gaurav Kohli <gauravkohli@linux.microsoft.com>
To:     kys@microsoft.com, decui@microsoft.com, haiyangz@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
        bp@alien8.de, mikelley@microsoft.com
Cc:     gauravkohli@linux.microsoft.com
Subject: [PATCH v2] x86/hyperv: Remove unregister syscore call from Hyper-V cleanup
Date:   Fri, 25 Nov 2022 22:14:51 -0800
Message-Id: <1669443291-2575-1-git-send-email-gauravkohli@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V cleanup code comes under panic path where preemption and irq
is already disabled. So calling of unregister_syscore_ops might schedule
out the thread even for the case where mutex lock is free.
hyperv_cleanup
	unregister_syscore_ops
			mutex_lock(&syscore_ops_lock)
				might_sleep
Here might_sleep might schedule out this thread, where voluntary preemption
config is on and this thread will never comes back. And also this was added
earlier to maintain the symmetry which is not required as this can comes
during crash shutdown path only.

To prevent the same, removing unregister_syscore_ops function call.

Signed-off-by: Gaurav Kohli <gauravkohli@linux.microsoft.com>
---
v2: Update commit message
---
 arch/x86/hyperv/hv_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index f49bc3ec76e6..5ec7badab600 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -537,8 +537,6 @@ void hyperv_cleanup(void)
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	union hv_reference_tsc_msr tsc_msr;
 
-	unregister_syscore_ops(&hv_syscore_ops);
-
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
-- 
2.17.1

