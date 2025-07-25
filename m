Return-Path: <linux-hyperv+bounces-6390-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36873B1181D
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 07:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602F55652B3
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 05:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22EA243969;
	Fri, 25 Jul 2025 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sfdXG8+v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810943A1DB;
	Fri, 25 Jul 2025 05:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422874; cv=none; b=EWU1C0EDwQWkGWbiVH1EQQXvzy6kKdWOmfzLVaIMtFMeapMZuH6QXsu89spL6eVldE6XhHAwW1cKx9fya7rVrdtV7JHntngw5tAmj9DR3jNEAJBxq0A7tH6m0GaDVQ6jNq1PoyygiPcYRPJEXbUszAjLcNqes2sY2N1jmJaEWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422874; c=relaxed/simple;
	bh=6TIwr/wtNsiuTVt+HLiSo7bWliZphS0D2xEFobD2hmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSDhsnIkJXYKz1tykdsYGwiHVr2mLg7me7o0sgVEgTVni+Hk7Do1dtoSTyo2oTbyGvVreZcTR/jnB72CKVhgh1TzxK9YJ+gIJ70pbLARagyX6URYzYznPcSW0LsWSlZHo1PEFblp/sj6hNZo2Ha0oSpK1XpnkH3lYU3aISXYLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sfdXG8+v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.130.86] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0CCCF2014DFF;
	Thu, 24 Jul 2025 22:54:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CCCF2014DFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753422872;
	bh=HWcbsXJkRsia03Kf091pMg8O2CKL2zvnMJOjSHbc+zY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sfdXG8+vggzKC4riSv2Jrjas0/hUm71FO7F9mU7CSeP/Q8gMd7iahvuk4ZCap/0yG
	 47eSpDx+11KINrVEulRGvAq34lR0jb9frACkCMK+zOulNZq/A924769VxsRt2DC9+C
	 x/bQeKQhKxkvIBpGCl/R3PqpDH6H6uCKwsYKQKfo=
Message-ID: <03c90b7d-e9b8-4f8f-9267-c273791077c2@linux.microsoft.com>
Date: Fri, 25 Jul 2025 11:24:20 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] Drivers: hv: Introduce mshv_vtl driver
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
 Markus Elfring <Markus.Elfring@web.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
 <20250724082547.195235-3-namjain@linux.microsoft.com>
 <SN6PR02MB41571331AF61BE197F76B970D459A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41571331AF61BE197F76B970D459A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/25/2025 8:52 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, July 24, 2025 1:26 AM
>>
> 
> Overall, this is looking really good. I have just a few comments embedded below.
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
>> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
>> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>> Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>
> 
> This "Message-ID" line looks misplaced or just spurious.

Removed it, not sure where it got introduced, but I see it is not used 
commonly.

> 
>> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/Kconfig          |   22 +
>>   drivers/hv/Makefile         |    7 +-
>>   drivers/hv/mshv_vtl.h       |   52 ++
>>   drivers/hv/mshv_vtl_main.c  | 1508 +++++++++++++++++++++++++++++++++++
>>   include/hyperv/hvgdk_mini.h |  106 +++
>>   include/uapi/linux/mshv.h   |   80 ++
>>   6 files changed, 1774 insertions(+), 1 deletion(-)
> 
> Nice! 254 fewer lines inserted than in the previous version!

Yes :) thanks a lot for your review comments.

> 
>>   create mode 100644 drivers/hv/mshv_vtl.h
>>   create mode 100644 drivers/hv/mshv_vtl_main.c
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 57623ca7f350..2e8df09db599 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -73,4 +73,26 @@ config MSHV_ROOT
>>

<snip>

>> +
>> +static struct tasklet_struct msg_dpc;
>> +static wait_queue_head_t fd_wait_queue;
>> +static bool has_message;
>> +static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
>> +static DEFINE_MUTEX(flag_lock);
>> +static bool __read_mostly mshv_has_reg_page;
>> +
>> +/* hvcall code is of type u16, allocate a bitmap of size (1 << 16) to accommodate it */
>> +#define MAX_BITMAP_SIZE BIT(16)
> 
> Or maybe per my comment below, use
> 
> #define MAX_BITMAP_BYTES ((U16_MAX + 1)/8)

I think I ignored the u8 part of the bitmap array. Will change it.

