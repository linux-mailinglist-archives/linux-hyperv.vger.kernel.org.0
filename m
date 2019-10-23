Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61E2E189F
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Oct 2019 13:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404623AbfJWLTQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Oct 2019 07:19:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404543AbfJWLTQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Oct 2019 07:19:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9NB9Wjn044781;
        Wed, 23 Oct 2019 11:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=9IpjYxNkQXUflfRwtoJIwSIYGnGJ9sg16wFTmhQflww=;
 b=lzYZ37ndJIEKT/pu34sev7qhitguoliLqMoCY4GoUWcJlLmRrGZfgQAwrwigw4awQ7RZ
 NVgF4CUt3R4lscy/LZDaTlksZw3WYtm061o9w+KBIovr13WLYYO93Hi8+WoE2NJ3WOKz
 oGjo8HWFWDaJ6i0bt1Kk8e5tiPD5BryyzLBPM/6p4VmtCxS7VjRZu19vAp70iBYt1OrL
 1vmzfOSc1JtQ0XB1IXR8fvvX5mdOS8u0D/1OZdEh9aEqiSySaof8u+WpHo68WL/WxvR5
 FAGtQbpoYJ2Wnz7YJak/kAlDwAsvr5oleqrxogca3M1/V3pPEhP6yaM76mcaXLn1x3UE NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vqu4qvenw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 11:17:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9NBDPIt145394;
        Wed, 23 Oct 2019 11:17:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vt2hf4au7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 11:17:09 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9NBH39m014839;
        Wed, 23 Oct 2019 11:17:03 GMT
Received: from z2.cn.oracle.com (/10.182.71.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Oct 2019 04:17:02 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, peterz@infradead.org,
        will@kernel.org, linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v8 0/5] Add a unified parameter "nopvspin"
Date:   Wed, 23 Oct 2019 19:16:19 +0800
Message-Id: <1571829384-5309-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230114
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There are cases folks want to disable spinlock optimization for
debug/test purpose. Xen and hyperv already have parameters "xen_nopvspin"
and "hv_nopvspin" to support that, but kvm doesn't.

The first patch adds that feature to KVM guest with "nopvspin".

For compatibility reason original parameters "xen_nopvspin" and
"hv_nopvspin" are retained and marked obsolete.

v8:
PATCH2: use 'kvm-guest' instead of 'kvm_guest'        [Sean Christopherson]
PATCH3: add a comment to explain missed 'return'      [Sean Christopherson]

v7:
PATCH3: update comment and use goto, add RB              [Vitaly Kuznetsov]

v6:
PATCH1: add Reviewed-by                                  [Vitaly Kuznetsov]
PATCH2: change 'pv' to 'PV', add Reviewed-by             [Vitaly Kuznetsov]
PATCH3: refactor 'if' branch in kvm_spinlock_init()      [Vitaly Kuznetsov]

v5:
PATCH1: new patch to revert a currently unnecessory commit,
        code is simpler a bit after that change.         [Boris Ostrovsky]
PATCH3: fold 'if' statement,add comments on virt_spin_lock_key,
        reorder with PATCH2 to better reflect dependency                               
PATCH4: fold 'if' statement, add Reviewed-by             [Boris Ostrovsky]
PATCH5: add Reviewed-by                                  [Michael Kelley]

v4:
PATCH1: use variable name nopvspin instead of pvspin and
        defined it as __initdata, changed print message,
        updated patch description                     [Sean Christopherson]
PATCH2: remove Suggested-by, use "kvm-guest:" prefix  [Sean Christopherson]
PATCH3: make variable nopvsin and xen_pvspin coexist
        remove Reviewed-by due to code change         [Sean Christopherson]
PATCH4: make variable nopvsin and hv_pvspin coexist   [Sean Christopherson]

v3:
PATCH2: Fix indentation

v2:
PATCH1: pick the print code change into separate PATCH2,
        updated patch description             [Vitaly Kuznetsov]
PATCH2: new patch with print code change      [Vitaly Kuznetsov]
PATCH3: add Reviewed-by                       [Juergen Gross]

Zhenzhong Duan (5):
  Revert "KVM: X86: Fix setup the virt_spin_lock_key before static key
    get initialized"
  x86/kvm: Change print code to use pr_*() format
  x86/kvm: Add "nopvspin" parameter to disable PV spinlocks
  xen: Mark "xen_nopvspin" parameter obsolete
  x86/hyperv: Mark "hv_nopvspin" parameter obsolete

 Documentation/admin-guide/kernel-parameters.txt | 14 ++++-
 arch/x86/hyperv/hv_spinlock.c                   |  4 ++
 arch/x86/include/asm/qspinlock.h                |  1 +
 arch/x86/kernel/kvm.c                           | 79 ++++++++++++++++---------
 arch/x86/xen/spinlock.c                         |  4 +-
 kernel/locking/qspinlock.c                      |  7 +++
 6 files changed, 76 insertions(+), 33 deletions(-)

-- 
1.8.3.1

