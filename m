Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920B3331C66
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Mar 2021 02:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCIBjl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Mar 2021 20:39:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56550 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCIBja (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Mar 2021 20:39:30 -0500
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7301D20B39C5;
        Mon,  8 Mar 2021 17:39:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7301D20B39C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1615253969;
        bh=KUGV6hydJiC2ecOYgOhUlT08L9k+FkrRtg+TJ0Z2Bf8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QEHDmsudkxhyQvgK4w3DcqxUng8+bGPjMcbExn3gvKrY3aR8dbwKbZ+SVzfV3qHX/
         AP7HtX4iB/5HwSsbk7GKTNLCJJ9SXJSdnLRPwR8bGSGjjaIqXpHBtA5EeR5kOe6XXG
         xCDIaPHtO33ymKU021PZp2xqGyenlVUGqdSWMn5s=
Subject: Re: [RFC PATCH 10/18] virt/mshv: get and set vcpu registers ioctls
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
 <1605918637-12192-11-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB1593DC9AAF0ABBD0DE2EBA30D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <c7972607-7d99-5dad-354d-6ca8e8be0d8a@linux.microsoft.com>
Date:   Mon, 8 Mar 2021 17:39:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593DC9AAF0ABBD0DE2EBA30D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/8/2021 11:47 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November 20, 2020 4:30 PM
>>
>> Add ioctls for getting and setting virtual processor registers.
>>
>> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  Documentation/virt/mshv/api.rst         |  11 +
>>  arch/x86/include/uapi/asm/hyperv-tlfs.h | 601 ++++++++++++++++++++++++
>>  include/asm-generic/hyperv-tlfs.h       |  65 +--
>>  include/linux/mshv.h                    |   1 +
>>  include/uapi/linux/mshv.h               |  12 +
>>  virt/mshv/mshv_main.c                   | 258 +++++++++-
>>  6 files changed, 903 insertions(+), 45 deletions(-)
>>
[snip]
>> +
>> +union hv_register_value {
>> +	struct hv_u128 reg128;
>> +	__u64 reg64;
>> +	__u32 reg32;
>> +	__u16 reg16;
>> +	__u8 reg8;
>> +	union hv_x64_fp_register fp;
>> +	union hv_x64_fp_control_status_register fp_control_status;
>> +	union hv_x64_xmm_control_status_register xmm_control_status;
>> +	struct hv_x64_segment_register segment;
>> +	struct hv_x64_table_register table;
>> +	union hv_explicit_suspend_register explicit_suspend;
>> +	union hv_intercept_suspend_register intercept_suspend;
>> +	union hv_dispatch_suspend_register dispatch_suspend;
>> +	union hv_x64_interrupt_state_register interrupt_state;
>> +	union hv_x64_pending_interruption_register pending_interruption;
>> +	union hv_x64_msr_npiep_config_contents npiep_config;
>> +	union hv_x64_pending_exception_event pending_exception_event;
>> +	union hv_x64_pending_virtualization_fault_event
>> +		pending_virtualization_fault_event;
>> +};
>> +
>>  #endif
>> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
>> index 6e5072e29897..b9295400c20b 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -622,53 +622,30 @@ struct hv_retarget_device_interrupt {
>>  } __packed __aligned(8);
>>
>>
>> -/* HvGetVpRegisters hypercall input with variable size reg name list*/
>> -struct hv_get_vp_registers_input {
>> -	struct {
>> -		u64 partitionid;
>> -		u32 vpindex;
>> -		u8  inputvtl;
>> -		u8  padding[3];
>> -	} header;
>> -	struct input {
>> -		u32 name0;
>> -		u32 name1;
>> -	} element[];
>> -} __packed;
>> -
>> +/* HvGetVpRegisters hypercall with variable size reg name list*/
>> +struct hv_get_vp_registers {
>> +	u64 partition_id;
>> +	u32 vp_index;
>> +	u8  input_vtl;
>> +	u8  rsvd_z8;
>> +	u16 rsvd_z16;
>> +	__aligned(8) enum hv_register_name names[];
>> +} __aligned(8);
>>
>> -/* HvGetVpRegisters returns an array of these output elements */
>> -struct hv_get_vp_registers_output {
>> -	union {
>> -		struct {
>> -			u32 a;
>> -			u32 b;
>> -			u32 c;
>> -			u32 d;
>> -		} as32 __packed;
>> -		struct {
>> -			u64 low;
>> -			u64 high;
>> -		} as64 __packed;
>> -	};
>> +/* HvSetVpRegisters hypercall with variable size reg name/value list*/
>> +struct hv_register_assoc {
>> +	enum hv_register_name name;
>> +	__aligned(16) union hv_register_value value;
>>  };
>>
>> -/* HvSetVpRegisters hypercall with variable size reg name/value list*/
>> -struct hv_set_vp_registers_input {
>> -	struct {
>> -		u64 partitionid;
>> -		u32 vpindex;
>> -		u8  inputvtl;
>> -		u8  padding[3];
>> -	} header;
>> -	struct {
>> -		u32 name;
>> -		u32 padding1;
>> -		u64 padding2;
>> -		u64 valuelow;
>> -		u64 valuehigh;
>> -	} element[];
>> -} __packed;
>> +struct hv_set_vp_registers {
>> +	u64 partition_id;
>> +	u32 vp_index;
>> +	u8  input_vtl;
>> +	u8  rsvd_z8;
>> +	u16 rsvd_z16;
>> +	struct hv_register_assoc elements[];
>> +} __aligned(16);
> 
> Throughout these structures, I think the approach needs to be more
> explicit about the memory layout.  The current definitions assume that
> the compiler is inserting padding in the expected places, and not in
> any unexpected places.  My previous concerns about use of enum
> also apply.
> 
> The code also removes some layouts that are used in the
> not-yet-accepted patches for ARM64.   Let sync on how to get
> those back in.
> 

I'll add __packed to all these structures.
The hv_register_name enum can be replaced by #defines, and the type can be
u32 or u64 (it only needs 32 bits).

I'll sync with you on the ARM64 structs.

>>
>>  enum hv_device_type {
>>  	HV_DEVICE_TYPE_LOGICAL = 0,
>> diff --git a/include/linux/mshv.h b/include/linux/mshv.h
>> index 50521c5f7948..dfe469f573f9 100644
>> --- a/include/linux/mshv.h
>> +++ b/include/linux/mshv.h
>> @@ -17,6 +17,7 @@
>>  struct mshv_vp {
>>  	u32 index;
>>  	struct mshv_partition *partition;
>> +	struct mutex mutex;
>>  };
>>
>>  struct mshv_mem_region {
>> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
>> index 1f053eae68a6..5d53ed655429 100644
>> --- a/include/uapi/linux/mshv.h
>> +++ b/include/uapi/linux/mshv.h
>> @@ -33,6 +33,14 @@ struct mshv_create_vp {
>>  	__u32 vp_index;
>>  };
>>
>> +#define MSHV_VP_MAX_REGISTERS	128
>> +
>> +struct mshv_vp_registers {
>> +	int count; /* at most MSHV_VP_MAX_REGISTERS */
>> +	enum hv_register_name *names;
>> +	union hv_register_value *values;
>> +};
> 
> Having separate arrays for the names and values results in an extra
> copy of the data down in the ioctl code.  Any reason the caller couldn't
> supply the data as an array, where each entry is already a name/value
> pair?
> 

I initially thought it would not make a difference to the number of copies,
but it turns out it does. I will change it to use hv_register_assoc everywhere.

>> +
>>  #define MSHV_IOCTL 0xB8
>>
>>  /* mshv device */
>> @@ -44,4 +52,8 @@ struct mshv_create_vp {
>>  #define MSHV_UNMAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x03, struct
>> mshv_user_mem_region)
>>  #define MSHV_CREATE_VP		_IOW(MSHV_IOCTL, 0x04, struct mshv_create_vp)
>>
>> +/* vp device */
>> +#define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct
>> mshv_vp_registers)
>> +#define MSHV_SET_VP_REGISTERS   _IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
>> +
>>  #endif
>> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
>> index 3be9d9a468c1..2a10137a1e84 100644
>> --- a/virt/mshv/mshv_main.c
>> +++ b/virt/mshv/mshv_main.c
>> @@ -74,6 +74,12 @@ static struct miscdevice mshv_dev = {
>>  #define HV_MAP_GPA_BATCH_SIZE	\
>>  		(PAGE_SIZE / sizeof(struct hv_map_gpa_pages) / sizeof(u64))
>>  #define PIN_PAGES_BATCH_SIZE	(0x10000000 / PAGE_SIZE)
>> +#define HV_GET_REGISTER_BATCH_SIZE	\
>> +	(PAGE_SIZE / \
>> +	 sizeof(struct hv_get_vp_registers) / sizeof(enum hv_register_name))
>> +#define HV_SET_REGISTER_BATCH_SIZE	\
>> +	(PAGE_SIZE / \
>> +	 sizeof(struct hv_set_vp_registers) / sizeof(struct hv_register_assoc))
> 
> These new size calculations have the same bug as HV_MAP_GPA_BATCH_SIZE.
> The first divide operations should be subtraction.
> 

Yep, I'll fix it.

> With the correct calculation, HV_GET_REGISTER_BATCH_SIZE  will be
> too large.  The input page will accommodate more 32 bit register names
> than the output page will accommodate 128 bit register values.  The limit
> should be based on the latter, not the former.  Or calculate both the
> input and output limit and use the minimum.
> 

I didn't think about this previously! Will fix.

>>
>>  static int
>>  hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
>> @@ -380,10 +386,258 @@ hv_call_unmap_gpa_pages(u64 partition_id,
>>  	return ret;
>>  }
>>
>> +static int
>> +hv_call_get_vp_registers(u32 vp_index,
>> +			 u64 partition_id,
>> +			 u16 count,
>> +			 const enum hv_register_name *names,
>> +			 union hv_register_value *values)
>> +{
>> +	struct hv_get_vp_registers *input_page;
>> +	union hv_register_value *output_page;
>> +	u16 completed = 0;
>> +	u64 hypercall_status;
>> +	unsigned long remaining = count;
>> +	int rep_count;
>> +	int status;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>> +
>> +	input_page = (struct hv_get_vp_registers *)(*this_cpu_ptr(
>> +		hyperv_pcpu_input_arg));
>> +	output_page = (union hv_register_value *)(*this_cpu_ptr(
>> +		hyperv_pcpu_output_arg));
>> +
>> +	input_page->partition_id = partition_id;
>> +	input_page->vp_index = vp_index;
>> +	input_page->input_vtl = 0;
>> +	input_page->rsvd_z8 = 0;
>> +	input_page->rsvd_z16 = 0;
>> +
>> +	while (remaining) {
>> +		rep_count = min(remaining, HV_GET_REGISTER_BATCH_SIZE);
>> +		memcpy(input_page->names, names,
>> +			sizeof(enum hv_register_name) * rep_count);
>> +
>> +		hypercall_status =
>> +			hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS, rep_count,
>> +					    0, input_page, output_page);
>> +		status = hypercall_status & HV_HYPERCALL_RESULT_MASK;
>> +		if (status != HV_STATUS_SUCCESS) {
>> +			pr_err("%s: completed %li out of %u, %s\n",
>> +			       __func__,
>> +			       count - remaining, count,
>> +			       hv_status_to_string(status));
>> +			break;
>> +		}
>> +		completed = (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
>> +			    HV_HYPERCALL_REP_COMP_OFFSET;
>> +		memcpy(values, output_page,
>> +			sizeof(union hv_register_value) * completed);
>> +
>> +		names += completed;
>> +		values += completed;
>> +		remaining -= completed;
>> +	}
>> +	local_irq_restore(flags);
>> +
>> +	return -hv_status_to_errno(status);
>> +}
>> +
>> +static int
>> +hv_call_set_vp_registers(u32 vp_index,
>> +			 u64 partition_id,
>> +			 u16 count,
>> +			 struct hv_register_assoc *registers)
>> +{
>> +	struct hv_set_vp_registers *input_page;
>> +	u16 completed = 0;
>> +	u64 hypercall_status;
>> +	unsigned long remaining = count;
>> +	int rep_count;
>> +	int status;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>> +	input_page = (struct hv_set_vp_registers *)(*this_cpu_ptr(
>> +		hyperv_pcpu_input_arg));
>> +
>> +	input_page->partition_id = partition_id;
>> +	input_page->vp_index = vp_index;
>> +	input_page->input_vtl = 0;
>> +	input_page->rsvd_z8 = 0;
>> +	input_page->rsvd_z16 = 0;
>> +
>> +	while (remaining) {
>> +		rep_count = min(remaining, HV_SET_REGISTER_BATCH_SIZE);
>> +		memcpy(input_page->elements, registers,
>> +			sizeof(struct hv_register_assoc) * rep_count);
>> +
>> +		hypercall_status =
>> +			hv_do_rep_hypercall(HVCALL_SET_VP_REGISTERS, rep_count,
>> +					    0, input_page, NULL);
>> +		status = hypercall_status & HV_HYPERCALL_RESULT_MASK;
>> +		if (status != HV_STATUS_SUCCESS) {
>> +			pr_err("%s: completed %li out of %u, %s\n",
>> +			       __func__,
>> +			       count - remaining, count,
>> +			       hv_status_to_string(status));
>> +			break;
>> +		}
>> +		completed = (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
>> +			    HV_HYPERCALL_REP_COMP_OFFSET;
>> +		registers += completed;
>> +		remaining -= completed;
>> +	}
>> +
>> +	local_irq_restore(flags);
>> +
>> +	return -hv_status_to_errno(status);
>> +}
>> +
>> +static long
>> +mshv_vp_ioctl_get_regs(struct mshv_vp *vp, void __user *user_args)
>> +{
>> +	struct mshv_vp_registers args;
>> +	enum hv_register_name *names;
>> +	union hv_register_value *values;
>> +	long ret;
>> +
>> +	if (copy_from_user(&args, user_args, sizeof(args)))
>> +		return -EFAULT;
>> +
>> +	if (args.count > MSHV_VP_MAX_REGISTERS)
>> +		return -EINVAL;
>> +
>> +	names = kmalloc_array(args.count,
>> +			      sizeof(enum hv_register_name),
>> +			      GFP_KERNEL);
>> +	if (!names)
>> +		return -ENOMEM;
>> +
>> +	values = kmalloc_array(args.count,
>> +			       sizeof(union hv_register_value),
>> +			       GFP_KERNEL);
>> +	if (!values) {
>> +		kfree(names);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (copy_from_user(names, args.names,
>> +			   sizeof(enum hv_register_name) * args.count)) {
>> +		ret = -EFAULT;
>> +		goto free_return;
>> +	}
>> +
>> +	ret = hv_call_get_vp_registers(vp->index, vp->partition->id,
>> +				       args.count, names, values);
>> +	if (ret)
>> +		goto free_return;
>> +
>> +	if (copy_to_user(args.values, values,
>> +			 sizeof(union hv_register_value) * args.count)) {
>> +		ret = -EFAULT;
>> +	}
>> +
>> +free_return:
>> +	kfree(names);
>> +	kfree(values);
>> +	return ret;
>> +}
>> +
>> +static long
>> +mshv_vp_ioctl_set_regs(struct mshv_vp *vp, void __user *user_args)
>> +{
>> +	int i;
>> +	struct mshv_vp_registers args;
>> +	struct hv_register_assoc *registers;
>> +	enum hv_register_name *names;
>> +	union hv_register_value *values;
>> +	long ret;
>> +
>> +	if (copy_from_user(&args, user_args, sizeof(args)))
>> +		return -EFAULT;
>> +
>> +	if (args.count > MSHV_VP_MAX_REGISTERS)
>> +		return -EINVAL;
>> +
>> +	names = kmalloc_array(args.count,
>> +			      sizeof(enum hv_register_name),
>> +			      GFP_KERNEL);
>> +	if (!names)
>> +		return -ENOMEM;
>> +
>> +	values = kmalloc_array(args.count,
>> +			       sizeof(union hv_register_value),
>> +			       GFP_KERNEL);
>> +	if (!values) {
>> +		kfree(names);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	registers = kmalloc_array(args.count,
>> +				  sizeof(struct hv_register_assoc),
>> +				  GFP_KERNEL);
>> +	if (!registers) {
>> +		kfree(values);
>> +		kfree(names);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (copy_from_user(names, args.names,
>> +			   sizeof(enum hv_register_name) * args.count)) {
>> +		ret = -EFAULT;
>> +		goto free_return;
>> +	}
>> +
>> +	if (copy_from_user(values, args.values,
>> +			   sizeof(union hv_register_value) * args.count)) {
>> +		ret = -EFAULT;
>> +		goto free_return;
>> +	}
>> +
>> +	for (i = 0; i < args.count; i++) {
>> +		memcpy(&registers[i].name, &names[i],
>> +		       sizeof(enum hv_register_name));
>> +		memcpy(&registers[i].value, &values[i],
>> +		       sizeof(union hv_register_value));
>> +	}
> 
> The above will result in uninitialized memory being sent to
> Hyper-V, since there is implicit padding associated with the
> 32 bit name field.
> 

This shouldn't be an issue after I change this to use hv_register_assoc,
instead of separate names and values buffers.

>> +
>> +	ret = hv_call_set_vp_registers(vp->index, vp->partition->id,
>> +				       args.count, registers);
>> +
>> +free_return:
>> +	kfree(names);
>> +	kfree(values);
>> +	kfree(registers);
>> +	return ret;
>> +}
>> +
>> +
>>  static long
>>  mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>>  {
>> -	return -ENOTTY;
>> +	struct mshv_vp *vp = filp->private_data;
>> +	long r = 0;
>> +
>> +	if (mutex_lock_killable(&vp->mutex))
>> +		return -EINTR;
>> +
>> +	switch (ioctl) {
>> +	case MSHV_GET_VP_REGISTERS:
>> +		r = mshv_vp_ioctl_get_regs(vp, (void __user *)arg);
>> +		break;
>> +	case MSHV_SET_VP_REGISTERS:
>> +		r = mshv_vp_ioctl_set_regs(vp, (void __user *)arg);
>> +		break;
>> +	default:
>> +		r = -ENOTTY;
>> +		break;
>> +	}
>> +	mutex_unlock(&vp->mutex);
>> +
>> +	return r;
>>  }
>>
>>  static int
>> @@ -420,6 +674,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>>  	if (!vp)
>>  		return -ENOMEM;
>>
>> +	mutex_init(&vp->mutex);
>> +
>>  	vp->index = args.vp_index;
>>  	vp->partition = mshv_partition_get(partition);
>>  	if (!vp->partition) {
>> --
>> 2.25.1
