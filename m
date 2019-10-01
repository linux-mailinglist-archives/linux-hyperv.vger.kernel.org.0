Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9FAC33D5
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Oct 2019 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfJAMGQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Oct 2019 08:06:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41434 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfJAMGQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Oct 2019 08:06:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91C4U42173251;
        Tue, 1 Oct 2019 12:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=ZJU7loQMKeSoP/RlUzFVBDI3b7KBQRKdPz3cE8BrKSw=;
 b=T2zDujtlnzNEZAYBTPrGPAsOXWfBF6J7caNaZ02j+TqHsWBEoYzS5/wAyc3zLwG2v7mk
 N19xuaEd3V13gCBlu/Wmi9JrpdhRzFMGt+/EqS1Tdzk+j0aVzmcbERWHG6+YVc335j33
 LgR9iLITnZtpx29J88n3ws3ekSo+rsosSRmIMrRlIoSl77gPgr6aoB8SzSWVWcSlKoHg
 Nf2y6UAbxYZ+E/rWmigk+D8dSZifiOn/6nk0+wO2yL0QCMqEW6et8F9EYHtG04c9d6wO
 T7hF6gR5mt9nJb2yfxqYs8wDFuh+sLoczaCE5CZZfICNNPBjspTTvuoU5g2pb8an92Di sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2v9xxunbsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 12:04:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91C465w188345;
        Tue, 1 Oct 2019 12:04:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vbqd0rcfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 12:04:32 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x91C4GJF017650;
        Tue, 1 Oct 2019 12:04:16 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 05:04:16 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     vkuznets@redhat.com, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/4] x86/kvm: Add "nopvspin" parameter to disable PV spinlocks
Date:   Mon, 30 Sep 2019 20:08:57 +0800
Message-Id: <1569845340-11884-2-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569845340-11884-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1569845340-11884-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010112
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There are cases where a guest tries to switch spinlocks to bare metal
behavior (e.g. by setting "xen_nopvspin" on XEN platform and
"hv_nopvspin" on HYPER_V).

That feature is missed on KVM, add a new parameter "nopvspin" to disable
PV spinlocks for KVM guest.

This new parameter is also used to replace "xen_nopvspin" and
"hv_nopvspin".

The global variable pvspin isn't defined as __initdata as it's used at
runtime by XEN guest.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 arch/x86/include/asm/qspinlock.h                | 1 +
 arch/x86/kernel/kvm.c                           | 7 +++++++
 kernel/locking/qspinlock.c                      | 7 +++++++
 4 files changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c7ac2f3..4b956d8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5330,6 +5330,10 @@
 			as generic guest with no PV drivers. Currently support
 			XEN HVM, KVM, HYPER_V and VMWARE guest.
 
+	nopvspin	[X86,KVM] Disables the qspinlock slow path
+			using PV optimizations which allow the hypervisor to
+			'idle' the guest on lock contention.
+
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
 			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 444d6fd..34a4484 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -32,6 +32,7 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 extern void __pv_init_lock_hash(void);
 extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
+extern bool pvspin;
 
 #define	queued_spin_unlock queued_spin_unlock
 /**
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index e820568..a4f108d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -842,6 +842,13 @@ void __init kvm_spinlock_init(void)
 	if (num_possible_cpus() == 1)
 		return;
 
+	if (!pvspin) {
+		pr_info("PV spinlocks disabled\n");
+		static_branch_disable(&virt_spin_lock_key);
+		return;
+	}
+	pr_info("PV spinlocks enabled\n");
+
 	__pv_init_lock_hash();
 	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
 	pv_ops.lock.queued_spin_unlock =
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2473f10..945b510 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -580,4 +580,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 #include "qspinlock_paravirt.h"
 #include "qspinlock.c"
 
+bool pvspin = true;
+static __init int parse_nopvspin(char *arg)
+{
+	pvspin = false;
+	return 0;
+}
+early_param("nopvspin", parse_nopvspin);
 #endif
-- 
1.8.3.1

