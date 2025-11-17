Return-Path: <linux-hyperv+bounces-7646-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0E1C65F1D
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 20:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5E100294BD
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 19:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD0C27AC4D;
	Mon, 17 Nov 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN6Iu9aw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69F815855E;
	Mon, 17 Nov 2025 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407446; cv=none; b=KPku5mvguYhcbGm50/uqZ6Ax8ssgnKbC4cJQGLD3wIImMFDlh11gvQltgDNvN5A5ttfBhvQFk14E+hzOH5vCscR7BiyLZieDBHVXqrGlAEd5rFeVqrO+nUsMl1a//SGRbl0HgLoTIiz6We40l57SsP2bFaqDTTL/5XDOZVQOGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407446; c=relaxed/simple;
	bh=sfSZLfC/hG8Co4aP3Qgyua5VpkRSrO6qQB32AVkIIKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTw6M1994LB7yIQ8pOLImkRXA7NFgeCSzRcFbgHxpBwXWVWzMNjvpeBlhSDvhLpGwi3oAtAVo9tfeiTyToQ5PorKI+42fI86rD/0GHCfm6n3P5bCahzQuSfdAwnw8qPE6soO8uj4uo16gmwb8moCJeoIKtq18/astOC7A4NTj3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN6Iu9aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A2BC19422;
	Mon, 17 Nov 2025 19:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763407444;
	bh=sfSZLfC/hG8Co4aP3Qgyua5VpkRSrO6qQB32AVkIIKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NN6Iu9awEpXmipGV1Kqt2o7Lng73vw27F/57QIDmhnJm7s2e8Dprx/Xl+2jNNwf4H
	 wXUZJK1gWhu7clCFd2iQ52ryUjCmijE6KmPKASTJkhP0p6rAjjgKXg+nE+c2Gl5UiW
	 mHG9Zvn1Cyiq5rABF8XhvPqH+hvHNtNLRz8pKTrE+dU42EeQy/p1OAy1gaIwS5/nzr
	 qZ15RoJb6DTlfSA5+SmZppOfDYwjhZ9cVOHL1x8/d86QywZAtpzI6Fg6V+k9Rp29cm
	 kGR+t2IwkoykVqNEdZk1qI4ikJvMYfutc2osjqNQQoN/Wqq+X7JJau9ZkQM0/ELNTW
	 AToUdAPMtDUgg==
Date: Mon, 17 Nov 2025 19:24:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: ioctl for self targeted passthrough
 hvcalls
Message-ID: <20251117192402.GA2402579@liuwe-devbox-debian-v2.local>
References: <20251117095207.113502-1-anirudh@anirudhrb.com>
 <36ac7105-3aa7-4e53-b87d-b99438f65295@linux.microsoft.com>
 <20251117191827.GC2380208@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117191827.GC2380208@liuwe-devbox-debian-v2.local>

On Mon, Nov 17, 2025 at 07:18:27PM +0000, Wei Liu wrote:
> On Mon, Nov 17, 2025 at 10:16:12AM -0800, Nuno Das Neves wrote:
> > On 11/17/2025 1:52 AM, Anirudh Rayabharam wrote:
> > > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > 
> > > Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
> > > execute a passthrough hypercall targeting the root/parent partition
> > > i.e. HV_PARTITION_ID_SELF.
> > > 
> > 
> > I think it's worth taking a moment to check and perhaps explain in
> > the commit message/a comment any security implications of the VMM
> > process being able to call these hypercalls on the root/parent
> > partition.
> > 
> > One implication would be: can the VMM process influence other
> > processes in the root partition via these hypercalls,
> > e.g. HVCALL_SET_VP_REGISTERS? I would think that the hypervisor
> > itself disallows this but we should check. We can ask the
> > hypervisor team what they think, and check the hypervisor code.
> > 
> > Specifically we should check on any hypercall that could possibly
> > influence partition state, i.e.:
> > HVCALL_SET_PARTITION_PROPERTY
> > HVCALL_SET_VP_REGISTERS
> > HVCALL_INSTALL_INTERCEPT
> > HVCALL_CLEAR_VIRTUAL_INTERRUPT
> > HVCALL_REGISTER_INTERCEPT_RESULT
> > HVCALL_ASSERT_VIRTUAL_INTERRUPT
> > HVCALL_SIGNAL_EVENT_DIRECT
> > HVCALL_POST_MESSAGE_DIRECT
> > 
> > If it turns out there is something risky we are enabling here, we can
> > introduce a new array of hypercalls to restrict which ones can be
> > called on HV_PARTITION_ID_SELF.
> > 
> 
> This is a good point. Please check with the hypervisor team.

I should add: it is always easier to relax restrictions later than to
add them back in, so if there is any doubt and we want this code in as
quickly as possible, we can start with a new array and expand it later.

Wei

