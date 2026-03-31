Return-Path: <linux-hyperv+bounces-9857-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILxBAJHjy2n0MAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9857-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 17:09:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447636B73D
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 17:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B335B305F055
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0A4401A0E;
	Tue, 31 Mar 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KglO/3Mo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E603FFADE;
	Tue, 31 Mar 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969379; cv=none; b=gKFKM2U7cL0wVfHr1VACyM8vJXJeBNWR0ZQFXbxzdKMMf4Iopv/ZMJ5yVIOuB08tonWaEWbuX82OHvbDOiVb8VwqKh/pE0eaSnNAnxl/URo2y9b4Fj6S0IrN+v5Mf7oikXyxdlVFZeJrWhNCu10NVwWo+3JzZS3SbgUE/QFDENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969379; c=relaxed/simple;
	bh=lKc0nR0+3UMuWZyWz6l9MjXgdkdLagd8O+NJe9KaxV4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lx/7ecs92D1hikmR3vFhX7VxOxmrB/fyYBABeF61Dyom9t4LoeVm0IC4wiQKz+lkFIAV+lo9+FQQ68yAzj1rzFFDc6dVcWjM9+NxK7go1pQ0AeFjepxtkCARijy/qLXP5exlskO9v/DkEjleguXHfVQRUPnNGpXqA3kwykWBzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KglO/3Mo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969378; x=1806505378;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lKc0nR0+3UMuWZyWz6l9MjXgdkdLagd8O+NJe9KaxV4=;
  b=KglO/3MoKB03HCMY9nz1ITGz+Qa37xd8SnZOvQMODqf0t8PNlmVMg/tp
   QHBLVF698m5kmyc4YsjSCJpM0zmzjqFET/6ucwoyhUGqtoxAGxL0CWpug
   DZNg95KYp69URRRBJxX5PN+iPe44nv0wCkh+AtZc0SeY7atamrggNfKBS
   we35ntCa8D8eT48w1TOuvPHzKmMY7J/9lpAlEbYdUYYHXpEcniUTfk8Lw
   zZvCqmTAbmHxLG1uAAb6nCdkFFyHk/zMWLKOZyRLS4oNfMAmUUQ7sX8UU
   luF3N0D/ouUGbSvHlmWfS4QOt6bdhmrlIQ9+fBTUCoZQWGmXuDZ3j/dYa
   w==;
X-CSE-ConnectionGUID: lI8GtGyzTBCrHEwicmhDjg==
X-CSE-MsgGUID: DJRoOitSTMCDj6sHxM/BrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86682260"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86682260"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:53 -0700
X-CSE-ConnectionGUID: JHiKH3CWRemnPBHhcWS24A==
X-CSE-MsgGUID: Gcx1iYgWQJaJHg3SKbkrBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221527611"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 31 Mar 2026 18:02:33 +0300 (EEST)
To: Danilo Krummrich <dakr@kernel.org>
cc: Russell King <linux@armlinux.org.uk>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>, 
    Nikhil Agarwal <nikhil.agarwal@amd.com>, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Mathieu Poirier <mathieu.poirier@linaro.org>, 
    Vineeth Vijayan <vneethv@linux.ibm.com>, 
    Peter Oberparleiter <oberpar@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, 
    Harald Freudenberger <freude@linux.ibm.com>, 
    Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
    "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
    Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
    =?ISO-8859-15?Q?Eugenio_P=E9rez?= <eperezma@redhat.com>, 
    Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, driver-core@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
    linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
    linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, 
    virtualization@lists.linux.dev, kvm@vger.kernel.org, 
    xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org, 
    Gui-Dong Han <hanguidong02@gmail.com>
Subject: Re: [PATCH 06/12] platform/wmi: use generic driver_override
 infrastructure
