Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5806057EBD
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Jun 2019 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfF0IzH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jun 2019 04:55:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41116 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0IzH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jun 2019 04:55:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R8sCA5058141;
        Thu, 27 Jun 2019 08:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=5KptyXNJmsTfP77XZt6SnuUAhHI9DQzGxKm5f7pgB/c=;
 b=ZLYYb7UFwgWFaRYyu6JpYhO5fd6M2quAU8xGVS5kQ8hcr2oFJ38wen5HoT81YUMJpqyE
 6oxiA5DRsjp4irhvb5WgbndwNQyfZx6wtw3Cv/VgPxTsen4zZKRjvKtrqdlmAZG59DPc
 RZeeoQEUXg3IVo2If1FgItoTJxeaYPqssea6Ukl20L4ejILxLuSZosnH1LQDNDYEUpVF
 FWCdid540riv/M6bRtOirnUh57w6PhS6Erf3GFLjcgjkd1oRd0yTvZoHGSv2odX5K+wZ
 09yg2cXJ4Ce1Awma+6PcOTpAB/qWNsZrNlGnyw7ILBzbYUCr50WkAgWV1vp/uf45P5my jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t9c9py1ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 08:54:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R8pvea017707;
        Thu, 27 Jun 2019 08:52:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t99f4w3j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 08:52:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R8qLWd027247;
        Thu, 27 Jun 2019 08:52:21 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 01:52:20 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH RESEND] locking/spinlocks, paravirt, hyperv: Correct the hv_nopvspin case
Date:   Wed, 26 Jun 2019 16:56:01 +0800
Message-Id: <1561539361-29313-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270105
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

