Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E1349833
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Mar 2021 18:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCYRgb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 Mar 2021 13:36:31 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39070 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhCYRgZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Mar 2021 13:36:25 -0400
Received: from [10.0.0.176] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8343320B5680;
        Thu, 25 Mar 2021 10:36:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8343320B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1616693784;
        bh=sg3/l9uhFKBKLgff3upMJL1Zy8JnVqhr4vRcu8hQggM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l7myan5nf3LpH/4PYlSS21s/VZrDI8h70jSRMwWSvQSFPG8Pfvbs/00ItRuwJq/rU
         DhR3SabrT7xBVyDDk6XoLyO36pBhjxyG5EITWkUe7TnuyPpTIozYFiOICZhS1ClF20
         NRjuXh3IskNEwas/04RM0xgmUkMuvSBcnjw23G8s=
Subject: Re: [RFC PATCH 16/18] virt/mshv: mmap vp register page
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
 <1605918637-12192-17-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB15937352FFE4CE51DC54191BD78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <cfc08cd8-6b25-ad67-28c3-6515ac9c3381@linux.microsoft.com>
Date:   Thu, 25 Mar 2021 10:36:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB15937352FFE4CE51DC54191BD78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 2/8/2021 11:49 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November 20, 2020 4:31 PM
>>
>> Introduce mmap interface for a virtual processor, exposing a page for
>> setting and getting common registers while the VP is suspended.
>>
>> This provides a more performant and convenient way to get and set these
>> registers in the context of a vmm's run-loop.
>>
>> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  Documentation/virt/mshv/api.rst         | 11 ++++
>>  arch/x86/include/uapi/asm/hyperv-tlfs.h | 74 ++++++++++++++++++++++
>>  include/asm-generic/hyperv-tlfs.h       | 10 +++
>>  include/linux/mshv.h                    |  1 +
>>  include/uapi/asm-generic/hyperv-tlfs.h  |  5 ++
>>  include/uapi/linux/mshv.h               | 12 ++++
>>  virt/mshv/mshv_main.c                   | 82 +++++++++++++++++++++++++
>>  7 files changed, 195 insertions(+)
>>
>> diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
>> index 7fd75f248eff..89c276a8778f 100644
>> --- a/Documentation/virt/mshv/api.rst
>> +++ b/Documentation/virt/mshv/api.rst
>> @@ -149,3 +149,14 @@ HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED
>>  Get/set various vp state. Currently these can be used to get and set
>>  emulated LAPIC state, and xsave data.
>>
>> +3.10 mmap(vp)
>> +-------------
>> +:Type: vp mmap
>> +:Parameters: offset should be HV_VP_MMAP_REGISTERS_OFFSET
>> +:Returns: 0 on success
>> +
>> +Maps a page into userspace that can be used to get and set common registers
>> +while the vp is suspended.
>> +The page is laid out in struct hv_vp_register_page in asm/hyperv-tlfs.h.
>> +
> 
> I'm assuming there's no support for the corresponding munmap().
> What happens if munmap is called?  Does it just fail and the page remains
> mapped?
> 

munmap() will successfully unmap the page from userspace.
The physical state page remains mapped in the hypervisor, tracked in mshv in vp->register_page.
This is re-used on subsequent mmap()s.

