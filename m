Return-Path: <linux-hyperv+bounces-9807-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF/KJtV4xWnw+QQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9807-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 19:20:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 117DC339F7D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 19:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27E030FA9BE
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057539768C;
	Thu, 26 Mar 2026 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM6w98Z1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62566325485;
	Thu, 26 Mar 2026 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548507; cv=none; b=IR40UoITLW/dRzwRMC++VUt/FkeH5MeUuuGKzuY0pkUM7YRY6WP3V1shdiAFCnxWmJt1Z73lxPY7BoeAixJ4wPycmLdecK+HaUU2R9vBU2W42D9wPLpWNn5IY7fUFOowu4km0ich+pofaQNHP6yBJ3RopXzAkCqltYjv8Tk8qm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548507; c=relaxed/simple;
	bh=0X1DCc+9Eo0RuIwrj7oY6TUZUNFxGIFKgMRZYFFzcYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=My9pSWD2zLf4WwlhMCCGLHNQ2qR3tuJ4iZdIqvEDONG/kZb6JW/nhlSu+dYoYoQgB2anb3arfgQ8AJo6oXDVWFqgXafJDiyUuNvR2iTeAoJRBndG84P4YUdHOEPfYYDsWmr9OMhzsYuHvUWwwnQ3TmXM/1j2WVsBL3ZegcceDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM6w98Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DE6C116C6;
	Thu, 26 Mar 2026 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774548507;
	bh=0X1DCc+9Eo0RuIwrj7oY6TUZUNFxGIFKgMRZYFFzcYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NM6w98Z1qWs2v5XGqBHmCWm6JxAhr8BMb8fUamV5wL+wE7MKHdSXLxwSME5ezhUbH
	 VOyIPsSXzcgwwfMsCgAvfntHYvRMCI5McoXeBkzm7PxpPr6CtwJ2j/g/tXcwFVa4Wo
	 mfwgQnoNGj3+Q2qe/VwxwVJGO8tkG/hoHlV41bfq7nPm+ifUdXZJTQQCfLoSTGkKKZ
	 GO/exOJI1I8y/8270z+FNS+HBZvuGqcXZFp+0eaxpOWl3481O7GW2mWATZewkwIy7q
	 K/JDPU1QB11yIcAtsgX6nNiKmDxqpi1JcRBv8ZiWu3lRldZ84kirC/fAvXlie0d9kJ
	 aLY5/Yv6bcogQ==
Date: Thu, 26 Mar 2026 13:08:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Armin Wolf <W_Armin@gmx.de>, Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arm-kernel@lists.infradead.org,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: Re: [PATCH 05/12] PCI: use generic driver_override infrastructure
Message-ID: <20260326180825.GA1330769@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324005919.2408620-6-dakr@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9807-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 117DC339F7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 01:59:09AM +0100, Danilo Krummrich wrote:
> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
> 
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
> 
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]
> 
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
> Fixes: 782a985d7af2 ("PCI: Introduce new device binding path using pci_dev.driver_override")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/pci/pci-driver.c           | 11 +++++++----
>  drivers/pci/pci-sysfs.c            | 28 ----------------------------
>  drivers/pci/probe.c                |  1 -
>  include/linux/pci.h                |  6 ------

For the above:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

"driver_override" is mentioned several places in
Documentation/ABI/testing/sysfs-bus-*.  I assume this series doesn't
change the behavior documented there?  Should any of this doc be
consolidated?

