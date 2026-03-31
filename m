Return-Path: <linux-hyperv+bounces-9863-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N0eIR0ezGnHPgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9863-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 21:18:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 074D0370794
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 21:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 479563004F19
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34E3A542A;
	Tue, 31 Mar 2026 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Jix2YZqP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPkl0NIe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CB331209;
	Tue, 31 Mar 2026 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984729; cv=none; b=fB2PHm0w/TrZqQt82UuzNECJTDId9la+fgheacyKNNzyBQ8K4jYBo5vl0S07XVOhm7WdsMGKGGcY9UGFmpdZCQigucmfa83rGjaqTvgFhDNAZeine/X4AiuN/BtyuiSlhmiDTZExFtK1Upkl2pV6PkXzPAdMe1kCCre4RSsDGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984729; c=relaxed/simple;
	bh=eJC1dGMKA7WWnvIcrQkw8YE6B7Kq4iS3s/Ohm6s3FTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7cyVZixgrTANTH2w906VJGg7cBfHcSHigcgxxc0v8SASIzl9UXZex9tliDTPYItbEkd9bDeOK/Z5jOc+Z/fuhiSLbOt8Ye5KtwcboWl4QPcRRGZ0cMe/nKISVAowILWu0udKvqwCdEQrN9TZXVdR49sMPWltSBEGVl5ATH0a20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Jix2YZqP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qPkl0NIe; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id D592A130008E;
	Tue, 31 Mar 2026 15:18:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 15:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774984723;
	 x=1774991923; bh=e2GLgeMPntSzKQd7unYxJVNrGT++Ey/+j0e558YaVKo=; b=
	Jix2YZqPgfjz22R+GBZTSkmM/A+yTGqbP2D7RrPJTBlHCtwUy2TreQYJzy0FYt4E
	mn6iGMSZZUAvgOUzmgtxkvDhEQqNq9so/LsT2uXs0WUjbk/iVyGgezKLdcntmYCJ
	j1mTHgBbF1XmhYE9OLcmwaqRwm079G64C6NXLlTJGqXGDGeTuyvQuKL+LrxHsVyt
	h07JL26/s5vAaqvA+uFn5EtvqWaXeuVPLWaay4hdvRDT/GeDy5zchULu+Xf5bCKw
	aMCGUFvWJ4r5sa9ylZo53CH1LtcUihVM+4twawyn4uPT0avFIdaMYMGGz87cRj5W
	75pcl2tsTe5q72qXomhEng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774984723; x=
	1774991923; bh=e2GLgeMPntSzKQd7unYxJVNrGT++Ey/+j0e558YaVKo=; b=q
	Pkl0NIe505sDev2vE+9dEjJ2QQvY24shKDHRjyi5iJrJ3lhJmCH83R7Ej6uIsdKx
	Ah2qPK0lawqj3n8MX9UbaZlR8zOv0eboHPEu2zTV9Ar46wm3SvS5yBG219IjmBDw
	/8aE106Yb9iAY8X18cayks75OdeneZOPyq2pnCyvpFrGdunxzgrlbZPAQhHCnM3H
	MhJM8//IeSYiIyV967PwBaCx9UybPaAajGdNOPqf34786RvJS1R2NeBhzECYdV9r
	Hhp4kbOPpgzUg+fw9gf2jEWED5P2y3OiIotVEJPhPvUaSmHyFEthzrD5syHkfCDz
	oj1hrBx1gCRLurULKhEqQ==
X-ME-Sender: <xms:Eh7MaYVXhSLS49doWxNbldxcSkPJQ2lBgD6S-cXj9ML6P8DuIhi54A>
    <xme:Eh7MaY3CTvPt8pC-6__rnVlJHk3AMpws04d9x1eLmygsx9xxcOKA3tvfX2RGrzeid
    3eITD6bgIngUTpBItaVYS7mKstrqZdkyduHlmJydVKX9r92pk1CAA>
X-ME-Received: <xmr:Eh7MaWAMOBeQDrW_EEEiAtExZoJg9HXrtPbMbrU13INIpg2pRTwgJd0Tapg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudegveeu
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhgghesiihivghpvgdrtggrpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhig
    rdhorhhgrdhukhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepihhorghnrgdrtghiohhrnhgvihesnhigphdrtghomhdprhgtphhtthhopehnih
    hpuhhnrdhguhhpthgrsegrmhgurdgtohhmpdhrtghpthhtohepnhhikhhhihhlrdgrghgr
    rhifrghlsegrmhgurdgtohhmpdhrtghpthhtohepkhihshesmhhitghrohhsohhfthdrtg
    homh
X-ME-Proxy: <xmx:Eh7MaXq2mlnlOelEQan96Ie-hgy-LAK8CHBHQdkG7r27nkHcaWiIbg>
    <xmx:Eh7Mab_KIxvqr4OxQc5evz-T_S8zOMbzrx08jzw5C5b7mvco3Iesuw>
    <xmx:Eh7MaefX2P0crsZiJ44xT0eYo0t5zG2qKmdKMy8HHuopFTELtHeNKg>
    <xmx:Eh7MaRJs8ye8aup8P2JAiOncajQ7Ro6xy3heBDnJcGy9BvoI7oIX_g>
    <xmx:Ex7MaSUwhQGLpsFOIWtvVzTCvrLLbvifdUNGQI9PxQ_RqFwZ-CC-1T0v>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 15:18:38 -0400 (EDT)
