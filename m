Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9689C50B3E
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2019 14:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfFXM6l (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Jun 2019 08:58:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40208 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbfFXM6k (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Jun 2019 08:58:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCsCOt134804;
        Mon, 24 Jun 2019 12:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=+Q4pzzrxZoJXh+xVOIj14v8jnXjgdLST/W4xS1dW8sQ=;
 b=fMa51adxpe2xRi74bVyNtxKNrVqVbNu56QNXztXbNDMdlbocpv7FNVwpzCuTCbi/0XZ4
 IXCJ7KPjWBAz6PREBQzE3auHgTQLSkzWLv9R5B3oovhX2uNlvvgsqmMO0YseCJjqmvhI
 7DKW3KLrsqYkjd7ZXJDUysuy8dHJM8e8/95E/u+CBHBsaZyb68huRAOZGYVx9/IohwAI
 7AkZfzeSo8ZpTeoeApGJBClWaGA7UzAZ5fnNJ7iTHAsXGxkaKSfkK2vvb73T23ebyNIL
 52lQzFD7kn851uvBlQ3+oM47WJMSkOpRZmycPF7Kg59wF24M0yFpokegjP8ADLEHuVUj zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brsx9a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCw9Ws042162;
        Mon, 24 Jun 2019 12:58:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t9acbg5r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:23 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OCwNcK024881;
        Mon, 24 Jun 2019 12:58:23 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 05:58:23 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH 5/6] locking/spinlocks, paravirt, hyperv: Correct the hv_nopvspin case
Date:   Sun, 23 Jun 2019 21:01:42 +0800
Message-Id: <1561294903-6166-5-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240105
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
Cc: linux-hyperv@vger.kernel.org
---
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

