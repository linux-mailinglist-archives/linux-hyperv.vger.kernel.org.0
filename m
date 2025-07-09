Return-Path: <linux-hyperv+bounces-6168-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80089AFF553
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 01:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D825D565E4E
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 23:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F82D238C1B;
	Wed,  9 Jul 2025 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+zxMFKp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F1E55B;
	Wed,  9 Jul 2025 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752103400; cv=none; b=g+6hvgPkdjQ5v4ZvUOIps1/sYBf4kQTdvmnitWQbXIDaeqIZ4jckFIGBs1/WhoSalU1FkKiULLTPAN85ERbjzwcF9EDc3acKaq9meuhmWZfahS4CODNAxEUSFIynxwqngyqad6nl3SQELl4554+jwuuDF1gwj6I6lgTJnKSL4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752103400; c=relaxed/simple;
	bh=bCV+LA15f6mlZ/QEVHI8ShEaF8U5+pTpFavarhgTyII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJzT4m/finUse/JgGh2pcTdHnkliwgrX0SDRb8HNLZL0dIDgDPuTi/lPtj+ReKjKVlwOZi8wzQGPO3P8uLaqPOCoFNojk22tZYHrR41yBzR15HRT2WcqrSZUnF+dsadqAtoD3siRboa4DVcvF0//cfy5gYDzXm9SKVlLkEkKhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+zxMFKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9122CC4CEEF;
	Wed,  9 Jul 2025 23:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752103398;
	bh=bCV+LA15f6mlZ/QEVHI8ShEaF8U5+pTpFavarhgTyII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+zxMFKpkli/jgyFaThavQyBVDB/5UvbL7D242K2RWsPNEhL+oriRrD5Oo+PvWpdI
	 ERuh4BY6lw+zGM8xtx8wpoLxcgPZudq5njNzWtryJQtgegUUnDf05RJ3JmYwhkWguW
	 JHKZrbQ+tpAleOND4ozNXDBpQRbMdrgJDx0U4Ds9lgX/hUc228hnU9K1JEMFPBWWHo
	 XunAc+qZloL292ny0zgbrMjOWNFZ0vHSFooyM+nyXy3juF7yT1qHQ9Vnqxqkx+/mHd
	 PoL3zzXuFrSVJePfVeWGXvo03t7L/uMjtTuvQAre0zWGxsskVGE6rKHgUfo12BDyzR
	 /dXAI84cHqO9w==
Date: Wed, 9 Jul 2025 23:23:17 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Message-ID: <aG755Yx-FVKIkHzH@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-1-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-1-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:11PM +0800, Xuewei Niu wrote:
> From: Dexuan Cui <decui@microsoft.com>
> 
> When hv_sock was originally added, __vsock_stream_recvmsg() and
> vsock_stream_has_data() actually only needed to know whether there
> is any readable data or not, so hvs_stream_has_data() was written to
> return 1 or 0 for simplicity.
> 
> However, now hvs_stream_has_data() should return the readable bytes
> because vsock_data_ready() -> vsock_stream_has_data() needs to know the
> actual bytes rather than a boolean value of 1 or 0.
> 
> The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
> the readable bytes.
> 
> Let hvs_stream_has_data() return the readable bytes of the payload in
> the next host-to-guest VMBus hv_sock packet.
> 
> Note: there may be multiple incoming hv_sock packets pending in the
> VMBus channel's ringbuffer, but so far there is not a VMBus API that
> allows us to know all the readable bytes in total without reading and
> caching the payload of the multiple packets, so let's just return the
> readable bytes of the next single packet. In the future, we'll either
> add a VMBus API that allows us to know the total readable bytes without
> touching the data in the ringbuffer, or the hv_sock driver needs to
> understand the VMBus packet format and parse the packets directly.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

