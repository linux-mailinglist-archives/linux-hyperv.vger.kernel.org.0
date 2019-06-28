Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2D58F6C
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2019 02:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfF1AyQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jun 2019 20:54:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38604 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfF1AyQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jun 2019 20:54:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S0DYMF078901;
        Fri, 28 Jun 2019 00:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=w85fdhBnDnSJZdF4gNrdI0qjj60PNfiLCX8rThOx2Mc=;
 b=P20VVlmj6tAjCBXzHGd1RrYIQG6BmeSTSOuaxXOGRdPYYkxXTebWzWb18ng4X2r49PCT
 5PA8vd4ebmFvRxj9a4tn3F7M8k50nBhxUCC4U+lq4RGT9H4vUFwH/ug+Dp9SYPT3gk+Q
 3w2ksCK6bxrtATMMo7Qx6qICm3dLGaD8vei07r/NQO5I4TB2sA9MePPxY6rWAdAgIBte
 M8Q+9BNoaXipbEwwXmhBye6lBXoiJEcaPJvOey2deZ37EQoKhjwPHIjjDQTD7a4xol4H
 uz7vTc7DS4cjg8zPtTbBAxnq1jj3y/TZK5FnXXGTD76uOAEQbiFFq16Cr3cZVATbtnSf ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t9cyqtwqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 00:53:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S0q2Zb124249;
        Fri, 28 Jun 2019 00:53:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f5aace-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 00:53:08 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5S0r4D6010716;
        Fri, 28 Jun 2019 00:53:04 GMT
Received: from [10.191.27.62] (/10.191.27.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 17:53:04 -0700
Subject: Re: [PATCH v2 6/7] locking/spinlocks, paravirt, hyperv: Correct the
 hv_nopvspin case
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bp@alien8.de, hpa@zytor.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com, Waiman Long <longman@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, linux-hyperv@vger.kernel.org
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561377779-28036-7-git-send-email-zhenzhong.duan@oracle.com>
 <20190627222851.GC11506@sasha-vm>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <eaeb5e52-5fa8-20c9-bc5c-090572718511@oracle.com>
Date:   Fri, 28 Jun 2019 08:53:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627222851.GC11506@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 2019/6/28 6:28, Sasha Levin wrote:
> On Mon, Jun 24, 2019 at 08:02:58PM +0800, Zhenzhong Duan wrote:
>> With the boot parameter "hv_nopvspin" specified a Hyperv guest should
>> not make use of paravirt spinlocks, but behave as if running on bare
>> metal. This is not true, however, as the qspinlock code will fall back
>> to a test-and-set scheme when it is detecting a hypervisor.
>>
>> In order to avoid this disable the virt_spin_lock_key.
>>
>> Same change for XEN is already in Commit e6fd28eb3522
>> ("locking/spinlocks, paravirt, xen: Correct the xen_nopvspin case")
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>> Cc: Waiman Long <longman@redhat.com>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>> Cc: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: Stephen Hemminger <sthemmin@microsoft.com>
>> Cc: Sasha Levin <sashal@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: linux-hyperv@vger.kernel.org
>> ---
>> arch/x86/hyperv/hv_spinlock.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/hyperv/hv_spinlock.c 
>> b/arch/x86/hyperv/hv_spinlock.c
>> index 07f21a0..d90b4b0 100644
>> --- a/arch/x86/hyperv/hv_spinlock.c
>> +++ b/arch/x86/hyperv/hv_spinlock.c
>> @@ -64,6 +64,9 @@ __visible bool hv_vcpu_is_preempted(int vcpu)
>>
>> void __init hv_init_spinlocks(void)
>> {
>> +    if (unlikely(!hv_pvspin))
>> +        static_branch_disable(&virt_spin_lock_key);
>
> This should be combined in the conditional under it, which already
> attempts to disable PV spinlocks, note how hv_pvspin is checked there.
> hc_pvspin isn't the only reason we would disable PV spinlocks on hyperv.

In virt_spin_lock() there is a comment as below. The test-and-set spinlock

is an optimization to hypervisor platform when PV spinlock is unsupported.

         /*
          * On hypervisors without PARAVIRT_SPINLOCKS support we fall
          * back to a Test-and-Set spinlock, because fair locks have
          * horrible lock 'holder' preemption issues.
          */


So my understanding is:

If hv_pvspin=0 by command line, we want to behave as if running on bare 
metal(the fair locks path).

Though there is performance regression, but it's not that important when 
we use hv_pvspin=0.

If PV spinlock is disabled by other reasons, we prefer the optimization 
path.

>
> Also, there's no need for the unlikely() here, it's only getting called
> once...

Ok, I'll removed it.


Thanks

Zhenzhong

