Return-Path: <linux-hyperv+bounces-4039-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D28A434F7
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Feb 2025 07:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FFA7A58DA
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Feb 2025 06:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1065256C68;
	Tue, 25 Feb 2025 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CKjWH1i8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8152566F1;
	Tue, 25 Feb 2025 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740463996; cv=none; b=SeRnWbywAvWT8OvkaWTJT5ycr2qTsQWiJvtfBx+pLxZiKiEFwAh4v89tXksqOdDdWRF5vz7Vc1M4slT6G2VsETKyY+RiVRLwztJkEOrekviKLqj2hHIo/KB0XCfgtg0CJ+/lrpjuDqvhart0W7VfMriNxgpOY9NCR5cR5sZrm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740463996; c=relaxed/simple;
	bh=GPUPZeCXKfXNhvuJExZ+jWuWgptD83dizoihy6ohZF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr5tqvXrB/e8I6HaFDIclYkUc08tFtoTENsvVulP0CZNLghaNZGra4jIURdeuqs85kFnvLJPz/nBcntPrRxSIMNfo8IzSiEtQY+rHW19jvzJh853QZnqAU2Fr4zvTed2CmZ667eECMRklEY7hNRWCvuykTf+8Z/g10+98HvXAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CKjWH1i8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516F4C4CEDD;
	Tue, 25 Feb 2025 06:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740463994;
	bh=GPUPZeCXKfXNhvuJExZ+jWuWgptD83dizoihy6ohZF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKjWH1i8Fk+EJ/pwcIYxJUS/PNq18v6Z4w0XWq7OfGIoIE3TUzOES3H32VUbBQCmn
	 eNpBhlw6Pvt6CcqSq0Ayy4aZgLqrCq7lD+Z0+4HViEcaM5Mo5ESQG8jLqO/bZJlIGr
	 77Q3v/A3spDsjDhJux/rvtHPtytU/xl6orlmFUps=
Date: Tue, 25 Feb 2025 07:12:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH] uio_hv_generic: Fix sysfs creation path for ring buffer
Message-ID: <2025022504-diagnosis-outsell-684c@gregkh>
References: <20250225052001.2225-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225052001.2225-1-namjain@linux.microsoft.com>

