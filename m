Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB2E395669
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 May 2021 09:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhEaHnq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 May 2021 03:43:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54488 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhEaHmi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 May 2021 03:42:38 -0400
Received: from localhost.localdomain (unknown [106.201.36.115])
        by linux.microsoft.com (Postfix) with ESMTPSA id B121620B7178;
        Mon, 31 May 2021 00:40:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B121620B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622446859;
        bh=YhAUisS/fLN6E+FWvha/XrO7IzCg7dvX4MvgIwJw0DU=;
        h=From:To:Cc:Subject:Date:From;
        b=in3pdezQoum4Z+VcwkiTO9CHskSKXDo6XMdA5+ET0xZ7ZGlFqJSuVxDi/EOPh1I7M
         LImlQfep7uOioaz+k9vtUzFcjo6nn7ffpL7FDlPvkK4RuqDbyCtjVA3R+CuNMJAxWc
         LG6CJr89CVKXrnZOQrUK693KXO8s6NRlWIlmOgF8=
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Subject: [PATCH] x86/hyperv: LP creation with lp_index on same CPU-id
Date:   Mon, 31 May 2021 13:10:46 +0530
Message-Id: <20210531074046.113452-1-kumarpraveen@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The hypervisor expects the lp_index to be same as cpu-id during LP creation
This fix correct the same, as cpu_physical_id can give different cpu-id.

Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 22f13343b5da..4fa0a4280895 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -236,7 +236,7 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 	for_each_present_cpu(i) {
 		if (i == 0)
 			continue;
-		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
+		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, i);
 		BUG_ON(ret);
 	}
 
-- 
2.25.1

