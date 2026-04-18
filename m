Return-Path: <linux-hyperv+bounces-10205-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IcyGXHO4mm4+gAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10205-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Apr 2026 02:21:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D504A41F53A
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Apr 2026 02:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1D2430338A6
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Apr 2026 00:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39FF1A262D;
	Sat, 18 Apr 2026 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dYT9ZNDu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1787175A97;
	Sat, 18 Apr 2026 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776471661; cv=none; b=LrwcvbjKyTsmUGMkQHFhAYr2QM3BwVFTQmjbQq2IOtQboFRyJ+EZRBQEeOypHXDICSnMXDxNi4dEqrmjNPVCXT6yrPtkRp/d2UYpXjkVy62br+S38gvPwAsB0TpGcV1pu8myfXmJoaN9JLLXRYVIp6KDXlVR/RcBYd00Bff/NB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776471661; c=relaxed/simple;
	bh=54HzNelDzBSSQvthwgLiprleLLldcu1fhR4OCJOh4bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dd5sZJnLxfyw1Ny1Dz8wqh0vUmbJ1p61LOeM8ckL2+xttnat+kZOwBzAMX+wS12RY4NgjE5yUv0enqVUzQdJnmiB/TWM1DyDFfxhNXn4fVBz3uOwMnkAGgeuJU3PKDwAEEFwfOtU3OG7OfytdsuFSoPas/wblHkSTnG3GcRtsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dYT9ZNDu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B96520B7128;
	Fri, 17 Apr 2026 17:20:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B96520B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776471659;
	bh=GVHuT39vJFq3z9p9Y8P4lQnO5Ygvg1D3+qSvKG01gbY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dYT9ZNDuycE39Rmok1I6PkVn+1fRDnnVG7AQULHoh8ka9lRpuZZfVcN3GE476KHCm
	 7q9IKowPidbuXTYdIZorG3mFjFlT9roQFkhQcwZt5HmGQogAfGL0LjONAQykbCKjkF
	 8HrR1mr46rqVdmR18Z3suICKceYTvClPyPCcdPKY=
Message-ID: <ffe33ce4-0a1b-44af-9e17-7f641fef9339@linux.microsoft.com>
Date: Fri, 17 Apr 2026 17:20:57 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 07/15] mshv: Add ioctl support for MSHV-VFIO bridge
 device
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
 romank@linux.microsoft.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-8-mrathor@linux.microsoft.com>
 <aW-pw7GlQdFv-lf5@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aW-pw7GlQdFv-lf5@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10205-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: D504A41F53A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 08:13, Stanislav Kinsburskii wrote:
