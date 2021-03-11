Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4D337E45
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Mar 2021 20:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCKThu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 11 Mar 2021 14:37:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48128 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhCKThf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 Mar 2021 14:37:35 -0500
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id EFBFA20B39C5;
        Thu, 11 Mar 2021 11:37:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFBFA20B39C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1615491455;
        bh=v1vwp9aAXvB1rus+cWmXyPwWJTloF491LASSdvpbK+I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VgXbiklhQ8N+9K3KG1tcMVG6pSErveiwyCkDrjMOGJeBZUrOv0D3A5xNoxtLls6Z0
         G3124n/Su+Z5ZRfvSD9PvN0KLK/ESWUa9S1BgXBN46HCxlD/AgF2i0BGYH4P+iPQrl
         TsUHyHS7zVnQFW0lTbmyWBduli1qYa8OeU3bFvgQ=
Subject: Re: [RFC PATCH 11/18] virt/mshv: set up synic pages for intercept
 messages
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
 <1605918637-12192-12-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB1593EC8F1ACA57299AB5016AD78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <9e06a119-880f-5199-903b-056675331d6f@linux.microsoft.com>
Date:   Thu, 11 Mar 2021 11:37:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593EC8F1ACA57299AB5016AD78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 2/8/2021 11:47 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November 20, 2020 4:31 PM
>>
>> Same idea as synic setup in drivers/hv/hv.c:hv_synic_enable_regs()
>> and hv_synic_disable_regs().
>> Setting up synic registers in both vmbus driver and mshv would clobber
>> them, but the vmbus driver will not run in the root partition, so this
>> is safe.
>>
>> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  arch/x86/include/asm/hyperv-tlfs.h      |  29 ---
>>  arch/x86/include/uapi/asm/hyperv-tlfs.h | 264 ++++++++++++++++++++++++
>>  include/asm-generic/hyperv-tlfs.h       |  46 +----
>>  include/linux/mshv.h                    |   1 +
>>  include/uapi/asm-generic/hyperv-tlfs.h  |  43 ++++
>>  virt/mshv/mshv_main.c                   |  98 ++++++++-
>>  6 files changed, 404 insertions(+), 77 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> index 4cd44ae9bffb..c34a6bb4f457 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -267,35 +267,6 @@ struct hv_tsc_emulation_status {
>>  #define HV_X64_MSR_TSC_REFERENCE_ENABLE		0x00000001
>>  #define HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT	12
>>
>> -
>> -/* Define hypervisor message types. */
>> -enum hv_message_type {
>> -	HVMSG_NONE			= 0x00000000,
>> -
>> -	/* Memory access messages. */
>> -	HVMSG_UNMAPPED_GPA		= 0x80000000,
>> -	HVMSG_GPA_INTERCEPT		= 0x80000001,
>> -
>> -	/* Timer notification messages. */
>> -	HVMSG_TIMER_EXPIRED		= 0x80000010,
>> -
>> -	/* Error messages. */
>> -	HVMSG_INVALID_VP_REGISTER_VALUE	= 0x80000020,
>> -	HVMSG_UNRECOVERABLE_EXCEPTION	= 0x80000021,
>> -	HVMSG_UNSUPPORTED_FEATURE	= 0x80000022,
>> -
>> -	/* Trace buffer complete messages. */
>> -	HVMSG_EVENTLOG_BUFFERCOMPLETE	= 0x80000040,
>> -
>> -	/* Platform-specific processor intercept messages. */
>> -	HVMSG_X64_IOPORT_INTERCEPT	= 0x80010000,
>> -	HVMSG_X64_MSR_INTERCEPT		= 0x80010001,
>> -	HVMSG_X64_CPUID_INTERCEPT	= 0x80010002,
>> -	HVMSG_X64_EXCEPTION_INTERCEPT	= 0x80010003,
>> -	HVMSG_X64_APIC_EOI		= 0x80010004,
>> -	HVMSG_X64_LEGACY_FP_ERROR	= 0x80010005
>> -};
>> -
>>  struct hv_nested_enlightenments_control {
>>  	struct {
>>  		__u32 directhypercall:1;
>> diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-
>> tlfs.h
>> index 2ff655962738..c6a27053f791 100644
>> --- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> @@ -722,4 +722,268 @@ union hv_register_value {
>>  		pending_virtualization_fault_event;
>>  };
>>
>> +/* Define hypervisor message types. */
>> +enum hv_message_type {
>> +	HVMSG_NONE				= 0x00000000,
>> +
>> +	/* Memory access messages. */
>> +	HVMSG_UNMAPPED_GPA			= 0x80000000,
>> +	HVMSG_GPA_INTERCEPT			= 0x80000001,
>> +
>> +	/* Timer notification messages. */
>> +	HVMSG_TIMER_EXPIRED			= 0x80000010,
>> +
>> +	/* Error messages. */
>> +	HVMSG_INVALID_VP_REGISTER_VALUE		= 0x80000020,
>> +	HVMSG_UNRECOVERABLE_EXCEPTION		= 0x80000021,
>> +	HVMSG_UNSUPPORTED_FEATURE		= 0x80000022,
>> +
>> +	/* Trace buffer complete messages. */
>> +	HVMSG_EVENTLOG_BUFFERCOMPLETE		= 0x80000040,
>> +
>> +	/* Platform-specific processor intercept messages. */
>> +	HVMSG_X64_IO_PORT_INTERCEPT		= 0x80010000,
>> +	HVMSG_X64_MSR_INTERCEPT			= 0x80010001,
>> +	HVMSG_X64_CPUID_INTERCEPT		= 0x80010002,
>> +	HVMSG_X64_EXCEPTION_INTERCEPT		= 0x80010003,
>> +	HVMSG_X64_APIC_EOI			= 0x80010004,
>> +	HVMSG_X64_LEGACY_FP_ERROR		= 0x80010005,
>> +	HVMSG_X64_IOMMU_PRQ			= 0x80010006,
>> +	HVMSG_X64_HALT				= 0x80010007,
>> +	HVMSG_X64_INTERRUPTION_DELIVERABLE	= 0x80010008,
>> +	HVMSG_X64_SIPI_INTERCEPT		= 0x80010009,
>> +};
> 
> I have a separate patch series that moves this enum to the
> asm-generic portion of hyperv-tlfs.h because there's not a good way
> to separate the arch neutral from arch dependent values.
> 

Ok, but it should also be changed to #define instead of an enum, right?
I will do that in this patch.
This requires a couple of changes in other files in drivers/hv
where this enum is used.

>> +
>> +
>> +union hv_x64_vp_execution_state {
>> +	__u16 as_uint16;
>> +	struct {
>> +		__u16 cpl:2;
>> +		__u16 cr0_pe:1;
>> +		__u16 cr0_am:1;
>> +		__u16 efer_lma:1;
>> +		__u16 debug_active:1;
>> +		__u16 interruption_pending:1;
>> +		__u16 vtl:4;
>> +		__u16 enclave_mode:1;
>> +		__u16 interrupt_shadow:1;
>> +		__u16 virtualization_fault_active:1;
>> +		__u16 reserved:2;
>> +	};
>> +};
>> +
>> +/* Values for intercept_access_type field */
>> +#define HV_INTERCEPT_ACCESS_READ	0
>> +#define HV_INTERCEPT_ACCESS_WRITE	1
>> +#define HV_INTERCEPT_ACCESS_EXECUTE	2
>> +
>> +struct hv_x64_intercept_message_header {
>> +	__u32 vp_index;
>> +	__u8 instruction_length:4;
>> +	__u8 cr8:4; // only set for exo partitions
>> +	__u8 intercept_access_type;
>> +	union hv_x64_vp_execution_state execution_state;
>> +	struct hv_x64_segment_register cs_segment;
>> +	__u64 rip;
>> +	__u64 rflags;
>> +};
>> +
>> +#define HV_HYPERCALL_INTERCEPT_MAX_XMM_REGISTERS 6
>> +
>> +struct hv_x64_hypercall_intercept_message {
>> +	struct hv_x64_intercept_message_header header;
>> +	__u64 rax;
>> +	__u64 rbx;
>> +	__u64 rcx;
>> +	__u64 rdx;
>> +	__u64 r8;
>> +	__u64 rsi;
>> +	__u64 rdi;
>> +	struct hv_u128 xmmregisters[HV_HYPERCALL_INTERCEPT_MAX_XMM_REGISTERS];
>> +	struct {
>> +		__u32 isolated:1;
>> +		__u32 reserved:31;
>> +	};
>> +};
>> +
>> +union hv_x64_register_access_info {
>> +	union hv_register_value source_value;
>> +	enum hv_register_name destination_register;
>> +	__u64 source_address;
>> +	__u64 destination_address;
>> +};
>> +
>> +struct hv_x64_register_intercept_message {
>> +	struct hv_x64_intercept_message_header header;
>> +	struct {
>> +		__u8 is_memory_op:1;
>> +		__u8 reserved:7;
>> +	};
>> +	__u8 reserved8;
>> +	__u16 reserved16;
>> +	enum hv_register_name register_name;
>> +	union hv_x64_register_access_info access_info;
>> +};
>> +
>> +union hv_x64_memory_access_info {
>> +	__u8 as_uint8;
>> +	struct {
>> +		__u8 gva_valid:1;
>> +		__u8 gva_gpa_valid:1;
>> +		__u8 hypercall_output_pending:1;
>> +		__u8 tlb_locked_no_overlay:1;
>> +		__u8 reserved:4;
>> +	};
>> +};
>> +
>> +union hv_x64_io_port_access_info {
>> +	__u8 as_uint8;
>> +	struct {
>> +		__u8 access_size:3;
>> +		__u8 string_op:1;
>> +		__u8 rep_prefix:1;
>> +		__u8 reserved:3;
>> +	};
>> +};
>> +
>> +union hv_x64_exception_info {
>> +	__u8 as_uint8;
>> +	struct {
>> +		__u8 error_code_valid:1;
>> +		__u8 software_exception:1;
>> +		__u8 reserved:6;
>> +	};
>> +};
>> +
>> +enum hv_cache_type {
>> +	HV_CACHE_TYPE_UNCACHED	   = 0,
>> +	HV_CACHE_TYPE_WRITE_COMBINING = 1,
>> +	HV_CACHE_TYPE_WRITE_THROUGH   = 4,
>> +	HV_CACHE_TYPE_WRITE_PROTECTED = 5,
>> +	HV_CACHE_TYPE_WRITE_BACK	  = 6
>> +};
>> +
>> +struct hv_x64_memory_intercept_message {
>> +	struct hv_x64_intercept_message_header header;
>> +	enum hv_cache_type cache_type;
>> +	__u8 instruction_byte_count;
>> +	union hv_x64_memory_access_info memory_access_info;
>> +	__u8 tpr_priority;
>> +	__u8 reserved1;
>> +	__u64 guest_virtual_address;
>> +	__u64 guest_physical_address;
>> +	__u8 instruction_bytes[16];
>> +};
>> +
>> +struct hv_x64_cpuid_intercept_message {
>> +	struct hv_x64_intercept_message_header header;
>> +	__u64 rax;
>> +	__u64 rcx;
>> +	__u64 rdx;
>> +	__u64 rbx;
>> +	__u64 default_result_rax;
>> +	__u64 default_result_rcx;
>> +	__u64 default_result_rdx;
>> +	__u64 default_result_rbx;
>> +};
>> +
>> +struct hv_x64_msr_intercept_message {
>> +	struct hv_x64_intercept_message_header header;
>> +	__u32 msr_number;
>> +	__u32 reserved;
>> +	__u64 rdx;
>> +	__u64 rax;
>> +};
>> +
>> +struct hv_x64_io_port_intercept_message {
>> +	struct hv_x64_intercept_message_header header;
>> +	__u16 port_number;
>> +	union hv_x64_io_port_access_info access_info;
>> +	__u8 instruction_byte_count;
>> +	__u32 reserved;
>> +	__u64 rax;
>> +	__u8 instruction_bytes[16];
>> +	struct hv_x64_segment_register ds_segment;
>> +	struct hv_x64_segment_register es_segment;
>> +	__u64 rcx;
>> +	__u64 rsi;
>> +	__u64 rdi;
>> +};
>> +
>> +struct hv_x64_exception_intercept_message {
>> +	struct hv_x64_intercept_message_header header;
>> +	__u16 exception_vector;
>> +	union hv_x64_exception_info exception_info;
>> +	__u8 instruction_byte_count;
>> +	__u32 error_code;
>> +	__u64 exception_parameter;
>> +	__u64 reserved;
>> +	__u8 instruction_bytes[16];
>> +	struct hv_x64_segment_register ds_segment;
>> +	struct hv_x64_segment_register ss_segment;
>> +	__u64 rax;
>> +	__u64 rcx;
>> +	__u64 rdx;
>> +	__u64 rbx;
> 
> Is the above the correct ordering (rax, rcd, rdx, rbx)?
> It's just what you would expect ....
> 

This ordering is correct.
Why is it this way? I don't know.

>> +	__u64 rsp;
>> +	__u64 rbp;
>> +	__u64 rsi;
>> +	__u64 rdi;
>> +	__u64 r8;
>> +	__u64 r9;
>> +	__u64 r10;
>> +	__u64 r11;
>> +	__u64 r12;
>> +	__u64 r13;
>> +	__u64 r14;
>> +	__u64 r15;
>> +};
>> +
>> +struct hv_x64_invalid_vp_register_message {
>> +	__u32 vp_index;
>> +	__u32 reserved;
>> +};
>> +
>> +struct hv_x64_unrecoverable_exception_message {
>> +	struct hv_x64_intercept_message_header header;
>> +};
>> +
>> +enum hv_x64_unsupported_feature_code {
>> +	hv_unsupported_feature_intercept = 1,
>> +	hv_unsupported_feature_task_switch_tss = 2
>> +};
>> +
>> +struct hv_x64_unsupported_feature_message {
>> +	__u32 vp_index;
>> +	enum hv_x64_unsupported_feature_code feature_code;
>> +	__u64 feature_parameter;
>> +};
>> +
>> +struct hv_x64_halt_message {
>> +	struct hv_x64_intercept_message_header header;
>> +};
>> +
>> +enum hv_x64_pending_interruption_type {
>> +	HV_X64_PENDING_INTERRUPT	= 0,
>> +	HV_X64_PENDING_NMI		= 2,
>> +	HV_X64_PENDING_EXCEPTION	= 3
>> +};
>> +
>> +struct hv_x64_interruption_deliverable_message {
>> +	struct hv_x64_intercept_message_header header;
>> +	enum hv_x64_pending_interruption_type deliverable_type;
>> +	__u32 rsvd;
>> +};
>> +
>> +struct hv_x64_sipi_intercept_message {
>> +	struct hv_x64_intercept_message_header header;
>> +	__u32 target_vp_index;
>> +	__u32 interrupt_vector;
>> +};
>> +
>> +struct hv_x64_apic_eoi_message {
>> +	__u32 vp_index;
>> +	__u32 interrupt_vector;
>> +};
> 
> Same comments as before about enum types, not depending
> on the compiler to add padding, and marking as __packed.
> 

Yep, will do.

>> +
>>  #endif
>> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
>> index b9295400c20b..e0185c3872a9 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -241,6 +241,8 @@ static inline const char *hv_status_to_string(enum hv_status status)
>>  /* Valid SynIC vectors are 16-255. */
>>  #define HV_SYNIC_FIRST_VALID_VECTOR	(16)
>>
>> +#define HV_SYNIC_INTERCEPTION_SINT_INDEX 0x00000000
>> +
>>  #define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
>>  #define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
>>  #define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
>> @@ -250,49 +252,6 @@ static inline const char *hv_status_to_string(enum hv_status
>> status)
>>
>>  #define HV_SYNIC_STIMER_COUNT		(4)
>>
>> -/* Define synthetic interrupt controller message constants. */
>> -#define HV_MESSAGE_SIZE			(256)
>> -#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
>> -#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
>> -
>> -/* Define synthetic interrupt controller message flags. */
>> -union hv_message_flags {
>> -	__u8 asu8;
>> -	struct {
>> -		__u8 msg_pending:1;
>> -		__u8 reserved:7;
>> -	} __packed;
>> -};
>> -
>> -/* Define port identifier type. */
>> -union hv_port_id {
>> -	__u32 asu32;
>> -	struct {
>> -		__u32 id:24;
>> -		__u32 reserved:8;
>> -	} __packed u;
>> -};
>> -
>> -/* Define synthetic interrupt controller message header. */
>> -struct hv_message_header {
>> -	__u32 message_type;
>> -	__u8 payload_size;
>> -	union hv_message_flags message_flags;
>> -	__u8 reserved[2];
>> -	union {
>> -		__u64 sender;
>> -		union hv_port_id port;
>> -	};
>> -} __packed;
>> -
>> -/* Define synthetic interrupt controller message format. */
>> -struct hv_message {
>> -	struct hv_message_header header;
>> -	union {
>> -		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
>> -	} u;
>> -} __packed;
>> -
>>  /* Define the synthetic interrupt message page layout. */
>>  struct hv_message_page {
>>  	struct hv_message sint_message[HV_SYNIC_SINT_COUNT];
>> @@ -306,7 +265,6 @@ struct hv_timer_message_payload {
>>  	__u64 delivery_time;	/* When the message was delivered */
>>  } __packed;
>>
>> -
>>  /* Define synthetic interrupt controller flag constants. */
>>  #define HV_EVENT_FLAGS_COUNT		(256 * 8)
>>  #define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
>> diff --git a/include/linux/mshv.h b/include/linux/mshv.h
>> index dfe469f573f9..7709aaa1e064 100644
>> --- a/include/linux/mshv.h
>> +++ b/include/linux/mshv.h
>> @@ -42,6 +42,7 @@ struct mshv_partition {
>>  };
>>
>>  struct mshv {
>> +	struct hv_message_page __percpu **synic_message_page;
>>  	struct {
>>  		spinlock_t lock;
>>  		u64 count;
>> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-
>> tlfs.h
>> index e7b09b9f00de..e87389054b68 100644
>> --- a/include/uapi/asm-generic/hyperv-tlfs.h
>> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
>> @@ -6,6 +6,49 @@
>>  #define BIT(X)	(1ULL << (X))
>>  #endif
>>
>> +/* Define synthetic interrupt controller message constants. */
>> +#define HV_MESSAGE_SIZE			(256)
>> +#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
>> +#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
>> +
>> +/* Define synthetic interrupt controller message flags. */
>> +union hv_message_flags {
>> +	__u8 asu8;
>> +	struct {
>> +		__u8 msg_pending:1;
>> +		__u8 reserved:7;
>> +	};
>> +};
>> +
>> +/* Define port identifier type. */
>> +union hv_port_id {
>> +	__u32 asu32;
>> +	struct {
>> +		__u32 id:24;
>> +		__u32 reserved:8;
>> +	} u;
>> +};
>> +
>> +/* Define synthetic interrupt controller message header. */
>> +struct hv_message_header {
>> +	enum hv_message_type message_type;
>> +	__u8 payload_size;
>> +	union hv_message_flags message_flags;
>> +	__u8 reserved[2];
>> +	union {
>> +		__u64 sender;
>> +		union hv_port_id port;
>> +	};
>> +};
>> +
>> +/* Define synthetic interrupt controller message format. */
>> +struct hv_message {
>> +	struct hv_message_header header;
>> +	union {
>> +		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
>> +	} u;
>> +};
>> +
>>  /* Userspace-visible partition creation flags */
>>  #define HV_PARTITION_CREATION_FLAG_SMT_ENABLED_GUEST                BIT(0)
>>  #define HV_PARTITION_CREATION_FLAG_GPA_LARGE_PAGES_DISABLED         BIT(3)
>> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
>> index 2a10137a1e84..c9445d2edb37 100644
>> --- a/virt/mshv/mshv_main.c
>> +++ b/virt/mshv/mshv_main.c
>> @@ -15,6 +15,8 @@
>>  #include <linux/file.h>
>>  #include <linux/anon_inodes.h>
>>  #include <linux/mm.h>
>> +#include <linux/io.h>
>> +#include <linux/cpuhotplug.h>
>>  #include <linux/mshv.h>
>>  #include <asm/mshyperv.h>
>>
>> @@ -1152,23 +1154,111 @@ mshv_dev_release(struct inode *inode, struct file *filp)
>>  	return 0;
>>  }
>>
>> +static int
>> +mshv_synic_init(unsigned int cpu)
>> +{
>> +	union hv_synic_simp simp;
>> +	union hv_synic_sint sint;
>> +	union hv_synic_scontrol sctrl;
>> +	struct hv_message_page **msg_page =
>> +			this_cpu_ptr(mshv.synic_message_page);
>> +
>> +	/* Setup the Synic's message page */
>> +	hv_get_simp(simp.as_uint64);
>> +	simp.simp_enabled = true;
>> +	*msg_page = memremap(simp.base_simp_gpa << PAGE_SHIFT,
>> +			     PAGE_SIZE, MEMREMAP_WB);
> 
> Use HV_HYP_PAGE_SHIFT and HV_HYP_PAGE_SIZE.
> 

Yep, will do.

>> +	if (!msg_page) {
>> +		pr_err("%s: memremap failed\n", __func__);
>> +		return -EFAULT;
>> +	}
>> +	hv_set_simp(simp.as_uint64);
>> +
>> +	/* Enable intercepts */
>> +	sint.as_uint64 = 0;
>> +	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
>> +	sint.masked = false;
>> +	sint.auto_eoi = hv_recommend_using_aeoi();
>> +	hv_set_synint_state(HV_SYNIC_INTERCEPTION_SINT_INDEX, sint.as_uint64);
>> +
>> +	/* Enable global synic bit */
>> +	hv_get_synic_state(sctrl.as_uint64);
>> +	sctrl.enable = 1;
>> +	hv_set_synic_state(sctrl.as_uint64);
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +mshv_synic_cleanup(unsigned int cpu)
>> +{
>> +	union hv_synic_sint sint;
>> +	union hv_synic_simp simp;
>> +	union hv_synic_scontrol sctrl;
>> +	struct hv_message_page **msg_page =
>> +			this_cpu_ptr(mshv.synic_message_page);
>> +
>> +	/* Disable the interrupt */
>> +	hv_get_synint_state(HV_SYNIC_INTERCEPTION_SINT_INDEX, sint.as_uint64);
>> +	sint.masked = true;
>> +	hv_set_synint_state(HV_SYNIC_INTERCEPTION_SINT_INDEX, sint.as_uint64);
>> +
>> +	/* Disable Synic's message page */
>> +	hv_get_simp(simp.as_uint64);
>> +	simp.simp_enabled = false;
>> +	hv_set_simp(simp.as_uint64);
>> +	memunmap(*msg_page);
>> +
>> +	/* Disable global synic bit */
>> +	hv_get_synic_state(sctrl.as_uint64);
>> +	sctrl.enable = 0;
>> +	hv_set_synic_state(sctrl.as_uint64);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mshv_cpuhp_online;
>> +
>>  static int
>>  __init mshv_init(void)
>>  {
>> -	int r;
>> +	int ret;
> 
> Ideally, change the name of the variable in the earlier patch so this
> one isn't cluttered with the change.
> 

Will do.

>>
>> -	r = misc_register(&mshv_dev);
>> -	if (r)
>> +	ret = misc_register(&mshv_dev);
>> +	if (ret) {
>>  		pr_err("%s: misc device register failed\n", __func__);
>> +		return ret;
>> +	}
>> +	spin_lock_init(&mshv.partitions.lock);
>>
>> +	mshv.synic_message_page = alloc_percpu(struct hv_message_page *);
>> +	if (!mshv.synic_message_page) {
>> +		pr_err("%s: failed to allocate percpu synic page\n", __func__);
>> +		misc_deregister(&mshv_dev);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
>> +				mshv_synic_init,
>> +				mshv_synic_cleanup);
>> +	if (ret < 0) {
>> +		pr_err("%s: failed to setup cpu hotplug state: %i\n",
>> +		       __func__, ret);
>> +		return ret;
>> +	}
>> +
>> +	mshv_cpuhp_online = ret;
>>  	spin_lock_init(&mshv.partitions.lock);
> 
> It looks like the spin lock is being initialized twice.
> 

Oops!

>>
>> -	return r;
>> +	return 0;
>>  }
>>
>>  static void
>>  __exit mshv_exit(void)
>>  {
>> +	cpuhp_remove_state(mshv_cpuhp_online);
>> +	free_percpu(mshv.synic_message_page);
>> +
>>  	misc_deregister(&mshv_dev);
>>  }
>>
>> --
>> 2.25.1
