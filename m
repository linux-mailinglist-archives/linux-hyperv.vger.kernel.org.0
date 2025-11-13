Return-Path: <linux-hyperv+bounces-7556-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CABC59D28
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 20:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48913A4273
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F38313296;
	Thu, 13 Nov 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYlgg2Nq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0835CBBB;
	Thu, 13 Nov 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063073; cv=none; b=PafAeSYbfpVgBlXgLgE/BKzl06+2/y0l7jou0A2gdChqXNFtCGzczahydm1M0sQgmJPEYAWtFkNVAG3hwhOyUTj1jobnFrqYJdJfxlnBUfMWHGqYSc0ZQaPp7LaOMSLFqZxhZiUJv3Bd0GSJfNGAiKb4x0M49z3+emjs5R5+5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063073; c=relaxed/simple;
	bh=r20d3JnAnYzQMrhHjunqulaTsHwq7PfKFLbcJmhQVF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce8Nc/BP9y3D4gxWJe046I+WvdAMZemDQ5EPwKGyIb4ciYSmEGsUz+pzmv4x0tyjZH83KAaywb+ssCn+qQqaRVk/k60BFgqwWEZ9CGrQ/0gxDKdlzKvhd+wGg2JVBVBJz726CEAaV37U0ku4NiOgX6wzJugq2P8lvRh+3uhlhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYlgg2Nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7556C4CEF5;
	Thu, 13 Nov 2025 19:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063072;
	bh=r20d3JnAnYzQMrhHjunqulaTsHwq7PfKFLbcJmhQVF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYlgg2Nq0ALapV2V2ASqmwgDvkaXT4OjNarw239vYNanz90diKEVm7e7lPOKExMWf
	 tMslIAt1j1KKOpdiiAvveSbSeNk6cAZNvnx34YRrsZ6B31TwUSOw/ul/xYGLIXdGft
	 9GH+7QaiTfrAMcCFRiNm0FaLmf6To767K4BAcvdBf+lGrpKJbQciOeN6CJ/oGgPqyK
	 Ude2mBg7i5QygQOpHhAY8av+5pEP2B/xJQPFXeiHVShc5Zfh9j2ryU4d3MA2pxwBZi
	 wMxJhKYOC/NS1wokMSOdQrC8fOTsQYKCLAMCluw2wQ7E+vF9ydaUNr6WVsmVqSRzvY
	 BadZaFTRV0JxA==
Date: Thu, 13 Nov 2025 19:44:31 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"muislam@microsoft.com" <muislam@microsoft.com>,
	"anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
	Jinank Jain <jinankjain@microsoft.com>
Subject: Re: [PATCH v4] mshv: Extend create partition ioctl to support cpu
 features
Message-ID: <20251113194431.GB1175882@liuwe-devbox-debian-v2.local>
References: <1762903194-25195-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB415718EF45BF1B79F2C15F20D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20251113184756.GA1175882@liuwe-devbox-debian-v2.local>
 <b3a05360-0c55-4ec1-81c2-aa093ff78333@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3a05360-0c55-4ec1-81c2-aa093ff78333@linux.microsoft.com>

