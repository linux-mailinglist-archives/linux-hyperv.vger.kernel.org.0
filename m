Return-Path: <linux-hyperv+bounces-9859-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLLDKabty2m5MgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9859-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 17:52:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCA336C21D
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 17:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA59D3037E6C
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DB441C2EF;
	Tue, 31 Mar 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPPVnCRl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893C41B37D;
	Tue, 31 Mar 2026 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972279; cv=none; b=H/a6VC2iOiVwp+1ayxSF7y5okZDBjq7aQdTLW+wdjUfYN8ebKrnAti2TwXV/Mb2wWbDV3AyPcOTxdzqQIUTGDoua7NzUgW7opUnnmLAaBWm7QXOCjx0qXp0veGAfwOy4jiiG0+2QcSl7mRZB8x1aCmW0lHGiMKAh4y/mx5M6yK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972279; c=relaxed/simple;
	bh=Nge5zor6zpLsko98SNlgKwkLdBZ67zYKvW4fhw7iRFI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iAN2zocg46mE1s9wL/DKACEashVuJr86fLSVoC9Mkmv0tWRuest4jgaFvFXL+Y7h4z9A3hfrNgldgpB8PPCVqqQr7IfFvxKvvKi2IE0aXjwWdnP+0MNLGyJLcS80GqmLzCEM0f5hOBHTlxH4z3UP0dFdeocXQdj4LX0sOYHHDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPPVnCRl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774972276; x=1806508276;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nge5zor6zpLsko98SNlgKwkLdBZ67zYKvW4fhw7iRFI=;
  b=jPPVnCRl3+uoiRh+4DgQvV86Ct1cBMK5Eq9riRtLf5ynwETwAs/xPLNS
   vHUtLgsnSno/c58W4rANBoF6O+V4wT3AyTUpwRL9qBeD5ZnURhUWTWCz9
   51IZVfzVR32MjE/vjcZRvU8kYerekzLHWZWMmTkZ0v6GUGzWU2JuTN55w
   GJHySzkENll/g0YKzOQvaV4pHBuhjqEz1WMQVyYgFXPoRXq4QQSt/aBQy
   y0hjhZj01hRlapoRekY6Dg2vbc473HahP8SOy9Qzp5Xk9Jwh51zWuVjB+
   L+WmFoDez6QEQ0B5EcwwiOLpEB1fNC6ZdAuRJTm/mae43oeeSmJtzol4C
   A==;
X-CSE-ConnectionGUID: M9ul4KnxR3CvXu0TAzb5sQ==
X-CSE-MsgGUID: sMz40s9cQkKy2j7ou+OgKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75162616"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75162616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:51:14 -0700
X-CSE-ConnectionGUID: Erx6h0j4SBaLVonmWZa8AQ==
X-CSE-MsgGUID: i5Ax2DCyQZGon6IlICWnbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230465746"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:50:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 31 Mar 2026 18:50:52 +0300 (EEST)
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
In-Reply-To: <f819b7d8-5c80-4463-9afa-933a2ddc8ab3@kernel.org>
Message-ID: <dc11f3fd-a5c7-16e9-8417-6dddb63129fa@linux.intel.com>
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-7-dakr@kernel.org> <f15629e4-ef8f-b1b6-0158-064f40f111da@linux.intel.com> <f819b7d8-5c80-4463-9afa-933a2ddc8ab3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2141551316-1774972252=:989"
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9859-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 1DCA336C21D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2141551316-1774972252=:989
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 31 Mar 2026, Danilo Krummrich wrote:

> On 3/31/26 5:02 PM, Ilpo J=C3=A4rvinen wrote:
> > I tried applying this to platform-drivers tree but it failed to compile=
 so=20
> > I ended up dropping the changed.
>=20
> As the cover letter mentions, it sits on top of v7.0-rc5, did you conside=
r this?

I noticed it but I just assumed you were working on top of that, not that=
=20
there's something past -rc1 that is required.

> I can also pick it up via the driver-core tree.

If there's some post -rc1 material this depends, it's probably better that=
=20
way.

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-2141551316-1774972252=:989--

