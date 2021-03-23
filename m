Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190D83455A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 03:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCWCnf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 22:43:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14062 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCWCnU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 22:43:20 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4FwZ1bCpzNqR6;
        Tue, 23 Mar 2021 10:40:46 +0800 (CST)
Received: from vm-Yoda-Ubuntu1804.huawei.com (10.67.174.59) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 10:43:08 +0800
From:   Xu Yihang <xuyihang@huawei.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <x86@kernel.org>
CC:     <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuyihang@huawei.com>, <johnny.chenyi@huawei.com>,
        <heying24@huawei.com>
Subject: [PATCH -next] x86: Fix unused variable 'msr_val' warning
Date:   Tue, 23 Mar 2021 10:43:02 +0800
Message-ID: <20210323024302.174434-1-xuyihang@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322031713.23853-1-xuyihang@huawei.com>
References: <20210322031713.23853-1-xuyihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.59]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fixes the following W=1 kernel build warning(s):
arch/x86/hyperv/hv_spinlock.c:28:16: warning: variable ‘msr_val’ set but not used [-Wunused-but-set-variable]
  unsigned long msr_val;

As Hypervisor Top-Level Functional Specification states in chapter 7.5 Virtual Processor Idle Sleep State, "A partition which possesses the AccessGuestIdleMsr privilege (refer to section 4.2.2) may trigger entry into the virtual processor idle sleep state through a read to the hypervisor-defined MSR HV_X64_MSR_GUEST_IDLE". That means only a read is necessary, msr_val is not uesed, so potentially cast to void in order to silent this warning.

Reference:
https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xu Yihang <xuyihang@huawei.com>
---
 arch/x86/hyperv/hv_spinlock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index f3270c1fc48c..91cfe698bde0 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -25,7 +25,6 @@ static void hv_qlock_kick(int cpu)
 
 static void hv_qlock_wait(u8 *byte, u8 val)
 {
-	unsigned long msr_val;
 	unsigned long flags;
 
 	if (in_nmi())
@@ -48,8 +47,13 @@ static void hv_qlock_wait(u8 *byte, u8 val)
 	/*
 	 * Only issue the rdmsrl() when the lock state has not changed.
 	 */
-	if (READ_ONCE(*byte) == val)
+	if (READ_ONCE(*byte) == val) {
+		unsigned long msr_val;
+
 		rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);
+
+		(void)msr_val;
+	}
 	local_irq_restore(flags);
 }
 
-- 
2.17.1

