Return-Path: <linux-hyperv+bounces-5467-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C573AB39F7
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 16:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AA3189F2CB
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEA1DF754;
	Mon, 12 May 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZPYGoW8M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14671DBB03;
	Mon, 12 May 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058667; cv=none; b=Pahhz6WNEs+j9HVUpJgycCnf9d19iDE1l8rM5G08dUgRwDVJArIs5AlPbiNwUoHtNIo2QO9AwiDMF1mxXU4TrZc44i52VjJgAek4IVzkQ+FgePEDZD00mwb52eaxxoPP3Ck4CSkr/SqPbVOmqB3WDUOM+tmp7/uPu1Pyd8u7wKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058667; c=relaxed/simple;
	bh=kYVcmtEqpQeOMnmZHJ0L5aKjALE2y8vEQfj1Jd+EEuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/oE1vp2jiI2dcuJUY2fb9wO+tsqtHNlQU2JcIXB3GxNUZnggMHv0335Ok3aM+ndX1eZYpUj8AA+kYRo3ZQTlIUn2xnnQEANhtgRcz6pGO++9PS7KDBEU0uReACcsJ8gECJ7GgfdCkAD+kDnKaIQI2DMisOf3w669b28+hV1AfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZPYGoW8M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.217.194] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id BB42C20277F1;
	Mon, 12 May 2025 07:04:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB42C20277F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747058664;
	bh=r3ujCfycUy8qO/XJf4J3q36yShrcIHlkYzBjPKMm3F4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZPYGoW8M5hqucNUyoTLoWF+x1k9mG8diff0qeba9+P2i7nlmJEqhfkhBWXCcg8V5z
	 71ZcqMCngtZns0YIryJbyDyfORbhm0VJrD3DPAeBhG9LWDjfDz2T2rqhigl5U3g7AH
	 6AnXigaU6p09YvHEpeMm7XHTo9UO2k/DLaxQSmaE=
Message-ID: <7a8afdb6-15e8-4f35-9551-d5c8843ac028@linux.microsoft.com>
Date: Mon, 12 May 2025 19:34:18 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: ALOK TIWARI <alok.a.tiwari@oracle.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <a8e95da8-ab80-4581-b8b4-136a09f9f3f2@oracle.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <a8e95da8-ab80-4581-b8b4-136a09f9f3f2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/11/2025 2:25 AM, ALOK TIWARI wrote:
> 
> 
> On 06-05-2025 14:19, Naman Jain wrote:
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
>> OpenVMM : https://urldefense.com/v3/__https://openvmm.dev/guide/__;!! 
>> ACWV5N9M2RV99hQ! 
>> JP9UlleLto2qc_MQzB8ehw1vxtg1wE6rkxawFxyrIWJPPUOdoUk5fpa89l- 
>> uhlMNKAdgnWdKXhj5g1AEuVZImYkjDA$
>>
>> ---
>>   drivers/hv/Kconfig          |   20 +
>>   drivers/hv/Makefile         |    3 +
>>   drivers/hv/hv.c             |    2 +
>>   drivers/hv/hyperv_vmbus.h   |    1 +
>>   drivers/hv/mshv_vtl.h       |   52 ++
>>   drivers/hv/mshv_vtl_main.c  | 1749 +++++++++++++++++++++++++++++++++++
>>   drivers/hv/vmbus_drv.c      |    3 +-
>>   include/hyperv/hvgdk_mini.h |   81 ++
>>   include/hyperv/hvhdk.h      |    1 +
>>   include/uapi/linux/mshv.h   |   83 ++
>>   10 files changed, 1994 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/hv/mshv_vtl.h
>>   create mode 100644 drivers/hv/mshv_vtl_main.c
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 6c1416167bd2..57dcfcb69b88 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -72,4 +72,24 @@ config MSHV_ROOT
>>         If unsure, say N.
>> +config MSHV_VTL
>> +    bool "Microsoft Hyper-V VTL driver"
>> +    depends on HYPERV && X86_64
>> +    depends on TRANSPARENT_HUGEPAGE
>> +    depends on OF
>> +    # MTRRs are not per-VTL and are controlled by VTL0, so don't look 
>> at or mutate them.
> 
> # MTRRs are controlled by VTL0, and are not specific to individual VTLs.
> # Therefore, do not attempt to access or modify MTRRs here.
> 

