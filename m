Return-Path: <linux-hyperv+bounces-6317-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D1B0CF08
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 03:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3971705B5
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 01:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFDE7080C;
	Tue, 22 Jul 2025 01:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkvE889j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7A323D;
	Tue, 22 Jul 2025 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753147089; cv=none; b=XiaMb7QzbKSsbINlAfOXgfWNxbvB0aLXOw8RsOA8jhsSczRUUnqmWL0C/XubpFNNbdHeywuxY8evuemKjju1xm6sNpM2aiW5JsB6PegXjR0IsC/b73ynyIngC1JytPrW2biA1Rauf8QCjX7K3WGYUccnnBj1EoofCJydMGuCnN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753147089; c=relaxed/simple;
	bh=58G4hQ5/WYB9qMDV9HoXS6b9QDxGVyYptlpx2v3QD/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3h/EVFynzDz1ZySlwQuz4u6K+FBkG6qHq8C2EMlpXq097/gn+5wqIjfj/HIg4EYtqosIZYyGcn+VXjoodFbAC64J+lbOMiU/g6By4tlYB+SozWZQonsuEnqey6uRL28qwNNnZqOIblgcHYIAMyG7UYTrhz/ArDGHJqJViT9/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkvE889j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8779C4CEED;
	Tue, 22 Jul 2025 01:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753147088;
	bh=58G4hQ5/WYB9qMDV9HoXS6b9QDxGVyYptlpx2v3QD/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SkvE889jbt5tv9l+yFT7rv5B6aYpVQUYphLe3loTTj5Osrqt+yE7GmeObt1mh/NPo
	 HnoUSXMZiacKTQlKXFI5emlCOhuTWYN5t9/5rsXf7v0uXzquyb1yRBlcpme3PTmNjU
	 QLool18G89qHgen63lJWGy8G2a9E3veXOQrKr36cQe6tvB7GDCHeHP4qHzgOeN+jfE
	 a/CY8n8m2thbYipGA1H+B3SEUMBwkNYA6Vhmvsa2lDMKLjWvAVerqJ4MXTIH7dZqv3
	 di4zdID86qSBaDL+EVYGGB5uhd8MlXJg/KK2CeNa5au2VC4iJTJynX49EeovcUBwue
	 Q7qW4kf3QIbwQ==
Date: Mon, 21 Jul 2025 18:18:07 -0700
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
Message-ID: <20250721181807.752af6a4@kernel.org>
In-Reply-To: <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
References: <20250718061812.238412-1-lulu@redhat.com>
	<20250721162834.484d352a@kernel.org>
	<CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 09:04:20 +0800 Jason Wang wrote:
> On Tue, Jul 22, 2025 at 7:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Fri, 18 Jul 2025 14:17:55 +0800 Cindy Lu wrote: =20
> > > Subject: [PATCH RESEND] netvsc: transfer lower device max tso size =20
> >
> > You say RESEND but I don't see a link to previous posting anywhere.

Someone should respond to this part, please.

> > I'd rather we didn't extend the magic behavior of hyperv/netvsc any
> > further. =20
>=20
> Are you referring to the netdev coupling model of the VF acceleration?

Yes, it tries to apply whole bunch of policy automatically in=20
the kernel.

> > We have enough problems with it.
>=20
> But this fixes a real problem, otherwise nested VM performance will be
> broken due to the GSO software segmentation.

Perhaps, possibly, a migration plan can be devised, away from the
netvsc model, so we don't have to deal with nuggets of joy like:
https://lore.kernel.org/all/1752870014-28909-1-git-send-email-haiyangz@linu=
x.microsoft.com/

