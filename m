Return-Path: <linux-hyperv+bounces-8488-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id z+NvC7G+c2mjyQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8488-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 19:32:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B926A79AC9
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 19:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76B673012C7C
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9E13B58C;
	Fri, 23 Jan 2026 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mVFmwEB6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE893EBF04;
	Fri, 23 Jan 2026 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769193133; cv=none; b=LyteiBxwXPV/UXo0YSKyDKPns9Ao+5yVYl9L/kS5YzVPz2RWCr/IhhhjEae29ryC4mcs5gaKAX9pQAeimeAmj0NqV+EgB1WoKJiKqOTYlFA4aM0mDipHW71PjKXFo+OoYp9A20iKwz+1iHcRhARbAag1ZkxrkW/9+mXvDHzBoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769193133; c=relaxed/simple;
	bh=fe+7znZTJfEkVd9lWg3nIOXuSN9UvwR8nJNmfq213Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaecOipvmYxP1ah9S5OEqFkQb3cFgtkihdCnCAb5VHadgdgHQRFDWz/aJMNLdWTsUR3fPWNllQk30d2V/vQ+sFC60K2bHq2GC+eHd5I0l2+mpCBOKl83eLEphr4VO09gO/yRKxTAuUFKJrBvycw5d5az1qdlNkYeuBGYTCkvwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mVFmwEB6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.200.94] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 75C0E20B7167;
	Fri, 23 Jan 2026 10:32:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 75C0E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769193131;
	bh=PR6z6GPJq0iWQpb7yn8bJsX4OzmaTEOBXMrzD47WGoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mVFmwEB63pYU4wq0GsN/n45tf2rziTWSvpMG1zgCYncexD2J7OunjirP9kptmN8rm
	 smgrkqeQgjeB817l9mTwTGk6upRV/KOa2jTMQvSIlrnR00bvwXCmXAvNPig7kQgJaT
	 Mk0D0b29RJoagWXshB/uJDTGCouSgd0KC3Lg13S8=
Message-ID: <82082744-2e2f-4ea2-8ab4-cdd3e69ffd8f@linux.microsoft.com>
Date: Fri, 23 Jan 2026 10:32:09 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 06/15] mshv: Implement mshv bridge device for VFIO
To: Mukesh R <mrathor@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, mhklinux@outlook.com,
 romank@linux.microsoft.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-7-mrathor@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20260120064230.3602565-7-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8488-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: B926A79AC9
X-Rspamd-Action: no action

On 1/19/2026 10:42 PM, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> Add a new file to implement VFIO-MSHV bridge pseudo device. These
> functions are called in the VFIO framework, and credits to kvm/vfio.c
> as this file was adapted from it.
> 
> Original author: Wei Liu <wei.liu@kernel.org>
> (Slightly modified from the original version).
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>

Since the code is very similar to Wei's original commit, the way I'd
recommend to do it is:
1. Change the commit author to Wei, using git commit --amend --author=
and
2. Put his signed-off line before yours:

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>

This shows he is the author of the commit but you ported it.

If you feel you changed it enough that it should be considered
co-authored, you can instead keep your authorship of the commit and
put:

Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>

