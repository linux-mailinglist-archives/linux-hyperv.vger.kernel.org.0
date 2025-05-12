Return-Path: <linux-hyperv+bounces-5458-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28488AB2E86
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 06:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA351782E9
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 04:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A0F254B10;
	Mon, 12 May 2025 04:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OnKtWxgv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D92576;
	Mon, 12 May 2025 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747025733; cv=none; b=LKnOhzTf8HUzJjCx90E8aSUhCfERdHCgqS+cYP23p7I5y8QdcwkxCRd2a7DRHYvpHT8r/SXjZvdEB1Mqhi/JVZV08SLYLbDqQub0a7+Tcp6yupsPj2GOpzdiFPnSh7OOBmuzssRT8U/xFD8ywQTg5+ghhNwaMZgRbVDG3xeDhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747025733; c=relaxed/simple;
	bh=+LD9AORitbchLObd9JsoSm9q6YOOu15J2fN78WYCeMY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gyCILFMxWaMzEYYtxP5jDbuehC5oSZlbi61dS4icxpFVzl7TrWZgAicewQhCjSy9sY57CqGPjg7ikYG0OuyJAXnKUNFZbx1HVq2SNY+uAp7RM9cjYG9rFPhDlcSHVA6PfxScUKS3oDB7zfGxTOWm0EQ7DiZlkRkA1jq4nP1mSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OnKtWxgv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.86])
	by linux.microsoft.com (Postfix) with ESMTPSA id 81B74211D8B7;
	Sun, 11 May 2025 21:55:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81B74211D8B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747025730;
	bh=15offyRbgTEGUmwvyCQvDlXGSQKiWdqEpUaslXph4hI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=OnKtWxgvxSgGK9rSF5xcbVlxdtfyVG2xIFFFWQ87HpY09vw/h6MntoM6+y+IZDpeG
	 HqVvVEd2Py4iV4QvhObw6RrDF6KcI+yy1L6InNnHbWQtx7LRuPzMWKGihOxM986Chm
	 WndnpouWUOR8eveHr4kCI0/jdg8QCclmwrym3PHQ=
Message-ID: <c436603e-0735-45e7-8690-03fbf02f1668@linux.microsoft.com>
Date: Mon, 12 May 2025 10:25:24 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Saurabh Singh Sengar <ssengar@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/2025 6:32 PM, Saurabh Singh Sengar wrote:
> 
>> Provide an interface for Virtual Machine Monitor like OpenVMM and its
>> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
>> Expose devices and support IOCTLs for features like VTL creation,
>> VTL0 memory management, context switch, making hypercalls,
>> mapping VTL0 address space to VTL2 userspace, getting new VMBus
>> messages and channel events in VTL2 etc.
>>
>> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>
>> OpenVMM :
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fopenv
>> mm.dev%2Fguide%2F&data=05%7C02%7Cssengar%40microsoft.com%7Ce3b
>> 0a61c2c72423aa33408dd8c7af2e9%7C72f988bf86f141af91ab2d7cd011db47%
>> 7C1%7C0%7C638821181946438191%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
>> 0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp
>> bCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=uYUgaqKTazf0BL8ukdeUEor
>> d9hN8NidMLwE19NdprlE%3D&reserved=0
>>
>> ---
>>   drivers/hv/Kconfig          |   20 +
>>   drivers/hv/Makefile         |    3 +
>>   drivers/hv/hv.c             |    2 +
>>   drivers/hv/hyperv_vmbus.h   |    1 +
>>   drivers/hv/mshv_vtl.h       |   52 ++
>>   drivers/hv/mshv_vtl_main.c  | 1749
>> +++++++++++++++++++++++++++++++++++
>>   drivers/hv/vmbus_drv.c      |    3 +-
>>   include/hyperv/hvgdk_mini.h |   81 ++
>>   include/hyperv/hvhdk.h      |    1 +
>>   include/uapi/linux/mshv.h   |   83 ++
>>   10 files changed, 1994 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/hv/mshv_vtl.h
>>   create mode 100644 drivers/hv/mshv_vtl_main.c
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 6c1416167bd2..57dcfcb69b88 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -72,4 +72,24 @@ config MSHV_ROOT
>>
>>   	  If unsure, say N.
>>
>> +config MSHV_VTL
>> +	bool "Microsoft Hyper-V VTL driver"
>> +	depends on HYPERV && X86_64
>> +	depends on TRANSPARENT_HUGEPAGE
>> +	depends on OF
>> +	# MTRRs are not per-VTL and are controlled by VTL0, so don't look at
>> or mutate them.
>> +	depends on !MTRR
>> +	select CPUMASK_OFFSTACK
>> +	select HYPERV_VTL_MODE
>> +	default n
>> +	help
>> +	  Select this option to enable Hyper-V VTL driver support.
>> +	  This driver provides interfaces for Virtual Machine Manager (VMM)
>> running in VTL2
>> +	  userspace to create VTLs and partitions, setup and manage VTL0
>> memory and
>> +	  allow userspace to make direct hypercalls. This also allows to map
>> VTL0's address
>> +	  space to a usermode process in VTL2 and supports getting new
>> VMBus messages and channel
>> +	  events in VTL2.
>> +
>> +	  If unsure, say N.
>> +
>>   endmenu
>> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
>> index 976189c725dc..5e785dae08cc 100644
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
>> @@ -18,3 +19,5 @@ mshv_root-y := mshv_root_main.o mshv_synic.o
>> mshv_eventfd.o mshv_irq.o \
>>   # Code that must be built-in
>>   obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
>>   obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o mshv_common.o
>> +
>> +mshv_vtl-y := mshv_vtl_main.o mshv_common.o
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>> index 308c8f279df8..11e8096fe840 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -25,6 +25,7 @@
>>
>>   /* The one and only */
>>   struct hv_context hv_context;
>> +EXPORT_SYMBOL_GPL(hv_context);
>>
>>   /*
>>    * hv_init - Main initialization routine.
>> @@ -93,6 +94,7 @@ int hv_post_message(union hv_connection_id
>> connection_id,
>>
>>   	return hv_result(status);
>>   }
>> +EXPORT_SYMBOL_GPL(hv_post_message);
> 
> All the exports should be in separate patch.

Ack.

> 
>>
>>   int hv_synic_alloc(void)
>>   {
>> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
>> index 0b450e53161e..b61f01fc1960 100644
>> --- a/drivers/hv/hyperv_vmbus.h
>> +++ b/drivers/hv/hyperv_vmbus.h
>> @@ -32,6 +32,7 @@
>>    */
>>   #define HV_UTIL_NEGO_TIMEOUT 55
>>
>> +void vmbus_isr(void);
>>
>>   /* Definitions for the monitored notification facility */
>>   union hv_monitor_trigger_group {
>> diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
>> new file mode 100644
>> index 000000000000..f350e4650d7b
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
>> +		 * Reserving room for the cpu context to grow and be
>> +		 * able to maintain compat with user mode.
>> +		 */
>> +		char reserved[1024];
>> +	};
>> +	char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
>> +};
>> +
>> +#endif /* _MSHV_VTL_H */
>> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
>> new file mode 100644
>> index 000000000000..95db29472fc8
>> --- /dev/null
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -0,0 +1,1749 @@
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
>> +#include <uapi/linux/mshv.h>
>> +#include <hyperv/hvhdk.h>
>> +
>> +#include "../../kernel/fpu/legacy.h"
>> +#include "mshv.h"
>> +
>> +#include "mshv_vtl.h"
>> +#include "hyperv_vmbus.h"
>> +
> 
> <snip>
> 
> 
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
>> +	if (fd < 0)
>> +		return fd;
>> +	file = anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
>> +				  vtl, O_RDWR);
>> +	if (IS_ERR(file))
>> +		return PTR_ERR(file);
>> +	refcount_set(&vtl->ref_count, 1);
> 
> Do we have any use of ref_count ?