> 
>> +
>> +struct mshv_vtl_hvcall_fd {
>> +	u8 allow_bitmap[MAX_BITMAP_SIZE];
> 
> This is still too big. :-(  You'll get 64K bytes, which is 512K bits. You only need
> 64K bits.

True.

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
>> +struct mshv_vtl_per_cpu {
>> +	struct mshv_vtl_run *run;
>> +	struct page *reg_page;
>> +};
>> +
>> +/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
>> +union hv_synic_overlay_page_msr {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 enabled: 1;
>> +		u64 reserved: 11;
>> +		u64 pfn: 52;
>> +	};
> 
> Add __packed to exactly match hv_synic_simp.

Acked.

> 
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

<snip>

>> +static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
>> +{
>> +	struct mshv_vtl_ram_disposition vtl0_mem;
>> +	struct dev_pagemap *pgmap;
>> +	void *addr;
>> +
>> +	if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
>> +		return -EFAULT;
>> +	/* vlt0_mem.last_pfn is excluded in the pagemap range for VTL0 as per design */
> 
> s/vlt0_mem/vtl0_mem/

Acked.

> 
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
>> +
>> +	if (input.cpu >= num_possible_cpus() || !cpu_online(input.cpu))
>> +		return -EINVAL;
>> +	/*
>> +	 * Hotplug is not supported in VTL2 in OpenHCL, where this kernel driver exists.
> 
> More precisely, you mean "CPU hotplug" as opposed to "memory hotplug", though
> that should be evident from the context. (Memory hotplug may not be supported
> either, but that's not relevant here.)

Acked.

> 
>> +	 * CPU is expected to remain online after above cpu_online() check.
>> +	 */
>> +
>> +	file = NULL;
>> +	file = fget(input.fd);
>> +	if (!file)
>> +		return -EBADFD;
>> +
>> +	poll_file = per_cpu_ptr(&mshv_vtl_poll_file, READ_ONCE(input.cpu));
>> +	if (!poll_file)
>> +		return -EINVAL;
>> +
>> +	guard(mutex)(&mshv_vtl_poll_file_lock);
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
>> +	if (old_file)
>> +		fput(old_file);
> 
> Is it safe to call fput() while holding mshv_vtl_poll_file_lock? I don't know
> the answer, but the change to using "guard" has made the fput() within
> the scope of the lock, whereas previously it was not. My inclination would
> be to *not* hold mshv_vtl_poll_file_lock when calling fput(), but I can't
> immediately point to a problem that occur if the lock is held.
> 

I was also confused about it, but I think you are right, I can revert 
this to the previous implementation.

>> +
>> +	return 0;
>> +}
>> +
>> +/* Static table mapping register names to their corresponding actions */
>> +static const struct {
>> +	enum hv_register_name reg_name;
>> +	int debug_reg_num;  /* -1 if not a debug register */
>> +	u32 msr_addr;       /* 0 if not an MSR */
>> +} reg_table[] = {
>> +	/* Debug registers */
>> +	{HV_X64_REGISTER_DR0, 0, 0},
>> +	{HV_X64_REGISTER_DR1, 1, 0},
>> +	{HV_X64_REGISTER_DR2, 2, 0},
>> +	{HV_X64_REGISTER_DR3, 3, 0},
>> +	{HV_X64_REGISTER_DR6, 6, 0},
>> +	/* MTRR MSRs */
>> +	{HV_X64_REGISTER_MSR_MTRR_CAP, -1, MSR_MTRRcap},
>> +	{HV_X64_REGISTER_MSR_MTRR_DEF_TYPE, -1, MSR_MTRRdefType},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0, -1, MTRRphysBase_MSR(0)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1, -1, MTRRphysBase_MSR(1)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2, -1, MTRRphysBase_MSR(2)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3, -1, MTRRphysBase_MSR(3)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4, -1, MTRRphysBase_MSR(4)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5, -1, MTRRphysBase_MSR(5)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6, -1, MTRRphysBase_MSR(6)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7, -1, MTRRphysBase_MSR(7)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8, -1, MTRRphysBase_MSR(8)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9, -1, MTRRphysBase_MSR(9)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA, -1, MTRRphysBase_MSR(0xa)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB, -1, MTRRphysBase_MSR(0xb)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC, -1, MTRRphysBase_MSR(0xc)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASED, -1, MTRRphysBase_MSR(0xd)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE, -1, MTRRphysBase_MSR(0xe)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF, -1, MTRRphysBase_MSR(0xf)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0, -1, MTRRphysMask_MSR(0)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1, -1, MTRRphysMask_MSR(1)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2, -1, MTRRphysMask_MSR(2)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3, -1, MTRRphysMask_MSR(3)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4, -1, MTRRphysMask_MSR(4)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5, -1, MTRRphysMask_MSR(5)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6, -1, MTRRphysMask_MSR(6)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7, -1, MTRRphysMask_MSR(7)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8, -1, MTRRphysMask_MSR(8)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9, -1, MTRRphysMask_MSR(9)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA, -1, MTRRphysMask_MSR(0xa)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB, -1, MTRRphysMask_MSR(0xb)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC, -1, MTRRphysMask_MSR(0xc)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD, -1, MTRRphysMask_MSR(0xd)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE, -1, MTRRphysMask_MSR(0xe)},
>> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF, -1, MTRRphysMask_MSR(0xf)},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX64K00000, -1, MSR_MTRRfix64K_00000},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX16K80000, -1, MSR_MTRRfix16K_80000},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX16KA0000, -1, MSR_MTRRfix16K_A0000},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KC0000, -1, MSR_MTRRfix4K_C0000},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KC8000, -1, MSR_MTRRfix4K_C8000},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KD0000, -1, MSR_MTRRfix4K_D0000},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KD8000, -1, MSR_MTRRfix4K_D8000},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KE0000, -1, MSR_MTRRfix4K_E0000},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KE8000, -1, MSR_MTRRfix4K_E8000},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KF0000, -1, MSR_MTRRfix4K_F0000},
>> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KF8000, -1, MSR_MTRRfix4K_F8000},
>> +};
>> +
>> +static int mshv_vtl_set_reg(struct hv_register_assoc *regs)
>> +{
>> +	u64 reg64;
>> +	enum hv_register_name gpr_name;
>> +	int i;
>> +
>> +	gpr_name = regs->name;
>> +	reg64 = regs->value.reg64;
>> +
>> +	/* Search for the register in the table */
>> +	for (i = 0; i < ARRAY_SIZE(reg_table); i++) {
>> +		if (reg_table[i].reg_name == gpr_name) {
>> +			if (reg_table[i].debug_reg_num != -1) {
>> +				/* Handle debug registers */
>> +				if (gpr_name == HV_X64_REGISTER_DR6 &&
>> +				    !mshv_vsm_capabilities.dr6_shared)
>> +					goto hypercall;
>> +				native_set_debugreg(reg_table[i].debug_reg_num, reg64);
>> +			} else {
>> +				/* Handle MSRs */
>> +				wrmsrl(reg_table[i].msr_addr, reg64);
>> +			}
>> +			return 0;
>> +		}
>> +	}
>> +
>> +hypercall:
>> +	return 1;
>> +}
>> +
>> +static int mshv_vtl_get_reg(struct hv_register_assoc *regs)
>> +{
>> +	u64 *reg64;
>> +	enum hv_register_name gpr_name;
>> +	int i;
>> +
>> +	gpr_name = regs->name;
>> +	reg64 = (u64 *)&regs->value.reg64;
>> +
>> +	/* Search for the register in the table */
>> +	for (i = 0; i < ARRAY_SIZE(reg_table); i++) {
>> +		if (reg_table[i].reg_name == gpr_name) {
>> +			if (reg_table[i].debug_reg_num != -1) {
>> +				/* Handle debug registers */
>> +				if (gpr_name == HV_X64_REGISTER_DR6 &&
>> +				    !mshv_vsm_capabilities.dr6_shared)
>> +					goto hypercall;
>> +				*reg64 = native_get_debugreg(reg_table[i].debug_reg_num);
>> +			} else {
>> +				/* Handle MSRs */
>> +				rdmsrl(reg_table[i].msr_addr, *reg64);
>> +			}
>> +			return 0;
>> +		}
>> +	}
>> +
>> +hypercall:
>> +	return 1;
>> +}
> 
> Nice! You incorporated the debug registers as well into the static
> table and lookup functions. I count 224 fewer source code lines.

