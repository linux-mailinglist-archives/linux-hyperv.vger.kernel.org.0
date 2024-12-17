Return-Path: <linux-hyperv+bounces-3490-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F96D9F56CB
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194DE1887D87
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAF11F8EED;
	Tue, 17 Dec 2024 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/6gh/H7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E11F76C7;
	Tue, 17 Dec 2024 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463318; cv=none; b=Glr84PMOmwDhXMq5eOpKUykwdCmpB/0iLavMdY5m0VFChsEykwm8OQnUhTlKDbJYZkrEP3uBlPmb1bgrBWKCstWtlgOaFYwfAw/xd9TJh29TEdXnGghLnRQsoL475Gjav6ojEyymtAfvuoMQ6uVCPMsmRLMo/22/lYdMk8nZVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463318; c=relaxed/simple;
	bh=GaDNdtEf3V/Quwv0a67s1DQ1eOlCYVx+3g5YUMb9+NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0RPtItjNRee2+DJQa/OMJVD4j76egADwEulRV9nrZeWQbjcl407xdGcsytUK0Ibc1lIUp5IZ44tbYZvP2cZL1zjmDP91oUpjIYLjrotu5EjPo81X2yOWMcD7W5lO/F4TyVbUo7Y/F5ii+XCptxO1VKYhM73Tpiv0+OltCdeBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/6gh/H7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FFCC4CED3;
	Tue, 17 Dec 2024 19:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734463318;
	bh=GaDNdtEf3V/Quwv0a67s1DQ1eOlCYVx+3g5YUMb9+NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/6gh/H740JjP2fCj6AY92fq9iWZYl+3YHoh0l6lgpD+VHEw90lkSLzwO9c9ray9L
	 GA6vIQBoOLmzQU8Rc9rgPiq3MA1YKPT9FNNSUwqosbdhHOzQeyH8uoMqDRbDMvgCDx
	 fEzzK0QAXEFyFRgMmAWjfvskwFlNwh3h7/7PElSx9TW3bOy8oozHY9x5UZn1AOm1u0
	 RalCohXUzgrHvTUYF995BIwI1PqgQGmp1bHSo++YQK3Le9ifBthINWeGUu2Je7zLA5
	 kt5Iy5sMgsFBoeOJpXs64PgyyXvme50EGSY+DYXJZ0cJmUQceYi6zT5oUbzFFC+eyL
	 B3G02MXn7+7vw==
Date: Tue, 17 Dec 2024 19:21:56 +0000
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
Message-ID: <Z2HPVCCfznUeMXh3@liuwe-devbox-debian-v2>
References: <20241003035333.49261-1-mhklinux@outlook.com>
 <SN6PR02MB415740B41A34B1468BC6AE28D43D2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z1jZengWxcjEPdJD@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1jZengWxcjEPdJD@liuwe-devbox-debian-v2>

On Wed, Dec 11, 2024 at 12:14:50AM +0000, Wei Liu wrote:
> On Tue, Dec 10, 2024 at 07:58:34PM +0000, Michael Kelley wrote:
> > From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Wednesday, October 2, 2024 8:53 PM
> > > 
> > > Code specific to Hyper-V guests currently assumes the cpu_possible_mask
> > > is "dense" -- i.e., all bit positions 0 thru (nr_cpu_ids - 1) are set,
> > > with no "holes". Therefore, num_possible_cpus() is assumed to be equal
> > > to nr_cpu_ids.
> > > 
> > > Per a separate discussion[1], this assumption is not valid in the
> > > general case. For example, the function setup_nr_cpu_ids() in
> > > kernel/smp.c is coded to assume cpu_possible_mask may be sparse,
> > > and other patches have been made in the past to correctly handle
> > > the sparseness. See bc75e99983df1efd ("rcu: Correctly handle sparse
> > > possible cpu") as noted by Mark Rutland.
> > > 
> > > The general case notwithstanding, the configurations that Hyper-V
> > > provides to guest VMs on x86 and ARM64 hardware, in combination
> > > with the algorithms currently used by architecture specific code
> > > to assign Linux CPU numbers, *does* always produce a dense
> > > cpu_possible_mask. So the invalid assumption is not currently
> > > causing failures. But in the interest of correctness, and robustness
> > > against future changes in the code that populates cpu_possible_mask,
> > > update the Hyper-V code to no longer assume denseness.
> > > 
> > > The typical code pattern with the invalid assumption is as follows:
> > > 
> > > 	array = kcalloc(num_possible_cpus(), sizeof(<some struct>),
> > > 			GFP_KERNEL);
> > > 	....
> > > 	index into "array" with smp_processor_id()
> > > 
> > > In such as case, the array might be indexed by a value beyond the size
> > > of the array. The correct approach is to allocate the array with size
> > > "nr_cpu_ids". While this will probably leave unused any array entries
> > > corresponding to holes in cpu_possible_mask, the holes are assumed to
> > > be minimal and hence the amount of memory wasted by unused entries is
> > > minimal.
> > > 
> > > Removing the assumption in Hyper-V code is done in several patches
> > > because they touch different kernel subsystems:
> > > 
> > > Patch 1: Hyper-V x86 initialization of hv_vp_assist_page (there's no
> > > 	 hv_vp_assist_page on ARM64)
> > > Patch 2: Hyper-V common init of hv_vp_index
> > > Patch 3: Hyper-V IOMMU driver
> > > Patch 4: storvsc driver
> > > Patch 5: netvsc driver
> > 
> > Wei --
> > 
> > Could you pick up Patches 1, 2, and 3 in this series for the hyperv-next
> > tree? Peter Zijlstra acked the full series [2], and Patches 4 and 5 have
> > already been picked by the SCSI and net maintainers respectively [3][4].
> > 
> > Let me know if you have any concerns.
> 
> Michael, I will take a look later after I finish dealing with the
> hyperv-fixes branch.

Patch 1 to 3 have been applied to the hyperv-next branch.

Wei.

