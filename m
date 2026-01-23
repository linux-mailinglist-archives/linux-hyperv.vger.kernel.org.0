Return-Path: <linux-hyperv+bounces-8489-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FP+C1e/c2mjyQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8489-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 19:35:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD6179B06
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 19:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA67E30060BB
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41606257821;
	Fri, 23 Jan 2026 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RYxGafD+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F661F419F;
	Fri, 23 Jan 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769193298; cv=none; b=s2vPDENpU+eTjTju3ViuXxJwml3iAF5G8tl/If7LmVdPEuJ4FRkdEGI+vVMXSbACRMB6efqRgrpVCTw+QE0VN7LaZYeDlMdSV1KXgyrISYJIhDxX5OZlf4BWQy1m/WeK7XznZBnfUzBNK4kkLMi6ZLaw0zzsiafliFUoCdU0RD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769193298; c=relaxed/simple;
	bh=1vf6ApjnXFWphP8qs0RYETw8WhE8iEAzB2IHUE9oLyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+ugpk1oLgNcbsBrjvCJ07r5iBCS0ncBew4VyMutGAxYDR2FHZMdeknYX+9wVxaG9jyuDcwGTxN+9x0HUq0YF5lbLGtJ+LUkZiQ4g2PZsjgdrmdikoVIwFx8hY67BoNkmMgc34i1yd7ppkjL7B3bXpNxyEQ0wp3YOdg0DtZtat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RYxGafD+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.200.94] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id CE85A20B7167;
	Fri, 23 Jan 2026 10:34:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE85A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769193296;
	bh=3hdmIxYEvy393OJEhZpeyS8R9/tUvwKfAIsrTGZ+fgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RYxGafD+N//x9h+RbgJDVqNNgqIqtnyCbyICtTmFNHcQeLe79Cu1b48eA40Us2V7s
	 Qg8vYoJ1Qv3JTQDAAfQcmrtEM4Zr+ZkAoijQ+bZbg7wY2aMOOXI7UqbaxUoZskzWTf
	 60KKQHCfCWbH8a+7s6iHbcsfuFcbvAPVCZ5rBdsI=
Message-ID: <152d9393-4af3-4c2f-a808-367ee7249d36@linux.microsoft.com>
Date: Fri, 23 Jan 2026 10:34:55 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 14/15] mshv: Remove mapping of mmio space during map
 user ioctl
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
 <20260120064230.3602565-15-mrathor@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20260120064230.3602565-15-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8489-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BD6179B06
X-Rspamd-Action: no action

On 1/19/2026 10:42 PM, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> VFIO no longer puts the mmio pfn in vma->vm_pgoff. So, remove code
> that is using it to map mmio space. It is broken and will cause
> panic.

What is the reason for having this as a separate commit from patch 15?
It seems like removing this code and adding the mmio intercept
handling could be done in one patch.

> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 27313419828d..03f3aa9f5541 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1258,16 +1258,8 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
>  }
>  
>  /*
> - * This maps two things: guest RAM and for pci passthru mmio space.
> - *
> - * mmio:
> - *  - vfio overloads vm_pgoff to store the mmio start pfn/spa.
> - *  - Two things need to happen for mapping mmio range:
> - *	1. mapped in the uaddr so VMM can access it.
> - *	2. mapped in the hwpt (gfn <-> mmio phys addr) so guest can access it.
> - *
> - *   This function takes care of the second. The first one is managed by vfio,
> - *   and hence is taken care of via vfio_pci_mmap_fault().
> + * This is called for both user ram and mmio space. The mmio space is not
> + * mapped here, but later during intercept.
>   */
>  static long
>  mshv_map_user_memory(struct mshv_partition *partition,
> @@ -1276,7 +1268,6 @@ mshv_map_user_memory(struct mshv_partition *partition,
>  	struct mshv_mem_region *region;
>  	struct vm_area_struct *vma;
>  	bool is_mmio;
> -	ulong mmio_pfn;
>  	long ret;
>  
>  	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
> @@ -1286,7 +1277,6 @@ mshv_map_user_memory(struct mshv_partition *partition,
>  	mmap_read_lock(current->mm);
>  	vma = vma_lookup(current->mm, mem.userspace_addr);
>  	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
> -	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
>  	mmap_read_unlock(current->mm);
>  
>  	if (!vma)
> @@ -1313,10 +1303,8 @@ mshv_map_user_memory(struct mshv_partition *partition,
>  					    HV_MAP_GPA_NO_ACCESS, NULL);
>  		break;
>  	case MSHV_REGION_TYPE_MMIO:
> -		ret = hv_call_map_mmio_pages(partition->pt_id,
> -					     region->start_gfn,
> -					     mmio_pfn,
> -					     region->nr_pages);
> +		/* mmio mappings are handled later during intercepts */
> +		ret = 0;
>  		break;
>  	}
>  


