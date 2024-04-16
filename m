Return-Path: <linux-hyperv+bounces-1973-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA508A625E
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Apr 2024 06:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1D91C22753
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Apr 2024 04:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330A2232B;
	Tue, 16 Apr 2024 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V3ldUmg/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC412E4A;
	Tue, 16 Apr 2024 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713241590; cv=none; b=q+WJjKwLQ/Vmq34PDfCck0nYiNig5sp6qxlfzmsVvrwDs6Ni7KOxWMs3rqab87QKPe4rn/dZ3EOEiBW0F5O4DlGKvJ9+TExxtio6/0cJOSoCHfp5npWkQ4tpsLZbbCO109UYzFVVJ86rLGFaXQIXg00IwXqN3In8+siLzphGhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713241590; c=relaxed/simple;
	bh=Uj0gFPfjsB2Tq2LAWvfr3cF4Y/TLhu3QH0kOZFuDSqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUK6LRzjW7zQJ3+SaYlrmwC/goPWcE2NqcY4YfhGxugvJ532yHriMfPp5Iywp8BcUfYPLsJ48tUq4aCugd3t/bzb6EtDphM0Uhprz6DJwWX3UMQPwz5UlZlUN3m7v8r9g4cEc0w7PYoLMSMEyF4xgf/e4dgz6gnysbV0KTmU+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V3ldUmg/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 7AD2720FD43F; Mon, 15 Apr 2024 21:26:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AD2720FD43F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713241588;
	bh=cOu5HWHBwCqrmONXnl7imph0X4Y1AlmhpI1Ft1o6Eyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3ldUmg/vGihpgVLBoKOAO375ywqF4nV/NoOBRPYC1a4aBxCcURKsg6S8vB2QdaIE
	 lvMHdXUCBAcGQNBceeHVZnk9MuK4dDlif73OAt+tLB75AbXzDca1T1N6r+ClSAvvSG
	 OVzdzGzFfO+Q86PSQUNPDT0RBGYhgz4ssto3uUl4=
Date: Mon, 15 Apr 2024 21:26:28 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
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
Message-ID: <20240416042628.GB23796@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415163832.GA28558@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415163832.GA28558@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 15, 2024 at 09:38:32AM -0700, Saurabh Singh Sengar wrote:
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
> > +}
> > +
> > +static int mana_gd_setup_sysfs(struct pci_dev *pdev)
> > +{
> > +	struct gdma_context *gc = pci_get_drvdata(pdev);
> > +	int retval = 0;
> > +
> > +	gc->mana_attributes.mana_mport_attr.attr.name = "mport";
> > +	gc->mana_attributes.mana_mport_attr.attr.mode = 0444;
> > +	gc->mana_attributes.mana_mport_attr.show = mana_attr_show;
> > +	sysfs_attr_init(&gc->mana_attributes.mana_mport_attr);
> > +	retval = device_create_file(&pdev->dev,
> > +				    &gc->mana_attributes.mana_mport_attr);
> 
> if you can use .dev_groups, sysfs creation and removal will be lot more
> simplified for the driver.
Sure Saurabh, I think we can do this too.
> 
> - Saurabh

