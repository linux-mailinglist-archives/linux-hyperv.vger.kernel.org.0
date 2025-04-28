Return-Path: <linux-hyperv+bounces-5189-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BC6A9E6DB
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 06:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F6217039A
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 04:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198518DB0A;
	Mon, 28 Apr 2025 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eR9kE+gI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53473451;
	Mon, 28 Apr 2025 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745812921; cv=none; b=AJ0w29uLJO1bU/wwRzfK5GvLpYIgqCgeuLararfAxPhOEkaxN9VLWVcL2nkNcXelIYqsiO8hOJGJI6a86/g2VcyRmHn97SCEerce0pN/oqFbqOUawmQz9jDIjc9yWneqaZxC3KJR3wdEnX0GTkLyZS/N4QQl/plavj00gHJaZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745812921; c=relaxed/simple;
	bh=vjZ+IeCUxWIkl98nDUqWCFXomJ+Lt4Nn3F+vyW0cKns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiKI3hJMraz5Cm/gVkA8DMv+8DHVRxW1Wt8g69RDmDBxrk8rNZ4xuJkyvzg71h1YlEWrNWHasptO2I+eiYNUNV3tUDvecA6dbQgEiEsDpbqdHRvvweTTNsWtiU7cf3q+MBY7z6vcYwYym7jLs+fJ/Zg1MRp1p+cPc8diX2uSXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eR9kE+gI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 6B0DB204E7CD; Sun, 27 Apr 2025 21:01:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B0DB204E7CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745812913;
	bh=6ORYRjCLYBvY4FGKbLG0z5vkiNwL4q972XjmwAdxSnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eR9kE+gIj5DPlSl9DePllal/B67VdYVxiMn9aHFgZQ2dDK9PlV3/nNgiCTN2k+6ym
	 8ZVoKuBRomobidrEPCqh7QeAEmjTTThPmDcAJj4tHUL21LUFFc+5Wy9enH3xw63EnT
	 gWvs6MxQFyPEDn6CKZmwga4Kp/7+O7gsunYlEY/4=
Date: Sun, 27 Apr 2025 21:01:53 -0700
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
	Krzysztof Wilczy??ski <kw@linux.com>,
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
Subject: Re: [PATCH v2 3/3] net: mana: Allocate MSI-X vectors dynamically as
 required
Message-ID: <20250428040153.GA15037@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250425093556.30104eda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425093556.30104eda@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Apr 25, 2025 at 09:35:56AM -0700, Jakub Kicinski wrote:
> On Fri, 25 Apr 2025 03:54:38 -0700 Shradha Gupta wrote:
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> > +	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> 
> Could you please test your submissions on a kernel with debug options
> enabled? Thank you!
> -- 
> pw-bot: cr

Thank you Jakub. Will send out a newer version with this change.
Also, would make sure to build with debug options enabled for subsequent
submissions.

Regards,
Shradha.

