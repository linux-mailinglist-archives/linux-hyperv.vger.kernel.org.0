Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AAD6371B4
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Nov 2022 06:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiKXFXW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Nov 2022 00:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXFXV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Nov 2022 00:23:21 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1560B58BC3
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Nov 2022 21:23:20 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5EC2320B83C2;
        Wed, 23 Nov 2022 21:23:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5EC2320B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669267399;
        bh=MVfZuNzlk/Ta9CdVuPwvvYAZ+M9TwSSSa0WsZCzXMUY=;
        h=From:To:Cc:Subject:Date:From;
        b=cGLo1l6L0J4YdYKz5xljd2OPjhDbTT4fTZFsrG1t8kapcSYwlkJTY11m+oNpsctQE
         Sve+RqutHXsy+b12+psgf6ffIsYhBWtqvZ48DjijaLSbVhkRlhfmg6jdd6L1BvnxnZ
         /WKcbQg+FMZ8zSamDSFctQwUJSpsjizXOQ7XIZG0=
From:   Gaurav Kohli <gauravkohli@linux.microsoft.com>
To:     kys@microsoft.com, decui@microsoft.com, haiyangz@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
        bp@alien8.de
Cc:     gauravkohli@linux.microsoft.com
Subject: [PATCH] x86/hyperv: Remove unregister syscore call from hyperv cleanup
Date:   Wed, 23 Nov 2022 21:23:11 -0800
Message-Id: <1669267391-9809-1-git-send-email-gauravkohli@linux.microsoft.com>
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

Hyperv cleanup codes comes under panic path where preemption and irq
is already disabled. So calling of unregister_syscore_ops which has mutex
from hyperv cleanup might schedule out the thread and never comes back.

To prevent the same remove unwanted unregister_syscore_ops function call.

Signed-off-by: Gaurav Kohli <gauravkohli@linux.microsoft.com>

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index f49bc3ec76e6..c050de69dfde 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -537,7 +537,12 @@ void hyperv_cleanup(void)
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	union hv_reference_tsc_msr tsc_msr;
 
-	unregister_syscore_ops(&hv_syscore_ops);
+	/*
+	 * Avoid unregister_syscore_ops(&hv_syscore_ops) from cleanup code,
+	 * as this is only called in crash path where irq and preemption disabled.
+	 * If we add this, there is a chance that this get scheduled out due to mutex
+	 * in unregister_syscore_ops and never comes back.
+	 */
 
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
-- 
2.17.1

