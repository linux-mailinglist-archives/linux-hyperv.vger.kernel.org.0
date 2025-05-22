Return-Path: <linux-hyperv+bounces-5622-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179FBAC14B2
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 May 2025 21:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E30A43226
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 May 2025 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6129AAF0;
	Thu, 22 May 2025 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ObupD0p2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37028935E;
	Thu, 22 May 2025 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747941353; cv=none; b=eBTAznDrOLY86An0S+2aGeMOLszPBP9jkV2eIpoeWorVF1W8J3x2rkfBbJhvKtlmAcR+c957SnnEP5D5XNbf1Xa3SZ+S8FW9EnuHImBUOHRcpltgbhUGf6NihmYGtAtWDBtkySgyFGm7OexzNW0JAAgkR2S0KTvfRPms6JRKan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747941353; c=relaxed/simple;
	bh=GeUTFubYGR9tERUru+P0xo72+eP5xymBlpugZRq82wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgfJ+HhRt4wVkd9J9NhPxYt46jw71SB2HRbVkepLK5WeUS/C4C5rKOiOrswIr9Yl3blJ2WoqB2Of1JSh1ZkzfTzX3JZwxUBLXRkiSv0onU7G0Cx0bp8do89mvrBTMO90kLEz6EVlgunchihxmGNxY3qQAGzdr5fjdI/bio5mYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ObupD0p2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.193.116] (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1C3EC211CFAF;
	Thu, 22 May 2025 12:15:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C3EC211CFAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747941351;
	bh=VrjTp2U07OaxhZSrf6Ej4k5iw0cZ5M+pfupIHSeAQ5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ObupD0p2uFUgV123q3D/GflP5U4y6F3sFzC4gX6AB4KnfqF5Fef+7DBm9oVAu7Eo/
	 OpbYEh+qBMGy7l2P8WxXRAnDCbpXIPLYiU/9fYBY/9A2GHQspRJJ8oXXun6jTFHHh3
	 v/Lc/EPV0o0HCWJ5E58V1XqzHTzUgLmKqtpyvXfU=
Message-ID: <9986fbe1-d9fa-4e52-ad8e-da424e2f83f3@linux.microsoft.com>
Date: Thu, 22 May 2025 12:15:50 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Naman Jain <namjain@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20250519045642.50609-1-namjain@linux.microsoft.com>
 <20250519045642.50609-3-namjain@linux.microsoft.com>
 <aCzQMuwQZ1Lkk7eH@skinsburskii.>
 <80853cdb-fd34-4a5e-99a0-1a71b8ce8226@linux.microsoft.com>
 <3ab2597b-3a64-497c-888e-dd5d0c0e5076@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <3ab2597b-3a64-497c-888e-dd5d0c0e5076@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/21/2025 2:32 AM, Naman Jain wrote:
> 
> 
> On 5/21/2025 11:33 AM, Naman Jain wrote:
>>
>>
>> On 5/21/2025 12:25 AM, Stanislav Kinsburskii wrote:
>>> On Mon, May 19, 2025 at 10:26:42AM +0530, Naman Jain wrote:
>>>> Provide an interface for Virtual Machine Monitor like OpenVMM and its
>>>> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
>>>> Expose devices and support IOCTLs for features like VTL creation,
>>>> VTL0 memory management, context switch, making hypercalls,
>>>> mapping VTL0 address space to VTL2 userspace, getting new VMBus
>>>> messages and channel events in VTL2 etc.
>>>>
>>>> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
>>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>>> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
>>>> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>>>> Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>
>>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>>>> ---
>>>>   drivers/hv/Kconfig          |   20 +
>>>>   drivers/hv/Makefile         |    7 +-
>>>>   drivers/hv/mshv_vtl.h       |   52 +
>>>>   drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
>>>>   include/hyperv/hvgdk_mini.h |   81 ++
>>>>   include/hyperv/hvhdk.h      |    1 +
>>>>   include/uapi/linux/mshv.h   |   82 ++
>>>>   7 files changed, 2025 insertions(+), 1 deletion(-)
>>>>   create mode 100644 drivers/hv/mshv_vtl.h
>>>>   create mode 100644 drivers/hv/mshv_vtl_main.c
>>>>
>>>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>>>> index eefa0b559b73..21cee5564d70 100644
>>>> --- a/drivers/hv/Kconfig
>>>> +++ b/drivers/hv/Kconfig
>>>> @@ -72,4 +72,24 @@ config MSHV_ROOT
>>>>         If unsure, say N.
>>>> +config MSHV_VTL
>>>> +    tristate "Microsoft Hyper-V VTL driver"
>>>> +    depends on HYPERV && X86_64
>>>> +    depends on TRANSPARENT_HUGEPAGE
>>>
>>> Why does it depend on TRANSPARENT_HUGEPAGE?
>>>
>>
>> Thanks for reviewing. This config is required for below functions which
>> are used for mshv_vtl_low device.
>>
>> vm_fault_t mshv_vtl_low_huge_fault ->
>> * vmf_insert_pfn_pmd
>> * vmf_insert_pfn_pud
>>
>>
>>> <snip>
>>>
>>>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>>>> index 1be7f6a02304..cc11000e39f4 100644
>>>> --- a/include/hyperv/hvgdk_mini.h
>>>> +++ b/include/hyperv/hvgdk_mini.h
>>>> @@ -882,6 +882,23 @@ struct hv_get_vp_from_apic_id_in {
>>>>       u32 apic_ids[];
>>>>   } __packed;
>>>> +union hv_register_vsm_partition_config {
>>>> +    __u64 as_u64;
>>>
>>> Please, follow the file pattern: as_u64 -> as_uint64
>>>
>>>> +    struct {
>>>> +        __u64 enable_vtl_protection : 1;
>>>
>>> Ditto: __u64 -> u64
>>>
>>>> +        __u64 default_vtl_protection_mask : 4;
>>>> +        __u64 zero_memory_on_reset : 1;
>>>> +        __u64 deny_lower_vtl_startup : 1;
>>>> +        __u64 intercept_acceptance : 1;
>>>> +        __u64 intercept_enable_vtl_protection : 1;
>>>> +        __u64 intercept_vp_startup : 1;
>>>> +        __u64 intercept_cpuid_unimplemented : 1;
>>>> +        __u64 intercept_unrecoverable_exception : 1;
>>>> +        __u64 intercept_page : 1;
>>>> +        __u64 mbz : 51;
>>>> +    };
>>>> +};
>>>> +
>>>>   /*
>>>> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
>>>> index b4067ada02cf..9b890126e8e8 100644
>>>> --- a/include/hyperv/hvhdk.h
>>>> +++ b/include/hyperv/hvhdk.h
>>>> @@ -479,6 +479,7 @@ struct hv_connection_info {
>>>>   #define HV_EVENT_FLAGS_COUNT        (256 * 8)
>>>>   #define HV_EVENT_FLAGS_BYTE_COUNT    (256)
>>>>   #define HV_EVENT_FLAGS32_COUNT        (256 / sizeof(u32))
>>>> +#define HV_EVENT_FLAGS_LONG_COUNT    (HV_EVENT_FLAGS_BYTE_COUNT / sizeof(__u64))
>>>
>>> Ditto
>>>
>>>>   /* linux side we create long version of flags to use long bit ops on flags */
>>>>   #define HV_EVENT_FLAGS_UL_COUNT        (256 / sizeof(ulong))
>>>> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
>>>> index 876bfe4e4227..a8c39b08b39a 100644
>>>> --- a/include/uapi/linux/mshv.h
>>>> +++ b/include/uapi/linux/mshv.h
>>>> @@ -288,4 +288,86 @@ struct mshv_get_set_vp_state {
>>>>    * #define MSHV_ROOT_HVCALL            _IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
>>>>    */
>>>> +/* Structure definitions, macros and IOCTLs for mshv_vtl */
>>>> +
>>>> +#define MSHV_CAP_CORE_API_STABLE        0x0
>>>> +#define MSHV_CAP_REGISTER_PAGE          0x1
>>>> +#define MSHV_CAP_VTL_RETURN_ACTION      0x2
>>>> +#define MSHV_CAP_DR6_SHARED             0x3
>>>> +#define MSHV_MAX_RUN_MSG_SIZE                256
>>>> +
>>>> +#define MSHV_VP_MAX_REGISTERS   128
>>>> +
>>>> +struct mshv_vp_registers {
>>>> +    __u32 count;    /* at most MSHV_VP_MAX_REGISTERS */
>>>
>>> Same here: __u{32,64} -> u{32,64}.
>>>
>>> Please, address everywhere.
>>>
>>
>> I'll take care of all of these in my next patch.
>>
> 
> 
> One concern about this change in include/uapi/linux/mshv.h.
> I see the convention of using '__' family of data types in this file.
> Whatever we do here, will be applicable to existing code as well.
> Do you suggest we should change it to u{32,64} variants or keep
> it in current form?
> 

uapi code uses the '__' versions of these types, so they should stay
as they are.

Thanks
Nuno

> Regards,
> Naman
> 
>>> <snip>
>>>
>>>> +
>>>> +/* vtl device */
>>>> +#define MSHV_CREATE_VTL            _IOR(MSHV_IOCTL, 0x1D, char)
>>>> +#define MSHV_VTL_ADD_VTL0_MEMORY    _IOW(MSHV_IOCTL, 0x21, struct mshv_vtl_ram_disposition)
>>>> +#define MSHV_VTL_SET_POLL_FILE        _IOW(MSHV_IOCTL, 0x25, struct mshv_vtl_set_poll_file)
>>>> +#define MSHV_VTL_RETURN_TO_LOWER_VTL    _IO(MSHV_IOCTL, 0x27)
>>>> +#define MSHV_GET_VP_REGISTERS        _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
>>>> +#define MSHV_SET_VP_REGISTERS        _IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
>>>> +
>>>> +/* VMBus device IOCTLs */
>>>> +#define MSHV_SINT_SIGNAL_EVENT    _IOW(MSHV_IOCTL, 0x22, struct mshv_vtl_signal_event)
>>>> +#define MSHV_SINT_POST_MESSAGE    _IOW(MSHV_IOCTL, 0x23, struct mshv_vtl_sint_post_msg)
>>>> +#define MSHV_SINT_SET_EVENTFD     _IOW(MSHV_IOCTL, 0x24, struct mshv_vtl_set_eventfd)
>>>> +#define MSHV_SINT_PAUSE_MESSAGE_STREAM     _IOW(MSHV_IOCTL, 0x25, struct mshv_sint_mask)
>>>> +
>>>> +/* hv_hvcall device */
>>>> +#define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
>>>> +#define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
>>>
>>> How many of these ioctls are actually used by the mshv root driver?
>>> Should those which are VTl-specific be named as such (like MSHV_VTL_SET_POLL_FILE)?
>>> Another option would be to keep all the names generic.
>>>
>>> Thanks,
>>> Stanislav
>>
>> None of the IOCTLs in mshv_vtl section, introduced in this patch is used
>> by mshv_root driver. Since IOCTLs of mshv_root does not have MSHV_ROOT
>> prefix, I am OK with removing MSHV_VTL_* prefix from these IOCTL names.
>> You can let me know if you want me to prefix them with MSHV_VTL.
>>
>> Thanks again for reviewing.
>>
>> Regards,
>> Naman
>>
>>>
>>>>   #endif
>>>> -- 
>>>> 2.34.1
>>>>
>>


