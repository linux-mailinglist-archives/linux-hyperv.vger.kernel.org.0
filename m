Return-Path: <linux-hyperv+bounces-1975-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07408A72D6
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Apr 2024 20:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05901C21885
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Apr 2024 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FE6134425;
	Tue, 16 Apr 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QeyODSL4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F9134429;
	Tue, 16 Apr 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290985; cv=none; b=nvn2dtFsHSV5Y+RkRYErgH6VY9nMECe0D27rptc99p6FGSJesYfebf/cL5dVoRFuaEoLaju+liq9vYVZeVvsaUb7ftCLLmpZzkVk7R3CDezh7oVMSQfTrbgxK5wbUl8hDn64QTR6SnwJSOnE3z1VQ4O9wraG0mBqIjnCWfvNTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290985; c=relaxed/simple;
	bh=N4C2FjdiqPsdy0C9kaCE8/PgntEeBxpWzcAr3NeY9aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez0kvxrDA3lV8TKlCPmQkb5FuDRkJnjXOf0vREw9fqbIHRYn/rbYU/mIoI+Lawji0uo1rqWXe4RpDLhQaBX8zy06R1L2MGU9OgfwefmKHPgy+6U9muFD1Ur+LZgFmorGsZIlG0+1KtPDkssYrBcK5ZGa0oQTOb9I6v+Kdctrj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QeyODSL4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=TXomqugHQL46au9N8uw64oQNOo/r6UX6m/Q4x5PGJ/s=; b=Qe
	yODSL4fDFv1MzBJSrO1z8zZKmNc73pmcIo2Y/X2bUlc0REHNbm32Y+FukB9CDnKVU3YceRNG4ohs/
	+EwRYyI6BHmc5MiGJxj0ROQQ194dkGh8nChvnOeB9LWjDnvUJ9OjcEHN2928IhGbX7jisHyBuyoqd
	sQq2Yfra6x8SjD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwnFP-00DAOS-No; Tue, 16 Apr 2024 20:09:35 +0200
Date: Tue, 16 Apr 2024 20:09:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
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
Message-ID: <b34bfb11-98a3-4418-b482-14f2e50745d3@lunn.ch>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415161305.GO223006@ziepe.ca>
 <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>

On Tue, Apr 16, 2024 at 06:27:04AM +0200, Zhu Yanjun wrote:
> 在 2024/4/15 18:13, Jason Gunthorpe 写道:
> > On Mon, Apr 15, 2024 at 02:49:49AM -0700, Shradha Gupta wrote:
> > > Add new device attributes to view multiport, msix, and adapter MTU
> > > setting for MANA device.
> > > 
> > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > ---
> > >   .../net/ethernet/microsoft/mana/gdma_main.c   | 74 +++++++++++++++++++
> > >   include/net/mana/gdma.h                       |  9 +++
> > >   2 files changed, 83 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > index 1332db9a08eb..6674a02cff06 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > @@ -1471,6 +1471,65 @@ static bool mana_is_pf(unsigned short dev_id)
> > >   	return dev_id == MANA_PF_DEVICE_ID;
> > >   }
> > > +static ssize_t mana_attr_show(struct device *dev,
> > > +			      struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	struct gdma_context *gc = pci_get_drvdata(pdev);
> > > +	struct mana_context *ac = gc->mana.driver_data;
> > > +
> > > +	if (strcmp(attr->attr.name, "mport") == 0)
> > > +		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
> > > +	else if (strcmp(attr->attr.name, "adapter_mtu") == 0)
> > > +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
> > > +	else if (strcmp(attr->attr.name, "msix") == 0)
> > > +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
> > > +	else
> > > +		return -EINVAL;
> > > +
> > 
> > That is not how sysfs should be implemented at all, please find a
> > good example to copy from. Every attribute should use its own function
> > with the macros to link it into an attributes group and sysfs_emit
> > should be used for printing
> 
> Not sure if this file drivers/infiniband/hw/usnic/usnic_ib_sysfs.c is a good
> example or not.

The first question should be, what are these values used for? You can
then decide on debugfs or sysfs. debugfs is easier to use, and you
avoid any ABI, which will make long term support easier.

      Andrew