In-Reply-To: <20260324005919.2408620-7-dakr@kernel.org>
Message-ID: <f15629e4-ef8f-b1b6-0158-064f40f111da@linux.intel.com>
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-7-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9857-lists,linux-hyperv=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 0447636B73D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026, Danilo Krummrich wrote:

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
> Fixes: 12046f8c77e0 ("platform/x86: wmi: Add driver_override support")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/platform/wmi/core.c | 36 +++++-------------------------------
>  include/linux/wmi.h         |  4 ----
>  2 files changed, 5 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
> index b8e6b9a421c6..750e3619724e 100644
> --- a/drivers/platform/wmi/core.c
> +++ b/drivers/platform/wmi/core.c
> @@ -842,39 +842,11 @@ static ssize_t expensive_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(expensive);
>  
> -static ssize_t driver_override_show(struct device *dev, struct device_attribute *attr,
> -				    char *buf)
> -{
> -	struct wmi_device *wdev = to_wmi_device(dev);
> -	ssize_t ret;
> -
> -	device_lock(dev);
> -	ret = sysfs_emit(buf, "%s\n", wdev->driver_override);
> -	device_unlock(dev);
> -
> -	return ret;
> -}
> -
> -static ssize_t driver_override_store(struct device *dev, struct device_attribute *attr,
> -				     const char *buf, size_t count)
> -{
> -	struct wmi_device *wdev = to_wmi_device(dev);
> -	int ret;
> -
> -	ret = driver_set_override(dev, &wdev->driver_override, buf, count);
> -	if (ret < 0)
> -		return ret;
> -
> -	return count;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>  static struct attribute *wmi_attrs[] = {
>  	&dev_attr_modalias.attr,
>  	&dev_attr_guid.attr,
>  	&dev_attr_instance_count.attr,
>  	&dev_attr_expensive.attr,
> -	&dev_attr_driver_override.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(wmi);
> @@ -943,7 +915,6 @@ static void wmi_dev_release(struct device *dev)
>  {
>  	struct wmi_block *wblock = dev_to_wblock(dev);
>  
> -	kfree(wblock->dev.driver_override);
>  	kfree(wblock);
>  }
>  
> @@ -952,10 +923,12 @@ static int wmi_dev_match(struct device *dev, const struct device_driver *driver)
>  	const struct wmi_driver *wmi_driver = to_wmi_driver(driver);
>  	struct wmi_block *wblock = dev_to_wblock(dev);
>  	const struct wmi_device_id *id = wmi_driver->id_table;
> +	int ret;
>  
>  	/* When driver_override is set, only bind to the matching driver */
> -	if (wblock->dev.driver_override)
> -		return !strcmp(wblock->dev.driver_override, driver->name);
> +	ret = device_match_driver_override(dev, driver);
> +	if (ret >= 0)
> +		return ret;
>  
>  	if (id == NULL)
>  		return 0;
> @@ -1076,6 +1049,7 @@ static struct class wmi_bus_class = {
>  static const struct bus_type wmi_bus_type = {
>  	.name = "wmi",
>  	.dev_groups = wmi_groups,
> +	.driver_override = true,
>  	.match = wmi_dev_match,
>  	.uevent = wmi_dev_uevent,
>  	.probe = wmi_dev_probe,
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index 75cb0c7cfe57..14fb644e1701 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -18,16 +18,12 @@
>   * struct wmi_device - WMI device structure
>   * @dev: Device associated with this WMI device
>   * @setable: True for devices implementing the Set Control Method
> - * @driver_override: Driver name to force a match; do not set directly,
> - *		     because core frees it; use driver_set_override() to
> - *		     set or clear it.
>   *
>   * This represents WMI devices discovered by the WMI driver core.
>   */
>  struct wmi_device {
>  	struct device dev;
>  	bool setable;
> -	const char *driver_override;
>  };
>  
>  /**
> 

Hi,

I tried applying this to platform-drivers tree but it failed to compile so 
I ended up dropping the changed.

-- 
 i.


