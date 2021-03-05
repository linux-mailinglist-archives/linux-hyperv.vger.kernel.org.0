Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB4E32F509
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Mar 2021 22:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCEVB5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Mar 2021 16:01:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35106 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhCEVBh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Mar 2021 16:01:37 -0500
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2204D20B83EA;
        Fri,  5 Mar 2021 13:01:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2204D20B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614978097;
        bh=5IxUztsfBcIEdkt3OwxV347fI4KVp1/nTWkd9i9MPjY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UMNXVugEceMZymafNYwUNaNmiKFHiVCkaatsj/z5UCZN7+3Str5918/PGActoIveh
         cqHuzdTPIvNhkHlumgKSeYfIo4s8cMv8BJATpYPgdqcytl+vkftpjfXvSXXlTaMwUd
         jASUqo/ykA2ZAF7c2e+hwcIdUZdyGKPUURrPuZI0=
Subject: Re: [RFC PATCH 07/18] virt/mshv: withdraw memory hypercall
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-8-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB159305DE956E80D2B45ABA85D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <0044d83d-e207-50d4-ce71-00d605c6ea7c@linux.microsoft.com>
Date:   Fri, 5 Mar 2021 13:01:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB159305DE956E80D2B45ABA85D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/8/2021 11:44 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November 20, 2020 4:30 PM
>>
>> Withdraw the memory from a finalized partition and free the pages.
>> The partition is now cleaned up correctly when the fd is released.
>>
>> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  include/asm-generic/hyperv-tlfs.h | 10 ++++++
>>  virt/mshv/mshv_main.c             | 54 ++++++++++++++++++++++++++++++-
>>  2 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
>> index ab6ae6c164f5..2a49503b7396 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -148,6 +148,7 @@ struct ms_hyperv_tsc_page {
>>  #define HVCALL_DELETE_PARTITION			0x0043
>>  #define HVCALL_GET_PARTITION_ID			0x0046
>>  #define HVCALL_DEPOSIT_MEMORY			0x0048
>> +#define HVCALL_WITHDRAW_MEMORY			0x0049
>>  #define HVCALL_CREATE_VP			0x004e
>>  #define HVCALL_GET_VP_REGISTERS			0x0050
>>  #define HVCALL_SET_VP_REGISTERS			0x0051
>> @@ -472,6 +473,15 @@ union hv_proximity_domain_info {
>>  	u64 as_uint64;
>>  };
>>
>> +struct hv_withdraw_memory_in {
>> +	u64 partition_id;
>> +	union hv_proximity_domain_info proximity_domain_info;
>> +};
>> +
>> +struct hv_withdraw_memory_out {
>> +	u64 gpa_page_list[0];
> 
> For a variable size array, the Linux kernel community has an effort
> underway to replace occurrences of [0] and [1] with just [].  I think
> [] can be used here.
> 

It seems the compiler doesn't like that, because there's no other members in the struct?

./include/asm-generic/hyperv-tlfs.h:452:6: error: flexible array member in a struct with no named members
  452 |  u64 gpa_page_list[];

I'll add a comment explaining that it's a hack to work around the compiler.

>> +};
>> +
> 
> Add __packed to the above two structs.
> 

Will do.

>>  struct hv_lp_startup_status {
>>  	u64 hv_status;
>>  	u64 substatus1;
>> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
>> index c4130a6508e5..162a1bb42a4a 100644
>> --- a/virt/mshv/mshv_main.c
>> +++ b/virt/mshv/mshv_main.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/file.h>
>>  #include <linux/anon_inodes.h>
>> +#include <linux/mm.h>
>>  #include <linux/mshv.h>
>>  #include <asm/mshyperv.h>
>>
>> @@ -57,8 +58,58 @@ static struct miscdevice mshv_dev = {
>>  	.mode = 600,
>>  };
>>
>> +#define HV_WITHDRAW_BATCH_SIZE	(PAGE_SIZE / sizeof(u64))
> 
> Use HV_HYP_PAGE_SIZE so that we're explicit that the dependency
> is on the page size used by Hyper-V, which might be different from the
> guest page size (at least on architectures like ARM64).
> 

Yes, will do.

>>  #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
>>
>> +static int
>> +hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
>> +{
>> +	struct hv_withdraw_memory_in *input_page;
>> +	struct hv_withdraw_memory_out *output_page;
>> +	u16 completed;
>> +	u64 hypercall_status;
>> +	unsigned long remaining = count;
>> +	int status;
>> +	int i;
>> +	unsigned long flags;
>> +
>> +	while (remaining) {
>> +		local_irq_save(flags);
>> +
>> +		input_page = (struct hv_withdraw_memory_in *)(*this_cpu_ptr(
>> +			hyperv_pcpu_input_arg));
>> +		output_page = (struct hv_withdraw_memory_out *)(*this_cpu_ptr(
>> +			hyperv_pcpu_output_arg));
>> +
>> +		input_page->partition_id = partition_id;
>> +		input_page->proximity_domain_info.as_uint64 = 0;
>> +		hypercall_status = hv_do_rep_hypercall(
>> +			HVCALL_WITHDRAW_MEMORY,
>> +			min(remaining, HV_WITHDRAW_BATCH_SIZE), 0, input_page,
>> +			output_page);
>> +
>> +		completed = (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
>> +			    HV_HYPERCALL_REP_COMP_OFFSET;
>> +
>> +		for (i = 0; i < completed; i++)
>> +			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
>> +
>> +		local_irq_restore(flags);
> 
> Seems like there's some risk that we have interrupts disabled for too long.
> We could be calling __free_page() up to 512 times.  It might be better for this
> function to allocate its own page to be used as the output page, so that interrupts
> can be enabled immediately after the hypercall completes.  Then the __free_page()
> loop can execute with interrupts enabled.   We have the per-cpu input and output
> pages to avoid the overhead of allocating/freeing pages for each hypercall, but in this
> case a private output page might be warranted.
> 

Good idea, I'll do that.

>> +
>> +		status = hypercall_status & HV_HYPERCALL_RESULT_MASK;
>> +		if (status != HV_STATUS_SUCCESS) {
>> +			if (status != HV_STATUS_NO_RESOURCES)
>> +				pr_err("%s: %s\n", __func__,
>> +				       hv_status_to_string(status));
>> +			break;
>> +		}
>> +
>> +		remaining -= completed;
>> +	}
>> +
>> +	return -hv_status_to_errno(status);
>> +}
>> +
>>  static int
>>  hv_call_create_partition(
>>  		u64 flags,
>> @@ -230,7 +281,8 @@ destroy_partition(struct mshv_partition *partition)
>>
>>  	/* Deallocates and unmaps everything including vcpus, GPA mappings etc */
>>  	hv_call_finalize_partition(partition->id);
>> -	/* TODO: Withdraw and free all pages we deposited */
>> +	/* Withdraw and free all pages we deposited */
>> +	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->id);
>>
>>  	hv_call_delete_partition(partition->id);
>>
>> --
>> 2.25.1
