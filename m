Return-Path: <linux-hyperv+bounces-3635-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB8A06DB6
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 06:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8467D188574D
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 05:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043911474A9;
	Thu,  9 Jan 2025 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq/jjLsQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66811369A8;
	Thu,  9 Jan 2025 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736401856; cv=none; b=DiVv85E8ux5fDpyOARdKPWRpRK1arY0sz4tW+XTM0On8gslw6p5FsBsWWjjhx2q/knPYS/s8Fw+TNj+BWJXTULP2jobQNKfbYFuETe9cTVus8j2ugAOhDp/w4bcSClksQ8DUPl4KP4hcoZHbo/D1ffyHaY1UbK9ZnA6cVntsi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736401856; c=relaxed/simple;
	bh=2xbFG61v1nRkE/jCcfoxwKC63jL9YosxJeNM2E8Mk+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPJn6NIrHbI1A701/RfWZWvyZGmlLW4zmZrrZMX9TNUNEYS9xaocOp59gBnY4ECxUAyp9H43E9LGS25o3Qpt/yvHiEmpJuYqGkSXKcmb/8lD6iiaEdyTHCWealzCow1of9L1M0k0D5+0S6RKKzRM2CIZGgJomMZgMeJlfIhFcu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq/jjLsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAE0C4CED2;
	Thu,  9 Jan 2025 05:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736401856;
	bh=2xbFG61v1nRkE/jCcfoxwKC63jL9YosxJeNM2E8Mk+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jq/jjLsQBeoq8cwYbdXe3D6SvEC4G0tpbCGdIzhTyKjvsJsd6QVVVmlIpxdtpnAlX
	 QkQInyIe0ksv8JE7NSMBvn9LoaUGe4sv1p2Bn5OMshvDkY23Qb5GzYtGJHN3jQMcQn
	 ZFMrFSJSWpG3Y+Lxy/CBnyHkoVf4rV3WIponEtyrqZ0q4TbsLRncoprtEfVRt8Vvdn
	 wFrgEtfLmwWS0C1dG1J42n7ZaQUoIdVVA0omQl6Di4p+ATXMOkciiygMC1Yhmueznh
	 Wa/iXuGxnUhuDrlOZDDy5fwQa29yHcamA8XTlf0a9BliQ/QXw717Q7bGYcQgSioEit
	 rm+nX4I9mfy3A==
Date: Thu, 9 Jan 2025 05:50:54 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>, hpa@zytor.com,
	kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, eahariha@linux.microsoft.com,
	haiyangz@microsoft.com, mingo@redhat.com, mhklinux@outlook.com,
	tglx@linutronix.de, tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v6 1/5] hyperv: Define struct hv_output_get_vp_registers
Message-ID: <Z39jvq4CsBjurJ1v@liuwe-devbox-debian-v2>
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
 <20250108222138.1623703-2-romank@linux.microsoft.com>
 <d5fb5c9b-a477-4043-8438-aff29dbd96bb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5fb5c9b-a477-4043-8438-aff29dbd96bb@linux.microsoft.com>

On Wed, Jan 08, 2025 at 03:25:22PM -0800, Nuno Das Neves wrote:
> On 1/8/2025 2:21 PM, Roman Kisel wrote:
> > There is no definition of the output structure for the
> > GetVpRegisters hypercall. Hence, using the hypercall
> > is not possible when the output value has some structure
> > to it. Even getting a datum of a primitive type reads
> > as ad-hoc without that definition.
> > 
> > Define struct hv_output_get_vp_registers to enable using
> > the GetVpRegisters hypercall. Make provisions for all
> > supported architectures. No functional changes.
> > 
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > ---
> >  include/hyperv/hvgdk_mini.h | 41 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > index db3d1aaf7330..4fffca9e16df 100644
> > --- a/include/hyperv/hvgdk_mini.h
> > +++ b/include/hyperv/hvgdk_mini.h
> > @@ -1068,6 +1068,35 @@ union hv_dispatch_suspend_register {
> >  	} __packed;
> >  };
> >  
> > +union hv_arm64_pending_interruption_register {
> > +	u64 as_uint64;
> > +	struct {
> > +		u64 interruption_pending : 1;
> > +		u64 interruption_type: 1;
> > +		u64 reserved : 30;
> > +		u64 error_code : 32;
> > +	} __packed;
> > +};
> > +
> > +union hv_arm64_interrupt_state_register {
> > +	u64 as_uint64;
> > +	struct {
> > +		u64 interrupt_shadow : 1;
> > +		u64 reserved : 63;
> > +	} __packed;
> > +};
> > +
> > +union hv_arm64_pending_synthetic_exception_event {
> > +	u64 as_uint64[2];
> > +	struct {
> > +		u8 event_pending : 1;
> > +		u8 event_type : 3;
> > +		u8 reserved : 4;
> > +		u8 rsvd[3];
> > +		u64 context;
> > +	} __packed;
> > +};
> > +
> 
> You've omitted the exception_type field.
> This is how it should be:
> 
> union hv_arm64_pending_synthetic_exception_event {
> 	u64 as_uint64[2];
> 	struct {
> 		u8 event_pending : 1;
> 		u8 event_type : 3;
> 		u8 reserved : 4;
> 		u8 rsvd[3];
> 		u32 exception_type;
> 		u64 context;
> 	} __packed;
> };
> 

I can fix this when I commit the change . This patch will be folded into
your old one anyway.

Thanks,
Wei.

