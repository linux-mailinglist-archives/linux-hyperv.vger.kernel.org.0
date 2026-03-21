Return-Path: <linux-hyperv+bounces-9678-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIqfOY7mvWkLDgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9678-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 01:30:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6FA2E2946
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 01:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2244C3004F63
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 00:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F9303A0A;
	Sat, 21 Mar 2026 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMZwYe1z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA490282F06;
	Sat, 21 Mar 2026 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774052952; cv=none; b=bz4JZELVRxaOl9u5HpXy/wx+iw2JGxUZflZu9xZCRtNSRol9UMxvXGZ8KwqcUXYF4sffjnmpvb8EYELhDKjYKaaC/LRE9pjNu9WZjRG0cWu+QCphqWsf6KHgZitdIccFcvoDqiGCJ6QWIM9RyQumnDDNEoN72EfH+jGpCSUzRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774052952; c=relaxed/simple;
	bh=tHN/oZKQb9QT/nhohbh+Hg4V8Ae8XMXyg47Ekl09UJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aewsNdhv5cX314dhR2d0aaA9PeBP8Xy/4mEfGUj+H/jk9ZBWG0Ent73Heuqqf+wJEv1v7kUjCOAapugm6Jp9P3UCK9qQlgqeCE20eFPJ81VQMXAGlR4t+SWB7qANd2QbzvaYc19UREuDt3pB/qReWhNLsIPkRRVCKrTo8/NEu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMZwYe1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21C6C4CEF7;
	Sat, 21 Mar 2026 00:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774052951;
	bh=tHN/oZKQb9QT/nhohbh+Hg4V8Ae8XMXyg47Ekl09UJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nMZwYe1zLTjEHhisByrmhcE8tcqgqrnljW3LPFjcGbEtePRZqZ60BkTxPtmQ9ZDDE
	 ukL/8UtQF+ZFtp6eTNFt3x0KTE0Hz2eMAdFPf3muMQYwj2J/hDRgM7Y/rUNmXRhLmS
	 +t/CdPUMVUax2hmkkLa1wb76Ogg84QLTXV6f8YGLdDQVh4Qyouz0n0mS9SuEMuP/ss
	 FxOaYB8rXRdVS7N//PD9Nfs66Nfg25KrcQaQnd19UlIspVvNkbimNhkwyxccGLE5Sw
	 CNOK0qqhJv+g/+QUkwpz1hGkygQbC1giHZUPjvB/psinn7Z8VqxOmMHh2FVUXQSvXt
	 Qm7RFXgLNQR1Q==
Date: Fri, 20 Mar 2026 17:29:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dipayanroy@microsoft.com
Subject: Re: [PATCH net-next, v3] net: mana: Force full-page RX buffers for
 4K page size on specific systems.
Message-ID: <20260320172908.1840229d@kernel.org>
In-Reply-To: <ab2T8LgRiDHDIUHV@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <abDo8XTu1EiQFC7T@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20260314125053.41d6221b@kernel.org>
	<ab2T8LgRiDHDIUHV@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9678-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F6FA2E2946
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 11:37:36 -0700 Dipayaan Roy wrote:
> On Sat, Mar 14, 2026 at 12:50:53PM -0700, Jakub Kicinski wrote:
> > On Tue, 10 Mar 2026 21:00:49 -0700 Dipayaan Roy wrote: =20
> > > On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
> > > fragments for RX buffers results in a significant throughput regressi=
on.
> > > Profiling reveals that this regression correlates with high overhead =
in the
> > > fragment allocation and reference counting paths on these specific
> > > platforms, rendering the multi-buffer-per-page strategy counterproduc=
tive. =20
> >=20
> > Can you say more ? We could technically take two references on the page
> > right away if MTU is small and avoid some of the cost. =20
>=20
> There is a 15-20% shortfall in achieving line rate for MANA (180+ Gbps)
> on a particular ARM64 SKU. The issue is only specific to this processor S=
KU =E2=80=94
> not seen on other ARM64 SKUs (e.g., GB200) or x86 SKUs. Critically, the
> regression only manifests beyond 16 TCP connections, which strongly indic=
ates
> seen when there is  high contention and traffic.
>=20
>   no. of     | rx buf backed       | rx buf backed
>  connections | with page fragments | with full page
> -------------+---------------------+---------------
>            4 |         139 Gbps    |     138 Gbps
>            8 |         140 Gbps    |     162 Gbps
>           16 |         186 Gbps    |     186 Gbps

These results look at bit odd, 4 and 16 streams have the same perf,
while all other cases indeed show a delta. What I was hoping for was
a more precise attribution of the performance issue. Like perf top
showing that its indeed the atomic ops on the refcount that stall.

>           32 |         136 Gbps    |     183 Gbps
>           48 |         159 Gbps    |     185 Gbps
>           64 |         165 Gbps    |     184 Gbps
>          128 |         170 Gbps    |     180 Gbps
> =20
> HW team is still working to RCA this hw behaviour.
>=20
> Regarding "We could technically take two references on the page right
> away", are you suggesting having page reference counting logic to driver
> instead of relying on page pool?

Yes, either that or adjust the page pool APIs.=20
page_pool_alloc_frag_netmem() currently sets the refcount to BIAS
which it then has to subtract later. So we get:

  set(BIAS)
  .. driver allocates chunks ..
  sub(BIAS_MAX - pool->frag_users)

Instead of using BIAS we could make the page pool guess that the caller
will keep asking for the same frame size. So initially take
(PAGE_SIZE/size) references.

> > The driver doesn't seem to set skb->truesize accordingly after this
> > change. So you're lying to the stack about how much memory each packet
> > consumes. This is a blocker for the change.
> >  =20
> ACK. I will send out a separate patch with fixes tag to fix the skb true
> size.
>=20
> > > To mitigate this, bypass the page_pool fragment path and force a sing=
le RX
> > > packet per page allocation when all the following conditions are met:
> > >   1. The system is configured with a 4K PAGE_SIZE.
> > >   2. A processor-specific quirk is detected via SMBIOS Type 4 data. =
=20
> >=20
> > I don't think we want the kernel to be in the business of carrying
> > matching on platform names and providing optimal config by default.
> > This sort of logic needs to live in user space or the hypervisor=20
> > (which can then pass a single bit to the driver to enable the behavior)
> >  =20
> As per our internal discussion the hypervisor cannot provide the CPU
> version info(in vm as well as in bare metal offerings).

Why? I suppose it's much more effort for you but it's much more effort
for the community to carry the workaround. So..

> On handling it from user side are you suggesting it to introduce a new
> ethtool Private Flags and have udev rules for the driver to set the priva=
te
> flag and switch to full page rx buffers? Given that the wide number of di=
stro
> support this might be harder to maintain/backport.=20
>=20
> Also the dmi parsing design was influenced by other net wireleass
> drivers as /wireless/ath/ath10k/core.c. If this approach is not
> acceptable for MANA driver then will have to take a alternate route
> based on the dsicussion right above it.

Plenty of ugly hacks in the kernel, it's no excuse.

