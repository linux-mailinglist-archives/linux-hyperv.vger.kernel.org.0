Return-Path: <linux-hyperv+bounces-9741-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE8DHDzqwmnnnAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9741-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 20:47:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B95831BCA2
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 20:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAD71309768F
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04398318EF4;
	Tue, 24 Mar 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ifvPJxvA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A425E3043DC;
	Tue, 24 Mar 2026 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381336; cv=none; b=Tt9bCBK+LTpfXSN9cGd7OFKwU64TPHqZD0lANIAdIvzq+coZrzJ88/q8ehn/UAPz1RSYq116h/5NKzGb20GPgEE+6/n68W/ew28KjbxVQap4BanyJNsWWlkn8nxV1RihU70aOYWng+YUB/pPaMKSjqdlAf0s4ZPKNlCienNqVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381336; c=relaxed/simple;
	bh=CP9KQznymj/57SvemGWPkQ/5+YO2JcQjnpOOJiKqnYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQs8E6t8UOd74GNHRtoe26daCV/ASXCnLqnVlOBZXVk/5KgspTtRQItQA+fHLtkTJcmpbyPP+njQyfEbXsJyF9EczJd2MSg9B68/sFjx5Hytt7tNRVQesiHi50asGIpNXawfd325ygCWOmVRNAuiV4B4rw+WomBCot2ON2N/VLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ifvPJxvA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774381324; x=1774986124; i=w_armin@gmx.de;
	bh=GGWlvb2n3V4HaO8XQjVf9hW7XhuAzhwdcuVxgB5Di8o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ifvPJxvAhtek8q+pCeeyITFinHZKIJzqVHZWD0oNtpjBH1VESRkcZtiJ0sFNIVvR
	 +0tHnwJ18q+Z71ZrayUhU0vh5SiV1GPGwunmQmajPwVX4HXy1AnJ3jVQfcgYl/q0G
	 7GpW93BfuY2TpH5ZIbrRDM1vyhuFD6vaYRPfQPHs2isrsWWvKb6H9asjxTkbrpRtL
	 3vWhE/L/BP8v1cfiKyUpLIqIJ9UK3RIuIZtPTLzS2X0sC5ZIUWvYq6SpqamMfPhIB
	 3LW6jjBPxIdqM4s0+mkdYOjqtI6GXvkruP0E13jFM3HajUwIRo0KgB5dciwbWvO8R
	 RuMZmDRORvSKwwSOYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1vpN8Z0wQN-00N053; Tue, 24
 Mar 2026 20:42:04 +0100
Message-ID: <50ed0e80-c1f3-48da-81f6-9edd2b1c35e1@gmx.de>
Date: Tue, 24 Mar 2026 20:41:59 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] platform/wmi: use generic driver_override
 infrastructure
To: Danilo Krummrich <dakr@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org,
 Gui-Dong Han <hanguidong02@gmail.com>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-7-dakr@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260324005919.2408620-7-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KKKjGPofriNO2Y7ny8bzLW+ogpO7D8lGPS1ezTtV32qPriElMBO
 jvtg2QtMPBSSFpK+K9f9/W3IHaIUxxM1SjbuL+eF3f/6Z6WRzj/HQbWdJ/0smqYXW/iekvq
 A+6iz88zZSNd21TB/fuLIMalZH7T5q5DuSXS3//CqYIoGgOXkyuC7c9IHxbPHBnE7ZSgdkY
 FFp1rdFLmEZzrK9+h1giQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kIvBWcj/zXQ=;/niOuXlWvI8Na8RihCaK5ylBNR/
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9741-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:dkim,gmx.de:email,gmx.de:mid]
X-Rspamd-Queue-Id: 2B95831BCA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 24.03.26 um 01:59 schrieb Danilo Krummrich:

> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
>
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
>
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@ker=
nel.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
> Fixes: 12046f8c77e0 ("platform/x86: wmi: Add driver_override support")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>   drivers/platform/wmi/core.c | 36 +++++-------------------------------
>   include/linux/wmi.h         |  4 ----
>   2 files changed, 5 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
> index b8e6b9a421c6..750e3619724e 100644
> --- a/drivers/platform/wmi/core.c
> +++ b/drivers/platform/wmi/core.c
> @@ -842,39 +842,11 @@ static ssize_t expensive_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(expensive);
>  =20
> -static ssize_t driver_override_show(struct device *dev, struct device_a=
ttribute *attr,
> -				    char *buf)
> -{
> -	struct wmi_device *wdev =3D to_wmi_device(dev);
> -	ssize_t ret;
> -
> -	device_lock(dev);
> -	ret =3D sysfs_emit(buf, "%s\n", wdev->driver_override);
> -	device_unlock(dev);
> -
> -	return ret;
> -}
> -
> -static ssize_t driver_override_store(struct device *dev, struct device_=
attribute *attr,
> -				     const char *buf, size_t count)
> -{
> -	struct wmi_device *wdev =3D to_wmi_device(dev);
> -	int ret;
> -
> -	ret =3D driver_set_override(dev, &wdev->driver_override, buf, count);
> -	if (ret < 0)
> -		return ret;
> -
> -	return count;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>   static struct attribute *wmi_attrs[] =3D {
>   	&dev_attr_modalias.attr,
>   	&dev_attr_guid.attr,
>   	&dev_attr_instance_count.attr,
>   	&dev_attr_expensive.attr,
> -	&dev_attr_driver_override.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(wmi);
> @@ -943,7 +915,6 @@ static void wmi_dev_release(struct device *dev)
>   {
>   	struct wmi_block *wblock =3D dev_to_wblock(dev);
>  =20
> -	kfree(wblock->dev.driver_override);
>   	kfree(wblock);
>   }
>  =20
> @@ -952,10 +923,12 @@ static int wmi_dev_match(struct device *dev, const=
 struct device_driver *driver)
>   	const struct wmi_driver *wmi_driver =3D to_wmi_driver(driver);
>   	struct wmi_block *wblock =3D dev_to_wblock(dev);
>   	const struct wmi_device_id *id =3D wmi_driver->id_table;
> +	int ret;
>  =20
>   	/* When driver_override is set, only bind to the matching driver */
> -	if (wblock->dev.driver_override)
> -		return !strcmp(wblock->dev.driver_override, driver->name);
> +	ret =3D device_match_driver_override(dev, driver);
> +	if (ret >=3D 0)
> +		return ret;
>  =20
>   	if (id =3D=3D NULL)
>   		return 0;
> @@ -1076,6 +1049,7 @@ static struct class wmi_bus_class =3D {
>   static const struct bus_type wmi_bus_type =3D {
>   	.name =3D "wmi",
>   	.dev_groups =3D wmi_groups,
> +	.driver_override =3D true,
>   	.match =3D wmi_dev_match,
>   	.uevent =3D wmi_dev_uevent,
>   	.probe =3D wmi_dev_probe,
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index 75cb0c7cfe57..14fb644e1701 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -18,16 +18,12 @@
>    * struct wmi_device - WMI device structure
>    * @dev: Device associated with this WMI device
>    * @setable: True for devices implementing the Set Control Method
> - * @driver_override: Driver name to force a match; do not set directly,
> - *		     because core frees it; use driver_set_override() to
> - *		     set or clear it.
>    *
>    * This represents WMI devices discovered by the WMI driver core.
>    */
>   struct wmi_device {
>   	struct device dev;
>   	bool setable;
> -	const char *driver_override;
>   };
>  =20
>   /**

