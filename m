Return-Path: <linux-hyperv+bounces-6421-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CFCB13E14
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Jul 2025 17:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2BE3B5867
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Jul 2025 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADDF26FA76;
	Mon, 28 Jul 2025 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aod8NwN3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44261D5145;
	Mon, 28 Jul 2025 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715949; cv=none; b=R5QD2ekF7d/OlnNRndtvazOikQ0ttkNWOo+83Tmy2GHwW1u/mQW924nLniRX0S0/Q7+pUxkXq99jHCSYe/Qn4/wDjMPaRCIBlEske5nuK8R7tCKjtc9Tin3GI2wVqyV8mKJMJyksqWhK1gE3PhqA4bUI4/ViBUXopA0CAq937Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715949; c=relaxed/simple;
	bh=jtQPl9fdZvZtEb/y/9SCQaBctzLJmmM7srwq7qNJiRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbts4n2dsA9Q0LzgFVQBBmHQyvwwoL29hC1hY98no5gp3jNh6ERu/4s/R8nMMgtxOQCQn9rpJd0ReC5pPil9OiinqQJVynCs8ice6CiX3cTnHwqPrh61j2I66NfgNyApexvlgLEdORjPdcq4fGzC/tc/GGIP1nsgcvOeseA2cLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aod8NwN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AA5C4CEE7;
	Mon, 28 Jul 2025 15:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753715948;
	bh=jtQPl9fdZvZtEb/y/9SCQaBctzLJmmM7srwq7qNJiRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aod8NwN3/JOlahigpX8mZ9sELREBI4cu7rK1H5sM1/q+xT5ZHCVKqfjGNj6GgoJxL
	 0aPINQS5wd453yRNHlVQBR4AFlgZP8g0O64eaqAqFhB0RK3lUz0/rTB2Zy232Hm+fu
	 QY063sbsaWf9gh/4DkQcGVaFH6Hx0O4UoWYTCzhjfdxY6HD7zTv7FXQsqYCbKHWdit
	 Agd6gVeG0xg1uDYFeqXjArZTucP+rbprdsv+oUOodlg5psJ2/FiuHuMCKEmvwypreK
	 0FPiURxyPmd0niG04uFJs+OQhUvfTdH02fgTPQnc5NmbNMUAaYwbN8KpBdiY57XgPx
	 rIk9mOR3HyeNA==
Date: Mon, 28 Jul 2025 08:19:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Jason Wang
 <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, KY Srinivasan
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
Message-ID: <20250728081907.3de03b67@kernel.org>
In-Reply-To: <20250727200126.2682aa39@hermes.local>
References: <20250718061812.238412-1-lulu@redhat.com>
	<20250721162834.484d352a@kernel.org>
	<CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
	<20250721181807.752af6a4@kernel.org>
	<CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
	<20250723080532.53ecc4f1@kernel.org>
	<SJ2PR21MB40138F71138A809C3A2D903BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
	<20250723151622.0606cc99@kernel.org>
	<20250727200126.2682aa39@hermes.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Jul 2025 20:01:26 -0700 Stephen Hemminger wrote:
> On Wed, 23 Jul 2025 15:16:22 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > > Actually, we had used the common bonding driver 9 years ago. But it's
> > > replaced by this kernel/netvsc based "transparent" bonding mode. See
> > > the patches listed below.
> > > 
> > > The user mode bonding scripts were unstable, and difficult to deliver
> > > & update for various distros. So Stephen developed the new "transparent"
> > > bonding mode, which greatly improves the situation.    
> > 
> > I specifically highlighted systemd-networkd as the change in the user
> > space landscape.  
> 
> Haiyang tried valiantly but getting every distro to do the right thing
> with VF's bonding and hot plug was impossible to support.

I understand, but I also don't want it to be an upstream Linux problem.

Again, no other cloud provider seems to have this issue, AFAIU.

