Return-Path: <linux-hyperv+bounces-8055-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B96CCD788
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Dec 2025 21:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1A033018420
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Dec 2025 20:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B063A2C0F8C;
	Thu, 18 Dec 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL6wkD9l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886521F4606;
	Thu, 18 Dec 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088380; cv=none; b=eexOmWZoWGlMOFspyjhnn89a5NjElzdU5aSgsA4qb5sYg3l2+M9rYLnMDY7ITXKop5EyaVlyOXAmL6w5PvBD9EGq9gJHfA8KVI/4oaBw4bVQvN8ugPJVMMhEztCWf1gGfkd6nL2OPviy+bQNFVdCUlCX3xm3L3p9rggZymLWiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088380; c=relaxed/simple;
	bh=vYaPYpeFERQRsoiWwuzfpPleiRloNE0gK4foA05TErY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUQ2GKSAoh+icv1uH8mqTltAGihYcLkqKhlBojlxebAspcGdJcOrZKDxDq4XX+4VySn6CSqb2PRaqmjHNGhatMe4+voOB2Q6HYUCuvr9+5qJJExbkO5nXeF5Xk+CIeT8fr31Dheeub5VRh73GN8TwzTryX1Bh66hU8QKkjWOMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL6wkD9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0505FC4CEFB;
	Thu, 18 Dec 2025 20:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088380;
	bh=vYaPYpeFERQRsoiWwuzfpPleiRloNE0gK4foA05TErY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eL6wkD9lyvOhl7i5r1Pz7N4A3nD8cGHN3ty2+7VogHr8o2pAxCURQ8kbNyNzuEFAC
	 K45cDT9/WcDc7WZSMVviCXe2E595/YXm9dFChadW0EtCETEsA9bdOoYunlYWtqYhPR
	 CprTT5Tw5wGN5KCXPtLFgTd/MV9vVjvRzsHfiG1+p57p6zug4zDN4pYm7HewrDIQGN
	 uTc46qkr8qFBDlHPFNjDKxhwxdRiPSDoZj3eMAeMjqQAlco5Vyg71tSjzTN0PmlyR8
	 dXv8AECIZd+wLSSuzHQsr2BUzJflmEbkZG6sJZZjW6nClJQWDoCOPgMyLR8p252ixP
	 84tI+wzZ5c2PQ==
Date: Thu, 18 Dec 2025 20:06:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: vdso@mailbox.org, kys@microsoft.com, decui@microsoft.com,
	haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
	longli@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/3] hyperv: add definitions for arm64 gpa intercepts
Message-ID: <20251218200618.GF1749918@liuwe-devbox-debian-v2.local>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
 <20251216142030.4095527-2-anirudh@anirudhrb.com>
 <1801063954.177813.1765897665357@app.mailbox.org>
 <jhyqp7vlqsmnps52cgzzuyon3aihcxizog4bknnofuibhud5ry@3nix3cwzwapw>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhyqp7vlqsmnps52cgzzuyon3aihcxizog4bknnofuibhud5ry@3nix3cwzwapw>

On Wed, Dec 17, 2025 at 10:38:47AM +0530, Anirudh Rayabharam wrote:
> On Tue, Dec 16, 2025 at 07:07:45AM -0800, vdso@mailbox.org wrote:
> > 
> > > On 12/16/2025 6:20 AM  Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> > 
> > [...]
> > 
> > > +#if IS_ENABLED(CONFIG_ARM64)
> > > +union hv_arm64_vp_execution_state {
> > > +	u16 as_uint16;
> > > +	struct {
> > > +		u16 cpl:2;
> > 
> > That looks oddly x86(-64)-specific (Current Priviledge Level).
> > 
> > Unless I'm mistaken, CPL doesn't belong here, and the bitfield isn't
> > used on ARM64. Provided the layout of the struct is correct, the
> > bitfield can have a better name of `reserved0` or something like that.
> 
> Hmmm... this is how it is defined in the hypervisor headers though.

We should ask the hypervisor folks then. Once this gets out in the wild
it will be difficult to change.

Wei

> 
> Anirudh.