Thanks for catching this, I don't see any use of ref_count.
I'll remove it.

> 
>> +	vtl->module_dev = module_dev;
>> +
>> +	fd_install(fd, file);
>> +
>> +	return fd;
>> +}
> 
> <snip>
> 
>> +static long
>> +mshv_vtl_ioctl_get_set_regs(void __user *user_args, bool set)
> 
> I didn't find much use of this function. I don't see any problem with separate get and set functions.
> But I will let you decide on this.

IMO, the reasoning behind keeping it in a common function is to avoid
duplication of code from start of function till "if (set)". As I don't
see any way to avoid that, I think it would be better to keep it in
current shape.

However we can remove one extra level of indirection in functions
mshv_vtl_ioctl_set_regs and mshv_vtl_ioctl_get_regs and use
mshv_vtl_ioctl_get_set_regs function directly.

> 
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
>> +	if (set) {
>> +		ret = mshv_vtl_set_reg(registers);
>> +		if (!ret)
>> +			goto free_return; /* No need of hypercall */
>> +		ret = vtl_set_vp_registers(args.count, registers);
>> +
>> +	} else {
>> +		ret = mshv_vtl_get_reg(registers);
>> +		if (!ret)
>> +			goto copy_args; /* No need of hypercall */
>> +		ret = vtl_get_vp_registers(args.count, registers);
>> +		if (ret)
>> +			goto free_return;
>> +
>> +copy_args:
>> +		if (copy_to_user((void __user *)args.regs_ptr, registers,
>> +				 sizeof(*registers) * args.count))
>> +			ret = -EFAULT;
>> +	}
>> +
>> +free_return:
>> +	kfree(registers);
>> +	return ret;
>> +}
>> +
> 
> <snip>
> 
>> +static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
>> +				struct mshv_vtl_hvcall __user *hvcall_user)
>> +{
>> +	struct mshv_vtl_hvcall hvcall;
>> +	unsigned long flags;
>> +	void *in, *out;
>> +
>> +	if (copy_from_user(&hvcall, hvcall_user, sizeof(struct
>> mshv_vtl_hvcall)))
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
>> +	local_irq_save(flags);
>> +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	out = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> +
>> +	if (copy_from_user(in, (void __user *)hvcall.input_ptr,
>> hvcall.input_size)) {
> 
> Here is an issue related to usage of user copy functions when interrupt are disabled.
> It was reported by Michael K here:
> https://github.com/microsoft/OHCL-Linux-Kernel/issues/33

Discussing internally, will reply on the latest email of this
discussion.

> 
> - Saurabh

Regards,
Naman

