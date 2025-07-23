Return-Path: <linux-hyperv+bounces-6371-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647ADB0FC95
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 00:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971EA58548D
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 22:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C421230BCC;
	Wed, 23 Jul 2025 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja846Zfs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9641C84D0;
	Wed, 23 Jul 2025 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308984; cv=none; b=R7ydsmyEail1pd2aTr2BJftsqD49dDusl5eK0yHEi9wFIitBJu5Cs7hZsyKN/46TvzQjzMgHyNDjmmqfPaPcSGnHm06efAUiRsJ5uFs4wwzX5yPJ+cl23ru2UG9DE3sRC0NJWtgFIJ+80vIWhL3qL8Yo71uEbzzBMf3L0xLaV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308984; c=relaxed/simple;
	bh=CXlQbWCod255PhLjLd1pnNzqKBTQAnCUYfPIJDFXxt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kvhq3zNhisEVqOqIZEBZmAAY8+l3qIpaqR0gTBFr3OIjCHityjkZXBZaPVyyV/3GQBk0OML+U9EI4ohX4n/bWwq9/x3vuvGDqApDIHL6v1A7jTAeQSfpgmR8sGLoQZY1p49LP3yAVaSJwKW7lMT9LpzmR2Oqgeb8G4S53pimYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja846Zfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22114C4CEE7;
	Wed, 23 Jul 2025 22:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753308983;
	bh=CXlQbWCod255PhLjLd1pnNzqKBTQAnCUYfPIJDFXxt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ja846ZfsobSHMLatLtSKRrWuSKOfxaPHfEzAJ34f28njgLINmFZpWB/AjV/gmY35L
	 05R9wcQt0M0eaz4Ej+W1Nulw2AcV/ZCmlAG+au9iJF42KHCqSzuXNX1ABrJQu1pTEW
	 gOYTD2urcBwM9xxiKbhmfzXNxkIUMaxv7K+IW9vSouCKr7iMhl98zcI+CbGigWt6gP
	 A00BFuSB789iM+Xisadpw40OzfJVgO96vKeXmcNvXSsSmIEaY/wIU8kC7suxC2EKcX
	 QiP/oE5cbZz+zWTTTfxfq8Bcqb/e3lXDGGJH7QlyhsM57ijbT7IeqvDPBgT6edEzQ1
	 YiM9AbxQQUZaw==
Date: Wed, 23 Jul 2025 15:16:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jason Wang <jasowang@redhat.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Cindy Lu <lulu@redhat.com>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Kelley
 <mhklinux@outlook.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Kees Cook <kees@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki
 Iwashima <kuniyu@google.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Guillaume Nault <gnault@redhat.com>, Joe
 Damato <jdamato@fastly.com>, Ahmed Zaki <ahmed.zaki@intel.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
Message-ID: <20250723151622.0606cc99@kernel.org>
In-Reply-To: <SJ2PR21MB40138F71138A809C3A2D903BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
References: <20250718061812.238412-1-lulu@redhat.com>
	<20250721162834.484d352a@kernel.org>
	<CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
	<20250721181807.752af6a4@kernel.org>
	<CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
	<20250723080532.53ecc4f1@kernel.org>
	<SJ2PR21MB40138F71138A809C3A2D903BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 20:18:03 +0000 Haiyang Zhang wrote:
> > > Btw, if I understand this correctly. This is for future development so
> > > it's not a blocker for this patch?  
> >
> > Not a blocker, I'm just giving an example of the netvsc auto-weirdness
> > being a source of tech debt and bugs. Commit d7501e076d859d is another
> > recent one off the top of my head. IIUC systemd-networkd is broadly
> > deployed now. It'd be great if there was some migration plan for moving
> > this sort of VM auto-bonding to user space (with the use of the common
> > bonding driver, not each hypervisor rolling its own).  
> 
> Actually, we had used the common bonding driver 9 years ago. But it's
> replaced by this kernel/netvsc based "transparent" bonding mode. See
> the patches listed below.
> 
> The user mode bonding scripts were unstable, and difficult to deliver
> & update for various distros. So Stephen developed the new "transparent"
> bonding mode, which greatly improves the situation.

I specifically highlighted systemd-networkd as the change in the user
space landscape.

