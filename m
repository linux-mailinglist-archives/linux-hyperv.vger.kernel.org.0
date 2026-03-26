Return-Path: <linux-hyperv+bounces-9802-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML9kELRqxWl1+AQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9802-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 18:19:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B7A339107
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 18:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94CC33014F53
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85A941C309;
	Thu, 26 Mar 2026 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QQa0oJUj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E5E3FB7C9;
	Thu, 26 Mar 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544719; cv=none; b=erg3k28l4i0aHXxUm6YQFhxfZsXC0r+uJO8wzlZRHm6IMQp8MFMwiXLZoVyUvFy8n65GB9uJHcdxGSvkoSX9SpyuPx3tjgwx65nE8qmplRmp0UanbvUsQbrTDu9A+XFSz5UvwtDYna9HT6wlFG9WPjPDOqRZjYPcqP/XjWo0BMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544719; c=relaxed/simple;
	bh=4Wu0UTzcOhkVnGPF19/hXiwpzCTdBwtuQrSychL2L3E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XuLNSapx3acc4sr3OtwufnpXv4kVRAFn2/ssNXeDg5vusKmD0eODcwXM+evHSDMqalytLNXJ6JK2ae3wYV9siSAtg5xEuZ/DN/hqaY2uGf8eUk/smOAnGNdHrmmdGWRnwkDXJL8OhF9NNCqNp3A7NDQC9UVmM1jK2RKQYUMs0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QQa0oJUj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.145.29] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id A64E220B710C;
	Thu, 26 Mar 2026 10:05:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A64E220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774544716;
	bh=rbwZ4OO0LsW1b8RWLG2CAH5pF9lzjnZ9lfP+6EK7t1k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QQa0oJUjjaHP32/aBFhPIPDpHZUup4Od8GSDvR1BVN3D4eWzkg03vaIXDEg8JhiMW
	 deCvh8frz57RAvkZDkZImBqUVIsflI7kFA3VvB7UDjB9spLSpJ6jPdgxMBnWCIlDHm
	 FzEO5GDRMJrhmZEkOtbzWM7MzCkN+OLafBqtyGvU=
Message-ID: <75c6dd78-bbae-4f5a-94ef-9de299720d38@linux.microsoft.com>
Date: Thu, 26 Mar 2026 10:05:06 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, m.szyprowski@samsung.com,
 robin.murphy@arm.com, easwar.hariharan@linux.microsoft.com,
 Tianyu Lan <tiala@microsoft.com>, iommu@lists.linux.dev,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 hch@infradead.org, vdso@hexbites.dev, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH V3] x86/VMBus: Confidential VMBus for dynamic DMA
 transfers
To: Tianyu Lan <ltykernel@gmail.com>
References: <20260325075649.248241-1-tiala@microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260325075649.248241-1-tiala@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9802-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,samsung.com,arm.com,linux.microsoft.com,lists.linux.dev,vger.kernel.org,infradead.org,hexbites.dev,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[easwar.hariharan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,openvmm.dev:url,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 37B7A339107
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/2026 12:56 AM, Tianyu Lan wrote:
> Hyper-V provides Confidential VMBus to communicate between
> device model and device guest driver via encrypted/private
> memory in Confidential VM. The device model is in OpenHCL
> (https://openvmm.dev/guide/user_guide/openhcl.html) that
> plays the paravisor role.
> 
> For a VMBus device, there are two communication methods to
> talk with Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic
> DMA transfer.
> 
> The Confidential VMBus Ring buffer has been upstreamed by
> Roman Kisel(commit 6802d8af47d1).
> 
> The dynamic DMA transition of VMBus device normally goes
> through DMA core and it uses SWIOTLB as bounce buffer in
> a CoCo VM.
> 
> The Confidential VMBus device can do DMA directly to
> private/encrypted memory. Because the swiotlb is decrypted
> memory, the DMA transfer must not be bounced through the
> swiotlb, so as to preserve confidentiality. This is different
> from the default for Linux CoCo VMs, so disable the VMBus
> device's use of swiotlb.
> 
> Expose swiotlb_dev_disable() from DMA Core to disable
> bounce buffer for device.
> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c  | 6 +++++-
>  include/linux/swiotlb.h | 5 +++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 3d1a58b667db..84e6971fc90f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2184,11 +2184,15 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>  	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
>  	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
>  
> +	device_initialize(&child_device_obj->device);
> +	if (child_device_obj->channel->co_external_memory)
> +		swiotlb_dev_disable(&child_device_obj->device);
> +
>  	/*
>  	 * Register with the LDM. This will kick off the driver/device
>  	 * binding...which will eventually call vmbus_match() and vmbus_probe()
>  	 */
> -	ret = device_register(&child_device_obj->device);
> +	ret = device_add(&child_device_obj->device);
>  	if (ret) {
>  		pr_err("Unable to register child device\n");
>  		put_device(&child_device_obj->device);
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..7c572570d5d9 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -169,6 +169,11 @@ static inline struct io_tlb_pool *swiotlb_find_pool(struct device *dev,
>  	return NULL;
>  }
>  
> +static inline bool swiotlb_dev_disable(struct device *dev)
> +{
> +	return dev->dma_io_tlb_mem == NULL;

Is there an extra = here?

- Easwar (he/him)

