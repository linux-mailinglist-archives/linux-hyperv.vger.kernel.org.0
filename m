Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622CE3455B8
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 03:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhCWCvJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 22:51:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14426 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhCWCuc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 22:50:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4G5y1fLmzkcpC;
        Tue, 23 Mar 2021 10:48:54 +0800 (CST)
Received: from vm-Yoda-Ubuntu1804.huawei.com (10.67.174.59) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 10:50:20 +0800
From:   Xu Yihang <xuyihang@huawei.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>
CC:     <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuyihang@huawei.com>, <johnny.chenyi@huawei.com>
Subject: [PATCH -next] x86: Fix unused variable 'hi'
Date:   Tue, 23 Mar 2021 10:50:13 +0800
Message-ID: <20210323025013.191533-1-xuyihang@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318074607.124663-1-xuyihang@huawei.com>
References: <20210318074607.124663-1-xuyihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.59]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fixes the following W=1 kernel build warning(s):
arch/x86/hyperv/hv_apic.c:58:15: warning: variable ‘hi’ set but not used [-Wunused-but-set-variable]

Compiled with CONFIG_HYPERV enabled:
make allmodconfig ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
make W=1 arch/x86/hyperv/hv_apic.o ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-

HV_X64_MSR_EOI stores on bit 31:0 and HV_X64_MSR_TPR stores in bit 7:0, which means higher
32 bits are not really used, therefore  potentially cast to void in order to silent this warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xu Yihang <xuyihang@huawei.com>
---
 arch/x86/hyperv/hv_apic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 284e73661a18..a8b639498033 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -60,9 +60,11 @@ static u32 hv_apic_read(u32 reg)
 	switch (reg) {
 	case APIC_EOI:
 		rdmsr(HV_X64_MSR_EOI, reg_val, hi);
+		(void) hi;
 		return reg_val;
 	case APIC_TASKPRI:
 		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
+		(void) hi;
 		return reg_val;
 
 	default:
-- 
2.17.1

