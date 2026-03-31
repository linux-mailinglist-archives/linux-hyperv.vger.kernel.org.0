Return-Path: <linux-hyperv+bounces-9853-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COxPNCOGy2l4IgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9853-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 10:30:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0FA36624A
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 10:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA0C30D01E2
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 08:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE443DD525;
	Tue, 31 Mar 2026 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSy9+x0o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77AF3DBD4A;
	Tue, 31 Mar 2026 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945345; cv=none; b=Rka0tOnxdn1LlC0+Ap95fSVmOXdeRQrkRaG7UtIZ+3763hPdoZn2aTHFXZi80PJY0AowjVbgpu7+kauTasWOVWAFNOO+BVtrAlx6e0W6F0gwFHpTm0OZfjqzeb4iHLfijkArcvpFJ3MsdeJvYqX/tdUIDO6X01D0JMaMRfiQg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945345; c=relaxed/simple;
	bh=l6+1fNT+srCycsiVVoib27WaB3v/ZfJTiLnjMUHoUKo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=GAqFVgtpqfY+jTv8RYYeTEjFB1tschma4wHs9Z72Pb7XNqnDE++abFKJi7VrhPrAIRlvPJZDAfNMy2Bl6M2a4zUQgWWzEIAM6dOHhcCfgof6CjdoQnMGgmV+wW2bRv+eSUHucTOa+RpoKa4tMb1uQ9J4t5YmJynreRAOD+7OB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSy9+x0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491C9C19423;
	Tue, 31 Mar 2026 08:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774945345;
	bh=l6+1fNT+srCycsiVVoib27WaB3v/ZfJTiLnjMUHoUKo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hSy9+x0oWet2Vv+Oa/3w4GpGm2W4uKeHJBTg9yWIIsbEo6AeK4CHA2HWQrg43wVml
	 UVDFcKRzAiCTcPrPYa8DFRgndlsXnw4fTPckVVFiVQb06rsmUThpiBFwbHCwFpNgx9
	 aItzsCrpgMmhdBzOksIXuo4KjSj0zwKhq5Cid6OYUD9yR5jXXRbnJ0gLf3fnZTo/+d
	 1ltaJGKRSE2hkkenVvfpB0JLleI13qUWazlmX5cCzMNZECQq3dZ5sC7thgT6+6cjC8
	 i3Qv/NInrpLzf5qRyZ3z333YkadqamLF6R3ft0Ny0IUSwt34LY7sCNzSn76UOiN7FG
	 7FAeA2EXbVc6w==
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Mar 2026 10:22:14 +0200
Message-Id: <DHGTLY0FJWD2.2VLT6NQWF97YY@kernel.org>
Subject: Re: [PATCH 05/12] PCI: use generic driver_override infrastructure
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Russell King"
 <linux@armlinux.org.uk>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Ioana Ciornei"
 <ioana.ciornei@nxp.com>, "Nipun Gupta" <nipun.gupta@amd.com>, "Nikhil
 Agarwal" <nikhil.agarwal@amd.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, "Long Li" <longli@microsoft.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Armin Wolf" <W_Armin@gmx.de>,
 "Bjorn Andersson" <andersson@kernel.org>, "Mathieu Poirier"
 <mathieu.poirier@linaro.org>, "Vineeth Vijayan" <vneethv@linux.ibm.com>,
 "Peter Oberparleiter" <oberpar@linux.ibm.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
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
 <linux-arm-kernel@lists.infradead.org>, "Gui-Dong Han"
 <hanguidong02@gmail.com>
To: "Alex Williamson" <alex@shazbot.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-6-dakr@kernel.org>
 <DHGATG6LJOM1.2AI7BYQ2O4DFU@kernel.org>
 <20260330141050.2cb47bd9@shazbot.org>
 <DHGT9XCG8Y96.3IB1EI6FF1ZDZ@kernel.org>
