Return-Path: <linux-hyperv+bounces-2504-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078BE91BC25
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2024 12:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B485D281026
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2024 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64870154420;
	Fri, 28 Jun 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJsz0jr0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713091509B6;
	Fri, 28 Jun 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569089; cv=none; b=bl9RGBqLpHNFuJYcMneoqdc3/8pZScyJuXUdFwKpw+3yAlITiPpfhpZlp2066IaYuy4KKXL9hrjk4uzTYLSDya+5YGEvNpgfW5dkIge2rtZWegBoZBB+Ct46D6WB+kxeiAeAoOZrZdyayNWGWc6jKAP2e6vxRMNnmVWmGDWLB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569089; c=relaxed/simple;
	bh=27RE7aMAeMSuXKrXKtMiDDZRYnA99jnOQEs5p75D+vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJm2xzgbk3zN1HI9kJJghnPUTDeDDm2yMDPJ2FHwWy4XTZQNsOXym1sym1vTkLe/Lsc6otB6J5MtP6p33VFVEsBpBy9PyHVUJG1BLTjkFALXKraZgS8coj6Scsid/PeCSZb3NZ1aehXV/v2oKVTeUdvtK9EQ4Ye6DwwvZff1q2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJsz0jr0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719569088; x=1751105088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=27RE7aMAeMSuXKrXKtMiDDZRYnA99jnOQEs5p75D+vQ=;
  b=AJsz0jr0bpFxl+QCT2gblBayhRwEtv9RfyrDYyAHNir2HgMApjaz0hdQ
   XuuDdkmTETWva4wM1ajfm0lrB3+mx6fiheP0V4nDprHXVH3JnmW3Pgds7
   XPgLjH4DHtGafvTe0fapYRzznf50/7pJ4uAyBgHi4J5z9d8tkw7pihLgq
   euODGkDVf3f/HefV8Uv30mdHpY4si8sM8rgpsmSchhREg1j8vLeoqI8oa
   iTmD/XD6P+1V+FuprYUTJQ0ZbCFVT531FPjkrAA7AN+vdU8kfsu2qMV+i
   JpwPmA12al1DnsWSRsVS0DgV5ypF6Q51ntvVWGP1PyFpPqYpHldu2uiWi
   w==;
X-CSE-ConnectionGUID: jxq2vWX0S36zn5L9Ql1KsA==
X-CSE-MsgGUID: gAbxT1ZsTACYYnFroCVe7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="34282929"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="34282929"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 03:04:47 -0700
X-CSE-ConnectionGUID: Kil1170XTI+k0keiXikvKA==
X-CSE-MsgGUID: /CtWA+6ATAqABZBcEzIDUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="75890944"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 28 Jun 2024 03:04:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 91FCB1C7; Fri, 28 Jun 2024 13:04:38 +0300 (EEST)
Date: Fri, 28 Jun 2024 13:04:38 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, ak@linux.intel.com, 
	arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com, dan.j.williams@intel.com, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, haiyangz@microsoft.com, 
	hpa@zytor.com, jane.chu@oracle.com, kys@microsoft.com, luto@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com, 
	wei.liu@kernel.org, Jason@zx2c4.com, nik.borisov@suse.com, mhklinux@outlook.com, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com, 
	rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com, vkuznets@redhat.com, 
	xiaoyao.li@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Message-ID: <kjt2m2aqnhmwqgn3ox6bkqtn5qurxawgnx3xyh42pu5sp3mwyj@qwyjttwubfck>
References: <20240521021238.1803-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521021238.1803-1-decui@microsoft.com>

On Mon, May 20, 2024 at 07:12:38PM -0700, Dexuan Cui wrote:
> @@ -785,15 +799,22 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
>   */
>  static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  {
> -	phys_addr_t start = __pa(vaddr);
> -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> +	unsigned long start = vaddr;
> +	unsigned long end = start + numpages * PAGE_SIZE;
> +	unsigned long step = end - start;
> +	unsigned long addr;
>  
> -	if (!tdx_map_gpa(start, end, enc))
> -		return false;
> +	/* Step through page-by-page for vmalloc() mappings */
> +	if (is_vmalloc_addr((void *)vaddr))
> +		step = PAGE_SIZE;
>  
> -	/* shared->private conversion requires memory to be accepted before use */
> -	if (enc)
> -		return tdx_accept_memory(start, end);
> +	for (addr = start; addr < end; addr += step) {
> +		phys_addr_t start_pa = slow_virt_to_phys((void *)addr);
> +		phys_addr_t end_pa   = start_pa + step;
> +
> +		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
> +			return false;
> +	}
>  
>  	return true;
>  }

This patch collied with kexec changes. tdx_kexec_finish() calls
tdx_enc_status_changed() after clearing pte, so slow_virt_to_phys()
crashes on in.

Daxuan, could you check if the fixup below works for you on vmalloc
addresses?

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index ef8ec2425998..5e455c883bcc 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -813,8 +813,15 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 		step = PAGE_SIZE;
 
 	for (addr = start; addr < end; addr += step) {
-		phys_addr_t start_pa = slow_virt_to_phys((void *)addr);
-		phys_addr_t end_pa   = start_pa + step;
+		phys_addr_t start_pa;
+		phys_addr_t end_pa;
+
+		if (virt_addr_valid(addr))
+			start_pa = __pa(addr);
+		else
+			start_pa = slow_virt_to_phys((void *)addr);
+
+		end_pa = start_pa + step;
 
 		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
 			return false;
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