Yes. Thanks.

> 
>> +
>> +static void mshv_vtl_return(struct mshv_vtl_cpu_context *vtl0)
>> +{


<snip>

>> +
>> +static long
>> +mshv_vtl_ioctl_get_regs(void __user *user_args)
>> +{
>> +	struct mshv_vp_registers args;
>> +	struct hv_register_assoc *reg;
>> +	long ret;
>> +
>> +	if (copy_from_user(&args, user_args, sizeof(args)))
>> +		return -EFAULT;
>> +
>> +	/*  This IOCTL supports processing only one register at a time. */
>> +	if (args.count != 1)
>> +		return -EINVAL;
>> +
>> +	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
> 
> If handling only one register, there's no need to kmalloc. Just
> declare the struct hv_register_assoc directly on the stack
> instead of a pointer to such. Then the error paths are
> simpler because memory doesn't need to be freed.

Acked. Makes sense.

> 
>> +	if (!reg)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(reg, (void __user *)args.regs_ptr,
>> +			   sizeof(*reg))) {
>> +		ret = -EFAULT;
>> +		goto free_return;
>> +	}
>> +
>> +	ret = mshv_vtl_get_reg(reg);
>> +	if (!ret)
>> +		goto copy_args; /* No need of hypercall */
>> +	ret = vtl_get_vp_register(reg);
>> +	if (ret)
>> +		goto free_return;
>> +
>> +copy_args:
>> +	if (copy_to_user((void __user *)args.regs_ptr, reg, sizeof(*reg)))
>> +		ret = -EFAULT;
>> +free_return:
>> +	kfree(reg);
>> +
>> +	return ret;
>> +}
>> +
>> +static long
>> +mshv_vtl_ioctl_set_regs(void __user *user_args)
>> +{
>> +	struct mshv_vp_registers args;
>> +	struct hv_register_assoc *reg;
>> +	long ret;
>> +
>> +	if (copy_from_user(&args, user_args, sizeof(args)))
>> +		return -EFAULT;
>> +
>> +	/*  This IOCTL supports processing only one register at a time. */
>> +	if (args.count != 1)
>> +		return -EINVAL;
>> +
>> +	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
> 
> Same here.  Declare struct hv_register_assoc on the stack.

Acked.

> 
>> +	if (!reg)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(reg, (void __user *)args.regs_ptr, sizeof(*reg))) {
>> +		ret = -EFAULT;
>> +		goto free_return;
>> +	}
>> +
>> +	ret = mshv_vtl_set_reg(reg);
>> +	if (!ret)
>> +		goto free_return; /* No need of hypercall */
>> +	ret = vtl_set_vp_register(reg);
>> +
>> +free_return:
>> +	kfree(reg);
>> +
>> +	return ret;
>> +}
>> +

