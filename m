Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DECB338198
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Mar 2021 00:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhCKXjL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 11 Mar 2021 18:39:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50286 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhCKXiu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 Mar 2021 18:38:50 -0500
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id CCD47208D373;
        Thu, 11 Mar 2021 15:38:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCD47208D373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1615505930;
        bh=dJYGY4DwsprXIOB2hRULhIsSJiQPnQNWSO2wAJ4Sa/Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=msgedgAzRbBQJtH0B5lYoQTqsLUkoFwR2K2xKaT8n4Rcj+yRICmQtAELhr6WngGxm
         kvzu/WFI4qowfcFT0W49z/3XZKD+s2NC6K52ORfn37KzEeyh+vd1h36Gm7KN1+rl6U
         K4qh7tFoFnS97dEqtneCcVkFRtaSPcBOhLZf3m0c=
Subject: Re: [RFC PATCH 15/18] virt/mshv: get and set vp state ioctls
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
 <1605918637-12192-16-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB1593B7D15C0607464B9394E5D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <84741601-7169-ee7b-a447-800e881d7e1a@linux.microsoft.com>
Date:   Thu, 11 Mar 2021 15:38:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593B7D15C0607464B9394E5D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 2/8/2021 11:48 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November 20, 2020 4:31 PM
>> To: linux-hyperv@vger.kernel.org
>> Cc: virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Michael Kelley
>> <mikelley@microsoft.com>; viremana@linux.microsoft.com; Sunil Muthuswamy
>> <sunilmut@microsoft.com>; nunodasneves@linux.microsoft.com; wei.liu@kernel.org;
>> Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>; KY Srinivasan
>> <kys@microsoft.com>
>> Subject: [RFC PATCH 15/18] virt/mshv: get and set vp state ioctls
>>
>> Introduce ioctls for getting and setting guest vcpu emulated LAPIC
>> state, and xsave data.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  Documentation/virt/mshv/api.rst         |   8 +
>>  arch/x86/include/uapi/asm/hyperv-tlfs.h |  59 ++++++
>>  include/asm-generic/hyperv-tlfs.h       |  41 ++++
>>  include/uapi/asm-generic/hyperv-tlfs.h  |  28 +++
>>  include/uapi/linux/mshv.h               |  13 ++
>>  virt/mshv/mshv_main.c                   | 262 ++++++++++++++++++++++++
>>  6 files changed, 411 insertions(+)
>>
>> diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
>> index 694f978131f9..7fd75f248eff 100644
>> --- a/Documentation/virt/mshv/api.rst
>> +++ b/Documentation/virt/mshv/api.rst
>> @@ -140,4 +140,12 @@ Assert interrupts in partitions that use Microsoft Hypervisor's
>> internal
>>  emulated LAPIC. This must be enabled on partition creation with the flag:
>>  HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED
>>
>> +3.9 MSHV_GET_VP_STATE and MSHV_SET_VP_STATE
>> +--------------------------
>> +:Type: vp ioctl
>> +:Parameters: struct mshv_vp_state
>> +:Returns: 0 on success
>> +
>> +Get/set various vp state. Currently these can be used to get and set
>> +emulated LAPIC state, and xsave data.
>>
>> diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-
>> tlfs.h
>> index 5478d4943bfc..78758aedf23e 100644
>> --- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> @@ -1051,4 +1051,63 @@ union hv_interrupt_control {
>>  	__u64 as_uint64;
>>  };
>>
>> +struct hv_local_interrupt_controller_state {
>> +	__u32 apic_id;
>> +	__u32 apic_version;
>> +	__u32 apic_ldr;
>> +	__u32 apic_dfr;
>> +	__u32 apic_spurious;
>> +	__u32 apic_isr[8];
>> +	__u32 apic_tmr[8];
>> +	__u32 apic_irr[8];
>> +	__u32 apic_esr;
>> +	__u32 apic_icr_high;
>> +	__u32 apic_icr_low;
>> +	__u32 apic_lvt_timer;
>> +	__u32 apic_lvt_thermal;
>> +	__u32 apic_lvt_perfmon;
>> +	__u32 apic_lvt_lint0;
>> +	__u32 apic_lvt_lint1;
>> +	__u32 apic_lvt_error;
>> +	__u32 apic_lvt_cmci;
>> +	__u32 apic_error_status;
>> +	__u32 apic_initial_count;
>> +	__u32 apic_counter_value;
>> +	__u32 apic_divide_configuration;
>> +	__u32 apic_remote_read;
>> +};
>> +
>> +#define HV_XSAVE_DATA_NO_XMM_REGISTERS 1
>> +
>> +union hv_x64_xsave_xfem_register {
>> +	__u64 as_uint64;
>> +	struct {
>> +		__u32 low_uint32;
>> +		__u32 high_uint32;
>> +	};
>> +	struct {
>> +		__u64 legacy_x87: 1;
>> +		__u64 legacy_sse: 1;
>> +		__u64 avx: 1;
>> +		__u64 mpx_bndreg: 1;
>> +		__u64 mpx_bndcsr: 1;
>> +		__u64 avx_512_op_mask: 1;
>> +		__u64 avx_512_zmmhi: 1;
>> +		__u64 avx_512_zmm16_31: 1;
>> +		__u64 rsvd8_9: 2;
>> +		__u64 pasid: 1;
>> +		__u64 cet_u: 1;
>> +		__u64 cet_s: 1;
>> +		__u64 rsvd13_16: 4;
>> +		__u64 xtile_cfg: 1;
>> +		__u64 xtile_data: 1;
>> +		__u64 rsvd19_63: 45;
>> +	};
>> +};
>> +
>> +struct hv_vp_state_data_xsave {
>> +	__u64 flags;
>> +	union hv_x64_xsave_xfem_register states;
>> +};
>> +
>>  #endif
>> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
>> index 2cd46241c545..4bc59a0344ce 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -167,6 +167,9 @@ struct ms_hyperv_tsc_page {
>>  #define HVCALL_ASSERT_VIRTUAL_INTERRUPT		0x0094
>>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>> +#define HVCALL_MAP_VP_STATE_PAGE			0x00e1
>> +#define HVCALL_GET_VP_STATE				0x00e3
>> +#define HVCALL_SET_VP_STATE				0x00e4
>>
>>  #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
>>  #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
>> @@ -796,4 +799,42 @@ struct hv_assert_virtual_interrupt {
>>  	u16 rsvd_z1;
>>  };
>>
>> +struct hv_vp_state_data {
>> +	enum hv_get_set_vp_state_type type;
>> +	u32 rsvd;
>> +	struct hv_vp_state_data_xsave xsave;
>> +
>> +};
>> +
>> +struct hv_get_vp_state_in {
>> +	u64 partition_id;
>> +	u32 vp_index;
>> +	u8 input_vtl;
>> +	u8 rsvd0;
>> +	u16 rsvd1;
>> +	struct hv_vp_state_data state_data;
>> +	u64 output_data_pfns[];
>> +};
>> +
>> +union hv_get_vp_state_out {
>> +	struct hv_local_interrupt_controller_state interrupt_controller_state;
>> +	/* Not supported yet */
>> +	/* struct hv_synthetic_timers_state synthetic_timers_state; */
>> +};
>> +
>> +union hv_input_set_vp_state_data {
>> +	u64 pfns;
>> +	u8 bytes;
>> +};
>> +
>> +struct hv_set_vp_state_in {
>> +	u64 partition_id;
>> +	u32 vp_index;
>> +	u8 input_vtl;
>> +	u8 rsvd0;
>> +	u16 rsvd1;
>> +	struct hv_vp_state_data state_data;
>> +	union hv_input_set_vp_state_data data[];
>> +};
>> +
>>  #endif
>> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-
>> tlfs.h
>> index e87389054b68..b3c84c69b73f 100644
>> --- a/include/uapi/asm-generic/hyperv-tlfs.h
>> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
>> @@ -64,4 +64,32 @@ struct hv_message {
>>  #define HV_MAP_GPA_EXECUTABLE           0xC
>>  #define HV_MAP_GPA_PERMISSIONS_MASK     0xF
>>
>> +/*
>> + * For getting and setting VP state, there are two options based on the state type:
>> + *
>> + *     1.) Data that is accessed by PFNs in the input hypercall page. This is used
>> + *         for state which may not fit into the hypercall pages.
>> + *     2.) Data that is accessed directly in the input\output hypercall pages.
>> + *         This is used for state that will always fit into the hypercall pages.
>> + *
>> + * In the future this could be dynamic based on the size if needed.
>> + *
>> + * Note these hypercalls have an 8-byte aligned variable header size as per the tlfs
>> + */
>> +
>> +#define HV_GET_SET_VP_STATE_TYPE_PFN	BIT(31)
>> +
>> +enum hv_get_set_vp_state_type {
>> +	HV_GET_SET_VP_STATE_LOCAL_INTERRUPT_CONTROLLER_STATE = 0,
>> +
>> +	HV_GET_SET_VP_STATE_XSAVE		= 1 |
>> HV_GET_SET_VP_STATE_TYPE_PFN,
>> +	/* Synthetic message page */
>> +	HV_GET_SET_VP_STATE_SIM_PAGE		= 2 |
>> HV_GET_SET_VP_STATE_TYPE_PFN,
>> +	/* Synthetic interrupt event flags page. */
>> +	HV_GET_SET_VP_STATE_SIEF_PAGE		= 3 |
>> HV_GET_SET_VP_STATE_TYPE_PFN,
>> +
>> +	/* Synthetic timers. */
>> +	HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS	= 4,
>> +};
>> +
>>  #endif
>> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
>> index faed9d065bb7..ae0bb64bbec3 100644
>> --- a/include/uapi/linux/mshv.h
>> +++ b/include/uapi/linux/mshv.h
>> @@ -53,6 +53,17 @@ struct mshv_assert_interrupt {
>>  	__u32 vector;
>>  };
>>
>> +struct mshv_vp_state {
>> +	enum hv_get_set_vp_state_type type;
>> +	struct hv_vp_state_data_xsave xsave; /* only for xsave request */
>> +
>> +	__u64 buf_size; /* If xsave, must be page-aligned */
>> +	union {
>> +		struct hv_local_interrupt_controller_state *lapic;
>> +		__u8 *bytes; /* Xsave data. must be page-aligned */
>> +	} buf;
>> +};
>> +
>>  #define MSHV_IOCTL 0xB8
>>
>>  /* mshv device */
>> @@ -70,5 +81,7 @@ struct mshv_assert_interrupt {
>>  #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct
>> mshv_vp_registers)
>>  #define MSHV_SET_VP_REGISTERS   _IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
>>  #define MSHV_RUN_VP		_IOR(MSHV_IOCTL, 0x07, struct hv_message)
>> +#define MSHV_GET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0A, struct mshv_vp_state)
>> +#define MSHV_SET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0B, struct mshv_vp_state)
>>
>>  #endif
>> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
>> index 9cf236ade50a..70172d9488de 100644
>> --- a/virt/mshv/mshv_main.c
>> +++ b/virt/mshv/mshv_main.c
>> @@ -864,6 +864,262 @@ mshv_vp_ioctl_set_regs(struct mshv_vp *vp, void __user
>> *user_args)
>>  	return ret;
>>  }
>>
>> +static int
>> +hv_call_get_vp_state(u32 vp_index,
>> +		     u64 partition_id,
>> +		     enum hv_get_set_vp_state_type type,
>> +		     struct hv_vp_state_data_xsave xsave,
>> +		    /* Choose between pages and ret_output */
>> +		     u64 page_count,
>> +		     struct page **pages,
>> +		     union hv_get_vp_state_out *ret_output)
>> +{
>> +	struct hv_get_vp_state_in *input;
>> +	union hv_get_vp_state_out *output;
>> +	int status;
>> +	int i;
>> +	u64 control;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	if (sizeof(*input) + (page_count * sizeof(u64)) > PAGE_SIZE)
>> +		return -EINVAL;
> 
> Nit:  Stylistically, you are handling this differently from the BATCH_SIZE
> macros, which are essentially doing the same thing of calculating
> how many entries will fit in the input page.   Note to use
> HV_HYP_PAGE_SIZE.
> 

Hmm, I didn't notice this. I guess it's ok either way, but for consistency I will add:
#define HV_GET_VP_STATE_BATCH_SIZE ((HV_HYP_PAGE_SIZE - sizeof(struct hv_get_vp_state_in)) / sizeof(u64))
And change the condition to:
if (page_count > HV_GET_VP_STATE_BATCH_SIZE)

>> +
>> +	if (!page_count && !ret_output)
>> +		return -EINVAL;
>> +
>> +	do {
>> +		local_irq_save(flags);
>> +		input = (struct hv_get_vp_state_in *)
>> +				(*this_cpu_ptr(hyperv_pcpu_input_arg));
>> +		output = (union hv_get_vp_state_out *)
>> +				(*this_cpu_ptr(hyperv_pcpu_output_arg));
>> +		memset(input, 0, sizeof(*input));
>> +		memset(output, 0, sizeof(*output));
>> +
>> +		input->partition_id = partition_id;
>> +		input->vp_index = vp_index;
>> +		input->state_data.type = type;
>> +		memcpy(&input->state_data.xsave, &xsave, sizeof(xsave));
>> +		for (i = 0; i < page_count; i++)
>> +			input->output_data_pfns[i] =
>> +				page_to_pfn(pages[i]) & HV_MAP_GPA_MASK;
>> +
>> +		control = (HVCALL_GET_VP_STATE) |
>> +			  (page_count << HV_HYPERCALL_VARHEAD_OFFSET);
>> +
>> +		status = hv_do_hypercall(control, input, output) &
>> +			 HV_HYPERCALL_RESULT_MASK;
>> +
>> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
>> +			if (status != HV_STATUS_SUCCESS)
>> +				pr_err("%s: %s\n", __func__,
>> +				       hv_status_to_string(status));
>> +			else if (ret_output)
>> +				memcpy(ret_output, output, sizeof(*output));
>> +
>> +			local_irq_restore(flags);
>> +			ret = -hv_status_to_errno(status);
>> +			break;
>> +		}
>> +		local_irq_restore(flags);
>> +
>> +		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>> +					    partition_id, 1);
>> +	} while (!ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int
>> +hv_call_set_vp_state(u32 vp_index,
>> +		     u64 partition_id,
>> +		     enum hv_get_set_vp_state_type type,
>> +		     struct hv_vp_state_data_xsave xsave,
>> +		    /* Choose between pages and bytes */
>> +		     u64 page_count,
>> +		     struct page **pages,
>> +		     u32 num_bytes,
>> +		     u8 *bytes)
>> +{
>> +	struct hv_set_vp_state_in *input;
>> +	int status;
>> +	int i;
>> +	u64 control;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +	u16 varhead_sz;
>> +
>> +	if (sizeof(*input) + (page_count * sizeof(u64)) > PAGE_SIZE)
> 
> Same comment as above.
> 

I'll do the same as above.

>> +		return -EINVAL;
>> +	if (sizeof(*input) + num_bytes > PAGE_SIZE)
> 
> Use HV_HYP_PAGE_SIZE.
> 

Will do.

>> +		return -EINVAL;
>> +
>> +	if (num_bytes)
>> +		/* round up to 8 and divide by 8 */
>> +		varhead_sz = (num_bytes + 7) >> 3;
>> +	else if (page_count)
>> +		varhead_sz =  page_count;
>> +	else
>> +		return -EINVAL;
>> +
>> +	do {
>> +		local_irq_save(flags);
>> +		input = (struct hv_set_vp_state_in *)
>> +				(*this_cpu_ptr(hyperv_pcpu_input_arg));
>> +		memset(input, 0, sizeof(*input));
>> +
>> +		input->partition_id = partition_id;
>> +		input->vp_index = vp_index;
>> +		input->state_data.type = type;
>> +		memcpy(&input->state_data.xsave, &xsave, sizeof(xsave));
>> +		if (num_bytes) {
>> +			memcpy((u8 *)input->data, bytes, num_bytes);
>> +		} else {
>> +			for (i = 0; i < page_count; i++)
>> +				input->data[i].pfns =
>> +					page_to_pfn(pages[i]) & HV_MAP_GPA_MASK;
> 
> Same comment as in earlier patch about GPA_MASK.  Also, this doesn't work
> if PAGE_SIZE != HV_HYP_PAGE_SIZE, though it may be fine to not handle that case
> for now.
> 

Will remove the mask.
As before, won't handle PAGE_SIZE != HV_HYP_PAGE_SIZE in this patch set.

>> +		}
>> +
>> +		control = (HVCALL_SET_VP_STATE) |
>> +			  (varhead_sz << HV_HYPERCALL_VARHEAD_OFFSET);
>> +
>> +		status = hv_do_hypercall(control, input, NULL) &
>> +			 HV_HYPERCALL_RESULT_MASK;
>> +
>> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
>> +			if (status != HV_STATUS_SUCCESS)
>> +				pr_err("%s: %s\n", __func__,
>> +				       hv_status_to_string(status));
>> +
>> +			local_irq_restore(flags);
>> +			ret = -hv_status_to_errno(status);
>> +			break;
>> +		}
>> +		local_irq_restore(flags);
>> +
>> +		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>> +					    partition_id, 1);
>> +	} while (!ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static long
>> +mshv_vp_ioctl_get_set_state_pfn(struct mshv_vp *vp,
>> +				struct mshv_vp_state *args,
>> +				bool is_set)
>> +{
>> +	u64 page_count, remaining;
>> +	int completed;
>> +	struct page **pages;
>> +	long ret;
>> +	unsigned long u_buf;
>> +
>> +	/* Buffer must be page aligned */
>> +	if (args->buf_size & (PAGE_SIZE - 1) ||
>> +	    (u64)args->buf.bytes & (PAGE_SIZE - 1))
>> +		return -EINVAL;
> 
> Use PAGE_ALIGNED macro.
> 

Will do.

>> +
>> +	if (!access_ok(args->buf.bytes, args->buf_size))
>> +		return -EFAULT;
>> +
>> +	/* Pin user pages so hypervisor can copy directly to them */
>> +	page_count = args->buf_size >> PAGE_SHIFT;
>> +	pages = kcalloc(page_count, sizeof(struct page *), GFP_KERNEL);
>> +	if (!pages)
>> +		return -ENOMEM;
>> +
>> +	remaining = page_count;
>> +	u_buf = (unsigned long)args->buf.bytes;
>> +	while (remaining) {
>> +		completed = pin_user_pages_fast(
>> +				u_buf,
>> +				remaining,
>> +				FOLL_WRITE,
>> +				&pages[page_count - remaining]);
>> +		if (completed < 0) {
>> +			pr_err("%s: failed to pin user pages error %i\n",
>> +			       __func__, completed);
>> +			ret = completed;
>> +			goto unpin_pages;
>> +		}
>> +		remaining -= completed;
>> +		u_buf += completed * PAGE_SIZE;
>> +	}
>> +
>> +	if (is_set)
>> +		ret = hv_call_set_vp_state(vp->index,
>> +					   vp->partition->id,
>> +					   args->type, args->xsave,
>> +					   page_count, pages,
>> +					   0, NULL);
>> +	else
>> +		ret = hv_call_get_vp_state(vp->index,
>> +					   vp->partition->id,
>> +					   args->type, args->xsave,
>> +					   page_count, pages,
>> +					   NULL);
>> +
>> +unpin_pages:
>> +	unpin_user_pages(pages, page_count - remaining);
>> +	kfree(pages);
>> +	return ret;
>> +}
>> +
>> +static long
>> +mshv_vp_ioctl_get_set_state(struct mshv_vp *vp, void __user *user_args, bool is_set)
>> +{
>> +	struct mshv_vp_state args;
>> +	long ret = 0;
>> +	union hv_get_vp_state_out vp_state;
>> +
>> +	if (copy_from_user(&args, user_args, sizeof(args)))
>> +		return -EFAULT;
>> +
>> +	/* For now just support these */
>> +	if (args.type != HV_GET_SET_VP_STATE_LOCAL_INTERRUPT_CONTROLLER_STATE &&
>> +	    args.type != HV_GET_SET_VP_STATE_XSAVE)
>> +		return -EINVAL;
>> +
>> +	/* If we need to pin pfns, delegate to helper */
>> +	if (args.type & HV_GET_SET_VP_STATE_TYPE_PFN)
>> +		return mshv_vp_ioctl_get_set_state_pfn(vp, &args, is_set);
>> +
>> +	if (args.buf_size < sizeof(vp_state))
>> +		return -EINVAL;
>> +
>> +	if (is_set) {
>> +		if (copy_from_user(
>> +				&vp_state,
>> +				args.buf.lapic,
>> +				sizeof(vp_state)))
>> +			return -EFAULT;
>> +
>> +		return hv_call_set_vp_state(vp->index,
>> +					    vp->partition->id,
>> +					    args.type, args.xsave,
>> +					    0, NULL,
>> +					    sizeof(vp_state),
>> +					    (u8 *)&vp_state);
>> +	}
>> +
>> +	ret = hv_call_get_vp_state(vp->index,
>> +				   vp->partition->id,
>> +				   args.type, args.xsave,
>> +				   0, NULL,
>> +				   &vp_state);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (copy_to_user(args.buf.lapic,
>> +			 &vp_state.interrupt_controller_state,
>> +			 sizeof(vp_state.interrupt_controller_state)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>>
>>  static long
>>  mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>> @@ -884,6 +1140,12 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long
>> arg)
>>  	case MSHV_SET_VP_REGISTERS:
>>  		r = mshv_vp_ioctl_set_regs(vp, (void __user *)arg);
>>  		break;
>> +	case MSHV_GET_VP_STATE:
>> +		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, false);
>> +		break;
>> +	case MSHV_SET_VP_STATE:
>> +		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, true);
>> +		break;
>>  	default:
>>  		r = -ENOTTY;
>>  		break;
>> --
>> 2.25.1
