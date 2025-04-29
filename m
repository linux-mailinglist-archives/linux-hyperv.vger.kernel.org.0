Return-Path: <linux-hyperv+bounces-5216-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADCBAA0603
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Apr 2025 10:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE324A0664
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Apr 2025 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6AF28D850;
	Tue, 29 Apr 2025 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DfMUzp7s"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB21322422F;
	Tue, 29 Apr 2025 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916222; cv=none; b=gOP8YY1SE/UK2N90UBUiwQJ1nMdlAuz5/w3sme4YHjE8dBru8ObDuIBL36W5CZDDj/Z+VaTLKkwPaX04rYgC5VUI3yaVFFjkEvDQiM41dOeWbqW82dodeEeRZQlzaxJrqxf0Zmeoxgs+XMg88P6rZhsRpY1uEWWu0Gp8fvfYuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916222; c=relaxed/simple;
	bh=gt9yqUMAyVr3pWh2vCa1j58/QxEYy6y71QRDSOzfzsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAPlccNHFTJ+aSSz3hq9oVnjsgXWEaxgzkfZ1LGOqwhdIOQQ0yGELWeV1siEumxRZLafX4a97DdDfrZvi9K5aUtJzDZZunQOTPPyaKeWETkqYUSQSmU16vVfxirCMsXUn2sJKKkaFcISZ8KGe0O3F/40fXNHLPXEFdll+UQ/9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DfMUzp7s; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 1967920BCAD1; Tue, 29 Apr 2025 01:43:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1967920BCAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745916214;
	bh=MLMI0YGgePRRieH5KhOgSTTxPGhA0u8+OCwx8w9CvY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DfMUzp7s2Yb7IFsfitPC0jmnzTNngOmgTbu0WzU27qJqIjE5K4rlQSVrhqBrtC6hd
	 Jqhv7WgTVOO/XMQTG3FcYuT+LGzqC2r0WJeZgdIVAYk0g+fawZ/g+ICp5WaU0pBBJk
	 YEl7ZuFlmttDh59oXrIo9omNL43JHUpxcsTXROhQ=
Date: Tue, 29 Apr 2025 01:43:34 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy??ski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2 1/3] PCI: Export pci_msix_prepare_desc() for dynamic
 MSI-X alloc
Message-ID: <20250429084334.GA10839@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250425163748.GA546623@bhelgaas>
 <87ldrkqxum.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldrkqxum.ffs@tglx>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 28, 2025 at 02:22:57PM +0200, Thomas Gleixner wrote:
> On Fri, Apr 25 2025 at 11:37, Bjorn Helgaas wrote:
> 
> Subject prefix wants to be PCI/MSI
> 
>   git log --format=oneline path/to/file
> 
> gives you a pretty decent hint
> 
> 
> 
> > On Fri, Apr 25, 2025 at 03:53:57AM -0700, Shradha Gupta wrote:
> >> For supporting dynamic MSI-X vector allocation by PCI controllers, enabling
> >> the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
> >> to prepare the desc is also needed.
> 
> Please write things out: ... to prepare the MSI descriptor ....
> 
> This is not twitter.
> 
> >> Export pci_msix_prepare_desc() to allow PCI controllers to support dynamic
> >> MSI-X vector allocation.
> >> 
> >> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> >> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> > Thanks for the update and for splitting this from the hv driver
> > update.  Will watch for Thomas's ack here.
> 
> Other than that:
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thank you for all the comments Thomas.
I'll be mindful of these going forward.

regards,
Shradha.

