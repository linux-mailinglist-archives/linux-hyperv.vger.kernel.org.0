Return-Path: <linux-hyperv+bounces-9830-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JJCMzC1ymmE/QUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9830-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 19:38:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4139E35F5C6
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A4293012CFE
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238213DDDB7;
	Mon, 30 Mar 2026 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S56YWHrx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1043DDDA3;
	Mon, 30 Mar 2026 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892332; cv=none; b=LkbEgkd3oYeTgAdP3a+TledJGBDEkkFkdCC3u0LX6FiMRENwPCI1wr/g0VlHl6HEonO7NJKpASu1Rpf0jClPjD/r8w05Ih95V9hzZ/DjI9+yxSRUgR/iTxwGNpYhAkHwySHaoJdyEiIJycbXYkB9CH0cIQZndNAhjkLypOR+RS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892332; c=relaxed/simple;
	bh=/8RwifExta3hi9wb0UAvoCzja5DI/LlE9XUZDEKtDlU=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:Mime-Version:
	 References:In-Reply-To; b=SD8/xN6VvQvaqrPz4qfgFA7f66EYFReohMjCkweFjH6MvN3fnm090XKAjsbU3JPrdnHUPk+NJ79ISrUX+5fuZMtNyd2BaYa5JuSOgsiIL6QsTw4+A5K57JMivfJlh2eXmh1HXIEnwOKknpQKb7Gj4xj90Bg3eU+1OtFq9Vk1KiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S56YWHrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39967C2BCB5;
	Mon, 30 Mar 2026 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774892332;
	bh=/8RwifExta3hi9wb0UAvoCzja5DI/LlE9XUZDEKtDlU=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=S56YWHrxhwHLS+EfSzEoW6H9YreN8wrQZ/7HEDAWqAjDAvn6rNoi6jXsbwo3fyTXv
	 TjHIGPt2qRPbkCCC5yCfSjAbtAw6BzXCZXCaq/yn658JrR6/xBRJ7/mYaDQNBA9Pmv
	 wsEtOTKeR8oMh9VC6LyR87wz4W/9tT1+Zpl9oixkuOSdi9YZxoGPEs7WRJpEIUF6YP
	 QT3eMcBSThXdTkmokN7Q16p5we5dG5K2/LjDkgP9NUYvkxjgwB7vubbfIKhxuyu2dj
	 oq30Tych+FNSMtuze99IC0ZOa+AcROHbp3uZujJVXn+3TGN1ylZ7O8WH21Mk5oRMNX
	 /gBaIKRkeOGJg==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 19:38:41 +0200
Message-Id: <DHGATG6LJOM1.2AI7BYQ2O4DFU@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 05/12] PCI: use generic driver_override infrastructure
Cc: "Russell King" <linux@armlinux.org.uk>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Ioana Ciornei" <ioana.ciornei@nxp.com>, "Nipun Gupta"
 <nipun.gupta@amd.com>, "Nikhil Agarwal" <nikhil.agarwal@amd.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, "Haiyang Zhang" <haiyangz@microsoft.com>,
 "Wei Liu" <wei.liu@kernel.org>, "Dexuan Cui" <decui@microsoft.com>, "Long
 Li" <longli@microsoft.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Armin
 Wolf" <W_Armin@gmx.de>, "Bjorn Andersson" <andersson@kernel.org>, "Mathieu
 Poirier" <mathieu.poirier@linaro.org>, "Vineeth Vijayan"
 <vneethv@linux.ibm.com>, "Peter Oberparleiter" <oberpar@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Harald
 Freudenberger" <freude@linux.ibm.com>, "Holger Dengler"
 <dengler@linux.ibm.com>, "Mark Brown" <broonie@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>, "Xuan Zhuo"
 <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "Juergen Gross" <jgross@suse.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko"
 <oleksandr_tyshchenko@epam.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <platform-driver-x86@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <kvm@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
 <linux-arm-kernel@lists.infradead.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Gui-Dong Han" <hanguidong02@gmail.com>
To: "Alex Williamson" <alex@shazbot.org>, "Jason Gunthorpe" <jgg@ziepe.ca>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-6-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-6-dakr@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-9830-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4139E35F5C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

(Cc: Jason)

On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index d43745fe4c84..460852f79f29 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifier_bl=
ock *nb,
>  	    pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>  		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
>  			 pci_name(pdev));
> -		pdev->driver_override =3D kasprintf(GFP_KERNEL, "%s",
> -						  vdev->vdev.ops->name);
> -		WARN_ON(!pdev->driver_override);
> +		WARN_ON(device_set_driver_override(&pdev->dev,
> +						   vdev->vdev.ops->name));

Technically, this is a change in behavior. If vdev->vdev.ops->name is NULL,=
 it
will trigger the WARN_ON(), whereas before it would have just written "(nul=
l)"
into driver_override.

I assume that vfio_pci_core drivers are expected to set the name in struct
vfio_device_ops in the first place and this code (silently) relies on this
invariant?

Alex, Jason: Should we keep this hunk above as is and check for a proper na=
me in
struct vfio_device_ops in vfio_pci_core_register_device() with a subsequent
patch?

>  	} else if (action =3D=3D BUS_NOTIFY_BOUND_DRIVER &&
>  		   pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>  		struct pci_driver *drv =3D pci_dev_driver(pdev);