> On Mon, Jan 19, 2026 at 10:42:22PM -0800, Mukesh R wrote:
>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>>
>> Add ioctl support for creating MSHV devices for a paritition. At
>> present only VFIO device types are supported, but more could be
>> added. At a high level, a partition ioctl to create device verifies
>> it is of type VFIO and does some setup for bridge code in mshv_vfio.c.
>> Adapted from KVM device ioctls.
>>
>> Credits: Original author: Wei Liu <wei.liu@kernel.org>
>> NB: Slightly modified from the original version.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>   drivers/hv/mshv_root_main.c | 126 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 126 insertions(+)
>>
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index 83c7bad269a0..27313419828d 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -1551,6 +1551,129 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
>>   	return ret;
>>   }
>>   
>> +static long mshv_device_attr_ioctl(struct mshv_device *mshv_dev, int cmd,
>> +				   ulong uarg)
>> +{
>> +	struct mshv_device_attr attr;
>> +	const struct mshv_device_ops *devops = mshv_dev->device_ops;
>> +
>> +	if (copy_from_user(&attr, (void __user *)uarg, sizeof(attr)))
>> +		return -EFAULT;
>> +
>> +	switch (cmd) {
>> +	case MSHV_SET_DEVICE_ATTR:
>> +		if (devops->device_set_attr)
>> +			return devops->device_set_attr(mshv_dev, &attr);
>> +		break;
>> +	case MSHV_HAS_DEVICE_ATTR:
>> +		if (devops->device_has_attr)
>> +			return devops->device_has_attr(mshv_dev, &attr);
>> +		break;
>> +	}
>> +
>> +	return -EPERM;
>> +}
>> +
>> +static long mshv_device_fop_ioctl(struct file *filp, unsigned int cmd,
>> +				  ulong uarg)
>> +{
>> +	struct mshv_device *mshv_dev = filp->private_data;
>> +
>> +	switch (cmd) {
>> +	case MSHV_SET_DEVICE_ATTR:
>> +	case MSHV_HAS_DEVICE_ATTR:
>> +		return mshv_device_attr_ioctl(mshv_dev, cmd, uarg);
>> +	}
>> +
>> +	return -ENOTTY;
>> +}
>> +
>> +static int mshv_device_fop_release(struct inode *inode, struct file *filp)
>> +{
>> +	struct mshv_device *mshv_dev = filp->private_data;
>> +	struct mshv_partition *partition = mshv_dev->device_pt;
>> +
>> +	if (mshv_dev->device_ops->device_release) {
>> +		mutex_lock(&partition->pt_mutex);
>> +		hlist_del(&mshv_dev->device_ptnode);
>> +		mshv_dev->device_ops->device_release(mshv_dev);
>> +		mutex_unlock(&partition->pt_mutex);
>> +	}
>> +
>> +	mshv_partition_put(partition);
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations mshv_device_fops = {
>> +	.owner = THIS_MODULE,
>> +	.unlocked_ioctl = mshv_device_fop_ioctl,
>> +	.release = mshv_device_fop_release,
>> +};
>> +
>> +long mshv_partition_ioctl_create_device(struct mshv_partition *partition,
>> +					void __user *uarg)
>> +{
>> +	long rc;
>> +	struct mshv_create_device devargk;
>> +	struct mshv_device *mshv_dev;
>> +	const struct mshv_device_ops *vfio_ops;
>> +	int type;
>> +
>> +	if (copy_from_user(&devargk, uarg, sizeof(devargk))) {
>> +		rc = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	/* At present, only VFIO is supported */
>> +	if (devargk.type != MSHV_DEV_TYPE_VFIO) {
>> +		rc = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	if (devargk.flags & MSHV_CREATE_DEVICE_TEST) {
>> +		rc = 0;
>> +		goto out;
>> +	}
>> +
>> +	mshv_dev = kzalloc(sizeof(*mshv_dev), GFP_KERNEL_ACCOUNT);
>> +	if (mshv_dev == NULL) {
>> +		rc = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	vfio_ops = &mshv_vfio_device_ops;
>> +	mshv_dev->device_ops = vfio_ops;
>> +	mshv_dev->device_pt = partition;
>> +
>> +	rc = vfio_ops->device_create(mshv_dev, type);
>> +	if (rc < 0) {
>> +		kfree(mshv_dev);
>> +		goto out;
>> +	}
>> +
>> +	hlist_add_head(&mshv_dev->device_ptnode, &partition->pt_devices);
>> +
>> +	mshv_partition_get(partition);
>> +	rc = anon_inode_getfd(vfio_ops->device_name, &mshv_device_fops,
>> +			      mshv_dev, O_RDWR | O_CLOEXEC);
>> +	if (rc < 0) {
>> +		mshv_partition_put(partition);
>> +		hlist_del(&mshv_dev->device_ptnode);
>> +		vfio_ops->device_release(mshv_dev);
>> +		goto out;
>> +	}
>> +
>> +	devargk.fd = rc;
>> +	rc = 0;
>> +
>> +	if (copy_to_user(uarg, &devargk, sizeof(devargk))) {
> 
> Shouldn't the partition be put here?

No. anon_inode_getfd was successful and so it installed the fd already..
As a result the cleanup will happen in the file op release.

Thanks,
-Mukesh

> Thanks,
> Stanislav
> 
>> +		rc = -EFAULT;
>> +		goto out;
>> +	}
>> +out:
>> +	return rc;
>> +}
>> +
>>   static long
>>   mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>>   {
>> @@ -1587,6 +1710,9 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>>   	case MSHV_ROOT_HVCALL:
>>   		ret = mshv_ioctl_passthru_hvcall(partition, true, uarg);
>>   		break;
>> +	case MSHV_CREATE_DEVICE:
>> +		ret = mshv_partition_ioctl_create_device(partition, uarg);
>> +		break;
>>   	default:
>>   		ret = -ENOTTY;
>>   	}
>> -- 
>> 2.51.2.vfs.0.1
>>