ACK.

>> +    depends on !MTRR
>> +    select CPUMASK_OFFSTACK
>> +    select HYPERV_VTL_MODE
>> +    default n
>> +    help
>> +      Select this option to enable Hyper-V VTL driver support.
>> +      This driver provides interfaces for Virtual Machine Manager 
>> (VMM) running in VTL2
>> +      userspace to create VTLs and partitions, setup and manage VTL0 
>> memory and
>> +      allow userspace to make direct hypercalls. This also allows to 
>> map VTL0's address
>> +      space to a usermode process in VTL2 and supports getting new 
>> VMBus messages and channel
>> +      events in VTL2.


<snip>

>> +
>> +struct mshv_vtl_run {
>> +    u32 cancel;
>> +    u32 vtl_ret_action_size;
>> +    u32 pad[2];
>> +    char exit_message[MSHV_MAX_RUN_MSG_SIZE];
>> +    union {
>> +        struct mshv_vtl_cpu_context cpu_context;
>> +
>> +        /*
>> +         * Reserving room for the cpu context to grow and be
>> +         * able to maintain compat with user mode.
> 
> here compat, sound like typo to compact.
> To improve clarity and ensure correctness
> "Reserving room for the cpu context to grow and to maintain 
> compatibility with user mode."
> 

ACK.

>> +         */
>> +        char reserved[1024];
>> +    };
>> +    char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
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
<snip>
> +
>> +static int hv_vtl_setup_synic(void)
>> +{
>> +    int ret;
>> +
>> +    /* Use our isr to first filter out packets destined for userspace */
>> +    hv_setup_vmbus_handler(mshv_vtl_vmbus_isr);
>> +
>> +    ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
>> +                mshv_vtl_alloc_context, NULL);
>> +    if (ret < 0) {
>> +        hv_remove_vmbus_handler();
>> +        return ret;
>> +    }
>> +
>> +    mshv_vtl_cpuhp_online = ret;
> 
> a '\n' before return
> 

ACK.

>> +    return 0;
>> +}
>> +
>> +static void hv_vtl_remove_synic(void)
>> +{
>> +    hv_remove_vmbus_handler();
>> +    cpuhp_remove_state(mshv_vtl_cpuhp_online);
>> +}
>> +
>> +static int vtl_get_vp_registers(u16 count,
>> +                struct hv_register_assoc *registers)
>> +{
>> +    union hv_input_vtl input_vtl;
>> +
>> +    input_vtl.as_uint8 = 0;
>> +    input_vtl.use_target_vtl = 1;
> 
> a '\n' before return, pleas consider this for other place also
> 

ACK. Done at other places too in the file.

>> +    return hv_call_get_vp_registers(HV_VP_INDEX_SELF, 
>> HV_PARTITION_ID_SELF,
>> +                    count, input_vtl, registers);
>> +}
>> +
>> +static int vtl_set_vp_registers(u16 count,
>> +                struct hv_register_assoc *registers)
>> +{
>> +    union hv_input_vtl input_vtl;
>> +
>> +    input_vtl.as_uint8 = 0;
>> +    input_vtl.use_target_vtl = 1;
>> +    return hv_call_set_vp_registers(HV_VP_INDEX_SELF, 
>> HV_PARTITION_ID_SELF,
>> +                    count, input_vtl, registers);
>> +}
>> +
>> +static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void 
>> __user *arg)
>> +{
>> +    struct mshv_vtl_ram_disposition vtl0_mem;
>> +    struct dev_pagemap *pgmap;
>> +    void *addr;
>> +
>> +    if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
>> +        return -EFAULT;
>> +
>> +    if (vtl0_mem.last_pfn <= vtl0_mem.start_pfn) {
>> +        dev_err(vtl->module_dev, "range start pfn (%llx) > end pfn 
>> (%llx)\n",
>> +            vtl0_mem.start_pfn, vtl0_mem.last_pfn);
>> +        return -EFAULT;
>> +    }
>> +
>> +    pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
>> +    if (!pgmap)
>> +        return -ENOMEM;
>> +
>> +    pgmap->ranges[0].start = PFN_PHYS(vtl0_mem.start_pfn);
>> +    pgmap->ranges[0].end = PFN_PHYS(vtl0_mem.last_pfn) - 1;
>> +    pgmap->nr_range = 1;
>> +    pgmap->type = MEMORY_DEVICE_GENERIC;
>> +
>> +    /*
>> +     * Determine the highest page order that can be used for the range.
>> +     * This works best when the range is aligned; i.e. start and length.
> 
> "can be used for the given memory range."
> Replaced "range" with "given memory range" to clarify that we are 
> talking about the memory range of the VTL0 memory.
> 
> Reworded "start and length"  -> "both the start and the length"
> 

ACK.

>> +     */
>> +    pgmap->vmemmap_shift = count_trailing_zeros(vtl0_mem.start_pfn | 
>> vtl0_mem.last_pfn);
>> +    dev_dbg(vtl->module_dev,
>> +        "Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: 
>> %lu\n",
>> +        vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
>> +
>> +    addr = devm_memremap_pages(mem_dev, pgmap);
>> +    if (IS_ERR(addr)) {
>> +        dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", 
>> PTR_ERR(addr));
>> +        kfree(pgmap);
>> +        return -EFAULT;
>> +    }

<snip>

>> +    return 0;
>> +}
>> +
>> +static int mshv_vtl_set_reg(struct hv_register_assoc *regs)
>> +{
>> +    u64 reg64;
>> +    enum hv_register_name gpr_name;
>> +
>> +    gpr_name = regs->name;
>> +    reg64 = regs->value.reg64;
>> +
>> +    switch (gpr_name) {
>> +    case HV_X64_REGISTER_DR0:
>> +        native_set_debugreg(0, reg64);
>> +        break;
>> +    case HV_X64_REGISTER_DR1:
>> +        native_set_debugreg(1, reg64);
>> +        break;
>> +    case HV_X64_REGISTER_DR2:
>> +        native_set_debugreg(2, reg64);
>> +        break;
>> +    case HV_X64_REGISTER_DR3:
>> +        native_set_debugreg(3, reg64);
>> +        break;
>> +    case HV_X64_REGISTER_DR6:
>> +        if (!mshv_vsm_capabilities.dr6_shared)
>> +            goto hypercall;
>> +        native_set_debugreg(6, reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_CAP:
>> +        wrmsrl(MSR_MTRRcap, reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
>> +        wrmsrl(MSR_MTRRdefType, reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
>> +        wrmsrl(MTRRphysBase_MSR(0), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
>> +        wrmsrl(MTRRphysBase_MSR(1), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
>> +        wrmsrl(MTRRphysBase_MSR(2), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
>> +        wrmsrl(MTRRphysBase_MSR(3), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
>> +        wrmsrl(MTRRphysBase_MSR(4), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
>> +        wrmsrl(MTRRphysBase_MSR(5), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
>> +        wrmsrl(MTRRphysBase_MSR(6), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
>> +        wrmsrl(MTRRphysBase_MSR(7), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
>> +        wrmsrl(MTRRphysBase_MSR(8), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
>> +        wrmsrl(MTRRphysBase_MSR(9), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
>> +        wrmsrl(MTRRphysBase_MSR(0xa), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
>> +        wrmsrl(MTRRphysBase_MSR(0xb), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
>> +        wrmsrl(MTRRphysBase_MSR(0xc), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
>> +        wrmsrl(MTRRphysBase_MSR(0xd), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
>> +        wrmsrl(MTRRphysBase_MSR(0xe), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
>> +        wrmsrl(MTRRphysBase_MSR(0xf), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
>> +        wrmsrl(MTRRphysMask_MSR(0), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
>> +        wrmsrl(MTRRphysMask_MSR(1), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
>> +        wrmsrl(MTRRphysMask_MSR(2), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
>> +        wrmsrl(MTRRphysMask_MSR(3), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
>> +        wrmsrl(MTRRphysMask_MSR(4), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
>> +        wrmsrl(MTRRphysMask_MSR(5), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
>> +        wrmsrl(MTRRphysMask_MSR(6), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
>> +        wrmsrl(MTRRphysMask_MSR(7), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
>> +        wrmsrl(MTRRphysMask_MSR(8), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
>> +        wrmsrl(MTRRphysMask_MSR(9), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
>> +        wrmsrl(MTRRphysMask_MSR(0xa), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
>> +        wrmsrl(MTRRphysMask_MSR(0xa), reg64);
> 
> is this typo or intentional 0xa -> 0xb ?

Thanks for catching this. This must be a typo. Corrected it.

> 
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
>> +        wrmsrl(MTRRphysMask_MSR(0xc), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
>> +        wrmsrl(MTRRphysMask_MSR(0xd), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
>> +        wrmsrl(MTRRphysMask_MSR(0xe), reg64);
>> +        break;
>> +    case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
>> +        wrmsrl(MTRRphysMask_MSR(0xf), reg64);

<snip>

>> +static struct miscdevice mshv_vtl_sint_dev = {
>> +    .name = "mshv_sint",
>> +    .fops = &mshv_vtl_sint_ops,
>> +    .mode = 0600,
>> +    .minor = MISC_DYNAMIC_MINOR,
>> +};
>> +
>> +static int mshv_vtl_hvcall_open(struct inode *node, struct file *f)
>> +{
>> +    struct miscdevice *dev = f->private_data;
>> +    struct mshv_vtl_hvcall_fd *fd;
>> +
>> +    if (!capable(CAP_SYS_ADMIN))
>> +        return -EPERM;
>> +
>> +    fd = vzalloc(sizeof(*fd));
>> +    if (!fd)
>> +        return -ENOMEM;
> 
> if (!fd) {
>      f->private_data = NULL;
>      return -ENOMEM;
> }
> Explicitly set to NULL to (avoid accidental use)
> it can avoids potential issues in later functions that may attempt to 
> access it. what is your view here ?

Makes sense. Will change it.

> 
>> +    fd->dev = dev;
>> +    mutex_init(&fd->init_mutex);
>> +
>> +    f->private_data = fd;
> 
> Assign immediately after allocation ensures a consistent state and sequence
>      f->private_data = fd;
>      fd->dev = dev;
>      mutex_init(&fd->init_mutex);
> 

Done

>> +
>> +    return 0;
>> +}
>> +
>> +static int mshv_vtl_hvcall_release(struct inode *node, struct file *f)
>> +{
>> +    struct mshv_vtl_hvcall_fd *fd;
>> +
>> +    fd = f->private_data;
>> +    f->private_data = NULL;
>> +    vfree(fd);
> 
> what about ?
> if (fd) {
>      vfree(fd);
>      f->private_data = NULL;
> }
> adding a check will improves readability and robustness.

This seems better. Will change it.

>> +
>> +    return 0;
>> +}
>> +
>> +static int mshv_vtl_hvcall_setup(struct mshv_vtl_hvcall_fd *fd,
>> +                 struct mshv_vtl_hvcall_setup __user *hvcall_setup_user)
>> +{
>> +    int ret = 0;
>> +    struct mshv_vtl_hvcall_setup hvcall_setup;
>> +
>> +    mutex_lock(&fd->init_mutex);
>> +
>> +    if (fd->allow_map_intialized) {
>> +        dev_err(fd->dev->this_device,
>> +            "Hypercall allow map has already been set, pid %d\n",
>> +            current->pid);
>> +        ret = -EINVAL;
>> +        goto exit;
>> +    }
>> +
>> +    if (copy_from_user(&hvcall_setup, hvcall_setup_user,
>> +               sizeof(struct mshv_vtl_hvcall_setup))) {
>> +        ret = -EFAULT;
>> +        goto exit;
>> +    }
>> +    if (hvcall_setup.bitmap_size > ARRAY_SIZE(fd->allow_bitmap)) {
>> +        ret = -EINVAL;
>> +        goto exit;
>> +    }
>> +    if (copy_from_user(&fd->allow_bitmap,
>> +               (void __user *)hvcall_setup.allow_bitmap_ptr,
>> +               hvcall_setup.bitmap_size)) {
>> +        ret = -EFAULT;
>> +        goto exit;
>> +    }
>> +
>> +    dev_info(fd->dev->this_device, "Hypercall allow map has been set, 
>> pid %d\n",
>> +         current->pid);
>> +    fd->allow_map_intialized = true;
>> +
>> +exit:
>> +
> 
> no need \n here
> 

ACKed.

>> +    mutex_unlock(&fd->init_mutex);
>> +
>> +    return ret;
>> +}
>> +
>> +static bool mshv_vtl_hvcall_is_allowed(struct mshv_vtl_hvcall_fd *fd, 
>> u16 call_code)
>> +{
>> +    u8 bits_per_item = 8 * sizeof(fd->allow_bitmap[0]);
>> +    u16 item_index = call_code / bits_per_item;
>> +    u64 mask = 1ULL << (call_code % bits_per_item);
>> +
>> +    return fd->allow_bitmap[item_index] & mask;
>> +}
>> +
>> +static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
>> +                struct mshv_vtl_hvcall __user *hvcall_user)
>> +{
>> +    struct mshv_vtl_hvcall hvcall;
>> +    unsigned long flags;
>> +    void *in, *out;
>> +
>> +    if (copy_from_user(&hvcall, hvcall_user, sizeof(struct 
>> mshv_vtl_hvcall)))
>> +        return -EFAULT;
>> +    if (hvcall.input_size > HV_HYP_PAGE_SIZE)
>> +        return -EINVAL;
>> +    if (hvcall.output_size > HV_HYP_PAGE_SIZE)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * By default, all hypercalls are not allowed.
>> +     * The user mode code has to set up the allow bitmap once.
>> +     */
>> +
>> +    if (!mshv_vtl_hvcall_is_allowed(fd, hvcall.control & 0xFFFF)) {
>> +        dev_err(fd->dev->this_device,
>> +            "Hypercall with control data %#llx isn't allowed\n",
>> +            hvcall.control);
>> +        return -EPERM;
>> +    }
>> +
>> +    local_irq_save(flags);
>> +    in = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +    out = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> +
>> +    if (copy_from_user(in, (void __user *)hvcall.input_ptr, 
>> hvcall.input_size)) {
>> +        local_irq_restore(flags);
>> +        return -EFAULT;
>> +    }
>> +
>> +    hvcall.status = hv_do_hypercall(hvcall.control, in, out);
>> +
>> +    if (copy_to_user((void __user *)hvcall.output_ptr, out, 
>> hvcall.output_size)) {
>> +        local_irq_restore(flags);
>> +        return -EFAULT;
>> +    }
>> +    local_irq_restore(flags);
>> +
>> +    return put_user(hvcall.status, &hvcall_user->status);
>> +}
>> +
>> +static long mshv_vtl_hvcall_ioctl(struct file *f, unsigned int cmd, 
>> unsigned long arg)
>> +{
>> +    struct mshv_vtl_hvcall_fd *fd = f->private_data;
>> +
>> +    switch (cmd) {
>> +    case MSHV_HVCALL_SETUP:
>> +        return mshv_vtl_hvcall_setup(fd, (struct 
>> mshv_vtl_hvcall_setup __user *)arg);
>> +    case MSHV_HVCALL:
>> +        return mshv_vtl_hvcall_call(fd, (struct mshv_vtl_hvcall 
>> __user *)arg);
>> +    default:
>> +        break;
>> +    }
>> +
>> +    return -ENOIOCTLCMD;
>> +}
>> +
>> +static const struct file_operations mshv_vtl_hvcall_file_ops = {
>> +    .owner = THIS_MODULE,
>> +    .open = mshv_vtl_hvcall_open,
>> +    .release = mshv_vtl_hvcall_release,
>> +    .unlocked_ioctl = mshv_vtl_hvcall_ioctl,
>> +};
>> +
>> +static struct miscdevice mshv_vtl_hvcall = {
>> +    .name = "mshv_hvcall",
>> +    .nodename = "mshv_hvcall",
>> +    .fops = &mshv_vtl_hvcall_file_ops,
>> +    .mode = 0600,
>> +    .minor = MISC_DYNAMIC_MINOR,
>> +};
>> +
>> +static int mshv_vtl_low_open(struct inode *inodep, struct file *filp)
>> +{
>> +    pid_t pid = task_pid_vnr(current);
>> +    uid_t uid = current_uid().val;
>> +    int ret = 0;
>> +
>> +    pr_debug("%s: Opening VTL low, task group %d, uid %d\n", 
>> __func__, pid, uid);
>> +
>> +    if (capable(CAP_SYS_ADMIN)) {
>> +        filp->private_data = inodep;
>> +    } else {
>> +        pr_err("%s: VTL low open failed: CAP_SYS_ADMIN required. task 
>> group %d, uid %d",
>> +               __func__, pid, uid);
>> +        ret = -EPERM;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static bool can_fault(struct vm_fault *vmf, unsigned long size, pfn_t 
>> *pfn)
>> +{
>> +    unsigned long mask = size - 1;
>> +    unsigned long start = vmf->address & ~mask;
>> +    unsigned long end = start + size;
>> +    bool valid;
> 
> valid is descriptive, but is_valid would be more explicit as a boolean 
> flag.

Thanks, noted.

> 
>> +
>> +    valid = (vmf->address & mask) == ((vmf->pgoff << PAGE_SHIFT) & 
>> mask) &&
>> +        start >= vmf->vma->vm_start &&
>> +        end <= vmf->vma->vm_end;
>> +
>> +    if (valid)
>> +        *pfn = __pfn_to_pfn_t(vmf->pgoff & ~(mask >> PAGE_SHIFT), 
>> PFN_DEV | PFN_MAP);
>> +
>> +    return valid;
>> +}
>> +
>> +static vm_fault_t mshv_vtl_low_huge_fault(struct vm_fault *vmf, 
>> unsigned int order)
>> +{
>> +    pfn_t pfn;
>> +    int ret = VM_FAULT_FALLBACK;
>> +
>> +    switch (order) {
>> +    case 0:
>> +        pfn = __pfn_to_pfn_t(vmf->pgoff, PFN_DEV | PFN_MAP);
>> +        return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
>> +
>> +    case PMD_ORDER:
>> +        if (can_fault(vmf, PMD_SIZE, &pfn))
>> +            ret = vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & 
>> FAULT_FLAG_WRITE);
>> +        return ret;
>> +
>> +    case PUD_ORDER:
>> +        if (can_fault(vmf, PUD_SIZE, &pfn))
>> +            ret = vmf_insert_pfn_pud(vmf, pfn, vmf->flags & 
>> FAULT_FLAG_WRITE);
>> +        return ret;
>> +
>> +    default:
>> +        return VM_FAULT_SIGBUS;
>> +    }
>> +}
>> +
>> +static vm_fault_t mshv_vtl_low_fault(struct vm_fault *vmf)
>> +{
>> +    return mshv_vtl_low_huge_fault(vmf, 0);
>> +}
>> +
>> +static const struct vm_operations_struct mshv_vtl_low_vm_ops = {
>> +    .fault = mshv_vtl_low_fault,
>> +    .huge_fault = mshv_vtl_low_huge_fault,
>> +};
>> +
>> +static int mshv_vtl_low_mmap(struct file *filp, struct vm_area_struct 
>> *vma)
>> +{
>> +    vma->vm_ops = &mshv_vtl_low_vm_ops;
>> +    vm_flags_set(vma, VM_HUGEPAGE | VM_MIXEDMAP);
>> +    return 0;
>> +}
>> +
>> +static const struct file_operations mshv_vtl_low_file_ops = {
>> +    .owner        = THIS_MODULE,
>> +    .open        = mshv_vtl_low_open,
>> +    .mmap        = mshv_vtl_low_mmap,
>> +};
>> +
>> +static struct miscdevice mshv_vtl_low = {
>> +    .name = "mshv_vtl_low",
>> +    .nodename = "mshv_vtl_low",
>> +    .fops = &mshv_vtl_low_file_ops,
>> +    .mode = 0600,
>> +    .minor = MISC_DYNAMIC_MINOR,
>> +};
>> +
>> +static int __init mshv_vtl_init(void)
>> +{
>> +    int ret;
>> +    struct device *dev = mshv_dev.this_device;
>> +
>> +    /*
>> +     * This creates /dev/mshv which provides functionality to create 
>> VTLs and partitions.
>> +     */
>> +    ret = misc_register(&mshv_dev);
>> +    if (ret) {
>> +        dev_err(dev, "mshv device register failed: %d\n", ret);
>> +        goto free_dev;
>> +    }
>> +
>> +    tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
>> +    init_waitqueue_head(&fd_wait_queue);
>> +
>> +    if (mshv_vtl_get_vsm_regs()) {
>> +        dev_emerg(dev, "Unable to get VSM capabilities !!\n");
>> +        ret = -ENODEV;
>> +        goto free_dev;
>> +    }
>> +    if (mshv_vtl_configure_vsm_partition(dev)) {
>> +        dev_emerg(dev, "VSM configuration failed !!\n");
>> +        ret = -ENODEV;
>> +        goto free_dev;
>> +    }
>> +
>> +    ret = hv_vtl_setup_synic();
>> +    if (ret)
>> +        goto free_dev;
>> +
>> +    /*
>> +     * mshv_sint device adds VMBus relay ioctl support.
>> +     * This provides a channel for VTL0 to communicate with VTL2.
>> +     */
>> +    ret = misc_register(&mshv_vtl_sint_dev);
>> +    if (ret)
>> +        goto free_synic;
>> +
>> +    /*
>> +     * mshv_hvcall device adds interface to enable userspace for 
>> direct hypercalls support.
>> +     */
>> +    ret = misc_register(&mshv_vtl_hvcall);
>> +    if (ret)
>> +        goto free_sint;
>> +
>> +    /*
>> +     * mshv_vtl_low device is used to map VTL0 address space to a 
>> user-mode process in VLT2.
> 
> typo VLT2 -> VTL2

ACKed.

> 
>> +     * It implements mmap() to allow a user-mode process in VTL2 to 
>> map to the address of VTL0.
>> +     */
>> +    ret = misc_register(&mshv_vtl_low);
>> +    if (ret)
>> +        goto free_hvcall;
>> +
>> +    /*
>> +     * "mshv vtl mem dev" device is later used to setup VTL0 memory.
>> +     */
>> +    mem_dev = kzalloc(sizeof(*mem_dev), GFP_KERNEL);
>> +    if (!mem_dev) {
>> +        ret = -ENOMEM;
>> +        goto free_low;
>> +    }
>> +
>> +    mutex_init(&mshv_vtl_poll_file_lock);
>> +
>> +    device_initialize(mem_dev);
>> +    dev_set_name(mem_dev, "mshv vtl mem dev");
>> +    ret = device_add(mem_dev);
>> +    if (ret) {
>> +        dev_err(dev, "mshv vtl mem dev add: %d\n", ret);
>> +        goto free_mem;
>> +    }
>> +
>> +    return 0;
>> +
>> +free_mem:
>> +    kfree(mem_dev);
>> +free_low:
>> +    misc_deregister(&mshv_vtl_low);
>> +free_hvcall:
>> +    misc_deregister(&mshv_vtl_hvcall);
>> +free_sint:
<snip>
>>    */
>> +/* Structure definitions, macros and IOCTLs for mshv_vtl */
>> +
>> +#define MSHV_CAP_CORE_API_STABLE        0x0
>> +#define MSHV_CAP_REGISTER_PAGE          0x1
>> +#define MSHV_CAP_VTL_RETURN_ACTION      0x2
>> +#define MSHV_CAP_DR6_SHARED             0x3
>> +#define MSHV_MAX_RUN_MSG_SIZE                256
>> +
>> +#define MSHV_VP_MAX_REGISTERS   128
>> +
>> +struct mshv_vp_registers {
>> +    __u32 count;    /* at most MSHV_VP_MAX_REGISTERS */
>> +    __u32 padding;
> 
> padding -> reserved?
> reserved(reserved or reserved1, reserved2) is more commonly used in 
> structures that may evolve to include additional field
> __u32 reserved; /* Reserved for alignment or future use */
> 

I don't have a strong opinion on this, but will change this.

>> +    __u64 regs_ptr;    /* pointer to struct hv_register_assoc */
>> +};
>> +
>> +struct mshv_vtl_set_eventfd {
>> +    __s32 fd;
>> +    __u32 flag;
>> +};
>> +
>> +struct mshv_vtl_signal_event {
>> +    __u32 connection_id;
>> +    __u32 flag;
>> +};
>> +
>> +struct mshv_vtl_sint_post_msg {
>> +    __u64 message_type;
>> +    __u32 connection_id;
>> +    __u32 payload_size;
> 
> do we have max limit for payload ? if yes
> __u32 payload_size; /* Must not exceed MSHV_VTL_MAX_PAYLOAD_SIZE */
> HV_MESSAGE_PAYLOAD_BYTE_COUNT, is this max payload size ?

No, this is the limit: HV_MESSAGE_PAYLOAD_BYTE_COUNT
Will add the comment.

> 
>> +    __u64 payload_ptr; /* pointer to message payload (bytes) */
>> +};
>> +
>> +struct mshv_vtl_ram_disposition {
>> +    __u64 start_pfn;
>> +    __u64 last_pfn;
>> +};
>> +
>> +struct mshv_vtl_set_poll_file {
>> +    __u32 cpu;
>> +    __u32 fd;
>> +};
>> +
>> +struct mshv_vtl_hvcall_setup {
>> +    __u64 bitmap_size;
>> +    __u64 allow_bitmap_ptr; /* pointer to __u64 */
>> +};
>> +
>> +struct mshv_vtl_hvcall {
>> +    __u64 control;
>> +    __u64 input_size;
>> +    __u64 input_ptr; /* pointer to input struct */
>> +    /* output */
>> +    __u64 status;
>> +    __u64 output_size;
>> +    __u64 output_ptr; /* pointer to output struct */
>> +};
> 
> this /* output */ is ambiguous. can we provide all description or non(as 
> name it self-explanatory) for better consistency and clarity
> struct mshv_vtl_hvcall {
>      __u64 control;      /* Hypercall control code */
>      __u64 input_size;   /* Size of the input data */
>      __u64 input_ptr;    /* Pointer to the input struct */
>      __u64 status;       /* Status of the hypercall (output) */
>      __u64 output_size;  /* Size of the output data */
>      __u64 output_ptr;   /* Pointer to the output struct */
> };

Will change it. Thanks.

>> +
>> +struct mshv_sint_mask {
>> +    __u8 mask;
>> +    __u8 reserved[7];
>> +};
>> +
>> +/* /dev/mshv device IOCTL */
>> +#define MSHV_CHECK_EXTENSION    _IOW(MSHV_IOCTL, 0x00, __u32)
>> +
> 
> 
> 
> Thanks,
> Alok

Thanks Alok for reviewing the code and suggesting improvements.
I'll take care of them in the next version.

Regards,
Naman

