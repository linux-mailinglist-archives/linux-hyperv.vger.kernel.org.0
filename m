Return-Path: <linux-hyperv+bounces-1968-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507F28A57FF
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 18:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0309B25236
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5011C8289A;
	Mon, 15 Apr 2024 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IGdTDLf6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D0182485;
	Mon, 15 Apr 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199121; cv=none; b=J3bxOEvG5/v+oVB8S5upB+VxY0VsruVlVGfNNldSCcv85oE5sgKDtXqfCCzNswKuoJmRpSqTEj5s1uERvrjRtOBmG67rIwqcV+jEmkRwPs6BA/l2XFIWBcSM3Mkv7+7SOauzcv0og1OLHeCVhPN2C5ICocEr85UAiUIXH1fjseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199121; c=relaxed/simple;
	bh=Iu3sKE+YRCqwKdiAB3om3hv5zVJb0LpbWJ23pVnz8Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrBHxxGrvGPl277AJG5SuJlgmm99YKP0yUAifKdIUJ8RmLE4z8yYARfzl1NjspbH+tr1PVgEXckSL1Pyty8Wh+8HyilUuq2SpIwMpejQBu3ofwghyfHNoMzcDWAl4921cgswsY4LOtDu4AB9bOkJa7CENYRDCGIZ3olUDLaxShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IGdTDLf6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id CFF9E20FC5F5; Mon, 15 Apr 2024 09:38:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFF9E20FC5F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713199112;
	bh=LhdsE6efodYH8GQvxcpPZhNnPBH3tY5kGI4QxFJUD7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGdTDLf6NwimYdoARfgYLzKymBbs2nS+TCIfTqZBb1p/2QYvV1Jy2p9AcHrIVGbyx
	 wWNZ/6STv4qrFKgJ8h9jsk3naDFVR9zZ+6BOndDZ0reksraiMZRhJMSdbWw5C5xs+i
	 1qVsQkuqaNM6aI3DB4RwYnFb9zlWr/lKUQLRGxbg=
Date: Mon, 15 Apr 2024 09:38:32 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
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
Message-ID: <20240415163832.GA28558@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 15, 2024 at 02:49:49AM -0700, Shradha Gupta wrote:
> Add new device attributes to view multiport, msix, and adapter MTU
> setting for MANA device.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 74 +++++++++++++++++++
>  include/net/mana/gdma.h                       |  9 +++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 1332db9a08eb..6674a02cff06 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1471,6 +1471,65 @@ static bool mana_is_pf(unsigned short dev_id)
>  	return dev_id == MANA_PF_DEVICE_ID;
>  }
>  
> +static ssize_t mana_attr_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	struct mana_context *ac = gc->mana.driver_data;
> +
> +	if (strcmp(attr->attr.name, "mport") == 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
> +	else if (strcmp(attr->attr.name, "adapter_mtu") == 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
> +	else if (strcmp(attr->attr.name, "msix") == 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
> +	else
> +		return -EINVAL;
> +}
> +
> +static int mana_gd_setup_sysfs(struct pci_dev *pdev)
> +{
> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	int retval = 0;
> +
> +	gc->mana_attributes.mana_mport_attr.attr.name = "mport";
> +	gc->mana_attributes.mana_mport_attr.attr.mode = 0444;
> +	gc->mana_attributes.mana_mport_attr.show = mana_attr_show;
> +	sysfs_attr_init(&gc->mana_attributes.mana_mport_attr);
> +	retval = device_create_file(&pdev->dev,
> +				    &gc->mana_attributes.mana_mport_attr);

if you can use .dev_groups, sysfs creation and removal will be lot more
simplified for the driver.

- Saurabh

