Return-Path: <linux-hyperv+bounces-1999-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BCF8AA232
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 20:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C901B283E92
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637C17335B;
	Thu, 18 Apr 2024 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2irT8uje"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD71442F4;
	Thu, 18 Apr 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465786; cv=none; b=i2Ztu5L6336v95mVbzpG9XGxVBGHwN7ROl4JDb/6zbe+J+TVmbA3JDnMDd7deF+JZJgU3605yCkpxGpxmMxoRhFS3R3kQOmImiGQKFZIDLpbnqW9A4FpyQKIxPhlWVk6rjSywH+uPAnGaILI4jWmtWWWObhHD8z/AVgg4lnaYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465786; c=relaxed/simple;
	bh=poi7sblqKuGVjBRS6baYMAH2Ecby1l888Y9D8KjJreA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0tShnfVzeM1dnvAPhD9LpiyVcPfflROaAO1z6TjG4vAvWVP6whtocBHjIlP38NfD5NfRGcgQiuucKEVGNRDpLTJNfLZTdotBO3By0rKupxdNEe10n8/hypb8A9vAo6FvwxD9YvujRoo611IHTjXAJy2+0BxFMwXR2cSzWOniHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2irT8uje; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PmXbe7fZpTi+Z5rvQSKNZY21mtNwNGVnRETWJxHS1MI=; b=2irT8ujeDLf5JzJ86o5fj7ys4K
	k3vVvftCxhwziqblLOCq3KModyyPSn97a6XgBQ3zcs09cf06U0JDXNTz0evVbfsgcob0cQTwSFhTK
	x2Z6HzyKmRJH7pwKjYZ848DPvtpabIbFp3z4HXqR5bs0BxQV9wmjp/UWUG7Y5/FUB9gw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxWip-00DNnt-1H; Thu, 18 Apr 2024 20:42:59 +0200
Date: Thu, 18 Apr 2024 20:42:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Add new device attributes for mana
Message-ID: <f3e7ea07-2903-4f19-ba86-94bba569dae9@lunn.ch>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415161305.GO223006@ziepe.ca>
 <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>
 <b34bfb11-98a3-4418-b482-14f2e50745d3@lunn.ch>
 <20240418060108.GB13182@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240418175059.GZ223006@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418175059.GZ223006@ziepe.ca>

> >From an RDMA perspective this is all available from other APIs already
> at least and I wouldn't want to see new sysfs unless there is a netdev
> justification.

It is unlikely there is a netdev justification. Configuration happens
via netlink, not sysfs.

    Andrew

