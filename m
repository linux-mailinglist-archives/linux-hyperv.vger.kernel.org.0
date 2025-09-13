Return-Path: <linux-hyperv+bounces-6855-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71FCB5613F
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Sep 2025 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F4C7A4EE6
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Sep 2025 13:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357A22ECEB9;
	Sat, 13 Sep 2025 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zx6w/wak"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A623283FC4;
	Sat, 13 Sep 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757771272; cv=none; b=k8cyMumVW4I1nRuOTm3xXjUM/0mCmpVDr7q1iYXvTar8QXk3CQEVGCd+pqYaDOjrEWyXC+1IoSANURknzEbV/S6O1Dp+vRIVJZRzWL98Wxb0Lep5MbrwELdo+jiOrR26fzB/yIqlgIBRKXVKBIOaC1OWEE6JMncFrYbfWe7SN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757771272; c=relaxed/simple;
	bh=UZ1FFYDAeyzL3fNFGkn2S5wdPo1eKK0Z4qYLy68oj7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awz+XzaGRgVV98oUR0O8VqHm//Z5A4k8SMBOWscMais2+kRr1eOfCSwyAM1XDnZGBy4MjiqKooXJwp7Z8fVwlyx5GZ3k5Bjfv8WxDoTBAGd+/nY+wPP5IV/Plt16rdHUSszLHYcWFrBrM8QpGDvIwdIQpMcQMBpy2jggLDLreE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zx6w/wak; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OgE8sh8Nl8Fom30U4y6FEEnUsfW7+fGifiRiLj1bT5M=; b=zx6w/wakWP9gzD8miF9IP8dv88
	n41j/awfWO4z/uL74iYw5DEO3KMvn78vzYYlS3is3/mqW7UAohpTHqRTkEy91A/wfRXbGV1ReeDr5
	zQ8torMtWqq7p/kl+xqcQjq6P5iJm4xl17IZLcY7+YGXIjaVii9ssFfgeJTcHE1G41fU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxQbL-008Ij6-37; Sat, 13 Sep 2025 15:47:39 +0200
Date: Sat, 13 Sep 2025 15:47:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH net] net/mlx5: report duplex full when speed is known
Message-ID: <bacbeaf2-104f-4da5-a66b-b8aee2b2de12@lunn.ch>
References: <20250913062810.11141-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913062810.11141-1-litian@redhat.com>

On Sat, Sep 13, 2025 at 02:28:10PM +0800, Li Tian wrote:
> Prior commit in Fixes, duplex is always reported full as long
> as the speed is known. Restore this behavior. Besides, modern
> Mellanox doesn't seem to care about half duplex. This change
> mitigates duplex unknown issue on Azure Mellanox 5.
> 
> Fixes: c268ca6087f55 ("net/mlx5: Expose port speed when possible")

I'm confused with your commit message. You say DUPLEX used to be
reported as Full if the speed is known. How does c268ca6087f55 change
this? You don't say in the commit message. Why is Half duplex
important to this fix? I don't see Half anywhere in the code.

Also, what sort of problems do you see with duplex unknown? When
somebody has a problem and is looking to find a patch which might fix
it, seeing a description of the problem fixed in the commit message is
useful.

	Andrew

