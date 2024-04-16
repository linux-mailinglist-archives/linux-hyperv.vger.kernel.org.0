Return-Path: <linux-hyperv+bounces-1972-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887258A6259
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Apr 2024 06:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD621F24056
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Apr 2024 04:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B521101;
	Tue, 16 Apr 2024 04:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CeQrwFtP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F85420B0E;
	Tue, 16 Apr 2024 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713241527; cv=none; b=qNZg5bWQHbfY17J46v+xsm9JNG/zGGu0mIOMASVC6YtG3jCMntyS8JRC8y4U17ks3R1YtePYBflRbDIomn503i+ZMqo7CiPGBtp/y7E69e5aLmZQ/GgdGZ5L2gZzNvwGfcE+tet6Gr3gvo2kLEes6LkP8XbIwZEh9O7wPx2HaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713241527; c=relaxed/simple;
	bh=dLKuEx3zS6xD3HOWu8wyg2W7hIiC28htgpdfpLYs9IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHYkNltP1gtrld+krOe3SFaaImyUEGz0/toID4j7aQYZuo4pWUf0awjXA0lnhIvD2swmRTx8MX9650DlrKHXp5DSRV5LQQhNkXY3Cniyufsed0SCRZt572XHhfDNWtHRZvFJuU6mue0XtXaVUKr3mK3n8uTzZNlVczcA6G0G/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CeQrwFtP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id EEDDF20FD43F; Mon, 15 Apr 2024 21:25:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEDDF20FD43F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713241525;
	bh=ogpyOHNHkyZwnpq6dIwauvYSTq02i3af+QgdMRMGFrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeQrwFtPIrMI1svwcbTGL4cUAUqpYv6uEHp4pP1EqCIynzeYP8zAmTG/WSVDJNYcb
	 Xb+xMLdqR5YXhG8tIHZPO1CWnPIjJcztbqZmM9lJfukqwDfjbSEpl6GUEMt8U1+eUQ
	 SYbflB8VYkyYF8PXVSwTr2TEDlYR5o7uMljDc4d4=
Date: Mon, 15 Apr 2024 21:25:25 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
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
Message-ID: <20240416042525.GA23796@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415161305.GO223006@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415161305.GO223006@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 15, 2024 at 01:13:05PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 15, 2024 at 02:49:49AM -0700, Shradha Gupta wrote:
> > Add new device attributes to view multiport, msix, and adapter MTU
> > setting for MANA device.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 74 +++++++++++++++++++
> >  include/net/mana/gdma.h                       |  9 +++
> >  2 files changed, 83 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 1332db9a08eb..6674a02cff06 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -1471,6 +1471,65 @@ static bool mana_is_pf(unsigned short dev_id)
> >  	return dev_id == MANA_PF_DEVICE_ID;
> >  }
> >  
> > +static ssize_t mana_attr_show(struct device *dev,
> > +			      struct device_attribute *attr, char *buf)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct gdma_context *gc = pci_get_drvdata(pdev);
> > +	struct mana_context *ac = gc->mana.driver_data;
> > +
> > +	if (strcmp(attr->attr.name, "mport") == 0)
> > +		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
> > +	else if (strcmp(attr->attr.name, "adapter_mtu") == 0)
> > +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
> > +	else if (strcmp(attr->attr.name, "msix") == 0)
> > +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
> > +	else
> > +		return -EINVAL;
> > +
> 
> That is not how sysfs should be implemented at all, please find a
> good example to copy from. Every attribute should use its own function
> with the macros to link it into an attributes group and sysfs_emit
> should be used for printing
> 
> Jason
Thanks Jason, I will make the appropriate changes in the next version.

Regards,
Shradha.

