Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB505619D9F
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Nov 2022 17:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiKDQro (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Nov 2022 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKDQrd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ECF32047
        for <linux-hyperv@vger.kernel.org>; Fri,  4 Nov 2022 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667580393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6EdVZ9Ytp7ie9/xHerVjqdlN3g0FspZlsm56S90mrRM=;
        b=WpzVgE6/X0IMgHOg/OItPSmNhvZQFAcXOKP1lblClnFNzhQeYis7stezcvU0fVGjFESMum
        ueVCSjnLPLDoc7LbewcIs4uAn8fGmuCZ9LzvnRx8sPZSH5amEXrfGgF2ABRTx8eNG8Z1SN
        W/+QFn8rDc/CLkn/ODU5Nh/7OtSFItM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-91-X9GinTX6PWim0J8Z9LjzMQ-1; Fri, 04 Nov 2022 12:46:29 -0400
X-MC-Unique: X9GinTX6PWim0J8Z9LjzMQ-1
Received: by mail-wm1-f69.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so4501645wme.7
        for <linux-hyperv@vger.kernel.org>; Fri, 04 Nov 2022 09:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EdVZ9Ytp7ie9/xHerVjqdlN3g0FspZlsm56S90mrRM=;
        b=I6SGZftNi22PeEgchYTp3N/72IH7uAWiw97aeKgzCjycxzaq/B7qM2DdbxqaQDhVJI
         XBIGrvtCLXIbtc0Rp/jPYnLNhsi2qqVaSmOQ/zCfGA2lCKHDPg4esBvXDwp0fYbaVcOq
         p8iFjiN9TPlIFcPa3+kqB7/KFQVFUcB9ACtJfC6vptExg+8Yqtjh+GP38RQvxpIzE411
         5tBfm0rAD2ksxiS/fA+MD9TKbEkj2+aU4VVdovsU89A45GWAXwrA8loPh4OWF39c03Pg
         4MFm73kXfagROmdj0wEGpzaUhoIUrzTfKwR0drMSZCnp8+junAqADzB1oELfmfaHGZF9
         T/qw==
X-Gm-Message-State: ACrzQf1/QwGD+Hg2oaeZtC7eG4RabOSXfyzUU3gS8eWD37RK/+ytZLp7
        4R7K6NbWJLRvjrE7hJ41oimcBx8Uu4WCYZs/NIseElHJfX96s59THKK5SbOM+DYh3DR2oUADWqr
        Yi4PZpwP5wtJbzOidUnSWWYPH
X-Received: by 2002:a5d:6145:0:b0:236:a948:9e35 with SMTP id y5-20020a5d6145000000b00236a9489e35mr22553242wrt.185.1667580387853;
        Fri, 04 Nov 2022 09:46:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5S29feX0TY+GN+inRYLlRbhUeaGWGp0FCMYMbzVHUbNnPw/uP7vCsFYUy/s/j7DedEzCRhdQ==
X-Received: by 2002:a5d:6145:0:b0:236:a948:9e35 with SMTP id y5-20020a5d6145000000b00236a9489e35mr22553229wrt.185.1667580387555;
        Fri, 04 Nov 2022 09:46:27 -0700 (PDT)
Received: from ovpn-192-136.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c190d00b003b47e8a5d22sm3789725wmq.23.2022.11.04.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:46:26 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/hyperv: Restore VP assist page after cpu
 offlining/onlining
In-Reply-To: <BYAPR21MB1688482206965765C716DC9ED73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221103190601.399343-1-vkuznets@redhat.com>
 <BYAPR21MB1688482206965765C716DC9ED73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Fri, 04 Nov 2022 17:46:25 +0100
Message-ID: <878rkqr7ku.fsf@ovpn-192-136.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--=-=-=
Content-Type: text/plain

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, November 3, 2022 12:06 PM
>> 
>> Commit e5d9b714fe40 ("x86/hyperv: fix root partition faults when writing
>> to VP assist page MSR") moved 'wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE)' under
>> 'if (*hvp)' condition. This works for root partition as hv_cpu_die()
>> does memunmap() and sets 'hv_vp_assist_page[cpu]' to NULL but breaks
>> non-root partitions as hv_cpu_die() doesn't free 'hv_vp_assist_page[cpu]'
>> for them. 
>
> Did you consider having hv_cpu_die() free the VP assist page and
> set hv_vp_assist_page[cpu] to NULL in the non-root case?

Oh yes, I did, and I even wrote a patch (attached) but it failed in
testing :-( My testing was to run CPU onlining/offlining loop and and
try using KVM on the same CPU at the same time. I was able to see issues
when KVM was not able to reach to Enlightened VMCS because VP assist
page was NULL.

>  That would
> make the root and non-root cases more consistent, and it would make
> hv_cpu_init() and hv_cpu_die() more symmetrical.   The hv_cpu_die()
> path frees up pretty much all the other per-CPU resources.  I don't
> know why it keeps the VP assist page for re-use if the CPU comes back
> online later.
>
> You added the original code for allocating the vp_assist_page in
> commit a46d15cc1a, so maybe you remember if there are any
> gotchas. :-)

The root cause of the problem I observed seems to be the order of CPU
hotplug. Hyper-V uses the last CPUHP_AP_ONLINE_DYN stage while KVM has
his own dedicated CPUHP_AP_KVM_STARTING one so we end up freeing VP
assist page before turning KVM off on the CPU. It may be sufficient to
introduce a new stage for Hyper-V and put it before KVM's. It's in my
backlog to explore this path but it may take me some time to get back to
it :-( 

>
> Michael
>
>> This causes VP assist page to remain unset after CPU
>> offline/online cycle:
>> 
>> $ rdmsr -p 24 0x40000073
>>   10212f001
>> $ echo 0 > /sys/devices/system/cpu/cpu24/online
>> $ echo 1 > /sys/devices/system/cpu/cpu24/online
>> $ rdmsr -p 24 0x40000073
>>   0
>> 
>> Fix the issue by always writing to HV_X64_MSR_VP_ASSIST_PAGE in
>> hv_cpu_init(). Note, checking 'if (!*hvp)', for root partition is
>> pointless as hv_cpu_die() always sets 'hv_vp_assist_page[cpu]' to
>> NULL (and it's also NULL initially).
>> 
>> Note: the fact that 'hv_vp_assist_page[cpu]' is reset to NULL may
>> present a (potential) issue for KVM. While Hyper-V uses
>> CPUHP_AP_ONLINE_DYN stage in CPU hotplug, KVM uses
>> CPUHP_AP_KVM_STARTING
>> which comes earlier in CPU teardown sequence. It is theoretically
>> possible that Enlightened VMCS is still in use. It is unclear if the
>> issue is real and if using KVM with Hyper-V root partition is even
>> possible.
>> 
>> While on it, drop the unneeded smp_processor_id() call from hv_cpu_init().
>> 
>> Fixes: e5d9b714fe40 ("x86/hyperv: fix root partition faults when writing to VP assist
>> page MSR")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/hyperv/hv_init.c | 54 +++++++++++++++++++--------------------
>>  1 file changed, 26 insertions(+), 28 deletions(-)
>> 
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index f49bc3ec76e6..a269049a43ce 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -77,7 +77,7 @@ static int hyperv_init_ghcb(void)
>>  static int hv_cpu_init(unsigned int cpu)
>>  {
>>  	union hv_vp_assist_msr_contents msr = { 0 };
>> -	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>> +	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
>>  	int ret;
>> 
>>  	ret = hv_common_cpu_init(cpu);
>> @@ -87,34 +87,32 @@ static int hv_cpu_init(unsigned int cpu)
>>  	if (!hv_vp_assist_page)
>>  		return 0;
>> 
>> -	if (!*hvp) {
>> -		if (hv_root_partition) {
>> -			/*
>> -			 * For root partition we get the hypervisor provided VP assist
>> -			 * page, instead of allocating a new page.
>> -			 */
>> -			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>> -			*hvp = memremap(msr.pfn <<
>> -
>> 	HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
>> -					PAGE_SIZE, MEMREMAP_WB);
>> -		} else {
>> -			/*
>> -			 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
>> -			 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
>> -			 * out to make sure we always write the EOI MSR in
>> -			 * hv_apic_eoi_write() *after* the EOI optimization is disabled
>> -			 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
>> -			 * case of CPU offlining and the VM will hang.
>> -			 */
>> +	if (hv_root_partition) {
>> +		/*
>> +		 * For root partition we get the hypervisor provided VP assist
>> +		 * page, instead of allocating a new page.
>> +		 */
>> +		rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>> +		*hvp = memremap(msr.pfn <<
>> HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
>> +				PAGE_SIZE, MEMREMAP_WB);
>> +	} else {
>> +		/*
>> +		 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
>> +		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
>> +		 * out to make sure we always write the EOI MSR in
>> +		 * hv_apic_eoi_write() *after* the EOI optimization is disabled
>> +		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
>> +		 * case of CPU offlining and the VM will hang.
>> +		 */
>> +		if (!*hvp)
>>  			*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
>> -			if (*hvp)
>> -				msr.pfn = vmalloc_to_pfn(*hvp);
>> -		}
>> -		WARN_ON(!(*hvp));
>> -		if (*hvp) {
>> -			msr.enable = 1;
>> -			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>> -		}
>> +		if (*hvp)
>> +			msr.pfn = vmalloc_to_pfn(*hvp);
>> +
>> +	}
>> +	if (!WARN_ON(!(*hvp))) {
>> +		msr.enable = 1;
>> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>>  	}
>> 
>>  	return hyperv_init_ghcb();
>> --
>> 2.38.1
>

-- 
Vitaly


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=0001-x86-hyperv-Free-VP-assist-page-from-hv_cpu_die.patch

From 9b9e30e3fc182f6a43efca0f93b5851392074a3a Mon Sep 17 00:00:00 2001
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Thu, 3 Nov 2022 16:27:41 +0100
Subject: [PATCH] x86/hyperv: Free VP assist page from hv_cpu_die()
Content-Type: text/plain

Normally, 'hv_vp_assist_page[cpu]' points to CPU's VP assist page mapping.
In case of Hyper-V root partition, this is 'memremap()' of the PFN given
by the hypervisor. In case of a non-root partition, it's vmalloc(). When
the CPU goes offline, hv_cpu_die() disables VP assist page by writing
HV_X64_MSR_VP_ASSIST_PAGE and in case of root partition, does memunmap().
For non-root partitions, the vmalloc()ed page remains allocated and
thus hv_cpu_init() has to check whether a new allocation is
needed. This is unnecessary complicated. Let's always free the page
from hv_cpu_die() and allocate it back from hv_cpu_init(). All VP
assist page users have to be prepared to 'hv_vp_assist_page[cpu]'
becoming NULL anyway as that's what happes already for the root
partition.

VP assist page has two users: KVM and APIC PV EOI. When a CPU goes
offline, there cannot be a running guest and thus KVM's use case
should be safe. As correctly noted in commit e320ab3cec7dd ("x86/hyper-v:
Zero out the VP ASSIST PAGE on allocation"), it is possible to see
interrupts after hv_cpu_die() and before the CPU is fully
dead. hv_apic_eoi_write() is, however, also prepared to see NULL in
'hv_vp_assist_page[smp_processor_id()]'. Moreover, checking the
page which is already unmapped from the hypervisor is incorrect in the
first place.

While on it, adjust VP assist page disabling a bit: always write to
HV_X64_MSR_VP_ASSIST_PAGE first and unmap/free the corresponding page
after, this is to make sure the hypervisor doesn't write to the
already freed memory in the interim.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_init.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a0165df3c4d8..74be6f145fc4 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -104,8 +104,7 @@ static int hv_cpu_init(unsigned int cpu)
 		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
 		 * case of CPU offlining and the VM will hang.
 		 */
-		if (!*hvp)
-			*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
+		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
 		if (*hvp)
 			msr.pfn = vmalloc_to_pfn(*hvp);
 
@@ -233,12 +232,17 @@ static int hv_cpu_die(unsigned int cpu)
 			 * page here and nullify it, so that in future we have
 			 * correct page address mapped in hv_cpu_init.
 			 */
-			memunmap(hv_vp_assist_page[cpu]);
-			hv_vp_assist_page[cpu] = NULL;
 			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 			msr.enable = 0;
 		}
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
+
+		if (hv_root_partition)
+			memunmap(hv_vp_assist_page[cpu]);
+		else
+			vfree(hv_vp_assist_page[cpu]);
+
+		hv_vp_assist_page[cpu] = NULL;
 	}
 
 	if (hv_reenlightenment_cb == NULL)
-- 
2.38.1


--=-=-=--

