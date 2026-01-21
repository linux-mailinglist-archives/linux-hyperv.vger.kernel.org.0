Return-Path: <linux-hyperv+bounces-8398-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJFZISUvcGkEXAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8398-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 02:43:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A114F444
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 02:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 223C0A8F225
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 01:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E130FF2A;
	Wed, 21 Jan 2026 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qmKw9cIn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A557311948;
	Wed, 21 Jan 2026 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959708; cv=none; b=eDBEFuzDY4iVe5Zs52yqv2jOU5ECjTzKi1J3qCBF8sUEfFjPCLNAwjq4PUQA4EDciBr6RRUMmHiQuKf4h0q7HSkKdh41WQzA2RPIwFDaGu/8XDdVxKPtinawB56bUSaI2p8bj6K9A8dLUiY/0JISgR1R24iGLtdQw4v4NHaJ/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959708; c=relaxed/simple;
	bh=qiw4+99EuAh7iKvvu6kBfdCS5m7pQz8ze71GSKIYow4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9nN3pAWbRUYSRukgdAOPid2b/so81yZNmJQGW1KTz1WxDqWhh/t4dcSMty3XSWYc5xp3t4+JdG+po/snvGt7V8vAFgsEomiufBaPgghLzTvBWEWRYJXpGdCkCoPYJxPs4TgcBcgzlH/Ult0y48q0/o4EhPsfTnK8V45tSDXKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qmKw9cIn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id B79F720B7167;
	Tue, 20 Jan 2026 17:41:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B79F720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768959701;
	bh=h1u27U5gS1The7w0JK5akAoj89QIuvkN4z0DjyBy/sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmKw9cInop9AHynO7hKDyhQLPFrZG1RLwzltG8pbrdak41axSEVaOiokn7fk5SsOu
	 3RZvI2gw1GArtNU2eD6flAKsm1NhYK5XDP2DHHgVW9Cx4hE3ulFRPSXxZZtRNpAobi
	 VyAzaz36TcJLoV8iRJQXalUBnjTSC+vZUxeDjGHY=
Date: Tue, 20 Jan 2026 17:41:39 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: Re: [PATCH v0 14/15] mshv: Remove mapping of mmio space during map
 user ioctl
Message-ID: <aXAu02NbucdEn-Ky@skinsburskii.localdomain>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-15-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-15-mrathor@linux.microsoft.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-8398-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: E7A114F444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 10:42:29PM -0800, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> VFIO no longer puts the mmio pfn in vma->vm_pgoff. So, remove code
> that is using it to map mmio space. It is broken and will cause
> panic.
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

No need updating ret here: it's 0 after the previous call.

Thanks,
Stanislav

>  		break;
>  	}
>  
> -- 
> 2.51.2.vfs.0.1
> 