>  drivers/vfio/pci/vfio_pci_core.c   |  5 ++---
>  drivers/xen/xen-pciback/pci_stub.c |  6 ++++--
>  6 files changed, 13 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index dd9075403987..d10ece0889f0 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -138,9 +138,11 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
>  {
>  	struct pci_dynid *dynid;
>  	const struct pci_device_id *found_id = NULL, *ids;
> +	int ret;
>  
>  	/* When driver_override is set, only bind to the matching driver */
> -	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
> +	ret = device_match_driver_override(&dev->dev, &drv->driver);
> +	if (ret == 0)
>  		return NULL;
>  
>  	/* Look at the dynamic ids first, before the static ones */
> @@ -164,7 +166,7 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
>  		 * matching.
>  		 */
>  		if (found_id->override_only) {
> -			if (dev->driver_override)
> +			if (ret > 0)
>  				return found_id;
>  		} else {
>  			return found_id;
> @@ -172,7 +174,7 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
>  	}
>  
>  	/* driver_override will always match, send a dummy id */
> -	if (dev->driver_override)
> +	if (ret > 0)
>  		return &pci_device_id_any;
>  	return NULL;
>  }
> @@ -452,7 +454,7 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
>  {
>  	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe ||
> -		pdev->driver_override);
> +		device_has_driver_override(&pdev->dev));
>  }
>  #else
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
> @@ -1722,6 +1724,7 @@ static const struct cpumask *pci_device_irq_get_affinity(struct device *dev,
>  
>  const struct bus_type pci_bus_type = {
>  	.name		= "pci",
> +	.driver_override = true,
>  	.match		= pci_bus_match,
>  	.uevent		= pci_uevent,
>  	.probe		= pci_device_probe,
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 16eaaf749ba9..a9006cf4e9c8 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -615,33 +615,6 @@ static ssize_t devspec_show(struct device *dev,
>  static DEVICE_ATTR_RO(devspec);
>  #endif
>  
> -static ssize_t driver_override_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t count)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	int ret;
> -
> -	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
> -	if (ret)
> -		return ret;
> -
> -	return count;
> -}
> -
> -static ssize_t driver_override_show(struct device *dev,
> -				    struct device_attribute *attr, char *buf)
> -{
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	ssize_t len;
> -
> -	device_lock(dev);
> -	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
> -	device_unlock(dev);
> -	return len;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>  static struct attribute *pci_dev_attrs[] = {
>  	&dev_attr_power_state.attr,
>  	&dev_attr_resource.attr,
> @@ -669,7 +642,6 @@ static struct attribute *pci_dev_attrs[] = {
>  #ifdef CONFIG_OF
>  	&dev_attr_devspec.attr,
>  #endif
> -	&dev_attr_driver_override.attr,
>  	&dev_attr_ari_enabled.attr,
>  	NULL,
>  };
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd79..b4707640e102 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2488,7 +2488,6 @@ static void pci_release_dev(struct device *dev)
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
>  	pci_bus_put(pci_dev->bus);
> -	kfree(pci_dev->driver_override);
>  	bitmap_free(pci_dev->dma_alias_mask);
>  	dev_dbg(dev, "device released\n");
>  	kfree(pci_dev);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index d43745fe4c84..460852f79f29 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifier_block *nb,
>  	    pdev->is_virtfn && physfn == vdev->pdev) {
>  		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
>  			 pci_name(pdev));
> -		pdev->driver_override = kasprintf(GFP_KERNEL, "%s",
> -						  vdev->vdev.ops->name);
> -		WARN_ON(!pdev->driver_override);
> +		WARN_ON(device_set_driver_override(&pdev->dev,
> +						   vdev->vdev.ops->name));
>  	} else if (action == BUS_NOTIFY_BOUND_DRIVER &&
>  		   pdev->is_virtfn && physfn == vdev->pdev) {
>  		struct pci_driver *drv = pci_dev_driver(pdev);
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index e4b27aecbf05..79a2b5dfd694 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -598,6 +598,8 @@ static int pcistub_seize(struct pci_dev *dev,
>  	return err;
>  }
>  
> +static struct pci_driver xen_pcibk_pci_driver;
> +
>  /* Called when 'bind'. This means we must _NOT_ call pci_reset_function or
>   * other functions that take the sysfs lock. */
>  static int pcistub_probe(struct pci_dev *dev, const struct pci_device_id *id)
> @@ -609,8 +611,8 @@ static int pcistub_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	match = pcistub_match(dev);
>  
> -	if ((dev->driver_override &&
> -	     !strcmp(dev->driver_override, PCISTUB_DRIVER_NAME)) ||
> +	if (device_match_driver_override(&dev->dev,
> +					 &xen_pcibk_pci_driver.driver) > 0 ||
>  	    match) {
>  
>  		if (dev->hdr_type != PCI_HEADER_TYPE_NORMAL
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..57e9463e4347 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -575,12 +575,6 @@ struct pci_dev {
>  	u8		supported_speeds; /* Supported Link Speeds Vector */
>  	phys_addr_t	rom;		/* Physical address if not from BAR */
>  	size_t		romlen;		/* Length if not from BAR */
> -	/*
> -	 * Driver name to force a match.  Do not set directly, because core
> -	 * frees it.  Use driver_set_override() to set or clear it.
> -	 */
> -	const char	*driver_override;
> -
>  	unsigned long	priv_flags;	/* Private flags for the PCI driver */
>  
>  	/* These methods index pci_reset_fn_methods[] */
> -- 
> 2.53.0
> 