In-Reply-To: <DHGT9XCG8Y96.3IB1EI6FF1ZDZ@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ziepe.ca,armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-9853-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B0FA36624A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 31, 2026 at 10:06 AM CEST, Danilo Krummrich wrote:
> On Mon Mar 30, 2026 at 10:10 PM CEST, Alex Williamson wrote:
>> On Mon, 30 Mar 2026 19:38:41 +0200
>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>
>>> (Cc: Jason)
>>>=20
>>> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
>>> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio=
_pci_core.c
>>> > index d43745fe4c84..460852f79f29 100644
>>> > --- a/drivers/vfio/pci/vfio_pci_core.c
>>> > +++ b/drivers/vfio/pci/vfio_pci_core.c
>>> > @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifie=
r_block *nb,
>>> >  	    pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>>> >  		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
>>> >  			 pci_name(pdev));
>>> > -		pdev->driver_override =3D kasprintf(GFP_KERNEL, "%s",
>>> > -						  vdev->vdev.ops->name);
>>> > -		WARN_ON(!pdev->driver_override);
>>> > +		WARN_ON(device_set_driver_override(&pdev->dev,
>>> > +						   vdev->vdev.ops->name)); =20
>>>=20
>>> Technically, this is a change in behavior. If vdev->vdev.ops->name is N=
ULL, it
>>> will trigger the WARN_ON(), whereas before it would have just written "=
(null)"
>>> into driver_override.
>>
>> It's worse than that.  Looking at the implementation in [1], we have:
>>
>> +static inline int device_set_driver_override(struct device *dev, const =
char *s)
>> +{
>> +	return __device_set_driver_override(dev, s, strlen(s));
>> +}
>>
>> So if name is NULL, we oops in strlen() before we even hit the -EINVAL
>> and WARN_ON().
>
> This was changed in v2 [2] and the actual code in-tree is
>
> 	static inline int device_set_driver_override(struct device *dev, const c=
har *s)
> 	{
> 		return __device_set_driver_override(dev, s, s ? strlen(s) : 0);
> 	}
>
> so it does indeed return -EINVAL for a NULL pointer.
>
>> I don't believe we have any vfio-pci variant drivers where the name is
>> NULL, but kasprintf() handling NULL as "(null)" was a consideration in
>> this design, that even if there is no name the device is sequestered
>> with a driver_override that won't match an actual driver.
>>
>>> I assume that vfio_pci_core drivers are expected to set the name in str=
uct
>>> vfio_device_ops in the first place and this code (silently) relies on t=
his
>>> invariant?
>>
>> We do expect that, but it was previously safe either way to make sure
>> VFs are only bound to the same ops driver or barring that, at least
>> don't perform a standard driver match.  The last thing we want to
>> happen automatically is for a user owned PF to create SR-IOV VFs that
>> automatically bind to native kernel drivers.
>> =20
>>> Alex, Jason: Should we keep this hunk above as is and check for a prope=
r name in
>>> struct vfio_device_ops in vfio_pci_core_register_device() with a subseq=
uent
>>> patch?
>>
>> Given the oops, my preference would be to roll it in here.  This change
>> is what makes it a requirement that name cannot be NULL, where this was
>> safely handled with kasprintf().
>
> Again, no oops here. :)
>
> I still think it makes more sense to fail early in
> vfio_pci_core_register_device(), rather than silently accept "(null)" in
> driver_override. It also doesn't seem unreasonable with only the WARN_ON(=
), but
> I can also just add vdev->vdev.ops->name ?: "(null)".

(Or just skip the call if !vdev->vdev.ops->name, as a user will read "(null=
)"
from sysfs either way.)

> Please let me know what you prefer.
>
> - Danilo
>
>> [1] https://lore.kernel.org/all/20260302002729.19438-2-dakr@kernel.org/
>
> [2] https://lore.kernel.org/driver-core/20260303115720.48783-1-dakr@kerne=
l.org/


