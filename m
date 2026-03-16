Return-Path: <linux-hyperv+bounces-9449-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AmtlJVVjuGlOdQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9449-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 21:08:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4072A007D
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 21:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3E4F302C323
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 20:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298183EC2F0;
	Mon, 16 Mar 2026 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgZmCbCP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590E3DB633;
	Mon, 16 Mar 2026 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691730; cv=none; b=lh/gTIA9YjGEZ88iFFQ2gnMxtFSlGPfh54UnHc+2kycLyafsj0Ys5FIXt/W/QbblY1ei9VnrmCsRrkoIl6Z9CjKaqDqrprTMDoT8lrzJpsfXtD0ptMV71QPj3eGkOzcXbnkg9hZaZ6RdQxTXnpsqWey88TIzanreAhq5GEMvP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691730; c=relaxed/simple;
	bh=tF5+TYy9TOMT17GvMJv8yMenIQK3D/nws+hDUWCARkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgFk/LuWSH1m4nh0xdmitUYgvOiuaYKEdPpIxjKVNotr+BZHM3vsXzsA1UADEZMQxprEx6Ku8WG1i9MXJVTOxljzQfwNFb1HK2JJfvFfiGO2I6qWJqKeSLIUJclHwUtG2TAIqz16dntzxhGJfjyLTofVtElrt2/NJ+1S/SdFUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgZmCbCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5352C19421;
	Mon, 16 Mar 2026 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773691729;
	bh=tF5+TYy9TOMT17GvMJv8yMenIQK3D/nws+hDUWCARkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgZmCbCPNR063athnMr3xIiM0OuidJOwtcT/SMyyQj+BXpZm2vcmrkMsRumOc0BEL
	 +5hVyJ2wnX3xe2HRJC474gv9BloaKMkyjc/L1fsJ7G/U63w8Jq2xHiSJBoe1fg847d
	 DQXNmwz6N3Vt3oEmrRW3hTEM8RHbQPfOQu3pfUR13Ej0TJhM5RAxmT8tNgc8tFuECL
	 b5lnW3KF+cjsJTZVArLb1tanGCSpedi7sL0Kfk+FSQyITfhy2+ITW1q4vzmZ1zBmLa
	 bbQyBUEJFHyfPws9y+rIoMN6IQv95Hj76vFBNJ5eUZtaigrOiAssXWah2wA9VatGAo
	 Up0BZVK3+0LaQ==
Date: Mon, 16 Mar 2026 22:08:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle service reset for
 RDMA resources
Message-ID: <20260316200843.GK61385@unreal>
References: <20260307014723.556523-1-longli@microsoft.com>
 <20260307173814.GN12611@unreal>
 <20260313165928.GH1704121@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313165928.GH1704121@ziepe.ca>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9449-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A4072A007D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:59:28PM -0300, Jason Gunthorpe wrote:
> On Sat, Mar 07, 2026 at 07:38:14PM +0200, Leon Romanovsky wrote:
> > On Fri, Mar 06, 2026 at 05:47:14PM -0800, Long Li wrote:
> > > When the MANA hardware undergoes a service reset, the ETH auxiliary device
> > > (mana.eth) used by DPDK persists across the reset cycle — it is not removed
> > > and re-added like RC/UD/GSI QPs. This means userspace RDMA consumers such
> > > as DPDK have no way of knowing that firmware handles for their PD, CQ, WQ,
> > > QP and MR resources have become stale.
> > 
> > NAK to any of this.
> > 
> > In case of hardware reset, mana_ib AUX device needs to be destroyed and
> > recreated later.
> 
> Yeah, that is our general model for any serious RAS event where the
> driver's view of resources becomes out of sync with the HW.
> 
> You have tear down the ib_device by removing the aux and then bring
> back a new one.
> 
> There is an IB_EVENT_DEVICE_FATAL, but the purpose of that event is to
> tell userspace to close and re-open their uverbs FD.
> 
> We don't have a model where a uverbs FD in userspace can continue to
> work after the device has a catasrophic RAS event.
> 
> There may be room to have a model where the ib device doesn't fully
> unplug/replug so it retains its name and things, but that is core code
> not driver stuff.

Good luck with that model. It is going to break RDMA-CM hotplug support.

Thanks

> 
> Jason
> 