> ---
>  drivers/hv/Makefile    |   3 +-
>  drivers/hv/mshv_vfio.c | 210 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hv/mshv_vfio.c
> 
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index a49f93c2d245..eae003c4cb8f 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -14,7 +14,8 @@ hv_vmbus-y := vmbus_drv.o \
>  hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
>  hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>  mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
> -	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
> +	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o \
> +               mshv_vfio.o
>  mshv_vtl-y := mshv_vtl_main.o
>  
>  # Code that must be built-in
> diff --git a/drivers/hv/mshv_vfio.c b/drivers/hv/mshv_vfio.c
> new file mode 100644
> index 000000000000..6ea4d99a3bd2
> --- /dev/null
> +++ b/drivers/hv/mshv_vfio.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * VFIO-MSHV bridge pseudo device
> + *
> + * Heavily inspired by the VFIO-KVM bridge pseudo device.
> + */
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/vfio.h>
> +
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +struct mshv_vfio_file {
> +	struct list_head node;
> +	struct file *file;	/* list of struct mshv_vfio_file */
> +};
> +
> +struct mshv_vfio {
> +	struct list_head file_list;
> +	struct mutex lock;
> +};
> +
> +static bool mshv_vfio_file_is_valid(struct file *file)
> +{
> +	bool (*fn)(struct file *file);
> +	bool ret;
> +
> +	fn = symbol_get(vfio_file_is_valid);
> +	if (!fn)
> +		return false;
> +
> +	ret = fn(file);
> +
> +	symbol_put(vfio_file_is_valid);
> +
> +	return ret;
> +}
> +
> +static long mshv_vfio_file_add(struct mshv_device *mshvdev, unsigned int fd)
> +{
> +	struct mshv_vfio *mshv_vfio = mshvdev->device_private;
> +	struct mshv_vfio_file *mvf;
> +	struct file *filp;
> +	long ret = 0;
> +
> +	filp = fget(fd);
> +	if (!filp)
> +		return -EBADF;
> +
> +	/* Ensure the FD is a vfio FD. */
> +	if (!mshv_vfio_file_is_valid(filp)) {
> +		ret = -EINVAL;
> +		goto out_fput;
> +	}
> +
> +	mutex_lock(&mshv_vfio->lock);
> +
> +	list_for_each_entry(mvf, &mshv_vfio->file_list, node) {
> +		if (mvf->file == filp) {
> +			ret = -EEXIST;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	mvf = kzalloc(sizeof(*mvf), GFP_KERNEL_ACCOUNT);
> +	if (!mvf) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	mvf->file = get_file(filp);
> +	list_add_tail(&mvf->node, &mshv_vfio->file_list);
> +
> +out_unlock:
> +	mutex_unlock(&mshv_vfio->lock);
> +out_fput:
> +	fput(filp);
> +	return ret;
> +}
> +
> +static long mshv_vfio_file_del(struct mshv_device *mshvdev, unsigned int fd)
> +{
> +	struct mshv_vfio *mshv_vfio = mshvdev->device_private;
> +	struct mshv_vfio_file *mvf;
> +	long ret;
> +
> +	CLASS(fd, f)(fd);
> +
> +	if (fd_empty(f))
> +		return -EBADF;
> +
> +	ret = -ENOENT;
> +	mutex_lock(&mshv_vfio->lock);
> +
> +	list_for_each_entry(mvf, &mshv_vfio->file_list, node) {
> +		if (mvf->file != fd_file(f))
> +			continue;
> +
> +		list_del(&mvf->node);
> +		fput(mvf->file);
> +		kfree(mvf);
> +		ret = 0;
> +		break;
> +	}
> +
> +	mutex_unlock(&mshv_vfio->lock);
> +	return ret;
> +}
> +
> +static long mshv_vfio_set_file(struct mshv_device *mshvdev, long attr,
> +			      void __user *arg)
> +{
> +	int32_t __user *argp = arg;
> +	int32_t fd;
> +
> +	switch (attr) {
> +	case MSHV_DEV_VFIO_FILE_ADD:
> +		if (get_user(fd, argp))
> +			return -EFAULT;
> +		return mshv_vfio_file_add(mshvdev, fd);
> +
> +	case MSHV_DEV_VFIO_FILE_DEL:
> +		if (get_user(fd, argp))
> +			return -EFAULT;
> +		return mshv_vfio_file_del(mshvdev, fd);
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static long mshv_vfio_set_attr(struct mshv_device *mshvdev,
> +			      struct mshv_device_attr *attr)
> +{
> +	switch (attr->group) {
> +	case MSHV_DEV_VFIO_FILE:
> +		return mshv_vfio_set_file(mshvdev, attr->attr,
> +					  u64_to_user_ptr(attr->addr));
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static long mshv_vfio_has_attr(struct mshv_device *mshvdev,
> +			      struct mshv_device_attr *attr)
> +{
> +	switch (attr->group) {
> +	case MSHV_DEV_VFIO_FILE:
> +		switch (attr->attr) {
> +		case MSHV_DEV_VFIO_FILE_ADD:
> +		case MSHV_DEV_VFIO_FILE_DEL:
> +			return 0;
> +		}
> +
> +		break;
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static long mshv_vfio_create_device(struct mshv_device *mshvdev, u32 type)
> +{
> +	struct mshv_device *tmp;
> +	struct mshv_vfio *mshv_vfio;
> +
> +	/* Only one VFIO "device" per VM */
> +	hlist_for_each_entry(tmp, &mshvdev->device_pt->pt_devices,
> +			     device_ptnode)
> +		if (tmp->device_ops == &mshv_vfio_device_ops)
> +			return -EBUSY;
> +
> +	mshv_vfio = kzalloc(sizeof(*mshv_vfio), GFP_KERNEL_ACCOUNT);
> +	if (mshv_vfio == NULL)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&mshv_vfio->file_list);
> +	mutex_init(&mshv_vfio->lock);
> +
> +	mshvdev->device_private = mshv_vfio;
> +
> +	return 0;
> +}
> +
> +/* This is called from mshv_device_fop_release() */
> +static void mshv_vfio_release_device(struct mshv_device *mshvdev)
> +{
> +	struct mshv_vfio *mv = mshvdev->device_private;
> +	struct mshv_vfio_file *mvf, *tmp;
> +
> +	list_for_each_entry_safe(mvf, tmp, &mv->file_list, node) {
> +		fput(mvf->file);
> +		list_del(&mvf->node);
> +		kfree(mvf);
> +	}
> +
> +	kfree(mv);
> +	kfree(mshvdev);
> +}
> +
> +struct mshv_device_ops mshv_vfio_device_ops = {
> +	.device_name = "mshv-vfio",
> +	.device_create = mshv_vfio_create_device,
> +	.device_release = mshv_vfio_release_device,
> +	.device_set_attr = mshv_vfio_set_attr,
> +	.device_has_attr = mshv_vfio_has_attr,
> +};


