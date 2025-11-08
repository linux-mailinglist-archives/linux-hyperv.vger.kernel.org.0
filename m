Return-Path: <linux-hyperv+bounces-7477-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB02FC43002
	for <lists+linux-hyperv@lfdr.de>; Sat, 08 Nov 2025 17:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D56A4E38F6
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Nov 2025 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDEE1E3762;
	Sat,  8 Nov 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UogX/wtW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E7F3A8F7;
	Sat,  8 Nov 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762619822; cv=none; b=WBM/MP1NdMdMHmI88+OOm8kcwUqgE7bvBmiY0OTyiSceaq2/jLAYLlshswuCyTOleNF0Y/E/i7fi2FYGSqScfjirNXWJBEks7qw/grXTEgoJWEGNQzap4PrZQUOidWXJPDeJSJrwJFHQUzltzFYhpBjX4jtjIYFB6Lr7upeI9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762619822; c=relaxed/simple;
	bh=LVT/aIc2AON71l19ykVx0Fj5Bo0LsiK+P1KP4yuRAkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ2QJm5Osjs6gv6p0XZ+MkY/RHtSOHxWXqWxw7q2OFKbHB0/1J1QgylMhU7wb4LAI7+gtpCmXzvFyZfkyrX+K2tS4TCho3QjpZsGtEarYD2fPQj2G8VFJt56OIo7/HQ+IVwhUM8WF7tAHPSY9ws45FY5xhnm2gApCvlHkTDy4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UogX/wtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334C7C16AAE;
	Sat,  8 Nov 2025 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762619820;
	bh=LVT/aIc2AON71l19ykVx0Fj5Bo0LsiK+P1KP4yuRAkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UogX/wtWXGveHNi5Em0vXRdgXw47JbmHjtRNDT1sbxetQOrviyCtRRnWBqFBMbyh/
	 DjfLPBul3iwbBViop268FCO1X1Sh345YbI0xD7QH4rTBGwV82ApQ0uo2HcEKGi91i5
	 T4ixlSoOkS0aVHfEw9wTUDzdVlg0EaYv2veGEEN1nqtVnvmtluIvThF2BBVEE1TaM1
	 QGbzZOo1waADecLNENgmjqFwpPd9DYb2PyR5hYc8tAaA0JxPFDiCnP6fgXIQXFkjRT
	 SD1Ls0Pi+qbphltPr0kHJO6ywttC7sqMeeAlEglbSC0OZ+gpunSTmLV6lib5M45Qo0
	 nbhdv69juwlqQ==
Date: Sat, 8 Nov 2025 16:36:55 +0000
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ally Heev <allyheev@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
Message-ID: <aQ9xp9pchMwml30P@horms.kernel.org>
References: <20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>

On Thu, Nov 06, 2025 at 03:07:26PM +0100, Alexander Lobakin wrote:
> From: Ally Heev <allyheev@gmail.com>
> Date: Thu, 06 Nov 2025 17:25:48 +0530
> 
> > Uninitialized pointers with `__free` attribute can cause undefined
> > behavior as the memory assigned randomly to the pointer is freed
> > automatically when the pointer goes out of scope.
> > 
> > It is better to initialize and assign pointers with `__free`
> > attribute in one statement to ensure proper scope-based cleanup.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
> > ---
> > Changes in v3:
> > - fixed style issues
> > - Link to v2: https://lore.kernel.org/r/20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com
> > 
> > Changes in v2:
> > - fixed non-pointer initialization to NULL
> > - NOTE: drop v1
> > - Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-net-ethernet-v1-1-f6ea84bbd750@gmail.com
> > ---
> >  drivers/net/ethernet/intel/ice/ice_flow.c       | 5 +++--
> >  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> > index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d715e40bb290e40c4aa 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> > @@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
> >  			 struct ice_parser_profile *prof, enum ice_block blk)
> >  {
> >  	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
> > -	struct ice_flow_prof_params *params __free(kfree);
> >  	u8 fv_words = hw->blk[blk].es.fvw;
> >  	int status;
> >  	int i, idx;
> >  
> > -	params = kzalloc(sizeof(*params), GFP_KERNEL);
> > +	struct ice_flow_prof_params *params __free(kfree) =
> > +		kzalloc(sizeof(*params), GFP_KERNEL);
> 
> Please don't do it that way. It's not C++ with RAII and
> declare-where-you-use.
> Just leave the variable declarations where they are, but initialize them
> with `= NULL`.
> 
> Variable declarations must be in one block and sorted from the longest
> to the shortest.
> 
> But most important, I'm not even sure how you could trigger an
> "undefined behaviour" here. Both here and below the variable tagged with
> `__free` is initialized right after the declaration block, before any
> return. So how to trigger an UB here?

FWIIW, I'd prefer if we sidestepped this discussion entirely
by not using __free [1] in this driver.

It seems to me that for both functions updated by this
patch that can easily be achieved using an idiomatic
goto label to free on error.

[1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

...