<snip>

>> +
>> +static int mshv_vtl_sint_ioctl_signal_event(struct mshv_vtl_signal_event __user *arg)
>> +{
>> +	u64 input, status;
>> +	struct mshv_vtl_signal_event signal_event;
>> +
>> +	if (copy_from_user(&signal_event, arg, sizeof(signal_event)))
>> +		return -EFAULT;
>> +
>> +	input = signal_event.connection_id | ((u64)signal_event.flag << 32);
>> +
>> +	status = hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, input) & HV_HYPERCALL_RESULT_MASK;
>> +	if (status)
> 
> Don't AND with HV_HYPERCALL_RESULT_MASK and then test the result.
> You can just do "return hv_result_to_errno(status)". The function will
> return zero if there's no error. See other uses of hv_result_to_errno() for
> the various patterns. We want to get away from AND'ing with
> HV_HYPERCALL_RESULT_MASK and instead always use the helper
> functions.

Acked.

> 
>> +		return hv_result_to_errno(status);
>> +	return 0;
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
>> +	guard(mutex)(&flag_lock);
>> +	old_eventfd = READ_ONCE(flag_eventfds[set_eventfd.flag]);
>> +	WRITE_ONCE(flag_eventfds[set_eventfd.flag], eventfd);
>> +
>> +	if (old_eventfd) {
>> +		synchronize_rcu();
>> +		eventfd_ctx_put(old_eventfd);
> 
> Again, I wonder if is OK to do eventfd_ctx_put() while holding
> flag_lock, since the use of guard() changes the scope of the lock
> compared with the previous version of this patch.
> 

I didn't find eventfd_ctx_put() to be a blocking operation, so I thought
of keeping guard() here. Although, synchronize_rcu() is a blocking
operation. Please advise, I am Ok with removing the guard, as the lock
is just being used here, and automatic cleanup should not be an issue
here.


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
>> +	guard(mutex)(&vtl2_vmbus_sint_mask_mutex);
>> +	on_each_cpu((smp_call_func_t)mshv_vtl_synic_mask_vmbus_sint, &mask.mask, 1);
>> +	WRITE_ONCE(vtl_synic_mask_vmbus_sint_masked, mask.mask != 0);
>> +	if (mask.mask)
>> +		wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
> 
> Doing this wakeup is probably safe to do while holding the lock.

Acked.

> 
>> +
>> +	return 0;
>> +}
>> +

<snip>

>> +};
>> +
>> +struct mshv_vtl_set_poll_file {
>> +	__u32 cpu;
>> +	__u32 fd;
>> +};
>> +
>> +struct mshv_vtl_hvcall_setup {
>> +	__u64 bitmap_array_size;
>> +	__u64 allow_bitmap_ptr; /* pointer to __u64 */
> 
> I don't think the comment is relevant. The unit of
> memory allocation in user space doesn't affect kernel
> code. And perhaps add a comment that bitmap_array_size
> is a *byte* count! :-)

Acked.

> 
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

Thanks for the review comments.

Regards,
Naman

