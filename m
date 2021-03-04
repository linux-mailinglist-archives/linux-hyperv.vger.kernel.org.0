Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12232D964
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Mar 2021 19:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhCDSZQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Mar 2021 13:25:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33452 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhCDSYv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Mar 2021 13:24:51 -0500
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id DD34120B83EA;
        Thu,  4 Mar 2021 10:24:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD34120B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614882251;
        bh=ynKto1RG0dL+YYFYClojs4qYol2ZvGeOMIWzdVDe7yE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MdQDDbTKTdzR/UdFeJLZAVvg5Lc1FDo304Wkdg0OZkGeTb8giRhWaro95Rf6QOdfA
         tnO2at0WFncfbRtFfBOiHQ7IRDJpsaDnmmCEp23b5cIzw5pFKV0E8UlGNJ7Z5kThBy
         MuefZeYMhm+arjUnGA2PYlmIyFzsKe+XVIV3aWhM=
Subject: Re: [RFC PATCH 01/18] x86/hyperv: convert hyperv statuses to linux
 error codes
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-2-git-send-email-nunodasneves@linux.microsoft.com>
 <871rdpo0is.fsf@vitty.brq.redhat.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <6bc7d41d-2dfc-39ae-6508-b85a78e8e7fa@linux.microsoft.com>
Date:   Thu, 4 Mar 2021 10:24:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <871rdpo0is.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/9/2021 5:04 AM, Vitaly Kuznetsov wrote:
> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
> 
>> Return linux-friendly error codes from hypercall wrapper functions.
>> This will be needed in the mshv module.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/hv_proc.c         | 30 ++++++++++++++++++++++++++---
>>  arch/x86/include/asm/mshyperv.h   |  1 +
>>  include/asm-generic/hyperv-tlfs.h | 32 +++++++++++++++++++++----------
>>  3 files changed, 50 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
>> index 0fd972c9129a..8f86f8e86748 100644
>> --- a/arch/x86/hyperv/hv_proc.c
>> +++ b/arch/x86/hyperv/hv_proc.c
>> @@ -18,6 +18,30 @@
>>  #define HV_DEPOSIT_MAX_ORDER (8)
>>  #define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
>>  
>> +int hv_status_to_errno(int hv_status)
>> +{
>> +	switch (hv_status) {
>> +	case HV_STATUS_SUCCESS:
>> +		return 0;
>> +	case HV_STATUS_INVALID_PARAMETER:
>> +	case HV_STATUS_UNKNOWN_PROPERTY:
>> +	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
>> +	case HV_STATUS_INVALID_VP_INDEX:
>> +	case HV_STATUS_INVALID_REGISTER_VALUE:
>> +	case HV_STATUS_INVALID_LP_INDEX:
>> +		return EINVAL;
>> +	case HV_STATUS_ACCESS_DENIED:
>> +	case HV_STATUS_OPERATION_DENIED:
>> +		return EACCES;
>> +	case HV_STATUS_NOT_ACKNOWLEDGED:
>> +	case HV_STATUS_INVALID_VP_STATE:
>> +	case HV_STATUS_INVALID_PARTITION_STATE:
>> +		return EBADFD;
>> +	}
>> +	return ENOTRECOVERABLE;
>> +}
>> +EXPORT_SYMBOL_GPL(hv_status_to_errno);
>> +
>>  /*
>>   * Deposits exact number of pages
>>   * Must be called with interrupts enabled
>> @@ -99,7 +123,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>  
>>  	if (status != HV_STATUS_SUCCESS) {
>>  		pr_err("Failed to deposit pages: %d\n", status);
>> -		ret = status;
>> +		ret = -hv_status_to_errno(status);
> 
> "-hv_status_to_errno" looks weird, could we just return
> '-EINVAL'/'-EACCES'/... from hv_status_to_errno() instead?
> 

Yes, good idea.

>>  		goto err_free_allocations;
>>  	}
>>  
>> @@ -155,7 +179,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>>  			if (status != HV_STATUS_SUCCESS) {
>>  				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
>>  				       lp_index, apic_id, status);
>> -				ret = status;
>> +				ret = -hv_status_to_errno(status);
>>  			}
>>  			break;
>>  		}
>> @@ -203,7 +227,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>>  			if (status != HV_STATUS_SUCCESS) {
>>  				pr_err("%s: vcpu %u, lp %u, %d\n", __func__,
>>  				       vp_index, flags, status);
>> -				ret = status;
>> +				ret = -hv_status_to_errno(status);
>>  			}
>>  			break;
>>  		}
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index cbee72550a12..eb75faa4d4c5 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -243,6 +243,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
>>  int hyperv_fill_flush_guest_mapping_list(
>>  		struct hv_guest_mapping_flush_list *flush,
>>  		u64 start_gfn, u64 end_gfn);
>> +int hv_status_to_errno(int hv_status);
>>  
>>  extern bool hv_root_partition;
>>  
>> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
>> index dd385c6a71b5..445244192fa4 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -181,16 +181,28 @@ enum HV_GENERIC_SET_FORMAT {
>>  #define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
>>  
>>  /* hypercall status code */
>> -#define HV_STATUS_SUCCESS			0
>> -#define HV_STATUS_INVALID_HYPERCALL_CODE	2
>> -#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
>> -#define HV_STATUS_INVALID_ALIGNMENT		4
>> -#define HV_STATUS_INVALID_PARAMETER		5
>> -#define HV_STATUS_OPERATION_DENIED		8
>> -#define HV_STATUS_INSUFFICIENT_MEMORY		11
>> -#define HV_STATUS_INVALID_PORT_ID		17
>> -#define HV_STATUS_INVALID_CONNECTION_ID		18
>> -#define HV_STATUS_INSUFFICIENT_BUFFERS		19
>> +#define HV_STATUS_SUCCESS			0x0
>> +#define HV_STATUS_INVALID_HYPERCALL_CODE	0x2
>> +#define HV_STATUS_INVALID_HYPERCALL_INPUT	0x3
>> +#define HV_STATUS_INVALID_ALIGNMENT		0x4
>> +#define HV_STATUS_INVALID_PARAMETER		0x5
>> +#define HV_STATUS_ACCESS_DENIED			0x6
>> +#define HV_STATUS_INVALID_PARTITION_STATE	0x7
>> +#define HV_STATUS_OPERATION_DENIED		0x8
>> +#define HV_STATUS_UNKNOWN_PROPERTY		0x9
>> +#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	0xA
>> +#define HV_STATUS_INSUFFICIENT_MEMORY		0xB
>> +#define HV_STATUS_INVALID_PARTITION_ID		0xD
>> +#define HV_STATUS_INVALID_VP_INDEX		0xE
>> +#define HV_STATUS_NOT_FOUND			0x10
>> +#define HV_STATUS_INVALID_PORT_ID		0x11
>> +#define HV_STATUS_INVALID_CONNECTION_ID		0x12
>> +#define HV_STATUS_INSUFFICIENT_BUFFERS		0x13
>> +#define HV_STATUS_NOT_ACKNOWLEDGED		0x14
>> +#define HV_STATUS_INVALID_VP_STATE		0x15
>> +#define HV_STATUS_NO_RESOURCES			0x1D
>> +#define HV_STATUS_INVALID_LP_INDEX		0x41
>> +#define HV_STATUS_INVALID_REGISTER_VALUE	0x50
>>  
>>  /*
>>   * The Hyper-V TimeRefCount register and the TSC
> 
