Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54E65F163
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jul 2019 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfGDCVN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Jul 2019 22:21:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41052 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGDCVM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Jul 2019 22:21:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x642JrBE165097;
        Thu, 4 Jul 2019 02:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=GxqPkKqiaZWF5TAkcRYXZctmYGfXSTCnWlJ2S2zRDMs=;
 b=WL2upingzcGwz60NTWvpbAb5kvVeh76Dlh4kF1cEZqpFSvCzXDW6ba5ZuTas34O2rytf
 cdLsBAcrUegNcyrWCO173+wzZBQrXBnBtQkheZyNm9zTGTc4PN0MXQNuw7j8ddaFVdYB
 Hneca9KFO6HFELWCOST+DTbr5l9VY5d3ZK5gmbH0eQbesCbBIZ2g/djhyT25gfwVk8P1
 9KLMqQji/tr/H4GyV2QECDqWoBVKiRUixSSituIg7fv70N/xJmCJEb0qYzofLmpGEdQp
 lEIdsOgtOWE/ozbwodNfQNFLQ1I/aI7hh+fUcQsMaYz6vID9AAg2G/NasexSIB1BZ5dW aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2te5tbvaxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 02:20:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x642IGBk084059;
        Thu, 4 Jul 2019 02:20:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2th5qm1uf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 02:20:35 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x642KSfg021256;
        Thu, 4 Jul 2019 02:20:28 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jul 2019 19:20:27 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH v3] locking/spinlocks, paravirt, hyperv: Correct the hv_nopvspin case
Date:   Wed,  3 Jul 2019 10:23:55 +0800
Message-Id: <1562120635-9806-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040029
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

With the boot parameter "hv_nopvspin" specified a Hyperv guest should
not make use of paravirt spinlocks, but behave as if running on bare
metal. This is not true, however, as the qspinlock code will fall back
to a test-and-set scheme when it is detecting a hypervisor.

In order to avoid this disable the virt_spin_lock_key.

Same change for XEN is already in Commit e6fd28eb3522
("locking/spinlocks, paravirt, xen: Correct the xen_nopvspin case")

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-hyperv@vger.kernel.org
---
v3: remove unlikely() as suggested by Sasha

 arch/x86/hyperv/hv_spinlock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 07f21a0..210495b 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -64,6 +64,9 @@ __visible bool hv_vcpu_is_preempted(int vcpu)
 
 void __init hv_init_spinlocks(void)
 {
+	if (!hv_pvspin)
+		static_branch_disable(&virt_spin_lock_key);
+
 	if (!hv_pvspin || !apic ||
 	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
 	    !(ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)) {
-- 
1.8.3.1

