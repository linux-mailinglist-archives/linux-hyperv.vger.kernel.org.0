Return-Path: <linux-hyperv+bounces-6860-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732AB56486
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Sep 2025 05:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3337189EC7B
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Sep 2025 03:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0FD262FC1;
	Sun, 14 Sep 2025 03:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w7rq9zwc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8C25EFBE;
	Sun, 14 Sep 2025 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821321; cv=none; b=uCplBBz8yzQAY+MraTBhgHldcPkZifVpH01dS9fOLXmeU8v9QslG3jIZfRWa0F6HEqdN4in1gL+Oa2cdOJ+A8y1knu84li0q9e/PGHDP5NpuITenpqi6uAfsvUchf/vuCb/ui49179HBm6ugHVtPiSulvTVJKUmpYRv5s9RJ08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821321; c=relaxed/simple;
	bh=bLKPANPGdu1NN3tYrg8eI0rcB/7FXnwOVSEky0033qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDn3CdDFNGe5Q79UwH6/qJ3t+s7Lg5VylXZThYAnrxDF0RRbdkAPiJAnIqYWuTgFrfwW78T9MLS/oPPZqayp/j9HKKQkTMzGw0D16zJLZWwyST8xtkUlvR65k0yYWfz2oX5LN3mZ53dA8rNW61CV0um5MEM3lIs0fBeTj5QD5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w7rq9zwc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=VjfehcYYvXQlpKjB4VJgwUpvWXsLk8CfYuq+im6XMTw=; b=w7
	rq9zwcQmOESpTGPGW4yVfxmTklvLYsabfMPKniFaPyW/AXDgXD9QlptGbc1qIhSpUmN2Gdswzx4Zt
	r5Grmfp72NVTEckPHSwo9Mt3rMbo4xVQmu61pBhx7L9G56SOzoNPIIfO9Z7YMc49fo6NEDVgpJNT8
	9+uS2WtN4EFU+zg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxdN7-008Kcb-CQ; Sun, 14 Sep 2025 05:25:49 +0200
Date: Sun, 14 Sep 2025 05:25:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH net] net/mlx5: report duplex full when speed is known
Message-ID: <9c685b29-ccb9-4b40-94bc-819c5871dac8@lunn.ch>
References: <20250913062810.11141-1-litian@redhat.com>
 <bacbeaf2-104f-4da5-a66b-b8aee2b2de12@lunn.ch>
 <CAHhBTWvcd45s5P-TfKBVzHy00jofbgoWtX+z3Uaj+5ZEBTNLfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhBTWvcd45s5P-TfKBVzHy00jofbgoWtX+z3Uaj+5ZEBTNLfQ@mail.gmail.com>

On Sun, Sep 14, 2025 at 10:22:35AM +0800, Li Tian wrote:
> On Sat, Sep 13, 2025 at 10:12 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > I'm confused with your commit message. You say DUPLEX used to be
> > reported as Full if the speed is known. How does c268ca6087f55 change
> > this?
> 
> Because in some circumstances like Azure, mlx5e_port_ptys2speed (now
> mlx5_port_ptys2info) does not return a speed.

So it can have link up without a speed? Speed is returned unknown? But
Azure is virtual? So both speed and duplex are both meaningless? There
is no physical communication medium. So unknown is reasonable.

> It does not return half duplex at all. It would be unknown. I'm just
> saying that half duplex shouldn't exist in modern Mellanox 5.

And that is relevant because?

> > Also, what sort of problems do you see with duplex unknown?
> 
> There were reports of RHEL seeing duplex unknown in ethtool
> on Azure Mellanox 5. The intention is to fix this.

Just reports of ethtool returning unknown? But nothing actually
broken?

	Andrew

