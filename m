Return-Path: <linux-hyperv+bounces-3458-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC19EC088
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2024 01:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEC16933C
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2024 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC8EEBA;
	Wed, 11 Dec 2024 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnhmrLf1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E05672;
	Wed, 11 Dec 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876093; cv=none; b=YTxxnq+IsUL89ngaKKbfyD0eRrBdR1U+hrv+q3HKsrt9pW22lcf4jw+8jPr5hIYj+SKU3seTcDAffNB+QCmwJOZ0GNLZMXz8Fa2361UGyRUo4TGzetsuQUx8HEVW/lIIVccWtPBCGb5l66fK0ShbQQXC5oRrdRoDV2JZT4WW3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876093; c=relaxed/simple;
	bh=4h21K1y9Z9l7y0DPA+vc7kYzKHGGP3oOLcObWgo9tSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma3Qcz0snXawvI/BauW0oTonU5llebi/oecOXvTlZazpe3+JYkeyYP8bWwcY4OwiNS9ROnGjAFYr/EDqTO0AaxY97zalK6DXwOCkuyWe9JN99Z8cBccd/iyef7ePcw3+rtasXXc/4CTfSL3PKAkVp9C05FmikJF9d9+9qjPvQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnhmrLf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE48C4CED6;
	Wed, 11 Dec 2024 00:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733876092;
	bh=4h21K1y9Z9l7y0DPA+vc7kYzKHGGP3oOLcObWgo9tSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnhmrLf15OP0vZ1BBuWnEFix9/nwPCVQj2QH0MJkizJYjTdLhGkWrDzwtGD8M4G8y
	 IhYqcT/TxF8B9DRM05anOrP/fpsSD0eR0Dr4NXWmsGon5yxchG4nKuFFXk8yzi7j+p
	 qtCmLSt2QgZMjUXUpkp2LDK1xHWOKz3dXqphYwET8vAaC8XBBcB7koOCXONVvTEHSd
	 csvIicP5EjXog2YDrJJ33fbRQg6BThOf7cA8zJlGNVhnO5ykNd6g17+YLJmj4w2Umk
	 8KA7jc9OT1WSleYLJs76mqjS+085ISejXzc+5kXdTmDrryDX5EX6i3dfvqQ5EJcnI/
	 I4KfFG3dIW8Dg==
Date: Wed, 11 Dec 2024 00:14:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@hansenpartnership.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
Message-ID: <Z1jZengWxcjEPdJD@liuwe-devbox-debian-v2>
References: <20241003035333.49261-1-mhklinux@outlook.com>
 <SN6PR02MB415740B41A34B1468BC6AE28D43D2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415740B41A34B1468BC6AE28D43D2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Dec 10, 2024 at 07:58:34PM +0000, Michael Kelley wrote:
> From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Wednesday, October 2, 2024 8:53 PM
> > 
> > Code specific to Hyper-V guests currently assumes the cpu_possible_mask
> > is "dense" -- i.e., all bit positions 0 thru (nr_cpu_ids - 1) are set,
> > with no "holes". Therefore, num_possible_cpus() is assumed to be equal
> > to nr_cpu_ids.
> > 
> > Per a separate discussion[1], this assumption is not valid in the
> > general case. For example, the function setup_nr_cpu_ids() in
> > kernel/smp.c is coded to assume cpu_possible_mask may be sparse,
> > and other patches have been made in the past to correctly handle
> > the sparseness. See bc75e99983df1efd ("rcu: Correctly handle sparse
> > possible cpu") as noted by Mark Rutland.
> > 
> > The general case notwithstanding, the configurations that Hyper-V
> > provides to guest VMs on x86 and ARM64 hardware, in combination
> > with the algorithms currently used by architecture specific code
> > to assign Linux CPU numbers, *does* always produce a dense
> > cpu_possible_mask. So the invalid assumption is not currently
> > causing failures. But in the interest of correctness, and robustness
> > against future changes in the code that populates cpu_possible_mask,
> > update the Hyper-V code to no longer assume denseness.
> > 
> > The typical code pattern with the invalid assumption is as follows:
> > 
> > 	array = kcalloc(num_possible_cpus(), sizeof(<some struct>),
> > 			GFP_KERNEL);
> > 	....
> > 	index into "array" with smp_processor_id()
> > 
> > In such as case, the array might be indexed by a value beyond the size
> > of the array. The correct approach is to allocate the array with size
> > "nr_cpu_ids". While this will probably leave unused any array entries
> > corresponding to holes in cpu_possible_mask, the holes are assumed to
> > be minimal and hence the amount of memory wasted by unused entries is
> > minimal.
> > 
> > Removing the assumption in Hyper-V code is done in several patches
> > because they touch different kernel subsystems:
> > 
> > Patch 1: Hyper-V x86 initialization of hv_vp_assist_page (there's no
> > 	 hv_vp_assist_page on ARM64)
> > Patch 2: Hyper-V common init of hv_vp_index
> > Patch 3: Hyper-V IOMMU driver
> > Patch 4: storvsc driver
> > Patch 5: netvsc driver
> 
> Wei --
> 
> Could you pick up Patches 1, 2, and 3 in this series for the hyperv-next
> tree? Peter Zijlstra acked the full series [2], and Patches 4 and 5 have
> already been picked by the SCSI and net maintainers respectively [3][4].
> 
> Let me know if you have any concerns.

Michael, I will take a look later after I finish dealing with the
hyperv-fixes branch.

Thanks,
Wei.

> 
> Thanks,
> 
> Michael
> 
> [2] https://lore.kernel.org/linux-hyperv/20241004100742.GO18071@noisy.programming.kicks-ass.net/
> [3] https://lore.kernel.org/linux-hyperv/yq15xnsjlc1.fsf@ca-mkp.ca.oracle.com/
> [4] https://lore.kernel.org/linux-hyperv/172808404024.2772330.2975585273609596688.git-patchwork-notify@kernel.org/
> 
> > 
> > I tested the changes by hacking the construction of cpu_possible_mask
> > to include a hole on x86. With a configuration set to demonstrate the
> > problem, a Hyper-V guest kernel eventually crashes due to memory
> > corruption. After the patches in this series, the crash does not occur.
> > 
> > [1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com/
> > 
> > Michael Kelley (5):
> >   x86/hyperv: Don't assume cpu_possible_mask is dense
> >   Drivers: hv: Don't assume cpu_possible_mask is dense
> >   iommu/hyper-v: Don't assume cpu_possible_mask is dense
> >   scsi: storvsc: Don't assume cpu_possible_mask is dense
> >   hv_netvsc: Don't assume cpu_possible_mask is dense
> > 
> >  arch/x86/hyperv/hv_init.c       |  2 +-
> >  drivers/hv/hv_common.c          |  4 ++--
> >  drivers/iommu/hyperv-iommu.c    |  4 ++--
> >  drivers/net/hyperv/netvsc_drv.c |  2 +-
> >  drivers/scsi/storvsc_drv.c      | 13 ++++++-------
> >  5 files changed, 12 insertions(+), 13 deletions(-)
> > 
> > --
> > 2.25.1
> > 

