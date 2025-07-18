Return-Path: <linux-hyperv+bounces-6284-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E48B09A91
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 06:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6912A1C27438
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 04:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435FB17CA17;
	Fri, 18 Jul 2025 04:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RlWLsmZ+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460D354652;
	Fri, 18 Jul 2025 04:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752813404; cv=none; b=fQbfR9a63XJ9sbPeCfp09unpOMNznVYFzsV9bIsypupv/e+9O+7SDeqQzfVUDR+eA25PZHh5TF6y1ZkmW+mB8oTTC/uwQyPLzDcMu2XGoLE8TOkui6c/t6N9Nl9obFjFNVUyedd9NHzJ4eOPNifp/uPsinfjvmld3ymyjT7EhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752813404; c=relaxed/simple;
	bh=02+rzrkaWdYk4XqX6qVROaD+h8B04mfwIP44900eODw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nf5+OSqgLiVBopB2UYeD1JvlTFG7dHuXpo1zpRiQmlggf//+x0s27kx57tEr+GbEVn/TlPZyz2zHWa4UVHQRUo59t+Mw/ofwsKYtXtnySHMjKXBepQUFhKc31+N5rW7E1q37DIqzK6q9/PFuenzfvd32OgbBTR26zvzZn4KDlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RlWLsmZ+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.201.247] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 33A21201BA3B;
	Thu, 17 Jul 2025 21:36:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33A21201BA3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752813394;
	bh=3msD9fwQkpMOMR/LaQVT8uDRi44XqKFUNGZNjbcSPv4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=RlWLsmZ+aV+7VPoatTznmltu2AZwp45Ji1lU/+aYZWlL2Ni9a0bAY/WT3k45aT2zW
	 hjTuY4EzuT1n9lzEy1ky7s6BHwXPDDC5PjUpsDX/IO8i/wx2/cRM42isMsRr15mGR1
	 RRwsWYhnomXF89xR59C/6uI4c6yr5oWxorpVuxZs=
Message-ID: <42bc5294-219f-4c26-ad05-740f6190aff3@linux.microsoft.com>
Date: Fri, 18 Jul 2025 10:06:25 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH v5 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250611072704.83199-1-namjain@linux.microsoft.com>
 <20250611072704.83199-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157F9F1F8493C74C9FCC6E4D449A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB4157F9F1F8493C74C9FCC6E4D449A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/9/2025 10:49 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, June 11, 2025 12:27 AM
>>
>> Provide an interface for Virtual Machine Monitor like OpenVMM and its
>> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
>> Expose devices and support IOCTLs for features like VTL creation,
>> VTL0 memory management, context switch, making hypercalls,
>> mapping VTL0 address space to VTL2 userspace, getting new VMBus
>> messages and channel events in VTL2 etc.
>>
> 
> I know it has been 4 weeks since you posted this patch, but I'm just
> now getting around to reviewing it. :-(
> 
> I've reviewed most of it reasonably carefully, but there are some
> parts, such as entering/exiting VTLs that I don't know the details of,
> and so just glossed over.
> 
>> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
>> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>> Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>
>> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/Kconfig          |   23 +
>>   drivers/hv/Makefile         |    7 +-
>>   drivers/hv/mshv_vtl.h       |   52 +
>>   drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
>>   include/hyperv/hvgdk_mini.h |   81 ++
>>   include/hyperv/hvhdk.h      |    1 +
>>   include/uapi/linux/mshv.h   |   82 ++
>>   7 files changed, 2028 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/hv/mshv_vtl.h
>>   create mode 100644 drivers/hv/mshv_vtl_main.c
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 1cd188b73b74..1403b4abbece 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -73,4 +73,27 @@ config MSHV_ROOT
>>
>>   	  If unsure, say N.
>>
>> +config MSHV_VTL
>> +	tristate "Microsoft Hyper-V VTL driver"
>> +	depends on HYPERV && X86_64
>> +	# Mapping VTL0 memory to a userspace process in VTL2 is supported in OpenHCL.
>> +	# VTL2 for OpenHCL makes use of Huge Pages to improve performance on VMs,
>> +	# specially with large memory requirements.
>> +	depends on TRANSPARENT_HUGEPAGE
>> +	# MTRRs are controlled by VTL0, and are not specific to individual VTLs.
>> +	# Therefore, do not attempt to access or modify MTRRs here.
>> +	depends on !MTRR
>> +	select CPUMASK_OFFSTACK
>> +	select HYPERV_VTL_MODE
> 
> I think "depends on HYPERV_VTL_MODE" would work better here. Kconfig
> allows you to "select" something that has dependencies that aren't satisfied,
> with the result that the kernel probably won't build. HYPERV_VTL_MODE
> has dependencies like "SMP" that you would need to duplicate here. If
> you change this to "depends on", then you don't need "depends on HYPERV"
> because that's covered by HYPERV_VTL_MODE. It looks like for now this
> is restricted to X86_64, though I'm guessing at some point in the future that
> restriction will go away.

Will address in next patch.

> 
>> +	default n
>> +	help
>> +	  Select this option to enable Hyper-V VTL driver support.
>> +	  This driver provides interfaces for Virtual Machine Manager (VMM) running in VTL2
>> +	  userspace to create VTLs and partitions, setup and manage VTL0 memory and
>> +	  allow userspace to make direct hypercalls. This also allows to map VTL0's address
>> +	  space to a usermode process in VTL2 and supports getting new VMBus messages and channel
>> +	  events in VTL2.
>> +
>> +	  If unsure, say N.
>> +
>>   endmenu
>> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
>> index 976189c725dc..c53a0df746b7 100644
>> --- a/drivers/hv/Makefile
>> +++ b/drivers/hv/Makefile
>> @@ -3,6 +3,7 @@ obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
>>   obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
>>   obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
>>   obj-$(CONFIG_MSHV_ROOT)		+= mshv_root.o
>> +obj-$(CONFIG_MSHV_VTL)          += mshv_vtl.o
>>
>>   CFLAGS_hv_trace.o = -I$(src)
>>   CFLAGS_hv_balloon.o = -I$(src)
>> @@ -14,7 +15,11 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+=
>> hv_debugfs.o
>>   hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>>   mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
>>   	       mshv_root_hv_call.o mshv_portid_table.o
>> +mshv_vtl-y := mshv_vtl_main.o
>>
>>   # Code that must be built-in
>>   obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
>> -obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o mshv_common.o
>> +obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
>> +ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
>> +    obj-y += mshv_common.o
>> +endif
>> diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
>> new file mode 100644
>> index 000000000000..f765fda3601b
>> --- /dev/null
>> +++ b/drivers/hv/mshv_vtl.h
>> @@ -0,0 +1,52 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +#ifndef _MSHV_VTL_H
>> +#define _MSHV_VTL_H
>> +
>> +#include <linux/mshv.h>
>> +#include <linux/types.h>
>> +#include <asm/fpu/types.h>
>> +
>> +struct mshv_vtl_cpu_context {
>> +	union {
>> +		struct {
>> +			u64 rax;
>> +			u64 rcx;
>> +			u64 rdx;
>> +			u64 rbx;
>> +			u64 cr2;
>> +			u64 rbp;
>> +			u64 rsi;
>> +			u64 rdi;
>> +			u64 r8;
>> +			u64 r9;
>> +			u64 r10;
>> +			u64 r11;
>> +			u64 r12;
>> +			u64 r13;
>> +			u64 r14;
>> +			u64 r15;
>> +		};
>> +		u64 gp_regs[16];
>> +	};
>> +
>> +	struct fxregs_state fx_state;
>> +};
>> +
>> +struct mshv_vtl_run {
>> +	u32 cancel;
>> +	u32 vtl_ret_action_size;
>> +	u32 pad[2];
>> +	char exit_message[MSHV_MAX_RUN_MSG_SIZE];
>> +	union {
>> +		struct mshv_vtl_cpu_context cpu_context;
>> +
>> +		/*
>> +		 * Reserving room for the cpu context to grow and to maintain compatibility
>> +		 * with user mode.
>> +		 */
>> +		char reserved[1024];
>> +	};
>> +	char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
>> +};
>> +
>> +#endif /* _MSHV_VTL_H */
>> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
>> new file mode 100644
>> index 000000000000..b1717b118772
>> --- /dev/null
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -0,0 +1,1783 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Microsoft Corporation.
>> + *
>> + * Author:
>> + *   Roman Kisel <romank@linux.microsoft.com>
>> + *   Saurabh Sengar <ssengar@linux.microsoft.com>
>> + *   Naman Jain <namjain@linux.microsoft.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/anon_inodes.h>
>> +#include <linux/pfn_t.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/count_zeros.h>
>> +#include <linux/eventfd.h>
>> +#include <linux/poll.h>
>> +#include <linux/file.h>
>> +#include <linux/vmalloc.h>
>> +#include <asm/debugreg.h>
>> +#include <asm/mshyperv.h>
>> +#include <trace/events/ipi.h>
>> +#include <uapi/asm/mtrr.h>

<snip>

>> +#include <uapi/linux/mshv.h>
>> +#include <hyperv/hvhdk.h>
>> +
>> +#include "../../kernel/fpu/legacy.h"
>> +#include "mshv.h"
>> +#include "mshv_vtl.h"
>> +#include "hyperv_vmbus.h"
>> +
>> +MODULE_AUTHOR("Microsoft");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Microsoft Hyper-V VTL Driver");
>> +
>> +#define MSHV_ENTRY_REASON_LOWER_VTL_CALL     0x1
>> +#define MSHV_ENTRY_REASON_INTERRUPT          0x2
>> +#define MSHV_ENTRY_REASON_INTERCEPT          0x3
>> +
>> +#define MAX_GUEST_MEM_SIZE	BIT_ULL(40)
> 
> This definition doesn't appear to be used anywhere. I was curious
> about what the units are, but with no usage, maybe that's moot.

Removed in next patch.

> 
>> +#define MSHV_PG_OFF_CPU_MASK	0xFFFF
>> +#define MSHV_REAL_OFF_SHIFT	16
> 
> The above two definitions are related. Perhaps define the CPU_MASK
> as "BIT_ULL(MSHV_REAL_OFF_SHIFT) - 1" so the relationship is
> explicit?

That also works, noted.

> 
>> +#define MSHV_RUN_PAGE_OFFSET	0
>> +#define MSHV_REG_PAGE_OFFSET	1
>> +#define VTL2_VMBUS_SINT_INDEX	7
>> +
>> +static struct device *mem_dev;
>> +
>> +static struct tasklet_struct msg_dpc;
>> +static wait_queue_head_t fd_wait_queue;
>> +static bool has_message;
>> +static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
>> +static DEFINE_MUTEX(flag_lock);
>> +static bool __read_mostly mshv_has_reg_page;
>> +
>> +struct mshv_vtl_hvcall_fd {
>> +	u64 allow_bitmap[2 * PAGE_SIZE];
> 
> Having PAGE_SIZE here begs the question of what happens on ARM64 if the
> VTL0 guest has a page size other than 4K?  Does VTL2 always use 4K page
> size, or must the VTL2 page size match VTL0? The Kconfig file is currently
> set up with VTL2 supported only for x86, so the question is moot for the
> moment, but I'm thinking ahead.
>


VTL2 is always using 4K page size in both arm64 and x86, as per usecase.
However, having PAGE_SIZE is not necessary in allow_bitmap size. Will
remove it. More explanation in below comments.


> Separately, "allow_bitmap" size is 64K bytes, or 512K bits. Is that the
> correct size?  From looking at mshv_vtl_hvcall_is_allowed(), I think this
> bitmap is indexed by the HV call code, which is a 16 bit value. So you
> only need 64K bits, and the size is too big by a factor of 8. In any case,
> it seems like the size should not be expressed in terms of PAGE_SIZE.

There are HVcall codes which are of type u16. So max(HVcall code) =
0xffff.

For every HVcall that needs to be allowed, we are saving HVcall code
info in a bitmap in below fashion:
if x = HVCall code and bitmap is an array of u64, of size
((0xffff/64=1023) + 1)

bitmap[x / 64] = (u64)1 << (x%64);

Later on in mshv_vtl_hvcall_is_allowed(), we calculate the array index
by dividing it by 64, and then see if call_code/64 bit is set.

Coming to size of allow_bitmap[], it is independent of PAGE_SIZE, and
can be safely initialized to 1024 (reducing by a factor of 8).
bitmap_size's maximum value is going to be 1024 in current
implementation, picking u64 was not mandatory, u16 will also work. Also,
item_index is also u16, so I should make bitmap_size as u16.

> 
>> +	bool allow_map_initialized;
>> +	/*
>> +	 * Used to protect hvcall setup in IOCTLs
>> +	 */
>> +	struct mutex init_mutex;
>> +	struct miscdevice *dev;
>> +};
>> +
>> +struct mshv_vtl_poll_file {
>> +	struct file *file;
>> +	wait_queue_entry_t wait;
>> +	wait_queue_head_t *wqh;
>> +	poll_table pt;
>> +	int cpu;
>> +};
>> +
>> +struct mshv_vtl {
>> +	struct device *module_dev;
>> +	u64 id;
>> +};
>> +
>> +union mshv_synic_overlay_page_msr {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 enabled: 1;
>> +		u64 reserved: 11;
>> +		u64 pfn: 52;
>> +	};
> 
> Since this appear to be a Hyper-V synthetic MSR, add __packed?

Acked.

> 
>> +};
>> +
>> +union hv_register_vsm_capabilities {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 dr6_shared: 1;
>> +		u64 mbec_vtl_mask: 16;
>> +		u64 deny_lower_vtl_startup: 1;
>> +		u64 supervisor_shadow_stack: 1;
>> +		u64 hardware_hvpt_available: 1;
>> +		u64 software_hvpt_available: 1;
>> +		u64 hardware_hvpt_range_bits: 6;
>> +		u64 intercept_page_available: 1;
>> +		u64 return_action_available: 1;
>> +		u64 reserved: 35;
>> +	} __packed;
>> +};
>> +
>> +union hv_register_vsm_page_offsets {
>> +	struct {
>> +		u64 vtl_call_offset : 12;
>> +		u64 vtl_return_offset : 12;
>> +		u64 reserved_mbz : 40;
>> +	};
>> +	u64 as_uint64;
>> +} __packed;
> 
> We've usually put the __packed on the struct definition.  Consistency .... :-)

