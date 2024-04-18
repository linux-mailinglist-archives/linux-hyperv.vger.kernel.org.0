Return-Path: <linux-hyperv+bounces-1991-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A318A92B9
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 08:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1F281E70
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 06:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618585FB8F;
	Thu, 18 Apr 2024 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J+FfVYQX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CB08C11;
	Thu, 18 Apr 2024 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420071; cv=none; b=Vln4CsLuECryTTXj+lCMb+6uKZx6RCE2BuU5mcFB7KtJHb9bcXPiBAvqPTIAZkuGSFnObZrY2HUAMD0ghI2FPbWp8cC5KtV1+11hYaJpiQqXgTTQWvABsAggOp2yw6oRL5KC9KBeww+EyQiXfYA34hhK4dYr+FHJkH7hlj+tj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420071; c=relaxed/simple;
	bh=wnxrM0SyZ5InG/utr8nH+FRU5SD2JuTpuZTi5wktvRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMKL4NpWXqY8UW0oPdxYlT2d8xAxELShh+BhOos8O/aKUOJbU53wc7sLR4WGZa4BXC1ooXspnrS2wRJaDGMugXQt5i5IxYVZzRLMSLQYrQ782VkFC3P7aslnaohZ+Phgrjhovp8TlM+mcRGtciReJkUHmsIrATm8oRp2yqYQXEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J+FfVYQX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id B365320FD4DC; Wed, 17 Apr 2024 23:01:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B365320FD4DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713420068;
	bh=YKgl5iX1KfOMktLT9SvYfyg3kkZRGtrAtWjdU53tHMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+FfVYQXqbM55TRugVunoZ8T8LxT+WPKcNjCZOoBaciWIWzP8nYHIjxevlR1GBCYz
	 lVspw0/oQFz7knVEGFm0ZB5Vbyig47AuQVuKemfJXJpyFtqRbIXO+01XPz/LleBmrB
	 pBicAD3JrmjO1130q7R3YCJozlKKNIbbeZSaRevU=
Date: Wed, 17 Apr 2024 23:01:08 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
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
Message-ID: <20240418060108.GB13182@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415161305.GO223006@ziepe.ca>
 <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>
 <b34bfb11-98a3-4418-b482-14f2e50745d3@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34bfb11-98a3-4418-b482-14f2e50745d3@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Apr 16, 2024 at 08:09:35PM +0200, Andrew Lunn wrote:
> On Tue, Apr 16, 2024 at 06:27:04AM +0200, Zhu Yanjun wrote:
> > ??? 2024/4/15 18:13, Jason Gunthorpe ??????:
> > > On Mon, Apr 15, 2024 at 02:49:49AM -0700, Shradha Gupta wrote:
> > > > Add new device attributes to view multiport, msix, and adapter MTU
> > > > setting for MANA device.
> > > > 
> > > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > > ---
> > > >   .../net/ethernet/microsoft/mana/gdma_main.c   | 74 +++++++++++++++++++
> > > >   include/net/mana/gdma.h                       |  9 +++
> > > >   2 files changed, 83 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > index 1332db9a08eb..6674a02cff06 100644
> > > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > @@ -1471,6 +1471,65 @@ static bool mana_is_pf(unsigned short dev_id)
> > > >   	return dev_id == MANA_PF_DEVICE_ID;
> > > >   }
> > > > +static ssize_t mana_attr_show(struct device *dev,
> > > > +			      struct device_attribute *attr, char *buf)
> > > > +{
> > > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > > +	struct gdma_context *gc = pci_get_drvdata(pdev);
> > > > +	struct mana_context *ac = gc->mana.driver_data;
> > > > +
> > > > +	if (strcmp(attr->attr.name, "mport") == 0)
> > > > +		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
> > > > +	else if (strcmp(attr->attr.name, "adapter_mtu") == 0)
> > > > +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
> > > > +	else if (strcmp(attr->attr.name, "msix") == 0)
> > > > +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
> > > > +	else
> > > > +		return -EINVAL;
> > > > +
> > > 
> > > That is not how sysfs should be implemented at all, please find a
> > > good example to copy from. Every attribute should use its own function
> > > with the macros to link it into an attributes group and sysfs_emit
> > > should be used for printing
> > 
> > Not sure if this file drivers/infiniband/hw/usnic/usnic_ib_sysfs.c is a good
> > example or not.
> 
> The first question should be, what are these values used for? You can
> then decide on debugfs or sysfs. debugfs is easier to use, and you
> avoid any ABI, which will make long term support easier.

Hi Andrew,
We want to eventually use these attributes to make the device settings configurable
and also improve debuggability for MANA devices. I feel having these attributes 
in sysfs would make more sense as we plan to extend the attribute list and also make
them settable.

Regards,
Shradha.
> 
>       Andrew

