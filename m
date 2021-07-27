Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664613D7B76
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jul 2021 18:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhG0Q6g (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jul 2021 12:58:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34944 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0Q6g (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jul 2021 12:58:36 -0400
Received: from [192.168.1.87] (unknown [223.178.63.20])
        by linux.microsoft.com (Postfix) with ESMTPSA id D8C6C20B36E0;
        Tue, 27 Jul 2021 09:58:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8C6C20B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1627405115;
        bh=hTo/XNh70TkhVEAJl3b1NTmwpe76n016drWCbwuCd5s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QPgA1Gccjwj8+go5MSvzJWAReY7TiVuQPVz+YCFVAlP+WnvkuXWI31D4a7qvmlE3d
         1z2lJALu6r/MvifUKEhREMHzjF6CIE217enRJqBoFOXmdtqOmVtd/1pD8xsU58Y78E
         3K31SFFJr69Hg9Vwh1Kw710hyQl3H5Djn/KOP2kE=
Subject: Re: [PATCH v3] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
References: <20210727104044.28078-1-kumarpraveen@linux.microsoft.com>
 <MWHPR21MB1593C1A51C6E812B0DA82ED5D7E99@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <87c3c57c-9ce7-f0f6-f698-23c823e3f817@linux.microsoft.com>
Date:   Tue, 27 Jul 2021 22:28:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593C1A51C6E812B0DA82ED5D7E99@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 27-07-2021 22:05, Michael Kelley wrote:
> From: Praveen Kumar <kumarpraveen@linux.microsoft.com> Sent: Tuesday, July 27, 2021 3:41 AM
>>
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
>> partition, we need to memremap the memory from hypervisor for root
>> kernel to use. The mapping is done in hv_cpu_init during bringup and
>> is unmaped in hv_cpu_die during teardown.
>>
>> Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/hv_init.c          | 61 +++++++++++++++++++++---------
>>  arch/x86/include/asm/hyperv-tlfs.h |  9 +++++
>>  2 files changed, 53 insertions(+), 17 deletions(-)
>>
>> changelog:
>> v1: initial patch
>> v2: commit message changes, removal of HV_MSR_APIC_ACCESS_AVAILABLE
>>     check and addition of null check before reading the VP assist MSR
>>     for root partition
>> v3: added new data structure to handle VP ASSIST MSR page and done
>>     handling in hv_cpu_init and hv_cpu_die
>>
>> ---
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 6f247e7e07eb..b859e42b4943 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -44,6 +44,7 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>>
>>  static int hv_cpu_init(unsigned int cpu)
>>  {
>> +	union hv_vp_assist_msr_contents msr;
>>  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>>  	int ret;
>>
>> @@ -54,27 +55,41 @@ static int hv_cpu_init(unsigned int cpu)
>>  	if (!hv_vp_assist_page)
>>  		return 0;
>>
>> -	/*
>> -	 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
>> -	 * 5.2.1 "GPA Overlay Pages"). Here it must be zeroed out to make sure
>> -	 * we always write the EOI MSR in hv_apic_eoi_write() *after* the
>> -	 * EOI optimization is disabled in hv_cpu_die(), otherwise a CPU may
>> -	 * not be stopped in the case of CPU offlining and the VM will hang.
>> -	 */
>> -	if (!*hvp) {
>> -		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
>> +	if (hv_root_partition) {
>> +		/*
>> +		 * For Root partition we get the hypervisor provided VP ASSIST
>> +		 * PAGE, instead of allocating a new page.
>> +		 */
>> +		rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>> +
>> +		/* remapping to root partition address space */
>> +		if (!*hvp)
>> +			*hvp = memremap(msr.guest_physical_address <<
>> +					HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
>> +					PAGE_SIZE, MEMREMAP_WB);
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
>> +
>>  	}
> 
> The tests here could be reversed to eliminate some duplication.  For example:
> 
> 	if(!*hvp) {
> 		if (hv_root_partition) {
> 			rdmsrl(....);
> 			*hvp = memremap( .....);
> 		} else {
> 			*hvp = __vmalloc(....);
> 		}
> 	}
> 
> 
Sure. Thanks.

>>
>> -	if (*hvp) {
>> -		u64 val;
>> +	WARN_ON(!(*hvp));
>>
>> -		val = vmalloc_to_pfn(*hvp);
>> -		val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
>> -			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
>> +	if (*hvp) {
>> +		if (!hv_root_partition)
>> +			msr.guest_physical_address = vmalloc_to_pfn(*hvp);
>>
>> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
>> +		msr.enable = 1;
>> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> 
> This version has a substantive difference compared with previous versions
> in that the "enable" bit is being set and written back to the MSR even when
> running in the root partition.  Is that intentional?
> 
Yes, we need to enable the same for root partition as well.

>>  	}
>> -
>>  	return 0;
>>  }
>>
>> @@ -170,9 +185,21 @@ static int hv_cpu_die(unsigned int cpu)
>>
>>  	hv_common_cpu_die(cpu);
>>
>> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> 
> This will set the guest_physical_address in the MSR to zero,
> even in the root partition case.  Is that OK?  It seems inconsistent
> with hv_cpu_init() where the existing guest_physical_address
> in the MSR is carefully preserved for the root partition case.
> Or is the intent here simply to clear the "enable" flag?
> 
>>
>> +		if (hv_root_partition) {
>> +			/*
>> +			 * For Root partition the VP ASSIST page is mapped to
>> +			 * hypervisor provided page, and thus, we unmap the
>> +			 * page here and nullify it, so that in future we have
>> +			 * correct page address mapped in hv_cpu_init
>> +			 */
>> +			memunmap(hv_vp_assist_page[cpu]);
>> +			hv_vp_assist_page[cpu] = NULL;
>> +		}
>> +	}
>> +
>>  	if (hv_reenlightenment_cb == NULL)
>>  		return 0;
>>
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> index f1366ce609e3..2e4e87046aa7 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -288,6 +288,15 @@ union hv_x64_msr_hypercall_contents {
>>  	} __packed;
>>  };
>>
>> +union hv_vp_assist_msr_contents {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 enable:1;
>> +		u64 reserved:11;
>> +		u64 guest_physical_address:52;
> 
> This field really should be named "guest_physical_page", as
> it is a page number, not an address.  You've matched the
> field names used in hv_x64_msr_hypercall_contents, which
> is good for consistency, except that the field name is
> wrong in hv_x64_msr_hypercall_contents. :-(   I think
> the Hyper-V TLFS originally called it a "physical address", but
> the TLFS has since been fixed to described it as a page number.
> I'd suggest getting this one named correctly; fixing the field
> name in hv_x64_msr_hypercall_contents is a separate cleanup
> that doesn't need to be done now.
> 
Sure. Will do it for this new data structure.

>> +	} __packed;
>> +};
>> +
>>  struct hv_reenlightenment_control {
>>  	__u64 vector:8;
>>  	__u64 reserved1:8;
>> --
>> 2.25.1

Regards,

~Praveen.