Acked. Will move __packed from union to struct.

> 
> Don't these three register definitions belong somewhere in the
> hvhdk or hvgdk include files?
> 

Moved them to hvgdk_mini.c

Will move hv_register_vsm_capabilities and hv_register_vsm_page_offsets
to hvgdk_mini.h and keep mshv_synic_overlay_page_msr here, with the
comment that Nuno pointed in his reply.


>> +
>> +struct mshv_vtl_per_cpu {
>> +	struct mshv_vtl_run *run;
>> +	struct page *reg_page;
>> +};
>> +
>> +static struct mutex mshv_vtl_poll_file_lock;
>> +static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
>> +static union hv_register_vsm_capabilities mshv_vsm_capabilities;
>> +
>> +static DEFINE_PER_CPU(struct mshv_vtl_poll_file, mshv_vtl_poll_file);
>> +static DEFINE_PER_CPU(unsigned long long, num_vtl0_transitions);
>> +static DEFINE_PER_CPU(struct mshv_vtl_per_cpu, mshv_vtl_per_cpu);
>> +
>> +static const struct file_operations mshv_vtl_fops;
>> +
>> +static long
>> +mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
>> +{
>> +	struct mshv_vtl *vtl;
>> +	struct file *file;
>> +	int fd;
>> +
>> +	vtl = kzalloc(sizeof(*vtl), GFP_KERNEL);
>> +	if (!vtl)
>> +		return -ENOMEM;
>> +
>> +	fd = get_unused_fd_flags(O_CLOEXEC);
>> +	if (fd < 0) {
>> +		kfree(vtl);
>> +		return fd;
>> +	}
>> +	file = anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
>> +				  vtl, O_RDWR);
>> +	if (IS_ERR(file)) {
>> +		kfree(vtl);
>> +		return PTR_ERR(file);
>> +	}
>> +	vtl->module_dev = module_dev;
>> +	fd_install(fd, file);
>> +
>> +	return fd;
>> +}
>> +
>> +static long
>> +mshv_ioctl_check_extension(void __user *user_arg)
>> +{
>> +	u32 arg;
>> +
>> +	if (copy_from_user(&arg, user_arg, sizeof(arg)))
>> +		return -EFAULT;
>> +
>> +	switch (arg) {
>> +	case MSHV_CAP_CORE_API_STABLE:
>> +		return 0;
>> +	case MSHV_CAP_REGISTER_PAGE:
>> +		return mshv_has_reg_page;
>> +	case MSHV_CAP_VTL_RETURN_ACTION:
>> +		return mshv_vsm_capabilities.return_action_available;
>> +	case MSHV_CAP_DR6_SHARED:
>> +		return mshv_vsm_capabilities.dr6_shared;
>> +	}
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static long
>> +mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>> +{
>> +	struct miscdevice *misc = filp->private_data;
>> +
>> +	switch (ioctl) {
>> +	case MSHV_CHECK_EXTENSION:
>> +		return mshv_ioctl_check_extension((void __user *)arg);
>> +	case MSHV_CREATE_VTL:
>> +		return mshv_ioctl_create_vtl((void __user *)arg, misc->this_device);
>> +	}
>> +
>> +	return -ENOTTY;
>> +}
>> +
>> +static const struct file_operations mshv_dev_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.unlocked_ioctl	= mshv_dev_ioctl,
>> +	.llseek		= noop_llseek,
>> +};
>> +
>> +static struct miscdevice mshv_dev = {
>> +	.minor = MISC_DYNAMIC_MINOR,
>> +	.name = "mshv",
>> +	.fops = &mshv_dev_fops,
>> +	.mode = 0600,
>> +};
>> +
>> +static struct mshv_vtl_run *mshv_vtl_this_run(void)
>> +{
>> +	return *this_cpu_ptr(&mshv_vtl_per_cpu.run);
>> +}
>> +
>> +static struct mshv_vtl_run *mshv_vtl_cpu_run(int cpu)
>> +{
>> +	return *per_cpu_ptr(&mshv_vtl_per_cpu.run, cpu);
>> +}
>> +
>> +static struct page *mshv_vtl_cpu_reg_page(int cpu)
>> +{
>> +	return *per_cpu_ptr(&mshv_vtl_per_cpu.reg_page, cpu);
>> +}
>> +
>> +static void mshv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
>> +{
>> +	struct hv_register_assoc reg_assoc = {};
>> +	union mshv_synic_overlay_page_msr overlay = {};
>> +	struct page *reg_page;
>> +	union hv_input_vtl vtl = { .as_uint8 = 0 };
> 
> This is the first of several places in this module where you need an input_vtl
> value of 0.  Rather than declare and initialize a local variable for each use
> case, I'd suggest declaring a global static at the top of the module, and reuse
> that global whenever needed.
> 

Acked.

>> +
>> +	reg_page = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
>> +	if (!reg_page) {
>> +		WARN(1, "failed to allocate register page\n");
>> +		return;
>> +	}
>> +
>> +	overlay.enabled = 1;
>> +	overlay.pfn = page_to_phys(reg_page) >> HV_HYP_PAGE_SHIFT;
> 
> Could use page_to_hvpfn() here.

Acked.

> 
>> +	reg_assoc.name = HV_X64_REGISTER_REG_PAGE;
>> +	reg_assoc.value.reg64 = overlay.as_uint64;
>> +
>> +	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
>> +				     1, vtl, &reg_assoc)) {
>> +		WARN(1, "failed to setup register page\n");
>> +		__free_page(reg_page);
>> +		return;
>> +	}
>> +
>> +	per_cpu->reg_page = reg_page;
>> +	mshv_has_reg_page = true;
>> +}
>> +
>> +static void mshv_vtl_synic_enable_regs(unsigned int cpu)
>> +{
>> +	union hv_synic_sint sint;
>> +
>> +	sint.as_uint64 = 0;
>> +	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
>> +	sint.masked = false;
>> +	sint.auto_eoi = hv_recommend_using_aeoi();
>> +
>> +	/* Enable intercepts */
>> +	if (!mshv_vsm_capabilities.intercept_page_available)
>> +		hv_set_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
>> +			   sint.as_uint64);
>> +
>> +	/* VTL2 Host VSP SINT is (un)masked when the user mode requests that */
>> +}
>> +
>> +static int mshv_vtl_get_vsm_regs(void)
>> +{
>> +	struct hv_register_assoc registers[2];
>> +	union hv_input_vtl input_vtl;
>> +	int ret, count = 2;
>> +
>> +	input_vtl.as_uint8 = 0;
> 
> One of the places I mentioned earlier where you could use global value
> instead of having to set up input_vtl here.

Will take care of all instances.

> 
>> +	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
>> +	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
>> +
>> +	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
>> +				       count, input_vtl, registers);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
>> +	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
>> +
>> +	return ret;
>> +}
>> +
>> +static int mshv_vtl_configure_vsm_partition(struct device *dev)
>> +{
>> +	union hv_register_vsm_partition_config config;
>> +	struct hv_register_assoc reg_assoc;
>> +	union hv_input_vtl input_vtl;
>> +
>> +	config.as_uint64 = 0;
>> +	config.default_vtl_protection_mask = HV_MAP_GPA_PERMISSIONS_MASK;
>> +	config.enable_vtl_protection = 1;
>> +	config.zero_memory_on_reset = 1;
>> +	config.intercept_vp_startup = 1;
>> +	config.intercept_cpuid_unimplemented = 1;
>> +
>> +	if (mshv_vsm_capabilities.intercept_page_available) {
>> +		dev_dbg(dev, "using intercept page\n");
>> +		config.intercept_page = 1;
>> +	}
>> +
>> +	reg_assoc.name = HV_REGISTER_VSM_PARTITION_CONFIG;
>> +	reg_assoc.value.reg64 = config.as_uint64;
>> +	input_vtl.as_uint8 = 0;
> 
> Another place to use the global input_vtl.

Acked.

> 
>> +
>> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
>> +				       1, input_vtl, &reg_assoc);
>> +}
>> +
>> +static void mshv_vtl_vmbus_isr(void)
>> +{
>> +	struct hv_per_cpu_context *per_cpu;
>> +	struct hv_message *msg;
>> +	u32 message_type;
>> +	union hv_synic_event_flags *event_flags;
>> +	unsigned long word;
>> +	int i, j;
>> +	struct eventfd_ctx *eventfd;
>> +
>> +	per_cpu = this_cpu_ptr(hv_context.cpu_context);
>> +	if (smp_processor_id() == 0) {
>> +		msg = (struct hv_message *)per_cpu->synic_message_page + VTL2_VMBUS_SINT_INDEX;
>> +		message_type = READ_ONCE(msg->header.message_type);
>> +		if (message_type != HVMSG_NONE)
>> +			tasklet_schedule(&msg_dpc);
>> +	}
>> +
>> +	event_flags = (union hv_synic_event_flags *)per_cpu->synic_event_page +
>> +			VTL2_VMBUS_SINT_INDEX;
>> +	for (i = 0; i < HV_EVENT_FLAGS_LONG_COUNT; i++) {
>> +		if (READ_ONCE(event_flags->flags[i])) {
>> +			word = xchg(&event_flags->flags[i], 0);
>> +			for_each_set_bit(j, &word, BITS_PER_LONG) {
> 
> Is there a reason for the complexity in finding and resetting bits that are
> set in the sync_event_page?  See the code in vmbus_chan_sched() that I
> think is doing the same thing, but with simpler code.

I am sorry, but I am not sure how this can be written similar to
vmbus_chan_sched(). We don't have eventfd signaling mechanism there.
Can you please share some more info/code snippet of what you were
suggesting?


> 
>> +				rcu_read_lock();
>> +				eventfd = READ_ONCE(flag_eventfds[i * BITS_PER_LONG + j]);
>> +				if (eventfd)
>> +					eventfd_signal(eventfd);
>> +				rcu_read_unlock();
>> +			}
>> +		}
>> +	}
>> +
>> +	vmbus_isr();
>> +}
>> +
>> +static int mshv_vtl_alloc_context(unsigned int cpu)
>> +{
>> +	struct mshv_vtl_per_cpu *per_cpu = this_cpu_ptr(&mshv_vtl_per_cpu);
>> +	struct page *run_page;
>> +
>> +	run_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> 
> Nit: Using __get_free_page() here would avoid having to deal with struct page,
> and having to translate from struct page to a virtual address.

Acked.

> 
>> +	if (!run_page)
>> +		return -ENOMEM;
>> +
>> +	per_cpu->run = page_address(run_page);
>> +	if (mshv_vsm_capabilities.intercept_page_available)
>> +		mshv_vtl_configure_reg_page(per_cpu);
>> +
>> +	mshv_vtl_synic_enable_regs(cpu);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mshv_vtl_cpuhp_online;
>> +
>> +static int hv_vtl_setup_synic(void)
>> +{
>> +	int ret;
>> +
>> +	/* Use our isr to first filter out packets destined for userspace */
>> +	hv_setup_vmbus_handler(mshv_vtl_vmbus_isr);
> 
> Will the normal vmbus_isr() already be setup as the vmbus_handler when this
> is called?  If so, then this will overwrite vmbus_isr() with mshv_vtl_vmbus_isr().

In my experiments, yes.

> 
>> +
>> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
>> +				mshv_vtl_alloc_context, NULL);
>> +	if (ret < 0) {
>> +		hv_remove_vmbus_handler();
> 
> But the error case won't restore vmbus_isr(). It will set vmbus_handler to NULL.
> I'm not sure if that's OK or not. Maybe it doesn't really matter.

In this fail case, mshv_vtl_init would abort, and things would not move
forward in OpenHCL. However, for completeness sake, I can replace
s/ hv_remove_vmbus_handler() / hv_setup_vmbus_handler(vmbus_isr)

> 
>> +		return ret;
>> +	}
>> +
>> +	mshv_vtl_cpuhp_online = ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static void hv_vtl_remove_synic(void)
>> +{
>> +	hv_remove_vmbus_handler();
>> +	cpuhp_remove_state(mshv_vtl_cpuhp_online);
> 
> Unless there's a reason otherwise, for symmetry these two steps
> should be done in the opposite order. The "remove" operation should
> typically do things in the reverse order of the "setup" operation.
> 
> And again, note that this won't restore vmbus_handler if
> vmbus_isr() was overwritten in hv_vtl_setup_synic().
> 

Acked. Will reorder this and replace remove with setup again.

>> +}
>> +
>> +static int vtl_get_vp_registers(u16 count,
>> +				struct hv_register_assoc *registers)
>> +{
>> +	union hv_input_vtl input_vtl;
>> +
>> +	input_vtl.as_uint8 = 0;
>> +	input_vtl.use_target_vtl = 1;
> 
> You can also setup a static global for this case.

Acked.

> 
>> +
>> +	return hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
>> +					count, input_vtl, registers);
>> +}
>> +
>> +static int vtl_set_vp_registers(u16 count,
>> +				struct hv_register_assoc *registers)
>> +{
>> +	union hv_input_vtl input_vtl;
>> +
>> +	input_vtl.as_uint8 = 0;
>> +	input_vtl.use_target_vtl = 1;
> 
> And reuse the global here.

Acked.

> 
>> +
>> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
>> +					count, input_vtl, registers);
>> +}
>> +
>> +static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
>> +{
>> +	struct mshv_vtl_ram_disposition vtl0_mem;
>> +	struct dev_pagemap *pgmap;
>> +	void *addr;
>> +
>> +	if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
>> +		return -EFAULT;
>> +
>> +	if (vtl0_mem.last_pfn <= vtl0_mem.start_pfn) {
>> +		dev_err(vtl->module_dev, "range start pfn (%llx) > end pfn (%llx)\n",
>> +			vtl0_mem.start_pfn, vtl0_mem.last_pfn);
>> +		return -EFAULT;
>> +	}
>> +
>> +	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
>> +	if (!pgmap)
>> +		return -ENOMEM;
>> +
>> +	pgmap->ranges[0].start = PFN_PHYS(vtl0_mem.start_pfn);
>> +	pgmap->ranges[0].end = PFN_PHYS(vtl0_mem.last_pfn) - 1;
> 
> Perhaps this should be
> 
> 	pgmap->ranges[0].end = PFN_PHYS(vtl0_mem.last_pfn + 1) - 1
> 
> otherwise the last page won't be included in the range. Or is excluding the
> last page intentional?

Excluding the last page is intentional. Hence there is a check for this
as well:
if (vtl0_mem.last_pfn <= vtl0_mem.start_pfn) {

> 
>> +	pgmap->nr_range = 1;
>> +	pgmap->type = MEMORY_DEVICE_GENERIC;
>> +
>> +	/*
>> +	 * Determine the highest page order that can be used for the given memory range.
>> +	 * This works best when the range is aligned; i.e. both the start and the length.
>> +	 */
>> +	pgmap->vmemmap_shift = count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn);
>> +	dev_dbg(vtl->module_dev,
>> +		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
>> +		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
>> +
>> +	addr = devm_memremap_pages(mem_dev, pgmap);
>> +	if (IS_ERR(addr)) {
>> +		dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", PTR_ERR(addr));
>> +		kfree(pgmap);
>> +		return -EFAULT;
>> +	}
>> +
>> +	/* Don't free pgmap, since it has to stick around until the memory
>> +	 * is unmapped, which will never happen as there is no scenario
>> +	 * where VTL0 can be released/shutdown without bringing down VTL2.
>> +	 */
>> +	return 0;
>> +}
>> +
>> +static void mshv_vtl_cancel(int cpu)
>> +{
>> +	int here = get_cpu();
>> +
>> +	if (here != cpu) {
>> +		if (!xchg_relaxed(&mshv_vtl_cpu_run(cpu)->cancel, 1))
>> +			smp_send_reschedule(cpu);
>> +	} else {
>> +		WRITE_ONCE(mshv_vtl_this_run()->cancel, 1);
>> +	}
>> +	put_cpu();
>> +}
>> +
>> +static int mshv_vtl_poll_file_wake(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
>> +{
>> +	struct mshv_vtl_poll_file *poll_file = container_of(wait, struct mshv_vtl_poll_file, wait);
>> +
>> +	mshv_vtl_cancel(poll_file->cpu);
>> +
>> +	return 0;
>> +}
>> +
>> +static void mshv_vtl_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
>> +{
>> +	struct mshv_vtl_poll_file *poll_file = container_of(pt, struct mshv_vtl_poll_file, pt);
>> +
>> +	WARN_ON(poll_file->wqh);
>> +	poll_file->wqh = wqh;
>> +	add_wait_queue(wqh, &poll_file->wait);
>> +}
>> +
>> +static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *user_input)
>> +{
>> +	struct file *file, *old_file;
>> +	struct mshv_vtl_poll_file *poll_file;
>> +	struct mshv_vtl_set_poll_file input;
>> +
>> +	if (copy_from_user(&input, user_input, sizeof(input)))
>> +		return -EFAULT;
> 
> Seems like input.cpu should be checked to make sure it's less than nr_cpu_ids.
> cpu_online() uses the value to index into a bit array without doing any checks
> unless CONFIG_DEBUG_PER_CPU_MAPS is set.

Thanks, will add that.

> 
>> +
>> +	if (!cpu_online(input.cpu))
>> +		return -EINVAL;
> 
> Having tested that the target CPU is online, does anything ensure that the
> CPU stays online during the completion of this function? Usually the
> cpus_read_lock() needs to be held to ensure that an online CPU stays
> online for the duration of an operation.

Added cpus_read_lock() block around per_cpu_ptr operation. In general,
CPUs are never hotplugged in kernel from our Usecase POV. I have omitted
adding these locks at other places for now. Please let me know your
thoughts on this, in case you feel we need to have it.

> 
>> +
>> +	file = NULL;
>> +	file = fget(input.fd);
>> +	if (!file)
>> +		return -EBADFD;
>> +
>> +	poll_file = per_cpu_ptr(&mshv_vtl_poll_file, READ_ONCE(input.cpu));
>> +	if (!poll_file)
>> +		return -EINVAL;
> 
> Testing poll_file here confused me a bit. per_cpu_ptr() just does some pointer
> arithmetic and doesn't return NULL from what I can tell.

per_cpu_ptr may point to wrong addresses if input.cpu is not correct or
greater than NR_CPUS. In any case, it should not be NULL. So I will
remove it. Thanks for noticing this.

> 
>> +
>> +	mutex_lock(&mshv_vtl_poll_file_lock);
>> +
>> +	if (poll_file->wqh)
>> +		remove_wait_queue(poll_file->wqh, &poll_file->wait);
>> +	poll_file->wqh = NULL;
>> +
>> +	old_file = poll_file->file;
>> +	poll_file->file = file;
>> +	poll_file->cpu = input.cpu;
>> +
>> +	if (file) {
>> +		init_waitqueue_func_entry(&poll_file->wait, mshv_vtl_poll_file_wake);
>> +		init_poll_funcptr(&poll_file->pt, mshv_vtl_ptable_queue_proc);
>> +		vfs_poll(file, &poll_file->pt);
>> +	}
>> +
>> +	mutex_unlock(&mshv_vtl_poll_file_lock);
>> +
>> +	if (old_file)
>> +		fput(old_file);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mshv_vtl_set_reg(struct hv_register_assoc *regs)
>> +{
>> +	u64 reg64;
>> +	enum hv_register_name gpr_name;
>> +
>> +	gpr_name = regs->name;
>> +	reg64 = regs->value.reg64;
>> +
>> +	switch (gpr_name) {
>> +	case HV_X64_REGISTER_DR0:
>> +		native_set_debugreg(0, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_DR1:
>> +		native_set_debugreg(1, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_DR2:
>> +		native_set_debugreg(2, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_DR3:
>> +		native_set_debugreg(3, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_DR6:
>> +		if (!mshv_vsm_capabilities.dr6_shared)
>> +			goto hypercall;
>> +		native_set_debugreg(6, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_CAP:
>> +		wrmsrl(MSR_MTRRcap, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
>> +		wrmsrl(MSR_MTRRdefType, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
>> +		wrmsrl(MTRRphysBase_MSR(0), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
>> +		wrmsrl(MTRRphysBase_MSR(1), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
>> +		wrmsrl(MTRRphysBase_MSR(2), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
>> +		wrmsrl(MTRRphysBase_MSR(3), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
>> +		wrmsrl(MTRRphysBase_MSR(4), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
>> +		wrmsrl(MTRRphysBase_MSR(5), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
>> +		wrmsrl(MTRRphysBase_MSR(6), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
>> +		wrmsrl(MTRRphysBase_MSR(7), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
>> +		wrmsrl(MTRRphysBase_MSR(8), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
>> +		wrmsrl(MTRRphysBase_MSR(9), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
>> +		wrmsrl(MTRRphysBase_MSR(0xa), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
>> +		wrmsrl(MTRRphysBase_MSR(0xb), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
>> +		wrmsrl(MTRRphysBase_MSR(0xc), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
>> +		wrmsrl(MTRRphysBase_MSR(0xd), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
>> +		wrmsrl(MTRRphysBase_MSR(0xe), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
>> +		wrmsrl(MTRRphysBase_MSR(0xf), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
>> +		wrmsrl(MTRRphysMask_MSR(0), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
>> +		wrmsrl(MTRRphysMask_MSR(1), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
>> +		wrmsrl(MTRRphysMask_MSR(2), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
>> +		wrmsrl(MTRRphysMask_MSR(3), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
>> +		wrmsrl(MTRRphysMask_MSR(4), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
>> +		wrmsrl(MTRRphysMask_MSR(5), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
>> +		wrmsrl(MTRRphysMask_MSR(6), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
>> +		wrmsrl(MTRRphysMask_MSR(7), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
>> +		wrmsrl(MTRRphysMask_MSR(8), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
>> +		wrmsrl(MTRRphysMask_MSR(9), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
>> +		wrmsrl(MTRRphysMask_MSR(0xa), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
>> +		wrmsrl(MTRRphysMask_MSR(0xb), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
>> +		wrmsrl(MTRRphysMask_MSR(0xc), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
>> +		wrmsrl(MTRRphysMask_MSR(0xd), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
>> +		wrmsrl(MTRRphysMask_MSR(0xe), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
>> +		wrmsrl(MTRRphysMask_MSR(0xf), reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX64K00000:
>> +		wrmsrl(MSR_MTRRfix64K_00000, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX16K80000:
>> +		wrmsrl(MSR_MTRRfix16K_80000, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX16KA0000:
>> +		wrmsrl(MSR_MTRRfix16K_A0000, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC0000:
>> +		wrmsrl(MSR_MTRRfix4K_C0000, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC8000:
>> +		wrmsrl(MSR_MTRRfix4K_C8000, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD0000:
>> +		wrmsrl(MSR_MTRRfix4K_D0000, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD8000:
>> +		wrmsrl(MSR_MTRRfix4K_D8000, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE0000:
>> +		wrmsrl(MSR_MTRRfix4K_E0000, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE8000:
>> +		wrmsrl(MSR_MTRRfix4K_E8000, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF0000:
>> +		wrmsrl(MSR_MTRRfix4K_F0000, reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF8000:
>> +		wrmsrl(MSR_MTRRfix4K_F8000, reg64);
>> +		break;
>> +
>> +	default:
>> +		goto hypercall;
>> +	}
>> +
>> +	return 0;
>> +
>> +hypercall:
>> +	return 1;
>> +}
> 
> To me, this function and the follow-on mshv_vtl_get_reg() are just
> begging to be implemented using a static table that maps from
> HV_X64_REGISTER_MSR* to MSR* (at least for the ~45 entries that
> are not debug registers). Each of the functions could then search
> through the table to find the HV_X64_REGISTER* and get the
> matching x86 MSR value, followed by a single invocation of wrmsr()
> or rdmsrl(). The generated code for mshv_vtl_set_reg() is about
> 1550 bytes, and a table search would be a lot smaller. The size
> of mshv_vtl_get_reg() would be similarly reduced using the same
> table. You'd probably end up with at least 100 fewer source code
> lines as well.
> 

:) makes sense, will change it.

>> +
>> +static int mshv_vtl_get_reg(struct hv_register_assoc *regs)
>> +{
>> +	u64 *reg64;
>> +	enum hv_register_name gpr_name;
>> +
>> +	gpr_name = regs->name;
>> +	reg64 = (u64 *)&regs->value.reg64;
>> +
>> +	switch (gpr_name) {
>> +	case HV_X64_REGISTER_DR0:
>> +		*reg64 = native_get_debugreg(0);
>> +		break;
>> +	case HV_X64_REGISTER_DR1:
>> +		*reg64 = native_get_debugreg(1);
>> +		break;
>> +	case HV_X64_REGISTER_DR2:
>> +		*reg64 = native_get_debugreg(2);
>> +		break;
>> +	case HV_X64_REGISTER_DR3:
>> +		*reg64 = native_get_debugreg(3);
>> +		break;
>> +	case HV_X64_REGISTER_DR6:
>> +		if (!mshv_vsm_capabilities.dr6_shared)
>> +			goto hypercall;
>> +		*reg64 = native_get_debugreg(6);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_CAP:
>> +		rdmsrl(MSR_MTRRcap, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
>> +		rdmsrl(MSR_MTRRdefType, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
>> +		rdmsrl(MTRRphysBase_MSR(0), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
>> +		rdmsrl(MTRRphysBase_MSR(1), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
>> +		rdmsrl(MTRRphysBase_MSR(2), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
>> +		rdmsrl(MTRRphysBase_MSR(3), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
>> +		rdmsrl(MTRRphysBase_MSR(4), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
>> +		rdmsrl(MTRRphysBase_MSR(5), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
>> +		rdmsrl(MTRRphysBase_MSR(6), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
>> +		rdmsrl(MTRRphysBase_MSR(7), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
>> +		rdmsrl(MTRRphysBase_MSR(8), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
>> +		rdmsrl(MTRRphysBase_MSR(9), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
>> +		rdmsrl(MTRRphysBase_MSR(0xa), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
>> +		rdmsrl(MTRRphysBase_MSR(0xb), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
>> +		rdmsrl(MTRRphysBase_MSR(0xc), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
>> +		rdmsrl(MTRRphysBase_MSR(0xd), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
>> +		rdmsrl(MTRRphysBase_MSR(0xe), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
>> +		rdmsrl(MTRRphysBase_MSR(0xf), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
>> +		rdmsrl(MTRRphysMask_MSR(0), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
>> +		rdmsrl(MTRRphysMask_MSR(1), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
>> +		rdmsrl(MTRRphysMask_MSR(2), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
>> +		rdmsrl(MTRRphysMask_MSR(3), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
>> +		rdmsrl(MTRRphysMask_MSR(4), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
>> +		rdmsrl(MTRRphysMask_MSR(5), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
>> +		rdmsrl(MTRRphysMask_MSR(6), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
>> +		rdmsrl(MTRRphysMask_MSR(7), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
>> +		rdmsrl(MTRRphysMask_MSR(8), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
>> +		rdmsrl(MTRRphysMask_MSR(9), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
>> +		rdmsrl(MTRRphysMask_MSR(0xa), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
>> +		rdmsrl(MTRRphysMask_MSR(0xb), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
>> +		rdmsrl(MTRRphysMask_MSR(0xc), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
>> +		rdmsrl(MTRRphysMask_MSR(0xd), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
>> +		rdmsrl(MTRRphysMask_MSR(0xe), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
>> +		rdmsrl(MTRRphysMask_MSR(0xf), *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX64K00000:
>> +		rdmsrl(MSR_MTRRfix64K_00000, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX16K80000:
>> +		rdmsrl(MSR_MTRRfix16K_80000, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX16KA0000:
>> +		rdmsrl(MSR_MTRRfix16K_A0000, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC0000:
>> +		rdmsrl(MSR_MTRRfix4K_C0000, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC8000:
>> +		rdmsrl(MSR_MTRRfix4K_C8000, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD0000:
>> +		rdmsrl(MSR_MTRRfix4K_D0000, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD8000:
>> +		rdmsrl(MSR_MTRRfix4K_D8000, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE0000:
>> +		rdmsrl(MSR_MTRRfix4K_E0000, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE8000:
>> +		rdmsrl(MSR_MTRRfix4K_E8000, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF0000:
>> +		rdmsrl(MSR_MTRRfix4K_F0000, *reg64);
>> +		break;
>> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF8000:
>> +		rdmsrl(MSR_MTRRfix4K_F8000, *reg64);
>> +		break;
>> +
>> +	default:
>> +		goto hypercall;
>> +	}
>> +
>> +	return 0;
>> +
>> +hypercall:
>> +	return 1;
>> +}
>> +
>> +static void mshv_vtl_return(struct mshv_vtl_cpu_context *vtl0)
>> +{
>> +	struct hv_vp_assist_page *hvp;
>> +	u64 hypercall_addr;
>> +
>> +	register u64 r8 asm("r8");
>> +	register u64 r9 asm("r9");
>> +	register u64 r10 asm("r10");
>> +	register u64 r11 asm("r11");
>> +	register u64 r12 asm("r12");
>> +	register u64 r13 asm("r13");
>> +	register u64 r14 asm("r14");
>> +	register u64 r15 asm("r15");
>> +
>> +	hvp = hv_vp_assist_page[smp_processor_id()];
>> +
>> +	/*
>> +	 * Process signal event direct set in the run page, if any.
>> +	 */
>> +	if (mshv_vsm_capabilities.return_action_available) {
>> +		u32 offset = READ_ONCE(mshv_vtl_this_run()->vtl_ret_action_size);
>> +
>> +		WRITE_ONCE(mshv_vtl_this_run()->vtl_ret_action_size, 0);
>> +
>> +		/*
>> +		 * Hypervisor will take care of clearing out the actions
>> +		 * set in the assist page.
>> +		 */
>> +		memcpy(hvp->vtl_ret_actions,
>> +		       mshv_vtl_this_run()->vtl_ret_actions,
>> +		       min_t(u32, offset, sizeof(hvp->vtl_ret_actions)));
>> +	}
>> +
>> +	hvp->vtl_ret_x64rax = vtl0->rax;
>> +	hvp->vtl_ret_x64rcx = vtl0->rcx;
>> +
>> +	hypercall_addr = (u64)((u8 *)hv_hypercall_pg + mshv_vsm_page_offsets.vtl_return_offset);
>> +
>> +	kernel_fpu_begin_mask(0);
>> +	fxrstor(&vtl0->fx_state);
>> +	native_write_cr2(vtl0->cr2);
>> +	r8 = vtl0->r8;
>> +	r9 = vtl0->r9;
>> +	r10 = vtl0->r10;
>> +	r11 = vtl0->r11;
>> +	r12 = vtl0->r12;
>> +	r13 = vtl0->r13;
>> +	r14 = vtl0->r14;
>> +	r15 = vtl0->r15;
>> +
>> +	asm __volatile__ (	\
>> +	/* Save rbp pointer to the lower VTL, keep the stack 16-byte aligned */
>> +		"pushq	%%rbp\n"
>> +		"pushq	%%rcx\n"
>> +	/* Restore the lower VTL's rbp */
>> +		"movq	(%%rcx), %%rbp\n"
>> +	/* Load return kind into rcx (HV_VTL_RETURN_INPUT_NORMAL_RETURN == 0)
>> */
>> +		"xorl	%%ecx, %%ecx\n"
>> +	/* Transition to the lower VTL */
>> +		CALL_NOSPEC
>> +	/* Save VTL0's rax and rcx temporarily on 16-byte aligned stack */
>> +		"pushq	%%rax\n"
>> +		"pushq	%%rcx\n"
>> +	/* Restore pointer to lower VTL rbp */
>> +		"movq	16(%%rsp), %%rax\n"
>> +	/* Save the lower VTL's rbp */
>> +		"movq	%%rbp, (%%rax)\n"
>> +	/* Restore saved registers */
>> +		"movq	8(%%rsp), %%rax\n"
>> +		"movq	24(%%rsp), %%rbp\n"
>> +		"addq	$32, %%rsp\n"
>> +
>> +		: "=a"(vtl0->rax), "=c"(vtl0->rcx),
>> +		  "+d"(vtl0->rdx), "+b"(vtl0->rbx), "+S"(vtl0->rsi), "+D"(vtl0->rdi),
>> +		  "+r"(r8), "+r"(r9), "+r"(r10), "+r"(r11),
>> +		  "+r"(r12), "+r"(r13), "+r"(r14), "+r"(r15)
>> +		: THUNK_TARGET(hypercall_addr), "c"(&vtl0->rbp)
>> +		: "cc", "memory");
>> +
>> +	vtl0->r8 = r8;
>> +	vtl0->r9 = r9;
>> +	vtl0->r10 = r10;
>> +	vtl0->r11 = r11;
>> +	vtl0->r12 = r12;
>> +	vtl0->r13 = r13;
>> +	vtl0->r14 = r14;
>> +	vtl0->r15 = r15;
>> +	vtl0->cr2 = native_read_cr2();
>> +
>> +	fxsave(&vtl0->fx_state);
>> +	kernel_fpu_end();
>> +}
>> +
>> +/*
>> + * Returning to a lower VTL treats the base pointer register
>> + * as a general purpose one. Without adding this, objtool produces
>> + * a warning.
>> + */
>> +STACK_FRAME_NON_STANDARD(mshv_vtl_return);
>> +
>> +static bool mshv_vtl_process_intercept(void)
>> +{
>> +	struct hv_per_cpu_context *mshv_cpu;
>> +	void *synic_message_page;
>> +	struct hv_message *msg;
>> +	u32 message_type;
>> +
>> +	mshv_cpu = this_cpu_ptr(hv_context.cpu_context);
>> +	synic_message_page = mshv_cpu->synic_message_page;
>> +	if (unlikely(!synic_message_page))
>> +		return true;
>> +
>> +	msg = (struct hv_message *)synic_message_page + HV_SYNIC_INTERCEPTION_SINT_INDEX;
>> +	message_type = READ_ONCE(msg->header.message_type);
>> +	if (message_type == HVMSG_NONE)
>> +		return true;
>> +
>> +	memcpy(mshv_vtl_this_run()->exit_message, msg, sizeof(*msg));
>> +	vmbus_signal_eom(msg, message_type);
>> +
>> +	return false;
>> +}
>> +
>> +static int mshv_vtl_ioctl_return_to_lower_vtl(void)
>> +{
>> +	preempt_disable();
>> +	for (;;) {
>> +		const unsigned long VTL0_WORK = _TIF_SIGPENDING | _TIF_NEED_RESCHED |
>> +						_TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL;
>> +		unsigned long ti_work;
>> +		u32 cancel;
>> +		unsigned long irq_flags;
>> +		struct hv_vp_assist_page *hvp;
>> +		int ret;
>> +
>> +		local_irq_save(irq_flags);
>> +		ti_work = READ_ONCE(current_thread_info()->flags);
>> +		cancel = READ_ONCE(mshv_vtl_this_run()->cancel);
>> +		if (unlikely((ti_work & VTL0_WORK) || cancel)) {
>> +			local_irq_restore(irq_flags);
>> +			preempt_enable();
>> +			if (cancel)
>> +				ti_work |= _TIF_SIGPENDING;
>> +			ret = mshv_do_pre_guest_mode_work(ti_work);
>> +			if (ret)
>> +				return ret;
>> +			preempt_disable();
>> +			continue;
>> +		}
>> +
>> +		mshv_vtl_return(&mshv_vtl_this_run()->cpu_context);
>> +		local_irq_restore(irq_flags);
>> +
>> +		hvp = hv_vp_assist_page[smp_processor_id()];
>> +		this_cpu_inc(num_vtl0_transitions);
>> +		switch (hvp->vtl_entry_reason) {
>> +		case MSHV_ENTRY_REASON_INTERRUPT:
>> +			if (!mshv_vsm_capabilities.intercept_page_available &&
>> +			    likely(!mshv_vtl_process_intercept()))
>> +				goto done;
>> +			break;
>> +
>> +		case MSHV_ENTRY_REASON_INTERCEPT:
>> +			WARN_ON(!mshv_vsm_capabilities.intercept_page_available);
>> +			memcpy(mshv_vtl_this_run()->exit_message, hvp->intercept_message,
>> +			       sizeof(hvp->intercept_message));
>> +			goto done;
>> +
>> +		default:
>> +			panic("unknown entry reason: %d", hvp->vtl_entry_reason);
>> +		}
>> +	}
>> +
>> +done:
>> +	preempt_enable();
>> +
>> +	return 0;
>> +}
>> +
>> +static long
>> +mshv_vtl_ioctl_get_regs(void __user *user_args)
>> +{
>> +	struct mshv_vp_registers args;
>> +	struct hv_register_assoc *registers;
>> +	long ret;
>> +
>> +	if (copy_from_user(&args, user_args, sizeof(args)))
>> +		return -EFAULT;
>> +
>> +	if (args.count == 0 || args.count > MSHV_VP_MAX_REGISTERS)
>> +		return -EINVAL;
>> +
>> +	registers = kmalloc_array(args.count,
>> +				  sizeof(*registers),
>> +				  GFP_KERNEL);
>> +	if (!registers)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(registers, (void __user *)args.regs_ptr,
>> +			   sizeof(*registers) * args.count)) {
>> +		ret = -EFAULT;
>> +		goto free_return;
>> +	}
>> +
>> +	ret = mshv_vtl_get_reg(registers);
>> +	if (!ret)
>> +		goto copy_args; /* No need of hypercall */
> 
> I'm puzzled by the functionality here. The input to this function may
> specify up to MSHV_VP_MAX_REGISTERS, which is 128. But if the
> first register in the input is handled by mshv_vtl_get_reg(), then
> no additional register values are retrieved. But the full set of
> register values are copied back to user space, all of which
> except the first are just whatever register values were originally
> copied in from user space.

Userspace in our case (OpenVMM) was always sending one register per
IOCTL, so this code always worked. However, to avoid confusion, I will
remove the consideration of args.count here and always process the first
register only. Will also add a note here. The feature could have been
extended to include a bunch of registers at once, but due to
complications in implementation of how many registers actually were set
successfully and to report back the failed registers to userspace, we
thought of keeping it simple as one register per IOCTL. This is also not
a performance sensitive path, so it should be fine.

> 
>> +	ret = vtl_get_vp_registers(args.count, registers);
>> +	if (ret)
>> +		goto free_return;
>> +
>> +copy_args:
>> +	if (copy_to_user((void __user *)args.regs_ptr, registers,
>> +			 sizeof(*registers) * args.count))
>> +		ret = -EFAULT;
>> +free_return:
>> +	kfree(registers);
>> +
>> +	return ret;
>> +}
>> +
>> +static long
>> +mshv_vtl_ioctl_set_regs(void __user *user_args)
>> +{
>> +	struct mshv_vp_registers args;
>> +	struct hv_register_assoc *registers;
>> +	long ret;
>> +
>> +	if (copy_from_user(&args, user_args, sizeof(args)))
>> +		return -EFAULT;
>> +
>> +	if (args.count == 0 || args.count > MSHV_VP_MAX_REGISTERS)
>> +		return -EINVAL;
>> +
>> +	registers = kmalloc_array(args.count,
>> +				  sizeof(*registers),
>> +				  GFP_KERNEL);
>> +	if (!registers)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(registers, (void __user *)args.regs_ptr,
>> +			   sizeof(*registers) * args.count)) {
>> +		ret = -EFAULT;
>> +		goto free_return;
>> +	}
>> +
>> +	ret = mshv_vtl_set_reg(registers);
>> +	if (!ret)
>> +		goto free_return; /* No need of hypercall */
> 
> Again, I'm puzzled by the functionality because only the first
> register value is set if mshv_vtl_set_reg() handles that register.
> The other specified register values are ignored.

Covered in my previous reply.

> 
>> +	ret = vtl_set_vp_registers(args.count, registers);
>> +
>> +free_return:
>> +	kfree(registers);
>> +
>> +	return ret;
>> +}
>> +
>> +static long
>> +mshv_vtl_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>> +{
>> +	long ret;
>> +	struct mshv_vtl *vtl = filp->private_data;
>> +
>> +	switch (ioctl) {
>> +	case MSHV_SET_POLL_FILE:
>> +		ret = mshv_vtl_ioctl_set_poll_file((struct mshv_vtl_set_poll_file *)arg);
>> +		break;
>> +	case MSHV_GET_VP_REGISTERS:
>> +		ret = mshv_vtl_ioctl_get_regs((void __user *)arg);
>> +		break;
>> +	case MSHV_SET_VP_REGISTERS:
>> +		ret = mshv_vtl_ioctl_set_regs((void __user *)arg);
>> +		break;
>> +	case MSHV_RETURN_TO_LOWER_VTL:
>> +		ret = mshv_vtl_ioctl_return_to_lower_vtl();
>> +		break;
>> +	case MSHV_ADD_VTL0_MEMORY:
>> +		ret = mshv_vtl_ioctl_add_vtl0_mem(vtl, (void __user *)arg);
>> +		break;
>> +	default:
>> +		dev_err(vtl->module_dev, "invalid vtl ioctl: %#x\n", ioctl);
>> +		ret = -ENOTTY;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
>> +{
>> +	struct page *page;
>> +	int cpu = vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
>> +	int real_off = vmf->pgoff >> MSHV_REAL_OFF_SHIFT;
>> +
>> +	if (!cpu_online(cpu))
>> +		return VM_FAULT_SIGBUS;
> 
> Same question as earlier -- what ensures the CPU stays online
> after the above test?

It was based on assumptions, I will add cpu_read_lock/unlock.

> 
>> +
>> +	if (real_off == MSHV_RUN_PAGE_OFFSET) {
>> +		page = virt_to_page(mshv_vtl_cpu_run(cpu));
>> +	} else if (real_off == MSHV_REG_PAGE_OFFSET) {
>> +		if (!mshv_has_reg_page)
>> +			return VM_FAULT_SIGBUS;
>> +		page = mshv_vtl_cpu_reg_page(cpu);
>> +	} else {
>> +		return VM_FAULT_NOPAGE;
>> +	}
>> +
>> +	get_page(page);
>> +	vmf->page = page;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct vm_operations_struct mshv_vtl_vm_ops = {
>> +	.fault = mshv_vtl_fault,
>> +};
>> +
>> +static int mshv_vtl_mmap(struct file *filp, struct vm_area_struct *vma)
>> +{
>> +	vma->vm_ops = &mshv_vtl_vm_ops;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mshv_vtl_release(struct inode *inode, struct file *filp)
>> +{
>> +	struct mshv_vtl *vtl = filp->private_data;
>> +
>> +	kfree(vtl);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations mshv_vtl_fops = {
>> +	.owner = THIS_MODULE,
>> +	.unlocked_ioctl = mshv_vtl_ioctl,
>> +	.release = mshv_vtl_release,
>> +	.mmap = mshv_vtl_mmap,
>> +};
>> +
>> +static void mshv_vtl_synic_mask_vmbus_sint(const u8 *mask)
>> +{
>> +	union hv_synic_sint sint;
>> +
>> +	sint.as_uint64 = 0;
>> +	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
>> +	sint.masked = (*mask != 0);
>> +	sint.auto_eoi = hv_recommend_using_aeoi();
>> +
>> +	hv_set_msr(HV_MSR_SINT0 + VTL2_VMBUS_SINT_INDEX,
>> +		   sint.as_uint64);
>> +
>> +	if (!sint.masked)
>> +		pr_debug("%s: Unmasking VTL2 VMBUS SINT on VP %d\n", __func__, smp_processor_id());
>> +	else
>> +		pr_debug("%s: Masking VTL2 VMBUS SINT on VP %d\n", __func__, smp_processor_id());
>> +}
>> +
>> +static void mshv_vtl_read_remote(void *buffer)
>> +{
>> +	struct hv_per_cpu_context *mshv_cpu = this_cpu_ptr(hv_context.cpu_context);
>> +	struct hv_message *msg = (struct hv_message *)mshv_cpu->synic_message_page +
>> +					VTL2_VMBUS_SINT_INDEX;
>> +	u32 message_type = READ_ONCE(msg->header.message_type);
>> +
>> +	WRITE_ONCE(has_message, false);
>> +	if (message_type == HVMSG_NONE)
>> +		return;
>> +
>> +	memcpy(buffer, msg, sizeof(*msg));
>> +	vmbus_signal_eom(msg, message_type);
>> +}
>> +
>> +static bool vtl_synic_mask_vmbus_sint_masked = true;
>> +
>> +static ssize_t mshv_vtl_sint_read(struct file *filp, char __user *arg, size_t size, loff_t
>> *offset)
>> +{
>> +	struct hv_message msg = {};
>> +	int ret;
>> +
>> +	if (size < sizeof(msg))
>> +		return -EINVAL;
>> +
>> +	for (;;) {
>> +		smp_call_function_single(VMBUS_CONNECT_CPU, mshv_vtl_read_remote, &msg, true);
>> +		if (msg.header.message_type != HVMSG_NONE)
>> +			break;
>> +
>> +		if (READ_ONCE(vtl_synic_mask_vmbus_sint_masked))
>> +			return 0; /* EOF */
>> +
>> +		if (filp->f_flags & O_NONBLOCK)
>> +			return -EAGAIN;
>> +
>> +		ret = wait_event_interruptible(fd_wait_queue,
>> +					       READ_ONCE(has_message) ||
>> +						READ_ONCE(vtl_synic_mask_vmbus_sint_masked));
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (copy_to_user(arg, &msg, sizeof(msg)))
>> +		return -EFAULT;
>> +
>> +	return sizeof(msg);
>> +}
>> +
>> +static __poll_t mshv_vtl_sint_poll(struct file *filp, poll_table *wait)
>> +{
>> +	__poll_t mask = 0;
>> +
>> +	poll_wait(filp, &fd_wait_queue, wait);
>> +	if (READ_ONCE(has_message) || READ_ONCE(vtl_synic_mask_vmbus_sint_masked))
>> +		mask |= EPOLLIN | EPOLLRDNORM;
>> +
>> +	return mask;
>> +}
>> +
>> +static void mshv_vtl_sint_on_msg_dpc(unsigned long data)
>> +{
>> +	WRITE_ONCE(has_message, true);
>> +	wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
>> +}
>> +
>> +static int mshv_vtl_sint_ioctl_post_message(struct mshv_vtl_sint_post_msg __user *arg)
>> +{
>> +	struct mshv_vtl_sint_post_msg message;
>> +	u8 payload[HV_MESSAGE_PAYLOAD_BYTE_COUNT];
>> +
>> +	if (copy_from_user(&message, arg, sizeof(message)))
>> +		return -EFAULT;
>> +	if (message.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT)
>> +		return -EINVAL;
>> +	if (copy_from_user(payload, (void __user *)message.payload_ptr,
>> +			   message.payload_size))
>> +		return -EFAULT;
>> +
>> +	return hv_post_message((union hv_connection_id)message.connection_id,
>> +			       message.message_type, (void *)payload,
>> +			       message.payload_size);
>> +}
>> +
>> +static int mshv_vtl_sint_ioctl_signal_event(struct mshv_vtl_signal_event __user *arg)
>> +{
>> +	u64 input;
>> +	struct mshv_vtl_signal_event signal_event;
>> +
>> +	if (copy_from_user(&signal_event, arg, sizeof(signal_event)))
>> +		return -EFAULT;
>> +
>> +	input = signal_event.connection_id | ((u64)signal_event.flag << 32);
>> +
>> +	return hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, input) & HV_HYPERCALL_RESULT_MASK;
> 
> The return value is inconsistent here. It might be a negative errno if
> copy_from_user() fails, or it might be a Hyper-V hypercall result code. The
> caller is mshv_vtl_sint_ioctl(), which is called from vfs_ioctl(), which
> expects a return value of 0 on success, and a negative errno on error.
> 
> You can use hv_result_to_errno() here to translate the hypercall result
> code to a negative errno.
> 

Acked.


>> +}
>> +
>> +static int mshv_vtl_sint_ioctl_set_eventfd(struct mshv_vtl_set_eventfd __user *arg)
>> +{
>> +	struct mshv_vtl_set_eventfd set_eventfd;
>> +	struct eventfd_ctx *eventfd, *old_eventfd;
>> +
>> +	if (copy_from_user(&set_eventfd, arg, sizeof(set_eventfd)))
>> +		return -EFAULT;
>> +	if (set_eventfd.flag >= HV_EVENT_FLAGS_COUNT)
>> +		return -EINVAL;
>> +
>> +	eventfd = NULL;
>> +	if (set_eventfd.fd >= 0) {
>> +		eventfd = eventfd_ctx_fdget(set_eventfd.fd);
>> +		if (IS_ERR(eventfd))
>> +			return PTR_ERR(eventfd);
>> +	}
>> +
>> +	mutex_lock(&flag_lock);
>> +	old_eventfd = flag_eventfds[set_eventfd.flag];
>> +	WRITE_ONCE(flag_eventfds[set_eventfd.flag], eventfd);
>> +	mutex_unlock(&flag_lock);
> 
> The above looks a little weird. Generally, if you are using READ_ONCE()
> or WRITE_ONCE() for a field, you should use them everywhere the field
> is referenced. I see that there is a READ_ONCE() in mshv_vtl_vmbus_isr().
> For robustness, I'd suggest using READ_ONCE() above to read the old value.
> 

I added these to resolve some issues with one of the static analyser
tools. Initially they were not there. Will add READ_ONCE now.

>> +
>> +	if (old_eventfd) {
>> +		synchronize_rcu();
>> +		eventfd_ctx_put(old_eventfd);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int mshv_vtl_sint_ioctl_pause_message_stream(struct mshv_sint_mask __user *arg)
>> +{
>> +	static DEFINE_MUTEX(vtl2_vmbus_sint_mask_mutex);
>> +	struct mshv_sint_mask mask;
>> +
>> +	if (copy_from_user(&mask, arg, sizeof(mask)))
>> +		return -EFAULT;
>> +	mutex_lock(&vtl2_vmbus_sint_mask_mutex);
>> +	on_each_cpu((smp_call_func_t)mshv_vtl_synic_mask_vmbus_sint, &mask.mask, 1);
>> +	WRITE_ONCE(vtl_synic_mask_vmbus_sint_masked, mask.mask != 0);
>> +	mutex_unlock(&vtl2_vmbus_sint_mask_mutex);
>> +	if (mask.mask)
>> +		wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
>> +
>> +	return 0;
>> +}
>> +
>> +static long mshv_vtl_sint_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
>> +{
>> +	switch (cmd) {
>> +	case MSHV_SINT_POST_MESSAGE:
>> +		return mshv_vtl_sint_ioctl_post_message((struct mshv_vtl_sint_post_msg *)arg);
>> +	case MSHV_SINT_SIGNAL_EVENT:
>> +		return mshv_vtl_sint_ioctl_signal_event((struct mshv_vtl_signal_event *)arg);
>> +	case MSHV_SINT_SET_EVENTFD:
>> +		return mshv_vtl_sint_ioctl_set_eventfd((struct mshv_vtl_set_eventfd *)arg);
>> +	case MSHV_SINT_PAUSE_MESSAGE_STREAM:
>> +		return mshv_vtl_sint_ioctl_pause_message_stream((struct mshv_sint_mask *)arg);
>> +	default:
>> +		return -ENOIOCTLCMD;
>> +	}
>> +}
>> +
>> +static const struct file_operations mshv_vtl_sint_ops = {
>> +	.owner = THIS_MODULE,
>> +	.read = mshv_vtl_sint_read,
>> +	.poll = mshv_vtl_sint_poll,
>> +	.unlocked_ioctl = mshv_vtl_sint_ioctl,
>> +};
>> +
>> +static struct miscdevice mshv_vtl_sint_dev = {
>> +	.name = "mshv_sint",
>> +	.fops = &mshv_vtl_sint_ops,
>> +	.mode = 0600,
>> +	.minor = MISC_DYNAMIC_MINOR,
>> +};
>> +
>> +static int mshv_vtl_hvcall_open(struct inode *node, struct file *f)
>> +{
>> +	struct miscdevice *dev = f->private_data;
>> +	struct mshv_vtl_hvcall_fd *fd;
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	fd = vzalloc(sizeof(*fd));
>> +	if (!fd)
>> +		return -ENOMEM;
>> +	fd->dev = dev;
>> +	f->private_data = fd;
>> +	mutex_init(&fd->init_mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mshv_vtl_hvcall_release(struct inode *node, struct file *f)
>> +{
>> +	struct mshv_vtl_hvcall_fd *fd;
>> +
>> +	fd = f->private_data;
>> +	if (fd) {
>> +		vfree(fd);
>> +		f->private_data = NULL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int mshv_vtl_hvcall_setup(struct mshv_vtl_hvcall_fd *fd,
>> +				 struct mshv_vtl_hvcall_setup __user *hvcall_setup_user)
>> +{
>> +	int ret = 0;
>> +	struct mshv_vtl_hvcall_setup hvcall_setup;
>> +
>> +	mutex_lock(&fd->init_mutex);
>> +
>> +	if (fd->allow_map_initialized) {
>> +		dev_err(fd->dev->this_device,
>> +			"Hypercall allow map has already been set, pid %d\n",
>> +			current->pid);
>> +		ret = -EINVAL;
>> +		goto exit;
>> +	}
>> +
>> +	if (copy_from_user(&hvcall_setup, hvcall_setup_user,
>> +			   sizeof(struct mshv_vtl_hvcall_setup))) {
>> +		ret = -EFAULT;
>> +		goto exit;
>> +	}
>> +	if (hvcall_setup.bitmap_size > ARRAY_SIZE(fd->allow_bitmap)) {
> 
> This implies that "bitmap_size" is in units of u64.


Covered in earlier reply.


> 
>> +		ret = -EINVAL;
>> +		goto exit;
>> +	}
>> +	if (copy_from_user(&fd->allow_bitmap,
>> +			   (void __user *)hvcall_setup.allow_bitmap_ptr,
>> +			   hvcall_setup.bitmap_size)) {
> 
> But this implies that "bitmap_size" is in units of bytes. So something is wrong.

Ditto.

> 
>> +		ret = -EFAULT;
>> +		goto exit;
>> +	}
>> +
>> +	dev_info(fd->dev->this_device, "Hypercall allow map has been set, pid %d\n",
>> +		 current->pid);
>> +	fd->allow_map_initialized = true;
>> +exit:
>> +	mutex_unlock(&fd->init_mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static bool mshv_vtl_hvcall_is_allowed(struct mshv_vtl_hvcall_fd *fd, u16 call_code)
>> +{
>> +	u8 bits_per_item = 8 * sizeof(fd->allow_bitmap[0]);
>> +	u16 item_index = call_code / bits_per_item;
>> +	u64 mask = 1ULL << (call_code % bits_per_item);
>> +
>> +	return fd->allow_bitmap[item_index] & mask;
> 
> See earlier comment on the size of "allow_bitmap".  This code implies the
> size should be 64K bits, but the size is actually 512K bits.


Ditto.

> 
>> +}
>> +
>> +static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
>> +				struct mshv_vtl_hvcall __user *hvcall_user)
>> +{
>> +	struct mshv_vtl_hvcall hvcall;
>> +	void *in, *out;
>> +	int ret;
>> +
>> +	if (copy_from_user(&hvcall, hvcall_user, sizeof(struct mshv_vtl_hvcall)))
>> +		return -EFAULT;
>> +	if (hvcall.input_size > HV_HYP_PAGE_SIZE)
>> +		return -EINVAL;
>> +	if (hvcall.output_size > HV_HYP_PAGE_SIZE)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * By default, all hypercalls are not allowed.
>> +	 * The user mode code has to set up the allow bitmap once.
>> +	 */
>> +
>> +	if (!mshv_vtl_hvcall_is_allowed(fd, hvcall.control & 0xFFFF)) {
>> +		dev_err(fd->dev->this_device,
>> +			"Hypercall with control data %#llx isn't allowed\n",
>> +			hvcall.control);
>> +		return -EPERM;
>> +	}
>> +
>> +	/*
>> +	 * This may create a problem for Confidential VM (CVM) usecase where we need to use
>> +	 * Hyper-V driver allocated per-cpu input and output pages (hyperv_pcpu_input_arg and
>> +	 * hyperv_pcpu_output_arg) for making a hypervisor call.
>> +	 *
>> +	 * TODO: Take care of this when CVM support is added.
>> +	 */
>> +	in = (void *)__get_free_page(GFP_KERNEL);
>> +	out = (void *)__get_free_page(GFP_KERNEL);
>> +
>> +	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_size)) {
>> +		ret = -EFAULT;
>> +		goto free_pages;
>> +	}
>> +
>> +	hvcall.status = hv_do_hypercall(hvcall.control, in, out);
>> +
>> +	if (copy_to_user((void __user *)hvcall.output_ptr, out, hvcall.output_size)) {
>> +		ret = -EFAULT;
>> +		goto free_pages;
>> +	}
>> +	ret = put_user(hvcall.status, &hvcall_user->status);
>> +free_pages:
>> +	free_page((unsigned long)in);
>> +	free_page((unsigned long)out);
>> +
>> +	return ret;
>> +}
>> +
>> +static long mshv_vtl_hvcall_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
>> +{
>> +	struct mshv_vtl_hvcall_fd *fd = f->private_data;
>> +
>> +	switch (cmd) {
>> +	case MSHV_HVCALL_SETUP:
>> +		return mshv_vtl_hvcall_setup(fd, (struct mshv_vtl_hvcall_setup __user *)arg);
>> +	case MSHV_HVCALL:
>> +		return mshv_vtl_hvcall_call(fd, (struct mshv_vtl_hvcall __user *)arg);
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -ENOIOCTLCMD;
>> +}
>> +
>> +static const struct file_operations mshv_vtl_hvcall_file_ops = {
>> +	.owner = THIS_MODULE,
>> +	.open = mshv_vtl_hvcall_open,
>> +	.release = mshv_vtl_hvcall_release,
>> +	.unlocked_ioctl = mshv_vtl_hvcall_ioctl,
>> +};
>> +
>> +static struct miscdevice mshv_vtl_hvcall = {
> 
> Unfortunately, this global variable name ("mshv_vtl_hvcall") is the
> same as the name of struct mshv_vtl_hvcall in include/uapi/linux/mshv.h.
> Even though it works, could some other name be used here to avoid
> any ambiguity?

Will change for this and mshv_vtl_hvcall_setup as well.

> 
>> +	.name = "mshv_hvcall",
>> +	.nodename = "mshv_hvcall",
>> +	.fops = &mshv_vtl_hvcall_file_ops,
>> +	.mode = 0600,
>> +	.minor = MISC_DYNAMIC_MINOR,
>> +};
>> +
>> +static int mshv_vtl_low_open(struct inode *inodep, struct file *filp)
>> +{
>> +	pid_t pid = task_pid_vnr(current);
>> +	uid_t uid = current_uid().val;
>> +	int ret = 0;
>> +
>> +	pr_debug("%s: Opening VTL low, task group %d, uid %d\n", __func__, pid, uid);
>> +
>> +	if (capable(CAP_SYS_ADMIN)) {
>> +		filp->private_data = inodep;
>> +	} else {
>> +		pr_err("%s: VTL low open failed: CAP_SYS_ADMIN required. task group %d, uid %d",
>> +		       __func__, pid, uid);
>> +		ret = -EPERM;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static bool can_fault(struct vm_fault *vmf, unsigned long size, pfn_t *pfn)
>> +{
>> +	unsigned long mask = size - 1;
>> +	unsigned long start = vmf->address & ~mask;
>> +	unsigned long end = start + size;
>> +	bool is_valid;
>> +
>> +	is_valid = (vmf->address & mask) == ((vmf->pgoff << PAGE_SHIFT) & mask) &&
>> +		start >= vmf->vma->vm_start &&
>> +		end <= vmf->vma->vm_end;
>> +
>> +	if (is_valid)
>> +		*pfn = __pfn_to_pfn_t(vmf->pgoff & ~(mask >> PAGE_SHIFT), PFN_DEV | PFN_MAP);
>> +
>> +	return is_valid;
>> +}
>> +
>> +static vm_fault_t mshv_vtl_low_huge_fault(struct vm_fault *vmf, unsigned int order)
>> +{
>> +	pfn_t pfn;
>> +	int ret = VM_FAULT_FALLBACK;
>> +
>> +	switch (order) {
>> +	case 0:
>> +		pfn = __pfn_to_pfn_t(vmf->pgoff, PFN_DEV | PFN_MAP);
>> +		return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
>> +
>> +	case PMD_ORDER:
>> +		if (can_fault(vmf, PMD_SIZE, &pfn))
>> +			ret = vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
>> +		return ret;
>> +
>> +	case PUD_ORDER:
>> +		if (can_fault(vmf, PUD_SIZE, &pfn))
>> +			ret = vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
>> +		return ret;
>> +
>> +	default:
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +}
> 
> There's an 'mm' patch set currently in linux-next that eliminates pfn_t, PFN_DEV, and
> PFN_MAP. Assuming the patch set goes into 6.17, the fault handling code here will need
> some rework. See
> https://lore.kernel.org/lkml/cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com/
> 

Thanks for sharing this, will take care of it.

>> +
>> +static vm_fault_t mshv_vtl_low_fault(struct vm_fault *vmf)
>> +{
>> +	return mshv_vtl_low_huge_fault(vmf, 0);
>> +}
>> +
>> +static const struct vm_operations_struct mshv_vtl_low_vm_ops = {
>> +	.fault = mshv_vtl_low_fault,
>> +	.huge_fault = mshv_vtl_low_huge_fault,
>> +};
>> +
>> +static int mshv_vtl_low_mmap(struct file *filp, struct vm_area_struct *vma)
>> +{
>> +	vma->vm_ops = &mshv_vtl_low_vm_ops;
>> +	vm_flags_set(vma, VM_HUGEPAGE | VM_MIXEDMAP);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations mshv_vtl_low_file_ops = {
>> +	.owner		= THIS_MODULE,
>> +	.open		= mshv_vtl_low_open,
>> +	.mmap		= mshv_vtl_low_mmap,
>> +};
>> +
>> +static struct miscdevice mshv_vtl_low = {
>> +	.name = "mshv_vtl_low",
>> +	.nodename = "mshv_vtl_low",
>> +	.fops = &mshv_vtl_low_file_ops,
>> +	.mode = 0600,
>> +	.minor = MISC_DYNAMIC_MINOR,
>> +};
>> +
>> +static int __init mshv_vtl_init(void)
>> +{
>> +	int ret;
>> +	struct device *dev = mshv_dev.this_device;
>> +
>> +	/*
>> +	 * This creates /dev/mshv which provides functionality to create VTLs and partitions.
>> +	 */
>> +	ret = misc_register(&mshv_dev);
>> +	if (ret) {
>> +		dev_err(dev, "mshv device register failed: %d\n", ret);
>> +		goto free_dev;
>> +	}
>> +
>> +	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
>> +	init_waitqueue_head(&fd_wait_queue);
>> +
>> +	if (mshv_vtl_get_vsm_regs()) {
>> +		dev_emerg(dev, "Unable to get VSM capabilities !!\n");
>> +		ret = -ENODEV;
>> +		goto free_dev;
>> +	}
>> +	if (mshv_vtl_configure_vsm_partition(dev)) {
>> +		dev_emerg(dev, "VSM configuration failed !!\n");
>> +		ret = -ENODEV;
>> +		goto free_dev;
>> +	}
>> +
>> +	ret = hv_vtl_setup_synic();
>> +	if (ret)
>> +		goto free_dev;
>> +
>> +	/*
>> +	 * mshv_sint device adds VMBus relay ioctl support.
>> +	 * This provides a channel for VTL0 to communicate with VTL2.
>> +	 */
>> +	ret = misc_register(&mshv_vtl_sint_dev);
>> +	if (ret)
>> +		goto free_synic;
>> +
>> +	/*
>> +	 * mshv_hvcall device adds interface to enable userspace for direct hypercalls support.
>> +	 */
>> +	ret = misc_register(&mshv_vtl_hvcall);
>> +	if (ret)
>> +		goto free_sint;
>> +
>> +	/*
>> +	 * mshv_vtl_low device is used to map VTL0 address space to a user-mode process in VTL2.
>> +	 * It implements mmap() to allow a user-mode process in VTL2 to map to the address of VTL0.
>> +	 */
>> +	ret = misc_register(&mshv_vtl_low);
>> +	if (ret)
>> +		goto free_hvcall;
>> +
>> +	/*
>> +	 * "mshv vtl mem dev" device is later used to setup VTL0 memory.
>> +	 */
>> +	mem_dev = kzalloc(sizeof(*mem_dev), GFP_KERNEL);
>> +	if (!mem_dev) {
>> +		ret = -ENOMEM;
>> +		goto free_low;
>> +	}
>> +
>> +	mutex_init(&mshv_vtl_poll_file_lock);
>> +
>> +	device_initialize(mem_dev);
>> +	dev_set_name(mem_dev, "mshv vtl mem dev");
>> +	ret = device_add(mem_dev);
>> +	if (ret) {
>> +		dev_err(dev, "mshv vtl mem dev add: %d\n", ret);
>> +		goto free_mem;
>> +	}
>> +
>> +	return 0;
>> +
>> +free_mem:
>> +	kfree(mem_dev);
>> +free_low:
>> +	misc_deregister(&mshv_vtl_low);
>> +free_hvcall:
>> +	misc_deregister(&mshv_vtl_hvcall);
>> +free_sint:
>> +	misc_deregister(&mshv_vtl_sint_dev);
>> +free_synic:
>> +	hv_vtl_remove_synic();
>> +free_dev:
>> +	misc_deregister(&mshv_dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static void __exit mshv_vtl_exit(void)
>> +{
>> +	device_del(mem_dev);
>> +	kfree(mem_dev);
>> +	misc_deregister(&mshv_vtl_low);
>> +	misc_deregister(&mshv_vtl_hvcall);
>> +	misc_deregister(&mshv_vtl_sint_dev);
>> +	hv_vtl_remove_synic();
>> +	misc_deregister(&mshv_dev);
>> +}
>> +
>> +module_init(mshv_vtl_init);
>> +module_exit(mshv_vtl_exit);
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index 1be7f6a02304..cc9260c37c49 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>> @@ -882,6 +882,23 @@ struct hv_get_vp_from_apic_id_in {
>>   	u32 apic_ids[];
>>   } __packed;
>>
>> +union hv_register_vsm_partition_config {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 enable_vtl_protection : 1;
>> +		u64 default_vtl_protection_mask : 4;
>> +		u64 zero_memory_on_reset : 1;
>> +		u64 deny_lower_vtl_startup : 1;
>> +		u64 intercept_acceptance : 1;
>> +		u64 intercept_enable_vtl_protection : 1;
>> +		u64 intercept_vp_startup : 1;
>> +		u64 intercept_cpuid_unimplemented : 1;
>> +		u64 intercept_unrecoverable_exception : 1;
>> +		u64 intercept_page : 1;
>> +		u64 mbz : 51;
>> +	};
> 
> Add __packed since this is a binary interface with Hyper-V.
> All the other register definitions have __packed.

Acked.

> 
>> +};
>> +
>>   struct hv_nested_enlightenments_control {
>>   	struct {
>>   		u32 directhypercall : 1;
>> @@ -1004,6 +1021,70 @@ enum hv_register_name {
>>
>>   	/* VSM */
>>   	HV_REGISTER_VSM_VP_STATUS				= 0x000D0003,
>> +
>> +	/* Synthetic VSM registers */
>> +	HV_REGISTER_VSM_CODE_PAGE_OFFSETS	= 0x000D0002,
>> +	HV_REGISTER_VSM_CAPABILITIES		= 0x000D0006,
>> +	HV_REGISTER_VSM_PARTITION_CONFIG	= 0x000D0007,
>> +
>> +#if defined(CONFIG_X86)
>> +	/* X64 Debug Registers */
>> +	HV_X64_REGISTER_DR0	= 0x00050000,
>> +	HV_X64_REGISTER_DR1	= 0x00050001,
>> +	HV_X64_REGISTER_DR2	= 0x00050002,
>> +	HV_X64_REGISTER_DR3	= 0x00050003,
>> +	HV_X64_REGISTER_DR6	= 0x00050004,
>> +	HV_X64_REGISTER_DR7	= 0x00050005,
>> +
>> +	/* X64 Cache control MSRs */
>> +	HV_X64_REGISTER_MSR_MTRR_CAP		= 0x0008000D,
>> +	HV_X64_REGISTER_MSR_MTRR_DEF_TYPE	= 0x0008000E,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0	= 0x00080010,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1	= 0x00080011,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2	= 0x00080012,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3	= 0x00080013,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4	= 0x00080014,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5	= 0x00080015,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6	= 0x00080016,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7	= 0x00080017,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8	= 0x00080018,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9	= 0x00080019,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA	= 0x0008001A,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB	= 0x0008001B,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC	= 0x0008001C,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASED	= 0x0008001D,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE	= 0x0008001E,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF	= 0x0008001F,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0	= 0x00080040,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1	= 0x00080041,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2	= 0x00080042,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3	= 0x00080043,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4	= 0x00080044,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5	= 0x00080045,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6	= 0x00080046,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7	= 0x00080047,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8	= 0x00080048,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9	= 0x00080049,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA	= 0x0008004A,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB	= 0x0008004B,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC	= 0x0008004C,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD	= 0x0008004D,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE	= 0x0008004E,
>> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF	= 0x0008004F,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX64K00000	= 0x00080070,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX16K80000	= 0x00080071,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX16KA0000	= 0x00080072,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX4KC0000	= 0x00080073,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX4KC8000	= 0x00080074,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX4KD0000	= 0x00080075,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX4KD8000	= 0x00080076,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX4KE0000	= 0x00080077,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX4KE8000	= 0x00080078,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX4KF0000	= 0x00080079,
>> +	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	= 0x0008007A,
>> +
>> +	HV_X64_REGISTER_REG_PAGE	= 0x0009001C,
>> +#endif
>>   };
>>
>>   /*
>> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
>> index b4067ada02cf..c6a62ec9f6da 100644
>> --- a/include/hyperv/hvhdk.h
>> +++ b/include/hyperv/hvhdk.h
>> @@ -479,6 +479,7 @@ struct hv_connection_info {
>>   #define HV_EVENT_FLAGS_COUNT		(256 * 8)
>>   #define HV_EVENT_FLAGS_BYTE_COUNT	(256)
>>   #define HV_EVENT_FLAGS32_COUNT		(256 / sizeof(u32))
>> +#define HV_EVENT_FLAGS_LONG_COUNT	(HV_EVENT_FLAGS_BYTE_COUNT / sizeof(u64))
>>
>>   /* linux side we create long version of flags to use long bit ops on flags */
>>   #define HV_EVENT_FLAGS_UL_COUNT		(256 / sizeof(ulong))
>> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
>> index 876bfe4e4227..a218536eaec1 100644
>> --- a/include/uapi/linux/mshv.h
>> +++ b/include/uapi/linux/mshv.h
>> @@ -288,4 +288,86 @@ struct mshv_get_set_vp_state {
>>    * #define MSHV_ROOT_HVCALL			_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
>>    */
>>
>> +/* Structure definitions, macros and IOCTLs for mshv_vtl */
>> +
>> +#define MSHV_CAP_CORE_API_STABLE        0x0
>> +#define MSHV_CAP_REGISTER_PAGE          0x1
>> +#define MSHV_CAP_VTL_RETURN_ACTION      0x2
>> +#define MSHV_CAP_DR6_SHARED             0x3
>> +#define MSHV_MAX_RUN_MSG_SIZE                256
>> +
>> +#define MSHV_VP_MAX_REGISTERS   128
>> +
>> +struct mshv_vp_registers {
>> +	__u32 count;	/* at most MSHV_VP_MAX_REGISTERS */
>> +	__u32 reserved; /* Reserved for alignment or future use */
>> +	__u64 regs_ptr;	/* pointer to struct hv_register_assoc */
>> +};
>> +
>> +struct mshv_vtl_set_eventfd {
>> +	__s32 fd;
>> +	__u32 flag;
>> +};
>> +
>> +struct mshv_vtl_signal_event {
>> +	__u32 connection_id;
>> +	__u32 flag;
>> +};
>> +
>> +struct mshv_vtl_sint_post_msg {
>> +	__u64 message_type;
>> +	__u32 connection_id;
>> +	__u32 payload_size; /* Must not exceed HV_MESSAGE_PAYLOAD_BYTE_COUNT */
>> +	__u64 payload_ptr; /* pointer to message payload (bytes) */
>> +};
>> +
>> +struct mshv_vtl_ram_disposition {
>> +	__u64 start_pfn;
>> +	__u64 last_pfn;
>> +};
>> +
>> +struct mshv_vtl_set_poll_file {
>> +	__u32 cpu;
>> +	__u32 fd;
>> +};
>> +
>> +struct mshv_vtl_hvcall_setup {
>> +	__u64 bitmap_size;
> 
> What are the units of "bitmap_size"?  Bits? Bytes? u64?

It would be length of bitmap array.

> 
>> +	__u64 allow_bitmap_ptr; /* pointer to __u64 */
>> +};
>> +
>> +struct mshv_vtl_hvcall {
>> +	__u64 control;      /* Hypercall control code */
>> +	__u64 input_size;   /* Size of the input data */
>> +	__u64 input_ptr;    /* Pointer to the input struct */
>> +	__u64 status;       /* Status of the hypercall (output) */
>> +	__u64 output_size;  /* Size of the output data */
>> +	__u64 output_ptr;   /* Pointer to the output struct */
>> +};
>> +
>> +struct mshv_sint_mask {
>> +	__u8 mask;
>> +	__u8 reserved[7];
>> +};
>> +
>> +/* /dev/mshv device IOCTL */
>> +#define MSHV_CHECK_EXTENSION    _IOW(MSHV_IOCTL, 0x00, __u32)
>> +
>> +/* vtl device */
>> +#define MSHV_CREATE_VTL			_IOR(MSHV_IOCTL, 0x1D, char)
>> +#define MSHV_ADD_VTL0_MEMORY	_IOW(MSHV_IOCTL, 0x21, struct mshv_vtl_ram_disposition)
>> +#define MSHV_SET_POLL_FILE		_IOW(MSHV_IOCTL, 0x25, struct mshv_vtl_set_poll_file)
>> +#define MSHV_RETURN_TO_LOWER_VTL	_IO(MSHV_IOCTL, 0x27)
>> +#define MSHV_GET_VP_REGISTERS		_IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
>> +#define MSHV_SET_VP_REGISTERS		_IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
>> +
>> +/* VMBus device IOCTLs */
>> +#define MSHV_SINT_SIGNAL_EVENT    _IOW(MSHV_IOCTL, 0x22, struct mshv_vtl_signal_event)
>> +#define MSHV_SINT_POST_MESSAGE    _IOW(MSHV_IOCTL, 0x23, struct mshv_vtl_sint_post_msg)
>> +#define MSHV_SINT_SET_EVENTFD     _IOW(MSHV_IOCTL, 0x24, struct mshv_vtl_set_eventfd)
>> +#define MSHV_SINT_PAUSE_MESSAGE_STREAM     _IOW(MSHV_IOCTL, 0x25, struct mshv_sint_mask)
>> +
>> +/* hv_hvcall device */
>> +#define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
>> +#define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
>>   #endif
>> --
>> 2.34.1
>>
> 


Thanks Michael for thoroughly reviewing the patch and sharing your
valuable comments.

I will wait for your comment on vmbus_chan_sched query for sending the
next patch, or anything else if you have in mind.

Regards,
Naman

