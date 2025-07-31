Return-Path: <linux-hyperv+bounces-6449-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30840B16A14
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Jul 2025 03:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0D0560921
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Jul 2025 01:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E965487BE;
	Thu, 31 Jul 2025 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWoTn6rC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3017BD9;
	Thu, 31 Jul 2025 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924716; cv=none; b=LzXuezqaM4yaBumQW/nI8w2RGpcbhcqzqCh5W+7ehTTAP5f0YRwlrMfKducc8BiFqSta9QsdcBZZbA0jZYu6xZl/BuizFOc8HZXVoiROSAc+t8eRaWt/b4Oq11ZE1vajA7eIu7oKHvCqVR3DT0ZMntQqx5mWcUS8T1PpOf9W/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924716; c=relaxed/simple;
	bh=uJzyPqF2mcBaFPZMkPf6v0KK/E0/EHwqwDPaWB9pXPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/ozb8RACx9h8T7QdNiT+dMv7Hu/RgzuLavddAizfUuFNqkuF3VogvRxjg0MAtVvSySId7mxkesV3s2TyPE4kD5qV2wTkUY8bFiV2tqcrwYjDYIVujeqcx7SI7xkfGk2RJtQnNcx+PUAgPhOezqFCG9PvuKQTINzbZC7vck1zQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWoTn6rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E772CC4CEE7;
	Thu, 31 Jul 2025 01:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753924716;
	bh=uJzyPqF2mcBaFPZMkPf6v0KK/E0/EHwqwDPaWB9pXPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hWoTn6rCE2YwljPfnWp96fHuixZshDRtEJ9LgleA79Bcys1VhjAez3XqG733Yb6BA
	 jazsIf8SVDuuJXOHGqNVVuXOo95pkW6b/XU2cRUp3UJBOHFGlMEoKJH/EeY32w3phb
	 QztDHctyn3Nj+n38NVYuIZAjwNOjOpNJIAfMHqpDBLiXHIMXHy6r4P+EMx3Sxw17sM
	 t2Q+Ja5TP4XKeSgMw1hpB7jUrLu7+0of9dT/nC1Ep12CCQ0KLTrAXjhFWKPWT+LghV
	 Qcgj7LXF0doIXGhHaJhqQNghLW11zhKt5rwhVRm6pNIiv7at4eRAjbW0p5EjDzuYa3
	 EzjpGmHHnt7mw==
Date: Wed, 30 Jul 2025 18:18:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Kees Cook <kees@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Guillaume Nault
 <gnault@redhat.com>, Joe Damato <jdamato@fastly.com>, Ahmed Zaki
 <ahmed.zaki@intel.com>, "open list:Hyper-V/Azure CORE AND DRIVERS"
 <linux-hyperv@vger.kernel.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
Message-ID: <20250730181835.2423917b@kernel.org>
In-Reply-To: <CACGkMEuvBU+ke7Pu1yGyhkzpr_hjSEJTq+PcV1jbZWcBFm-k1w@mail.gmail.com>
References: <20250718061812.238412-1-lulu@redhat.com>
	<20250721162834.484d352a@kernel.org>
	<CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
	<20250721181807.752af6a4@kernel.org>
	<CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
	<20250723080532.53ecc4f1@kernel.org>
	<CACGkMEuvBU+ke7Pu1yGyhkzpr_hjSEJTq+PcV1jbZWcBFm-k1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 09:07:27 +0800 Jason Wang wrote:
> > > Btw, if I understand this correctly. This is for future development so
> > > it's not a blocker for this patch?  
> >
> > Not a blocker, I'm just giving an example of the netvsc auto-weirdness
> > being a source of tech debt and bugs. Commit d7501e076d859d is another
> > recent one off the top of my head. IIUC systemd-networkd is broadly
> > deployed now. It'd be great if there was some migration plan for moving
> > this sort of VM auto-bonding to user space (with the use of the common
> > bonding driver, not each hypervisor rolling its own).
> >  
> 
> Please let me know if you want to merge this patch or not. If not, how
> to proceed.

As is its definitely not getting merged.
Please make it look less burdensome or fix it in user space(!!).