Date: Tue, 31 Mar 2026 13:18:37 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Ioana Ciornei" <ioana.ciornei@nxp.com>,
 "Nipun Gupta" <nipun.gupta@amd.com>,
 "Nikhil Agarwal" <nikhil.agarwal@amd.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, "Long Li" <longli@microsoft.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Armin Wolf" <W_Armin@gmx.de>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Mathieu Poirier" <mathieu.poirier@linaro.org>,
 "Vineeth Vijayan" <vneethv@linux.ibm.com>,
 "Peter Oberparleiter" <oberpar@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Harald Freudenberger" <freude@linux.ibm.com>,
 "Holger Dengler" <dengler@linux.ibm.com>,
 "Mark Brown" <broonie@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Jason Wang" <jasowang@redhat.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 "Juergen Gross" <jgross@suse.com>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-hyperv@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linux-arm-kernel@lists.infradead.org>,
 "Gui-Dong Han" <hanguidong02@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH 05/12] PCI: use generic driver_override infrastructure
Message-ID: <20260331131837.6a9fe9ec@shazbot.org>
In-Reply-To: <DHGTLY0FJWD2.2VLT6NQWF97YY@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
	<20260324005919.2408620-6-dakr@kernel.org>
	<DHGATG6LJOM1.2AI7BYQ2O4DFU@kernel.org>
	<20260330141050.2cb47bd9@shazbot.org>
	<DHGT9XCG8Y96.3IB1EI6FF1ZDZ@kernel.org>
	<DHGTLY0FJWD2.2VLT6NQWF97YY@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com,shazbot.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9863-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[51];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 074D0370794
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 10:22:14 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Tue Mar 31, 2026 at 10:06 AM CEST, Danilo Krummrich wrote:
> > On Mon Mar 30, 2026 at 10:10 PM CEST, Alex Williamson wrote:  
> >> On Mon, 30 Mar 2026 19:38:41 +0200
> >> "Danilo Krummrich" <dakr@kernel.org> wrote:
> >>  
> >>> (Cc: Jason)
> >>> 
> >>> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:  
> >>> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >>> > index d43745fe4c84..460852f79f29 100644
> >>> > --- a/drivers/vfio/pci/vfio_pci_core.c
> >>> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> >>> > @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifier_block *nb,
> >>> >  	    pdev->is_virtfn && physfn == vdev->pdev) {
> >>> >  		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
> >>> >  			 pci_name(pdev));
> >>> > -		pdev->driver_override = kasprintf(GFP_KERNEL, "%s",
> >>> > -						  vdev->vdev.ops->name);
> >>> > -		WARN_ON(!pdev->driver_override);
> >>> > +		WARN_ON(device_set_driver_override(&pdev->dev,
> >>> > +						   vdev->vdev.ops->name));    
> >>> 
> >>> Technically, this is a change in behavior. If vdev->vdev.ops->name is NULL, it
> >>> will trigger the WARN_ON(), whereas before it would have just written "(null)"
> >>> into driver_override.  
> >>
> >> It's worse than that.  Looking at the implementation in [1], we have:
> >>
> >> +static inline int device_set_driver_override(struct device *dev, const char *s)
> >> +{
> >> +	return __device_set_driver_override(dev, s, strlen(s));
> >> +}
> >>
> >> So if name is NULL, we oops in strlen() before we even hit the -EINVAL
> >> and WARN_ON().  
> >
> > This was changed in v2 [2] and the actual code in-tree is
> >
> > 	static inline int device_set_driver_override(struct device *dev, const char *s)
> > 	{
> > 		return __device_set_driver_override(dev, s, s ? strlen(s) : 0);
> > 	}
> >
> > so it does indeed return -EINVAL for a NULL pointer.

Ok, good.

> >> I don't believe we have any vfio-pci variant drivers where the name is
> >> NULL, but kasprintf() handling NULL as "(null)" was a consideration in
> >> this design, that even if there is no name the device is sequestered
> >> with a driver_override that won't match an actual driver.
> >>  
> >>> I assume that vfio_pci_core drivers are expected to set the name in struct
> >>> vfio_device_ops in the first place and this code (silently) relies on this
> >>> invariant?  
> >>
> >> We do expect that, but it was previously safe either way to make sure
> >> VFs are only bound to the same ops driver or barring that, at least
> >> don't perform a standard driver match.  The last thing we want to
> >> happen automatically is for a user owned PF to create SR-IOV VFs that
> >> automatically bind to native kernel drivers.
> >>    
> >>> Alex, Jason: Should we keep this hunk above as is and check for a proper name in
> >>> struct vfio_device_ops in vfio_pci_core_register_device() with a subsequent
> >>> patch?  
> >>
> >> Given the oops, my preference would be to roll it in here.  This change
> >> is what makes it a requirement that name cannot be NULL, where this was
> >> safely handled with kasprintf().  
> >
> > Again, no oops here. :)
> >
> > I still think it makes more sense to fail early in
> > vfio_pci_core_register_device(), rather than silently accept "(null)" in
> > driver_override. It also doesn't seem unreasonable with only the WARN_ON(), but
> > I can also just add vdev->vdev.ops->name ?: "(null)".  
> 
> (Or just skip the call if !vdev->vdev.ops->name, as a user will read "(null)"
> from sysfs either way.)

Hmm, I suppose they would, but there's a fundamental difference between
driver_override being set to "(null)" vs being NULL and only
interpreted as "(null)" via show.  The former would prevent ID table
matching, the latter would not.  The former is what was intended here,
without realizing both look the same through sysfs and present a
difficult debugging challenge.

Given no oops for strlen() now and no known in-kernel drivers with a
NULL name, I can post a patch that rejects a NULL name in the ops
structure in vfio_pci_core_register_device(), avoiding the entire
situation.

For this,

Acked-by: Alex Williamson <alex@shazbot.org>

Thanks,
Alex

