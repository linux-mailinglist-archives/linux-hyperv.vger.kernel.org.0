Return-Path: <linux-hyperv+bounces-7608-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB7C6014D
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 08:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426803BF59D
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA61DDC07;
	Sat, 15 Nov 2025 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMUDA75Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D62AE78;
	Sat, 15 Nov 2025 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763192764; cv=none; b=V2ZLnsPZDyN7je5nc3d1QR2CBfXhg+tNiAzn9NrU1ppCXBJWr4JRyQMUCHtirNT29NW4daj7gJIhwfit3/aa/xfSOwXTMzpbvRq1VC9wPEM/Ou47JFgzv03M27ZgBc0JxIsx4wjrVZm+4i6Be154rsxzqIM5I/Nbx5idi89sqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763192764; c=relaxed/simple;
	bh=XMLlTPL7w9SplHfIlI2OErvF9jfBT60mqBOs4nOE2lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1KBMVy3s6r0yLQyxEvptUlwFQB1Fa6Zs/ZoaPT2SLXywa6ny9zZqBuQTMK0yBx1cFw+v8Pw7++nHMAAgGCm19vX4Q+aPxn9Wy6y9tAIIkB++Fb4MMqN080FUIF8s33/1Ei9DNM989+mMigcifWdAZcOirSnjn5S81MMlLzQAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMUDA75Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A01C16AAE;
	Sat, 15 Nov 2025 07:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763192764;
	bh=XMLlTPL7w9SplHfIlI2OErvF9jfBT60mqBOs4nOE2lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMUDA75ZhGDUY1ucJF7q5wJ5fAxbUsm354vuDOgw2uaHf9ry4Igi2y6FYQRrHIU2z
	 RHypbNrvNooHDVpmxAv1gSG0JXCLR/w6spAtHpggYIRIwZb7657scMsIo00KYNrPF4
	 pEd91ck3HkWVGrHfrqH11O7OVsqo1ysqUlXW7sRLaGrlMLRDhWLO5/+8bvhfZYsDVV
	 urwQBCFZBU+fKF1dY9S89uMXan+2ODeiF6hQZxocaHAgBPK28x3+XwJq7eR6RmaGy5
	 Rjc0MJUTK2KfAn3mWj3jTk/hbK/Uk/dWPIFPrrRLCzg0froZurzmgmE1guv+zm+bU3
	 /In/JqR2QaOYg==
Date: Sat, 15 Nov 2025 07:46:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
Message-ID: <20251115074602.GB1794663@liuwe-devbox-debian-v2.local>
References: <20251114095853.3482596-1-anirudh@anirudhrb.com>
 <20251115062240.GA1794663@liuwe-devbox-debian-v2.local>
 <vywh5euispm7c4emz2bma3upnldj2x7rthhsedwhjguv54pakz@5dy326il2de2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vywh5euispm7c4emz2bma3upnldj2x7rthhsedwhjguv54pakz@5dy326il2de2>

On Sat, Nov 15, 2025 at 01:09:12PM +0530, Anirudh Rayabharam wrote:
> On Sat, Nov 15, 2025 at 06:22:40AM +0000, Wei Liu wrote:
> > On Fri, Nov 14, 2025 at 09:58:52AM +0000, Anirudh Rayabharam wrote:
> > > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > 
> > > Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
> > > execute a passthrough hypercall targeting the root/parent partition
> > > i.e. HV_PARTITION_ID_SELF.
> > > 
> > > This will be useful for the VMM to query things like supported
> > > synthetic processor features, supported VMM capabiliites etc.
> > > 
> > > While at it, add HVCALL_GET_PARTITION_PROPERTY_EX to the allowed list of
> > > passthrough hypercalls.
> > > 
> > > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> > This doesn't apply to hyperv-next. What's its base?
> 
> Hmmm... I remember doing this on hyperv-next. This the parent I see:
> 
> commit f2329fd987a0da4759c307c46fd27c4d05bb7433
> Author: Naman Jain <namjain@linux.microsoft.com>
> Date:   Thu Nov 13 04:41:49 2025 +0000
> 
>     Drivers: hv: Introduce mshv_vtl driver
> 
> No worries, I can rebase it on hyperv-next and send it again.

I pulled in some patches from hyperv-fixes to hyperv-next. That's
probably why. But you will see that eventually during a merge later
anyway, so it is good to just rebase and resend.

Wei

> 
> Thanks,
> Anirudh.
> 

