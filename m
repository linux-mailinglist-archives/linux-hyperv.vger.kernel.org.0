Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2651554E23
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2019 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfFYMAy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jun 2019 08:00:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38982 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfFYMAy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jun 2019 08:00:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBwbue034996;
        Tue, 25 Jun 2019 12:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=5KptyXNJmsTfP77XZt6SnuUAhHI9DQzGxKm5f7pgB/c=;
 b=j2inzlHbUEQOiQV5l7ffpAUJwcDn+DMuix5apmXpZYRI7Rq9KtJIDGGufxayF0dOP6Ch
 9AuaavWay5I/CBSiBvawjJQBgp9hQPYlL4FpN8NtHsLasrT/l+1WQhbhUBHJ3kSwmbRw
 E1m6oS8h9bOJfK4eZL9fv0uhN70aETlK4YS3vMKf/n86/wHcDhU671ukG6b9IqhJG7Gf
 HMeKNgnkBMsBegrN/JdHIQS3vLIFWuN8SHNtLzS03BcvB/qj/HQ4538mWh9fFCnWWzkz
 JiDFTiKMtc4ctA4OVW6fU0OhH9hlX4YBtj22KzETO7RsguTBR9fqMMx1WV3XriBqdbZY LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t9cyqbucn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 12:00:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBwx38130593;
        Tue, 25 Jun 2019 12:00:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2t9p6u51ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 12:00:09 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5PC08f9023716;
        Tue, 25 Jun 2019 12:00:08 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 05:00:08 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Waiman Long <longman@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-hyperv@vger.kernel.org
Subject: [PATCH v2 6/7] locking/spinlocks, paravirt, hyperv: Correct the hv_nopvspin case
Date:   Mon, 24 Jun 2019 20:02:58 +0800
Message-Id: <1561377779-28036-7-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250097
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
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-hyperv@vger.kernel.org
---
 arch/x86/hyperv/hv_spinlock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 07f21a0..d90b4b0 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -64,6 +64,9 @@ __visible bool hv_vcpu_is_preempted(int vcpu)
 
 void __init hv_init_spinlocks(void)
 {
+	if (unlikely(!hv_pvspin))
+		static_branch_disable(&virt_spin_lock_key);
+
 	if (!hv_pvspin || !apic ||
 	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
 	    !(ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)) {
-- 
1.8.3.1

