Return-Path: <linux-hyperv+bounces-2151-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0138C7B00
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 May 2024 19:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E27A1F21F36
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 May 2024 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC9215572D;
	Thu, 16 May 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nrZipxZp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9711429E;
	Thu, 16 May 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879944; cv=none; b=liHEzB3IOLoEJb8ICbYt4uDBOhO6o21ZwC2+sOAoHJNfnm7pnLIO5UEjIjWdnOtJLkS6eWBsGBXROyM8lAZ6efD6FVVFKXd+0iG0QGjcWEiBVtIR4W90eUPic3Yc9aHJPv/ChL/4ek1mT83bXjWxHqwwx3rfWfcExyKZqenAOiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879944; c=relaxed/simple;
	bh=MvMJ500IcUju/J5qbNPK3z8cC6mXwc3HjbRxf8hRgco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz0/XYpu08UwnKZCJ8Z/2ioj1rQLP3SPvE4e1S+2mFnlsF74PKEsJWcZeEDpqipjcTgRAwWf41ODHPQqd+apRTRcMq2k5Uz8uoBgBRT2hpPIij3q4sx00muzb7k6jswyTObwMVRqx2mWpmMUfrYs1PGh/kguKllqXB7+esOihTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nrZipxZp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xxQYQK2/Vh6beHOFwpkTAc40DkWP8JdY+uh5YwSLWrQ=; b=nrZipxZp3XsCImZTe22oaTOTPr
	4vihGnamFREThHGpVWBMw5lG8IAMgZg0g4WnuFvxKTfRwXk5mJFkCleLY9nOHM11FHahkUvj5Nsx5
	9R9h2FQc2Qm1uQJiO4PDaxB73rrhHWh3lx3os2mMunSO7oDMaiYnH7bPbxlwbadAGd5Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7ekZ-00FWeX-Bd; Thu, 16 May 2024 19:18:39 +0200
Date: Thu, 16 May 2024 19:18:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	yury.norov@gmail.com, leon@kernel.org, cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: mana: Fix the extra HZ in mana_hwc_send_request
Message-ID: <d9a7f46e-1e57-4c66-8e47-dfdd696f8f43@lunn.ch>
References: <1715875538-21499-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715875538-21499-1-git-send-email-schakrabarti@linux.microsoft.com>

On Thu, May 16, 2024 at 09:05:38AM -0700, Souradeep Chakrabarti wrote:
> Commit 62c1bff593b7 added an extra HZ along with msecs_to_jiffies.
> This patch fixes that.
> 
> Cc: stable@vger.kernel.org
> Fixes: 62c1bff593b7 ("net: mana: Configure hwc timeout from hardware")
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

Please set the Subject line to [PATCH net] to indicate which tree this
applies to.

	Andrew

