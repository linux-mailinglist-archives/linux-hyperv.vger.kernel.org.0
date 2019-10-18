Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B18AADBFEB
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2019 10:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505053AbfJRIaX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Oct 2019 04:30:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbfJRIaX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Oct 2019 04:30:23 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C2E74FC5DD1294023AB5;
        Fri, 18 Oct 2019 16:30:20 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 18 Oct 2019
 16:30:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <sashal@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <mikelley@microsoft.com>,
        <wei.liu@kernel.org>, <parri.andrea@gmail.com>
CC:     <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] x86/hyperv: Fix build error while CONFIG_PARAVIRT=n
Date:   Fri, 18 Oct 2019 16:29:21 +0800
Message-ID: <20191018082921.28164-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

while CONFIG_PARAVIRT=n, building fails:

arch/x86/kernel/cpu/mshyperv.c: In function ms_hyperv_init_platform:
arch/x86/kernel/cpu/mshyperv.c:219:2: error: pv_info undeclared (first use in this function); did you mean pr_info?
  pv_info.name = "Hyper-V";
  ^~~~~~~

Wrap it into a #ifdef to fix this.

Fixes: 628270ef628a ("x86/hyperv: Set pv_info.name to "Hyper-V"")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e7f0776..c656d92 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -216,7 +216,9 @@ static void __init ms_hyperv_init_platform(void)
 	int hv_host_info_ecx;
 	int hv_host_info_edx;
 
+#ifdef CONFIG_PARAVIRT
 	pv_info.name = "Hyper-V";
+#endif
 
 	/*
 	 * Extract the features and hints
-- 
2.7.4


