Return-Path: <linux-hyperv+bounces-5843-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDD2AD4A70
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 07:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FFF3A5508
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 05:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB01F7904;
	Wed, 11 Jun 2025 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VHfYSWCs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E44C8CE;
	Wed, 11 Jun 2025 05:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749620028; cv=none; b=Q0HEcKQr4Wfx6SPU7B4IrvS+k4R00YSH3aaHWGAGX28ucMDZJ+7fnydqv4mgKVSJFbCy/z3rmRKQiP+G+WK+8BFX9DDD7dj6RBHndwG178rek8vkmEUyp3MYsPsuMvvj5/Ubjp6/00WWrbCC3qq9rrzM8Do6TukuogH60/WV4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749620028; c=relaxed/simple;
	bh=j2JT6w4di0suk2PM+HT3i53B4qhB+nWi353sMFqh0tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL9ESm1Nv8uT6e3lR4IbDS9jGF7BDsACBq4l8BU25skxYVzFhKwZowNidHYWVT8jA30JdUID0VlOFIkpkBEddwnFn62pK/oOnbmwp4f0TjCtaZ+65giYqZSJg5DjEGdcJchKLWDWEzOdruB6lZ0yZZ385+drLwCEt+XZjd90xI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VHfYSWCs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 690EC2078616; Tue, 10 Jun 2025 22:33:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 690EC2078616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749620025;
	bh=IVNHs60qCEhEzZwh6VrFBZy8KV9zYK8+Roq6Zu0WZlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHfYSWCsorU9YqaB3Xq/2jz7p1a/1SJboRLvQ+QggwEbS+wvMEU648MWFf/7c1Ypn
	 CJ1kA+zDkXL4PF38YB+ulc57YqFL3a8y5318y00Lnk8MD/p0oY/Egv5iAfTuGpjwhV
	 XMJAQ1UEY9kLdsWoZgISxbC/4Fxa04nmtzjxexVU=
Date: Tue, 10 Jun 2025 22:33:45 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy???~Dski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v5 0/5] Allow dyn MSI-X vector allocation of MANA
Message-ID: <20250611053345.GA25921@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749476901-27251-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250610144046.1deba9f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610144046.1deba9f3@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jun 10, 2025 at 02:40:46PM -0700, Jakub Kicinski wrote:
> On Mon,  9 Jun 2025 06:48:21 -0700 Shradha Gupta wrote:
> > Since this patchset has patches from PCI and net tree, I am not entirely
> > sure what should be the target tree. Any suggestions/recommendations on
> > the same are welcomed.
> 
> Could you put these on a branch based on v6.16-rc1 ?
> That why if someone else needs them before the next merge window
> they can pull that branch. The patches look fine to me.

Thanks Jakub. Sure I will send out an update rebasing the series to
linux-next's v6.16-rc1.

Regards,
Shradha.

