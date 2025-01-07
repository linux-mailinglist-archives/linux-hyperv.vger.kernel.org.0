Return-Path: <linux-hyperv+bounces-3593-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6BAA034CD
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 03:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6BC1883473
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602CC13AA38;
	Tue,  7 Jan 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l10O6kK5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCD4964F;
	Tue,  7 Jan 2025 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736215250; cv=none; b=XF7o3Ot+pCseqEPisJGJD5Mr579FwhocokjiKD+nZrAXuknc7R/x/0si4kWk0MbLpZyJjfLIgOWq80uzXyQyG+M+Ze/pzNkch5wOBk2HBsENXrEWbj1PMYol0cKexIRMEInc7dHVm8XlDer9ZEGyFWuEXu6VfgR3eNXZUuyP0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736215250; c=relaxed/simple;
	bh=eTB0ohSHy6yj76a1yfGRTU/wZ+ZKzKTED7I8faMfD7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2nj111xstJBq+l4mSNlzLhn87QFziS8NUFve9olItF93biNSrrau7/y976TvdICfF5LnEslJhwFpMrpJvAuqVtCC5t9pmOUUdgtNoEm00fYLaIdvwAtkV706lo5qQeqmVz2vwNhkAuNcWua+tdcoWJslxd9SuEUMnWv5r4822U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l10O6kK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82137C4CED2;
	Tue,  7 Jan 2025 02:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736215249;
	bh=eTB0ohSHy6yj76a1yfGRTU/wZ+ZKzKTED7I8faMfD7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l10O6kK5DO6FpPBMhkHoemsvzNDJpoZoNZHeQbKVheKpGypB8wus8S22tGP7OFIpc
	 plJ72fnV319RHbq15YuD6aUvE/gCTl9UOytow2tzFXHVTfymIpIktdft5xRYCIBM3S
	 baBApWe37qHC2nn2Y+AqPEYs8zLOHZ/OPTaVE9EopPVUIpG8/eJX3w2w1DOAmZP+5O
	 b5KwWmHfurM5RIOYzTW1BVlPfCoo77syDfJ16OiwjLgx4D/MNHuwV3ZgeQz2jdl8Sw
	 1YGofu9dQuTw0FzbAiNBktFL+O5Bn8jEhED7wL9gvwChHTvnlfj14VLyQ3F8aJcs+2
	 +m7CGab7dN5bQ==
Date: Tue, 7 Jan 2025 02:00:48 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Sonia Sharma <sosha@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sosha@microsoft.com" <sosha@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] Drivers: hv: Allow single instance of hv_util devices
Message-ID: <Z3yK0Ee3eFLocJDW@liuwe-devbox-debian-v2>
References: <1734738938-21274-1-git-send-email-sosha@linux.microsoft.com>
 <SN6PR02MB41579A7AA47BC6751F57EC72D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41579A7AA47BC6751F57EC72D4082@SN6PR02MB4157.namprd02.prod.outlook.com>

On Sun, Dec 29, 2024 at 06:02:34PM +0000, Michael Kelley wrote:
> From: Sonia Sharma <sosha@linux.microsoft.com> Sent: Friday, December 20, 2024 3:56 PM
> > 
> 
> Please include the "linux-hyperv@vger.kernel.org" mailing list
> when submitting patches related to Hyper-V.
> 
> > Harden hv_util type device drivers to allow single
> > instance of the device be configured at given time.
> >

Why is this needed? What's the problem that this patch is trying to
solve?

> 
> I think the reason for this patch needs more explanation. For several
> VMBus devices, a well-behaved Hyper-V is expected to offer only one
> instance of the device in a given VM. Linux guests originally assumed
> that the Hyper-V host is well-behaved, so the device drivers for many
> of these devices were written assuming only a single instance. But
> with the introduction of Confidential Computing (CoCo) VMs, Hyper-V
> is no longer assumed to be well-behaved. If a compromised & malicious
> Hyper-V were to offer multiple instances of such a device, the device
> driver assumption about a single instance would be false, and
> memory corruption could occur, which has the potential to lead to
> compromise of the CoCo VM. The intent is to prevent such a scenario.
> 
> Note that this problem extends beyond just "util" devices. Hyper-V
> is expected to offer only a single instance of keyboard, mouse, frame
> buffer, and balloon devices as well. So this patch should be extended
> to include them as well (and your new function names containing
> "hv_util" should be adjusted). Interestingly, the Hyper-V keyboard driver
> does not assume a single instance, so it should be safe regardless. But
> the mouse, frame buffer, and balloon drivers are not safe.
> 
> With this understanding, there are two ways to approach the problem:
> 
> 1) Enforce the expectation that a well-behaved Hyper-V only offers a
> single instance of these VMBus devices. That's the approach that this
> patch takes.
> 
> 2) Update the device drivers to remove the assumption of a single
> instance. With this approach, if a compromised & malicious Hyper-V
> were to offer multiple instances, the extra devices might be bogus, 
> but memory corruption would not occur and the integrity of the
> CoCo VM should not be compromised. As mentioned above, such
> is already the case with the keyboard driver.
> 
> I've thought about the tradeoffs for the two approaches, and don't
> really have a strong opinion either way. In some sense, #2 is the
> more correct approach as ideally device drivers shouldn't make
> single instance assumptions. But #1 is an easier fix, and perhaps
> more robust. Other reviewers might have other reasons to prefer
> one over the other, and have a stronger viewpoint on the tradeoffs.
> I would be interested in any such comments. But I'm OK with
> approach #1 unless someone points out a good reason to
> prefer #2.

#2 is preferred. It is frowned upon to make assumptions that only one
instance of a device will be present.

It perhaps takes more work to check and enforce the invariant (as this
patch demonstrates) than to just let the device framework handle
multiple instances.

Thanks,
Wei.

