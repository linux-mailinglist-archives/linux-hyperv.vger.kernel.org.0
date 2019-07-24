Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A0772905
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jul 2019 09:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfGXHaN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Jul 2019 03:30:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45650 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfGXHaN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Jul 2019 03:30:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O7Sok9085679;
        Wed, 24 Jul 2019 07:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5rHaoPqVyO/Z653y01L3kbFt1bw3GKwSsu1Fgnt7N5k=;
 b=TCGu0AHUg1f1UAn1Wq2Jy9kqqnlFHRN/VwvZR+lp0hdk0hhqnZbeV4Z2PLWmpXMNN9Pb
 ne12mjvxm9H7fnhS+1fpaDXS6/gWZ/TzSyTdDUaCrRuFHx5EONlts0tgJ8QsFwr47uOV
 eVpeICTC1v8fKPeDzxEg/9thV1z0Hfoa0K7bLsfd3Sc1arG1PS7aGs3XptQ6+tr1EZk5
 FG+l2pHk4vNiG/XHaUGaks5fKr0Nzz2Anqn9dy7A6T7o6DrsDU6DSrYcZ4d8IZnDU+DB
 qRjBJH3odQ+71VYLEJngFmCauNqwfn8E/k8BMLy++FyYruaQhQgKp4kZqb4dOcF3k0Ry Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tx61bue0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 07:29:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O7RWvn116368;
        Wed, 24 Jul 2019 07:29:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tx60xjgcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 07:29:15 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6O7TAAN016494;
        Wed, 24 Jul 2019 07:29:11 GMT
Received: from [10.191.29.208] (/10.191.29.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 00:29:10 -0700
Subject: Re: [PATCH v3] locking/spinlocks, paravirt, hyperv: Correct the
 hv_nopvspin case
To:     linux-kernel@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
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
References: <1562120635-9806-1-git-send-email-zhenzhong.duan@oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <a3b87a0e-803d-5a28-03be-b9e2b37b94ba@oracle.com>
Date:   Wed, 24 Jul 2019 15:29:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562120635-9806-1-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240083
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Maintainers,

Any further comments on this? Thanks

Zhenzhong

On 2019/7/3 10:23, Zhenzhong Duan wrote:
> With the boot parameter "hv_nopvspin" specified a Hyperv guest should
> not make use of paravirt spinlocks, but behave as if running on bare
> metal. This is not true, however, as the qspinlock code will fall back
> to a test-and-set scheme when it is detecting a hypervisor.
>
> In order to avoid this disable the virt_spin_lock_key.
>
> Same change for XEN is already in Commit e6fd28eb3522
> ("locking/spinlocks, paravirt, xen: Correct the xen_nopvspin case")
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: linux-hyperv@vger.kernel.org
> ---
> v3: remove unlikely() as suggested by Sasha
>
>   arch/x86/hyperv/hv_spinlock.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
> index 07f21a0..210495b 100644
> --- a/arch/x86/hyperv/hv_spinlock.c
> +++ b/arch/x86/hyperv/hv_spinlock.c
> @@ -64,6 +64,9 @@ __visible bool hv_vcpu_is_preempted(int vcpu)
>   
>   void __init hv_init_spinlocks(void)
>   {
> +	if (!hv_pvspin)
> +		static_branch_disable(&virt_spin_lock_key);
> +
>   	if (!hv_pvspin || !apic ||
>   	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
>   	    !(ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)) {