>> +
>> diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-
>> tlfs.h
>> index 78758aedf23e..a241178567ff 100644
>> --- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> @@ -1110,4 +1110,78 @@ struct hv_vp_state_data_xsave {
>>  	union hv_x64_xsave_xfem_register states;
>>  };
>>
>> +/* Bits for dirty mask of hv_vp_register_page */
>> +#define HV_X64_REGISTER_CLASS_GENERAL	0
>> +#define HV_X64_REGISTER_CLASS_IP	1
>> +#define HV_X64_REGISTER_CLASS_XMM	2
>> +#define HV_X64_REGISTER_CLASS_SEGMENT	3
>> +#define HV_X64_REGISTER_CLASS_FLAGS	4
>> +
>> +#define HV_VP_REGISTER_PAGE_VERSION_1	1u
>> +
>> +struct hv_vp_register_page {
>> +	__u16 version;
>> +	bool isvalid;
> 
> Like enum, avoid type "bool" in data structures shared with
> Hyper-V.
> 

Indeed - this should be u8. I will change it.

>> +	__u8 rsvdz;
>> +	__u32 dirty;
>> +	union {
>> +		struct {
>> +			__u64 rax;
>> +			__u64 rcx;
>> +			__u64 rdx;
>> +			__u64 rbx;
>> +			__u64 rsp;
>> +			__u64 rbp;
>> +			__u64 rsi;
>> +			__u64 rdi;
>> +			__u64 r8;
>> +			__u64 r9;
>> +			__u64 r10;
>> +			__u64 r11;
>> +			__u64 r12;
>> +			__u64 r13;
>> +			__u64 r14;
>> +			__u64 r15;
>> +		};
>> +
>> +		__u64 gp_registers[16];
>> +	};
>> +	__u64 rip;
>> +	__u64 rflags;
>> +	union {
>> +		struct {
>> +			struct hv_u128 xmm0;
>> +			struct hv_u128 xmm1;
>> +			struct hv_u128 xmm2;
>> +			struct hv_u128 xmm3;
>> +			struct hv_u128 xmm4;
>> +			struct hv_u128 xmm5;
>> +		};
>> +
>> +		struct hv_u128 xmm_registers[6];
>> +	};
>> +	union {
>> +		struct {
>> +			struct hv_x64_segment_register es;
>> +			struct hv_x64_segment_register cs;
>> +			struct hv_x64_segment_register ss;
>> +			struct hv_x64_segment_register ds;
>> +			struct hv_x64_segment_register fs;
>> +			struct hv_x64_segment_register gs;
>> +		};
>> +
>> +		struct hv_x64_segment_register segment_registers[6];
>> +	};
>> +	/* read only */
>> +	__u64 cr0;
>> +	__u64 cr3;
>> +	__u64 cr4;
>> +	__u64 cr8;
>> +	__u64 efer;
>> +	__u64 dr7;
>> +	union hv_x64_pending_interruption_register pending_interruption;
>> +	union hv_x64_interrupt_state_register interrupt_state;
>> +	__u64 instruction_emulation_hints;
>> +};
>> +
>>  #endif
>> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
>> index 4bc59a0344ce..9eed4b869110 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -837,4 +837,14 @@ struct hv_set_vp_state_in {
>>  	union hv_input_set_vp_state_data data[];
>>  };
>>
>> +struct hv_map_vp_state_page_in {
>> +	u64 partition_id;
>> +	u32 vp_index;
>> +	enum hv_vp_state_page_type type;
>> +};
>> +
>> +struct hv_map_vp_state_page_out {
>> +	u64 map_location; /* page number */
>> +};
>> +
>>  #endif
>> diff --git a/include/linux/mshv.h b/include/linux/mshv.h
>> index 3933d80294f1..33f4d0cfee11 100644
>> --- a/include/linux/mshv.h
>> +++ b/include/linux/mshv.h
>> @@ -20,6 +20,7 @@ struct mshv_vp {
>>  	u32 index;
>>  	struct mshv_partition *partition;
>>  	struct mutex mutex;
>> +	struct page *register_page;
>>  	struct {
>>  		struct semaphore sem;
>>  		struct task_struct *task;
>> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-
>> tlfs.h
>> index b3c84c69b73f..a747f39b132a 100644
>> --- a/include/uapi/asm-generic/hyperv-tlfs.h
>> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
>> @@ -92,4 +92,9 @@ enum hv_get_set_vp_state_type {
>>  	HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS	= 4,
>>  };
>>
>> +enum hv_vp_state_page_type {
>> +	HV_VP_STATE_PAGE_REGISTERS = 0,
>> +	HV_VP_STATE_PAGE_COUNT
>> +};
>> +
>>  #endif
>> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
>> index ae0bb64bbec3..8537ff29aee5 100644
>> --- a/include/uapi/linux/mshv.h
>> +++ b/include/uapi/linux/mshv.h
>> @@ -13,6 +13,8 @@
>>
>>  #define MSHV_VERSION	0x0
>>
>> +#define MSHV_VP_MMAP_REGISTERS_OFFSET (HV_VP_STATE_PAGE_REGISTERS * 0x1000)
>> +
>>  struct mshv_create_partition {
>>  	__u64 flags;
>>  	struct hv_partition_creation_properties partition_creation_properties;
>> @@ -84,4 +86,14 @@ struct mshv_vp_state {
>>  #define MSHV_GET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0A, struct mshv_vp_state)
>>  #define MSHV_SET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0B, struct mshv_vp_state)
>>
>> +/* register page mapping example:
>> + * struct hv_vp_register_page *regs = mmap(NULL,
>> + *					   4096,
>> + *					   PROT_READ | PROT_WRITE,
>> + *					   MAP_SHARED,
>> + *					   vp_fd,
>> + *					   HV_VP_MMAP_REGISTERS_OFFSET);
>> + * munmap(regs, 4096);
>> + */
>> +
>>  #endif
>> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
>> index 70172d9488de..a597254fa4f4 100644
>> --- a/virt/mshv/mshv_main.c
>> +++ b/virt/mshv/mshv_main.c
>> @@ -43,11 +43,18 @@ static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl,
>> unsigned
>>  static int mshv_dev_open(struct inode *inode, struct file *filp);
>>  static int mshv_dev_release(struct inode *inode, struct file *filp);
>>  static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
>> +static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma);
>> +static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
>> +
>> +static const struct vm_operations_struct mshv_vp_vm_ops = {
>> +	.fault = mshv_vp_fault,
>> +};
>>
>>  static const struct file_operations mshv_vp_fops = {
>>  	.release = mshv_vp_release,
>>  	.unlocked_ioctl = mshv_vp_ioctl,
>>  	.llseek = noop_llseek,
>> +	.mmap = mshv_vp_mmap,
>>  };
>>
>>  static const struct file_operations mshv_partition_fops = {
>> @@ -499,6 +506,47 @@ hv_call_set_vp_registers(u32 vp_index,
>>  	return -hv_status_to_errno(status);
>>  }
>>
>> +static int
>> +hv_call_map_vp_state_page(u32 vp_index, u64 partition_id,
>> +			  struct page **state_page)
>> +{
>> +	struct hv_map_vp_state_page_in *input;
>> +	struct hv_map_vp_state_page_out *output;
>> +	int status;
>> +	int ret;
>> +	unsigned long flags;
>> +
>> +	do {
>> +		local_irq_save(flags);
>> +		input = (struct hv_map_vp_state_page_in *)(*this_cpu_ptr(
>> +			hyperv_pcpu_input_arg));
>> +		output = (struct hv_map_vp_state_page_out *)(*this_cpu_ptr(
>> +			hyperv_pcpu_output_arg));
>> +
>> +		input->partition_id = partition_id;
>> +		input->vp_index = vp_index;
>> +		input->type = HV_VP_STATE_PAGE_REGISTERS;
>> +		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE,
>> +						   input, output);
>> +
>> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
>> +			if (status == HV_STATUS_SUCCESS)
>> +				*state_page = pfn_to_page(output->map_location);
>> +			else
>> +				pr_err("%s: %s\n", __func__,
>> +				       hv_status_to_string(status));
>> +			local_irq_restore(flags);
>> +			ret = -hv_status_to_errno(status);
>> +			break;
>> +		}
>> +		local_irq_restore(flags);
>> +
>> +		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
>> +	} while (!ret);
>> +
>> +	return ret;
>> +}
>> +
>>  static void
>>  mshv_isr(void)
>>  {
>> @@ -1155,6 +1203,40 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long
>> arg)
>>  	return r;
>>  }
>>
>> +static vm_fault_t mshv_vp_fault(struct vm_fault *vmf)
>> +{
>> +	struct mshv_vp *vp = vmf->vma->vm_file->private_data;
>> +
>> +	vmf->page = vp->register_page;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	int ret;
>> +	struct mshv_vp *vp = file->private_data;
>> +
>> +	if (vma->vm_pgoff != MSHV_VP_MMAP_REGISTERS_OFFSET)
>> +		return -EINVAL;
>> +
>> +	if (mutex_lock_killable(&vp->mutex))
>> +		return -EINTR;
>> +
>> +	if (!vp->register_page) {
>> +		ret = hv_call_map_vp_state_page(vp->index,
>> +						vp->partition->id,
>> +						&vp->register_page);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	mutex_unlock(&vp->mutex);
>> +
>> +	vma->vm_ops = &mshv_vp_vm_ops;
>> +	return 0;
>> +}
>> +
>>  static int
>>  mshv_vp_release(struct inode *inode, struct file *filp)
>>  {
>> --
>> 2.25.1
