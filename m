Return-Path: <linux-hyperv+bounces-11155-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPodC5OJD2qnNAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11155-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 00:39:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200C5AC69C
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 00:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C5D30470C1
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 22:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E15E344D8B;
	Thu, 21 May 2026 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PD3u1dpk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F82DEA61;
	Thu, 21 May 2026 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403041; cv=none; b=QNmYJ5lFuKogeQTi17DyJBG+qYyk0f9P2P37ECmQ6zY1v13ZurxCIbuSq1bMxJc/nAJQgKoo69PY3JKCGTQoln+ddLBc4F7bNeO9V+HiPmEpIhqi7tSQHkZ7Qi6JyXrVTNDi3XWc4tBUaBeF2vuAGj+pasuFNByZ1T196RM2E3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403041; c=relaxed/simple;
	bh=42MiyThkTo5Bk2bOjHIfMp4LvvutnSKogcul3+MwEo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnED0OWAzE+qdXiAZgbgBnUaFs0sMhun4C5YS/Qb+WxCQF+4QFyS3zTEWwyDjDBDW2CzdlnqbEAap7MGIMe8naWUkIcm9/BY188c6wUtkA7qEhe/cCx3gePvVTFgb9+pswQt6s27jZepqjfaDZ8vQ+1vAczp1uv3u9NLyh8cgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PD3u1dpk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.93.0.114] (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60B7820B7167;
	Thu, 21 May 2026 15:37:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60B7820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779403032;
	bh=K+q3TuQy9kAKm2lWuh8cfQdzIBvnZyK7nIwqQdQIsMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PD3u1dpkY8CuuTd9Hsz6xTzHS4vEragGZv8Ny3WotJz3kld05acbCO15RlLKZHNZO
	 JYvVs+aFpzC+4Ifsa0kvNkp1/a9fbvX3j0oZP1uGZgMTmGTWCvdjmeAJSkpBaJfmhN
	 jlvGcAwww/yFceJBsSgaOC5me+Tfkzx2rztrAOXg=
Message-ID: <58ca691b-0eff-6e4a-4b35-c96b9da59ac2@linux.microsoft.com>
Date: Thu, 21 May 2026 15:37:17 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V3 09/11] x86/hyperv: Implement Hyper-V virtual IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 jacob.pan@linux.microsoft.com
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-10-mrathor@linux.microsoft.com>
 <20260515182322.GI7702@ziepe.ca>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260515182322.GI7702@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11155-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 8200C5AC69C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 11:23, Jason Gunthorpe wrote:
> On Mon, May 11, 2026 at 07:02:57PM -0700, Mukesh R wrote:
>> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
>> +{
>> +	struct hv_domain *hvdom;
>> +	int rc;
>> +
>> +	if (hv_l1vh_partition() && !hv_curr_thread_is_vmm()) {
>> +		pr_err("Hyper-V: l1vh iommu does not support host devices\n");
>> +		return NULL;
>> +	}
>> +
>> +	hvdom = kzalloc(sizeof(struct hv_domain), GFP_KERNEL);
>> +	if (hvdom == NULL)
>> +		return NULL;
>> +
>> +	spin_lock_init(&hvdom->mappings_lock);
>> +	hvdom->mappings_tree = RB_ROOT_CACHED;
>> +
>> +	/* Called under iommu group mutex, so single threaded */
>> +	if (++unique_id == HV_DEVICE_DOMAIN_ID_S2_NULL)   /* ie, UINTMAX */
>> +		goto out_err;
>> +
>> +	hvdom->domid_num = unique_id;
>> +	hvdom->partid = hv_get_current_partid();
>> +	hvdom->iommu_dom.geometry = default_geometry;
>> +	hvdom->iommu_dom.pgsize_bitmap = HV_IOMMU_PGSIZES;
>> +
>> +	/* For guests, by default we do direct attaches, so no domain in hyp */
>> +	if (hv_dom_owner_is_vmm(hvdom) && !hv_no_attdev)
>> +		hvdom->attached_dom = true;
> 
> What are you thinking sending something like this?!?!?
> 
> The function is called *alloc domain PAGING*, it does not, and can not
> allocate weird "special" domains that are not PAGING domains. I just
> spent a long time removing all this kind of crazyness from drivers.
> 
> There is alot of other things I don't like in this patch, but this is
> too much.
> 
> You have to drop this "direct attach" idea from the first iteration,
> Linux can't do it without alot more work, you should start with the
> basic paging domain mode.
> 
> Jason

Yeah, agree. There was some ambivalence whether this could be a stop gap
solution until the iommufd based solution is fully designed.

I'll remove the "direct attach" stuff and resend with just basic paging
domain mode. Thanks for the review.

Thanks,
-Mukesh


