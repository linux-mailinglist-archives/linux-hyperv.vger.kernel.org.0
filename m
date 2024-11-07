Return-Path: <linux-hyperv+bounces-3287-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837D49C1154
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 22:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6642B22E2F
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F821949A;
	Thu,  7 Nov 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IplPLXIA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9045218929;
	Thu,  7 Nov 2024 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016355; cv=none; b=uhVemMbeyDcmRk6ZgREw3bP8mN7GmGEMu27tRa8i3toeOqVq/fvjIIHUbtcxFaDLvrveldq8wjc3ZHl80LV1b+j3L7BcSTvQ7Z6CKNBZt6zrV2bINUyAPJbw8SXiIhUnMVCT5f+Wzgbm0Xpy+ED8L3d2W0WGYUlsOz9NVg1EZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016355; c=relaxed/simple;
	bh=p4XepiPlWotLLCpbltRXA5eCLxtJn/9N8T34r+FpzmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHKZctMBfbbsjUPdHdX9EDF5wNDgiknzviHD7RT4wDGJFNdybUF/xvy8dSHx4NQWfx3MUKTdYMf+VzFfstH/GBju0w1lq+m9RaFiH1Ud5Fm1Fg2dIjxAS/V3Cze+ZLvH4qj/s1yBbVUGXvRklue7iX5X+HKBFruDB9PHuL3RKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IplPLXIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301A6C4CED2;
	Thu,  7 Nov 2024 21:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731016354;
	bh=p4XepiPlWotLLCpbltRXA5eCLxtJn/9N8T34r+FpzmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IplPLXIAkoGRbVp0WqClSi7wzLJybTD1WZvkCKK+N0pQMscqteCyK08P5A7u8ICQv
	 uSDfpNqYhkPVpa2UpHYH5MUSzLK0nHnLRlw9Y/l0FWSxX7Iv973zyA0sGMpT7w2svW
	 RQuI8VXnstH/Vuchbc5lcFUwCC8CLOHRYI7Wc+aBVs0vZE+ADtpo9cH0MCMeng0sU3
	 M78SoXhyaUU7K/+JUOyfDAjw7vAA4LNUtGsG/QBt2iY499Ea6ISZkXpnnUhFptSs0m
	 KimAJ5AHDB8rBBfyvveaPF6IjoAADigdyT4LzNTVE4/Civ20ip+UvtQkDL17zNRfwT
	 e6hgqSFZqdx+w==
Date: Thu, 7 Nov 2024 13:52:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hyunwoo Kim <v4bel@theori.io>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent
 a dangling pointer
Message-ID: <20241107135233.225de6d6@kernel.org>
In-Reply-To: <20241107163942-mutt-send-email-mst@kernel.org>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
	<20241107112942.0921eb65@kernel.org>
	<20241107163942-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 16:41:02 -0500 Michael S. Tsirkin wrote:
> On Thu, Nov 07, 2024 at 11:29:42AM -0800, Jakub Kicinski wrote:
> > On Wed, 6 Nov 2024 04:36:04 -0500 Hyunwoo Kim wrote:  
> > > When hvs is released, there is a possibility that vsk->trans may not
> > > be initialized to NULL, which could lead to a dangling pointer.
> > > This issue is resolved by initializing vsk->trans to NULL.
> > > 
> > > Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> > > Cc: stable@vger.kernel.org  
> > 
> > I don't see the v1 on netdev@, nor a link to it in the change log
> > so I may be missing the context, but the commit message is a bit
> > sparse.
> > 
> > The stable and Fixes tags indicate this is a fix. But the commit
> > message reads like currently no such crash is observed, quote:
> > 
> >                           which could lead to a dangling pointer.
> >                                 ^^^^^
> >                                      ?
> > 
> > Could someone clarify?  
> 
> I think it's just an accent, in certain languages/cultures expressing
> uncertainty is considered polite. Should be "can".

You're probably right, the issue perhaps isn't the phrasing as much 
as the lack of pointing out the code path in which the dangling pointer
would be deferenced.  Hyunwoo Kim, can you provide one?

