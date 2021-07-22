Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60423D2766
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jul 2021 18:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGVPfI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jul 2021 11:35:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46222 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGVPfI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jul 2021 11:35:08 -0400
Received: from [192.168.1.87] (unknown [223.226.82.147])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B70F20B7178;
        Thu, 22 Jul 2021 09:15:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B70F20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626970543;
        bh=q2lgiM7WAuT4H/isn+1dsbM+2326xfckYWILjIaCQdE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XcERh7VFziMtRnOllHVVF+uwCnsEQYsSjZvTCvNsl7tRspjAHynVEbFvRTbH+7p9I
         fSzdXs921abDHCFX6pwkUp2vIRH7W6JE8Piq6r5z6fL+uJcHHwTMB2yNDbcDZluIjy
         tM+ISjBsSpPBEyEaP0aCx/maRG3Jfr4Nu/s4AiEo=
Subject: Re: [PATCH v2] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com
References: <20210721180302.18764-1-kumarpraveen@linux.microsoft.com>
 <20210722102741.vl4fvv3abifru2ge@liuwe-devbox-debian-v2>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <bd019dc6-75e9-ac89-18fa-c09561000188@linux.microsoft.com>
Date:   Thu, 22 Jul 2021 21:45:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722102741.vl4fvv3abifru2ge@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 22-07-2021 15:57, Wei Liu wrote:
> On Wed, Jul 21, 2021 at 11:33:02PM +0530, Praveen Kumar wrote:
>> For Root partition the VP assist pages are pre-determined by the
>> hypervisor. The Root kernel is not allowed to change them to
>> different locations. And thus, we are getting below stack as in
>> current implementation Root is trying to perform write to specific
>> MSR.
>>
>> [ 2.778197] unchecked MSR access error: WRMSR to 0x40000073 (tried to
>> write 0x0000000145ac5001) at rIP: 0xffffffff810c1084
>> (native_write_msr+0x4/0x30)
>> [ 2.784867] Call Trace:
>> [ 2.791507] hv_cpu_init+0xf1/0x1c0
>> [ 2.798144] ? hyperv_report_panic+0xd0/0xd0
>> [ 2.804806] cpuhp_invoke_callback+0x11a/0x440
>> [ 2.811465] ? hv_resume+0x90/0x90
>> [ 2.818137] cpuhp_issue_call+0x126/0x130
>> [ 2.824782] __cpuhp_setup_state_cpuslocked+0x102/0x2b0
>> [ 2.831427] ? hyperv_report_panic+0xd0/0xd0
>> [ 2.838075] ? hyperv_report_panic+0xd0/0xd0
>> [ 2.844723] ? hv_resume+0x90/0x90
>> [ 2.851375] __cpuhp_setup_state+0x3d/0x90
>> [ 2.858030] hyperv_init+0x14e/0x410
>> [ 2.864689] ? enable_IR_x2apic+0x190/0x1a0
>> [ 2.871349] apic_intr_mode_init+0x8b/0x100
>> [ 2.878017] x86_late_time_init+0x20/0x30
>> [ 2.884675] start_kernel+0x459/0x4fb
>> [ 2.891329] secondary_startup_64_no_verify+0xb0/0xbb
>>
>> Since, the hypervisor already provides the VP assist page for root
>> partition, we need to memremaps the memory from hypervisor for root
>> kernel to use. The mapping is done in hv_cpu_init during bringup and
>> is unmaped in hv_cpu_die during teardown.
>>
>> Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/hv_init.c | 53 ++++++++++++++++++++++++++-------------
>>  1 file changed, 36 insertions(+), 17 deletions(-)
>>
>> changelog:
>> v1: initial patch
>> v2: commit message changes, removal of HV_MSR_APIC_ACCESS_AVAILABLE
>>     check and addition of null check before reading the VP assist MSR
>>     for root partition
>>
>> ---
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 6f247e7e07eb..ffd3d3b37235 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -55,26 +55,41 @@ static int hv_cpu_init(unsigned int cpu)
>>  		return 0;
>>  
>>  	/*
>> -	 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
>> -	 * 5.2.1 "GPA Overlay Pages"). Here it must be zeroed out to make sure
>> -	 * we always write the EOI MSR in hv_apic_eoi_write() *after* the
>> -	 * EOI optimization is disabled in hv_cpu_die(), otherwise a CPU may
>> -	 * not be stopped in the case of CPU offlining and the VM will hang.
>> +	 * For Root partition we need to map the hypervisor VP ASSIST PAGE
>> +	 * instead of allocating a new page.
>>  	 */
>> -	if (!*hvp) {
>> -		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
>> -	}
>> +	if (hv_root_partition) {
>> +		union hv_x64_msr_hypercall_contents hypercall_msr;
>> +
>> +		rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, hypercall_msr.as_uint64);
>> +		/* remapping to root partition address space */
>> +		if (!*hvp)
>> +			*hvp = memremap(hypercall_msr.guest_physical_address <<
>> +					HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
>> +					PAGE_SIZE, MEMREMAP_WB);
>> +		WARN_ON(!(*hvp));
>> +	} else {
>> +		/*
>> +		 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's
>> +		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
>> +		 * out to make sure we always write the EOI MSR in
>> +		 * hv_apic_eoi_write() *after* theEOI optimization is disabled
>> +		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
>> +		 * case of CPU offlining and the VM will hang.
>> +		 */
>> +		if (!*hvp)
>> +			*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
>>  
>> -	if (*hvp) {
>> -		u64 val;
>> +		if (*hvp) {
>> +			u64 val;
>>  
>> -		val = vmalloc_to_pfn(*hvp);
>> -		val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
>> -			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
>> +			val = vmalloc_to_pfn(*hvp);
>> +			val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
>> +				HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
>>  
>> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
>> +			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
>> +		}
>>  	}
>> -
>>  	return 0;
>>  }
>>  
>> @@ -170,8 +185,12 @@ static int hv_cpu_die(unsigned int cpu)
>>  
>>  	hv_common_cpu_die(cpu);
>>  
>> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
>> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>> +		if (hv_root_partition)
>> +			memunmap(hv_vp_assist_page[cpu]);
> 
> I think about this a bit more, the NULL check for *hvp in hv_cpu_init in
> the original code is perhaps due to the code has opted to not free the
> page when disabling the VP assist page. When the CPU is brought back
> online, it does not want to allocate another page, but to use the one
> that's already allocated.
> 
> So, since you listened to my suggestion to add a similar check, you need
> to reset hv_vp_assist_page to NULL here. Alternatively the check for
> *hvp can be dropped for the root path. Either way, the difference
> between root and non-root should be documented.
> 

I would make it as NULL post memunmap as you suggested, so that we don't end up reusing the old/cached value. Before doing that, is there any use-case where hypervisor can allocate or change the VP assist page that can impact root kernel execution ?

> Wei.
> 
>> +		else
>> +			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
>> +	}
>>  
>>  	if (hv_reenlightenment_cb == NULL)
>>  		return 0;
>> -- 
>> 2.25.1
>>

Regards,

~Praveen.
