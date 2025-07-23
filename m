Return-Path: <linux-hyperv+bounces-6357-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD3B0F6A7
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E99AE1BBE
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F18248F69;
	Wed, 23 Jul 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnRuFnCp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ADF2FC3CD;
	Wed, 23 Jul 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283139; cv=none; b=NKbH1jArI4KqSNW0LWr8M3BwxO5B8HLQBsRaWZKibTPkTgGHHO7CYh0gq0k3UdLacaaeByodyjfmJJsLfAfurYAv0iDTIbL0yX+OIeXGgL5cCGCHo5gxIHmE3fuKWb92p7W9/gSf3her8cJtqaN0fZoQJG4NgLGPqYDt1lju2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283139; c=relaxed/simple;
	bh=+VqZgXFyL3YYIvQoVWM5/KuIxpRYpKZlCEZcxT6hSAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StdDP7tovoJIcbHPPH77tSrjm17o4z9I6sOnhfRZx9dhchYUo1KGc+vA4EwKISdnlwa3tmrr9OMqSOUVsKEKLS+IHHJXL/l6PffLpCu0dG4N/5jLPL1tFLSteHeVoNxhLS7CGUO3iCF4nrNU5mhY3ddFOh6TASEptOKoXbaMSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnRuFnCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB37C4CEE7;
	Wed, 23 Jul 2025 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753283134;
	bh=+VqZgXFyL3YYIvQoVWM5/KuIxpRYpKZlCEZcxT6hSAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fnRuFnCpfFNo3THDScrCiFfN/9QbE7YRCiIK21ePbo5OmFVVe3ucC6IVeButb4Bzk
	 m1AxgoqHslcoxkP8n2pDmTaUgQpZK+/6P7NcdKN1ze18TFTIyGOYsMVQBVnkwfBuUg
	 gXTnIccgx0KfcaUypdfRCkPrhgR9BFylckPyOikQnQDv4mY6bbvZw7v+PguEf+uBzm
	 N5Hqorco9vSCXKTZDNThvv9fgHp3r0aBFv6+j1rgjP7jb5qDOckdV64ybtFUCsSLAk
	 BhmWCDOjAD3dUzlEdds85QXXOhNTteWxfPDVggyI8RKMs4DG0zQxGqAjgfHekxrHb5
	 yLb9s7UvTQojA==
Date: Wed, 23 Jul 2025 08:05:32 -0700
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
Message-ID: <20250723080532.53ecc4f1@kernel.org>
In-Reply-To: <CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
References: <20250718061812.238412-1-lulu@redhat.com>
	<20250721162834.484d352a@kernel.org>
	<CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
	<20250721181807.752af6a4@kernel.org>
	<CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 14:00:47 +0800 Jason Wang wrote:
> > > But this fixes a real problem, otherwise nested VM performance will be
> > > broken due to the GSO software segmentation.  
> >
> > Perhaps, possibly, a migration plan can be devised, away from the
> > netvsc model, so we don't have to deal with nuggets of joy like:
> > https://lore.kernel.org/all/1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com/  
> 
> Btw, if I understand this correctly. This is for future development so
> it's not a blocker for this patch?

Not a blocker, I'm just giving an example of the netvsc auto-weirdness
being a source of tech debt and bugs. Commit d7501e076d859d is another
recent one off the top of my head. IIUC systemd-networkd is broadly
deployed now. It'd be great if there was some migration plan for moving
this sort of VM auto-bonding to user space (with the use of the common
bonding driver, not each hypervisor rolling its own).

