Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508BB3CFA97
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbhGTMwQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 08:52:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41906 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbhGTMp0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 08:45:26 -0400
Received: from [192.168.1.87] (unknown [223.226.82.147])
        by linux.microsoft.com (Postfix) with ESMTPSA id A0BF320B7178;
        Tue, 20 Jul 2021 06:25:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0BF320B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626787563;
        bh=HqYX3T0bLKMA1kOobGvXqTaw/kXreirUcXiiHXC1dtM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JXX9cWoxR1tIJOMrAXGmV/7B0la7lFilZSLN6wWJ8jWadF8qDtVoFmlpHghwqlf9s
         U85h80Z12atlh8+ykuQH915IFr3u6jfUJMUgK0n7xWyJ4rHAIwCpXPmtojeRF+pQEj
         HoeIX32X5IUIStTm8vHPmK01v2JJK9SexNWdlLu8=
Subject: Re: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com
References: <20210719185126.3740-1-kumarpraveen@linux.microsoft.com>
 <20210720112011.7nxhiy6iyz4gz3j5@liuwe-devbox-debian-v2>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <fd70c8e5-f58c-640b-30b7-70c4e4a4861a@linux.microsoft.com>
Date:   Tue, 20 Jul 2021 18:55:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720112011.7nxhiy6iyz4gz3j5@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 20-07-2021 16:50, Wei Liu wrote:
> The commit message needs a bit of work.
> 
> On Tue, Jul 20, 2021 at 12:21:26AM +0530, Praveen Kumar wrote:
>> The root partition is not supposed to write to VP ASSIST PAGE as this MSR
>> is specific to Guest VP, and thus below stack is observed.
>>
> 
> Yes, root kernel is supposed to write to this MSR, but that's not
> because this MSR is specific to children (guest) partitions. It is just
> that for root this is read-only.
> 
> You should mention VP assist pages for root are pre-determined by the
> hypervisor. Root kernel is not allowed to change them to different
> locations.
> 
>> [    2.778197] unchecked MSR access error: WRMSR to 0x40000073 (tried to write 0x0000000145ac5001) at rIP: 0xffffffff810c1084 (native_write_msr+0x4/0x30)
>> [    2.784867] Call Trace:
>> [    2.791507]  hv_cpu_init+0xf1/0x1c0
>> [    2.798144]  ? hyperv_report_panic+0xd0/0xd0
>> [    2.804806]  cpuhp_invoke_callback+0x11a/0x440
>> [    2.811465]  ? hv_resume+0x90/0x90
>> [    2.818137]  cpuhp_issue_call+0x126/0x130
>> [    2.824782]  __cpuhp_setup_state_cpuslocked+0x102/0x2b0
>> [    2.831427]  ? hyperv_report_panic+0xd0/0xd0
>> [    2.838075]  ? hyperv_report_panic+0xd0/0xd0
>> [    2.844723]  ? hv_resume+0x90/0x90
>> [    2.851375]  __cpuhp_setup_state+0x3d/0x90
>> [    2.858030]  hyperv_init+0x14e/0x410
>> [    2.864689]  ? enable_IR_x2apic+0x190/0x1a0
>> [    2.871349]  apic_intr_mode_init+0x8b/0x100
>> [    2.878017]  x86_late_time_init+0x20/0x30
>> [    2.884675]  start_kernel+0x459/0x4fb
>> [    2.891329]  secondary_startup_64_no_verify+0xb0/0xbb
>>
>> Root partition actually shares the VP ASSIST page with hypervisor, and
> 
> So do children partitions. This page is by design shared between
> hypervisor and any partitions that use it.
> 

Sure, will send updated commit log with these information in V2


>> thus as a solution, this patch memremaps the memory from hypervisor
>> during hv_cpu_init and unmaps during hv_cpu_die calls.
>>
>> Further, this patch also resolve some error handling and checkpatch
>> errors
>>
>> Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/hv_init.c | 57 +++++++++++++++++++++++++++------------
>>  1 file changed, 40 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 6f247e7e07eb..292b17e0b173 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -44,7 +44,7 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>>  
>>  static int hv_cpu_init(unsigned int cpu)
>>  {
>> -	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>> +	struct hv_vp_assist_page **hvp = NULL;
>>  	int ret;
>>  
>>  	ret = hv_common_cpu_init(cpu);
>> @@ -54,25 +54,43 @@ static int hv_cpu_init(unsigned int cpu)
>>  	if (!hv_vp_assist_page)
>>  		return 0;
>>  
>> +	hvp = &hv_vp_assist_page[smp_processor_id()];
>> +
> 
> Why is this needed? Is it because of checkpatch?

I think this is not required.

> 
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
> 
> This path suggests that it is possible to enter this function with *hvp
> already set.
> 
> The new path for root is missing this check.

Will add similar check for root partition as well. thanks.

> 
>> +	if (hv_root_partition &&
>> +	    ms_hyperv.features & HV_MSR_APIC_ACCESS_AVAILABLE) {
> 
> Is HV_MSR_APIC_ACCESS_AVAILABLE a root only flag? Shouldn't non-root
> kernel check this too?

Yes, you are right. Will update this in v2. thanks.

> 
> Wei.
> 

Regards,

~Praveen.