On Tue, Feb 25, 2025 at 10:50:01AM +0530, Naman Jain wrote:
> On regular bootup, devices get registered to vmbus first, so when
> uio_hv_generic driver for a particular device type is probed,
> the device is already initialized and added, so sysfs creation in
> uio_hv_generic probe works fine. However, when device is removed
> and brought back, the channel rescinds and device again gets
> registered to vmbus. However this time, the uio_hv_generic driver is
> already registered to probe for that device and in this case sysfs
> creation is tried before the device gets initialized completely.
> 
> Fix this by moving the core logic of sysfs creation for ring buffer,
> from uio_hv_generic to HyperV's vmbus driver, where rest of the sysfs
> attributes for the channels are defined. While doing that, make use
> of attribute groups and macros, instead of creating sysfs directly,
> to ensure better error handling and code flow.
> 
> Problem path:
> vmbus_device_register
>     device_register
>         uio_hv_generic probe
>                     sysfs_create_bin_file (fails here)
>         kset_create_and_add (dependency)
>         vmbus_add_channel_kobj (dependency)
> 
> Fixes: 9ab877a6ccf8 ("uio_hv_generic: make ring buffer attribute for primary channel")
> Cc: stable@kernel.org
> Suggested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
> Hi,
> This is the first patch after initial RFC was posted.
> https://lore.kernel.org/all/20250214064351.8994-1-namjain@linux.microsoft.com/
> 
> Changes since RFC patch:
> * Different approach to solve the problem is proposed (credits to
>   Michael Kelley).
> * Core logic for sysfs creation moved out of uio_hv_generic, to VMBus
>   drivers where rest of the sysfs attributes for a VMBus channel
>   are defined. (addressed Greg's comments)
> * Used attribute groups instead of sysfs_create* functions, and bundled
>   ring attribute with other attributes for the channel sysfs.  
> 
> Error logs:
> 
> [   35.574120] ------------[ cut here ]------------
> [   35.574122] WARNING: CPU: 0 PID: 10 at fs/sysfs/file.c:591 sysfs_create_bin_file+0x81/0x90
> [   35.574168] Workqueue: hv_pri_chan vmbus_add_channel_work
> [   35.574172] RIP: 0010:sysfs_create_bin_file+0x81/0x90
> [   35.574197] Call Trace:
> [   35.574199]  <TASK>
> [   35.574200]  ? show_regs+0x69/0x80
> [   35.574217]  ? __warn+0x8d/0x130
> [   35.574220]  ? sysfs_create_bin_file+0x81/0x90
> [   35.574222]  ? report_bug+0x182/0x190
> [   35.574225]  ? handle_bug+0x5b/0x90
> [   35.574244]  ? exc_invalid_op+0x19/0x70
> [   35.574247]  ? asm_exc_invalid_op+0x1b/0x20
> [   35.574252]  ? sysfs_create_bin_file+0x81/0x90
> [   35.574255]  hv_uio_probe+0x1e7/0x410 [uio_hv_generic]
> [   35.574271]  vmbus_probe+0x3b/0x90
> [   35.574275]  really_probe+0xf4/0x3b0
> [   35.574279]  __driver_probe_device+0x8a/0x170
> [   35.574282]  driver_probe_device+0x23/0xc0
> [   35.574285]  __device_attach_driver+0xb5/0x140
> [   35.574288]  ? __pfx___device_attach_driver+0x10/0x10
> [   35.574291]  bus_for_each_drv+0x86/0xe0
> [   35.574294]  __device_attach+0xc1/0x200
> [   35.574297]  device_initial_probe+0x13/0x20
> [   35.574315]  bus_probe_device+0x99/0xa0
> [   35.574318]  device_add+0x647/0x870
> [   35.574320]  ? hrtimer_init+0x28/0x70
> [   35.574323]  device_register+0x1b/0x30
> [   35.574326]  vmbus_device_register+0x83/0x130
> [   35.574328]  vmbus_add_channel_work+0x135/0x1a0
> [   35.574331]  process_one_work+0x177/0x340
> [   35.574348]  worker_thread+0x2b2/0x3c0
> [   35.574350]  kthread+0xe3/0x1f0
> [   35.574353]  ? __pfx_worker_thread+0x10/0x10
> [   35.574356]  ? __pfx_kthread+0x10/0x10
> 
> ---
>  drivers/hv/hyperv_vmbus.h    |  4 +++
>  drivers/hv/vmbus_drv.c       | 62 ++++++++++++++++++++++++++++++++++++
>  drivers/uio/uio_hv_generic.c | 34 ++------------------
>  include/linux/hyperv.h       |  3 ++
>  4 files changed, 72 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 29780f3a7478..e0c7b75e6c7a 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -477,4 +477,8 @@ static inline int hv_debug_add_dev_dir(struct hv_device *dev)
>  
>  #endif /* CONFIG_HYPERV_TESTING */
>  
> +/* Create and remove sysfs entry for memory mapped ring buffers for a channel */
> +int hv_create_ring_sysfs(struct vmbus_channel *channel);
> +int hv_remove_ring_sysfs(struct vmbus_channel *channel);
> +
>  #endif /* _HYPERV_VMBUS_H */
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 22afebfc28ff..0110643bad3f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1802,6 +1802,39 @@ static ssize_t subchannel_id_show(struct vmbus_channel *channel,
>  }
>  static VMBUS_CHAN_ATTR_RO(subchannel_id);
>  
> +/* Functions to create sysfs interface to allow mmap of the ring buffers.
> + * The ring buffer is allocated as contiguous memory by vmbus_open
> + */
> +static int hv_mmap_ring_buffer(struct vmbus_channel *channel, struct vm_area_struct *vma)
> +{
> +	void *ring_buffer = page_address(channel->ringbuffer_page);
> +
> +	if (channel->state != CHANNEL_OPENED_STATE)
> +		return -ENODEV;
> +
> +	return vm_iomap_memory(vma, virt_to_phys(ring_buffer),
> +			       channel->ringbuffer_pagecount << PAGE_SHIFT);
> +}
> +
> +static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
> +				       const struct bin_attribute *attr,
> +				       struct vm_area_struct *vma)
> +{
> +	struct vmbus_channel *channel = container_of(kobj, struct vmbus_channel, kobj);
> +
> +	if (!channel->mmap_ring_buffer)
> +		return -ENODEV;
> +	return channel->mmap_ring_buffer(channel, vma);

What is preventing mmap_ring_buffer from being set to NULL right after
checking it and then calling it here?  I see no locks here or where you
are assigning this variable at all, so what is preventing these types of
races?

thanks,

greg k-h

