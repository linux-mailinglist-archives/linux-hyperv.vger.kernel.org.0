Return-Path: <linux-hyperv+bounces-8062-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B019CCD9F5C
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 17:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23B6E3003F64
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19022227BA4;
	Tue, 23 Dec 2025 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C2xamyxd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7012222A9;
	Tue, 23 Dec 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507195; cv=none; b=Tb00WU6BwrCNbmrWb4AQT2ltPbS0ne/ixRsjClKeAwJujTqtR7dOjgmky8chcZtJsIa/Sf1kemxGtTxw+rr52jf/7xj5fJI0Na5tE9gSFG5qcNHW+G0tQRyNbuwBnMrMC82zsQrHpv+Kl7Tud0ty71bvwGJYaVMT2RlSdALWilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507195; c=relaxed/simple;
	bh=60t4qcg/XcrbQZgdQOhSg5fo0yPJLBCBNc8vtQLa15k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw2FBp/7MYkVpIhMG36++SGZxpkp00K3pTk/anZB8rp7ifZMiUM22bx/5+2LTcX2/gv/S7qlejYj1zl/OQbQA5YrBc0lwoAiVUfHuUzrE9kE8D5UrpVzpxzU2YLBHkfacINljJY9iuKy8xI3TL77F5qtMyrhpCcPy8UBIvZgeCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C2xamyxd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E4F1211E70F;
	Tue, 23 Dec 2025 08:26:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E4F1211E70F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1766507185;
	bh=bQC4PSb6FCv6sbOjoHGNQH/GzUFVYyxZFJe+w7qDPF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2xamyxdanaEpur0kRaEHwfkkfKwmTyIqU1JgZPnIAHqkdWC7TKAG7O7wMBJc5ijM
	 5WYD1S+JCOyWMjDHIYkJ1cXvcQpwAmxy9xfHrVV58jBnNWebtd5WTX2kcOytnTn5QS
	 8/9BPsAJlpmo6+FjwaP6LiKqPmUTxXtU9Cgz+OTA=
Date: Tue, 23 Dec 2025 08:26:23 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mshv: Align huge page stride with guest mapping
Message-ID: <aUrCr5wBSTrGm-IM@skinsburskii.localdomain>
References: <176593206931.276257.13023250440372517478.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157AAFDD8BD5BDCD2D3DB99D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157AAFDD8BD5BDCD2D3DB99D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Dec 23, 2025 at 03:51:22PM +0000, Michael Kelley wrote:
> From: Michael Kelley Sent: Monday, December 22, 2025 10:25 AM
> > 
> [snip]
> > 
> > Separately, in looking at this, I spotted another potential problem with
> > 2 Meg mappings that somewhat depends on hypervisor behavior that I'm
> > not clear on. To create a new region, the user space VMM issues the
> > MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace address, the
> > size, and the guest PFN. The only requirement on these values is that the
> > userspace address and size be page aligned. But suppose a 4 Meg region is
> > specified where the userspace address and the guest PFN have different
> > offsets modulo 2 Meg. The userspace address range gets populated first,
> > and may contain a 2 Meg large page. Then when mshv_chunk_stride()
> > detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES can be told
> > to create a 2 Meg mapping for the guest, the corresponding system PFN in
> > the page array may not be 2 Meg aligned. What does the hypervisor do in
> > this case? It can't create a 2 Meg mapping, right? So does it silently fallback
> > to creating 4K mappings, or does it return an error? Returning an error would
> > seem to be problematic for movable pages because the error wouldn't
> > occur until the guest VM is running and takes a range fault on the region.
> > Silently falling back to creating 4K mappings has performance implications,
> > though I guess it would work. My question is whether the
> > MSHV_GET_GUEST_MEMORY ioctl should detect this case and return an
> > error immediately.
> > 
> 
> In thinking about this more, I can answer my own question about the
> hypervisor behavior. When HVCALL_MAP_GPA_PAGES is set, the full
> list of 4K system PFNs is not provided as an input to the hypercall, so
> the hypervisor cannot silently fall back to 4K mappings. Assuming
> sequential PFNs would be wrong, so it must return an error if the
> alignment of a system PFN isn't on a 2 Meg boundary.
> 
> For a pinned region, this error happens in mshv_region_map() as
> called from  mshv_prepare_pinned_region(), so will propagate back
> to the ioctl. But the error happens only if pin_user_pages_fast()
> allocates one or more 2 Meg pages. So creating a pinned region
> where the guest PFN and userspace address have different offsets
> modulo 2 Meg might or might not succeed.
> 
> For a movable region, the error probably can't occur.
> mshv_region_handle_gfn_fault() builds an aligned 2 Meg chunk
> around the faulting guest PFN. mshv_region_range_fault() then
> determines the corresponding userspace addr, which won't be on
> a 2 Meg boundary, so the allocated memory won't contain a 2 Meg
> page. With no 2 Meg pages, mshv_region_remap_pages() will
> always do 4K mappings and will succeed. The downside is that a
> movable region with a guest PFN and userspace address with
> different offsets never gets any 2 Meg pages or mappings.
> 
> My conclusion is the same -- such misalignment should not be
> allowed when creating a region that has the potential to use 2 Meg
> pages. Regions less than 2 Meg in size could be excluded from such
> a requirement if there is benefit in doing so. It's possible to have
> regions up to (but not including) 4 Meg where the alignment prevents
> having a 2 Meg page, and those could also be excluded from the
> requirement.
> 

I'm not sure I understand the problem.  
There are three cases to consider:  
1. Guest mapping, where page sizes are controlled by the guest.  
2. Host mapping, where page sizes are controlled by the host.  
3. Hypervisor mapping, where page sizes are controlled by the hypervisor.  

The first case is not relevant here and is included for completeness.  

The second and third cases (host and hypervisor) share the memory layout, but it is up to each entity to decide which page sizes to use. For example, the host might map the proposed 4M region with only 4K pages, even if a 2M page is available in the middle. In this case, the host will map the memory as represented by 4K pages, but the hypervisor can still discover the 2M page in the middle and adjust its page tables to use a 2M page.  

This adjustment happens at runtime. Could this be the missing detail here?  

Thanks,  
Stanislav  

> Michael