On Thu, Nov 13, 2025 at 11:11:57AM -0800, Nuno Das Neves wrote:
> On 11/13/2025 10:47 AM, Wei Liu wrote:
> > On Wed, Nov 12, 2025 at 04:27:05PM +0000, Michael Kelley wrote:
> >> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, November 11, 2025 3:20 PM
> >>>
> >>> The existing mshv create partition ioctl does not provide a way to
> >>> specify which cpu features are enabled in the guest. Instead, it
> >>> attempts to enable all features and those that are not supported are
> >>> silently disabled by the hypervisor.
> >>>
> >>> This was done to reduce unnecessary complexity and is sufficient for
> >>> many cases. However, new scenarios require fine-grained control over
> >>> these features.
> >>>
> >>> Define a new mshv_create_partition_v2 structure which supports
> >>> passing the disabled processor and xsave feature bits through to the
> >>> create partition hypercall directly.
> >>>
> >>> Introduce a new flag MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables
> >>> the new structure. If unset, the original mshv_create_partition struct
> >>> is used, with the old behavior of enabling all features.
> >>>
> >>> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> >>> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> >>> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> >>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >>> ---
> >>> Changes in v4:
> >>> - Change BIT() to BIT_ULL() [Michael Kelley]
> >>> - Enforce pt_num_cpu_fbanks == MSHV_NUM_CPU_FEATURES_BANKS and expect
> >>>   that number to never change. In future, additional processor banks
> >>>   will be settable as 'early' partition properties. Remove redundant
> >>>   code that set default values for unspecified banks [Michael Kelley]
> >>> - Set xsave features to 0 on arm64 [Michael Kelley]
> >>> - Add clarifying comments in a few places
> >>>
> >>> Changes in v3:
> >>> - Remove the new cpu features definitions in hvhdk.h, and retain the
> >>>   old behavior of enabling all features for the old struct. For the v2
> >>>   struct, still disable unspecified feature banks, since that makes it
> >>>   robust to future extensions.
> >>> - Amend comments and commit message to reflect the above
> >>> - Fix unused variable on arm64 [kernel test robot]
> >>>
> >>> Changes in v2:
> >>> - Fix exposure of CONFIG_X86_64 to uapi [kernel test robot]
> >>> - Fix compilation issue on arm64 [kernel test robot]
> >>> ---
> >>>  drivers/hv/mshv_root_main.c | 113 +++++++++++++++++++++++++++++-------
> >>>  include/uapi/linux/mshv.h   |  34 +++++++++++
> >>>  2 files changed, 126 insertions(+), 21 deletions(-)
> >>>
> >>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> >>> index d542a0143bb8..9f9438289b60 100644
> >>> --- a/drivers/hv/mshv_root_main.c
> >>> +++ b/drivers/hv/mshv_root_main.c
> >>> @@ -1900,43 +1900,114 @@ add_partition(struct mshv_partition *partition)
> >>>  	return 0;
> >>>  }
> >>>
> >>> -static long
> >>> -mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
> >>> +static_assert(MSHV_NUM_CPU_FEATURES_BANKS ==
> >>> +	      HV_PARTITION_PROCESSOR_FEATURES_BANKS);
> >>> +
> >>> +static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
> >>> +					struct hv_partition_creation_properties *cr_props,
> >>> +					union hv_partition_isolation_properties *isol_props)
> >>>  {
> >>> -	struct mshv_create_partition args;
> >>> -	u64 creation_flags;
> >>> -	struct hv_partition_creation_properties creation_properties = {};
> >>> -	union hv_partition_isolation_properties isolation_properties = {};
> >>> -	struct mshv_partition *partition;
> >>> -	struct file *file;
> >>> -	int fd;
> >>> -	long ret;
> >>> +	int i;
> >>> +	struct mshv_create_partition_v2 args;
> >>> +	union hv_partition_processor_features *disabled_procs;
> >>> +	union hv_partition_processor_xsave_features *disabled_xsave;
> >>>
> >>> -	if (copy_from_user(&args, user_arg, sizeof(args)))
> >>> +	/* First, copy v1 struct in case user is on previous versions */
> >>> +	if (copy_from_user(&args, user_arg,
> >>> +			   sizeof(struct mshv_create_partition)))
> >>>  		return -EFAULT;
> >>>
> >>>  	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
> >>>  	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
> >>>  		return -EINVAL;
> >>>
> >>> +	disabled_procs = &cr_props->disabled_processor_features;
> >>> +	disabled_xsave = &cr_props->disabled_processor_xsave_features;
> >>> +
> >>> +	/* Check if user provided newer struct with feature fields */
> >>> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
> >>> +		if (copy_from_user(&args, user_arg, sizeof(args)))
> >>> +			return -EFAULT;
> >>
> >> There's subtle issue here that I didn't notice previously. This second copy_from_user()
> >> re-populates the first two fields of the "args" local variable. These two fields were
> >> validated by code a few lines above. But there's no guarantee that a second read of
> >> user space will get the same values. User space could have another thread that
> >> changes the user space values between the two copy_from_user() calls, and thereby
> >> sneak in some bogus values to be used further down in this function. Because of
> >> this risk, there's a general rule for kernel code, which is to avoid multiple accesses to
> >> the same user space values. There are places in the kernel where such double reads
> >> would be an exploitable security hole.
> >>
> 
> Good catch Michael! It's something I had read about once before long ago but had forgotten.
> I wonder if there's some kind of automation that could warn about potential issues - i.e.
> copy_from_user() on the same pointer twice.
> 
> >> The fix would be to validate the pt_flags and pt_isolation fields again, or to have the
> >> second copy_from_user copy only the additional fields. But it's also the case that the
> >> way the pt_flags and pt_isolation fields are used further down in this function,
> >> nothing bad can happen if malicious user space should succeed in sneaking in some
> >> bogus values.
> >>
> >> Net, as currently coded, there's nothing that needs to be fixed. It would be more
> >> robust to do one of the two fixes, if for no other reason than to acknowledge
> >> awareness of the risk of reading user space twice. But I'm not going to insist
> >> on a respin.
> > 
> > Nuno, I can commit this patch first. If you can post a diff later I can
> > squash it in.
> 
> It might be easier if I just spin a v5 today? I'll send it soon.

Yes, please resend. Thanks.

Wei

