Return-Path: <linux-hyperv+bounces-9829-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FPSF+Omymml+wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9829-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 18:37:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE235EE66
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 18:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 536C430074D9
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F926B74A;
	Mon, 30 Mar 2026 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/3XWocf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6A3793D0;
	Mon, 30 Mar 2026 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888139; cv=none; b=ad3UZ87Atc+Dl/pvWDK+z/lXRL8Ov7hrVab+QiNPu5ZlVC9MX0oCq9ri5wrtS0jczBclwSiJ+d1TNskvmxR7WXe4adgM7n72sImtpUZWe1aNyZtSKF9h93oGVwroBSalNi0LSLRCJdNeSTgEcbBbs39Tx1s6dzmR7f6ckh6qt9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888139; c=relaxed/simple;
	bh=HnR3T8HyhR5zh3UidQc9tY5GP+iCNJ+9G4eesNsn66c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SUDhd07PBiVBhnoqnSir44k5vwicaFjFvBEUZlOJFdDDaR8IErB8Rf9InZ6cehUx0Jd/MF34n0qqEwAsLtPANDZ6s449VHBmdImlyZ8HxHR5H3TvmMHhGk+t90Wr+vTzN8AAnX1qU4OVjpW2aSW50YKaddGsKtKhItNVDp4X2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/3XWocf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2732FC4CEF7;
	Mon, 30 Mar 2026 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774888138;
	bh=HnR3T8HyhR5zh3UidQc9tY5GP+iCNJ+9G4eesNsn66c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=P/3XWocfTvHDzL/TvgnY90VGL4nSlLd5QBe5hsYLKubBK3nWHOJaPjPq5JQAaRhM8
	 iAGk5KjaD3ik9GNqL6YSdRdGeXxBgLs24zJtsj3e6fxOpDbi7ZZd8I/d1cyMypX8NE
	 2XOL2YHA8im3TC/6MZc4CKSvIWYdWZeBHcvNBDXSWRJJuejsAH9jaZzQRbryV+m5kG
	 lnPI2WxSgVXB97c4laa/t/vZgU3QAb4tmja9ypMEFSoxTNm4EFRWFco06IOLdeGzNC
	 AdWvpkXe36xoTq6sFQYDIMUXUgS6vorYizdKVDGjM2rmv+ZiFnuwAzo46ijHVV7DUf
	 PA+6jJae0BAbA==
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 18:28:48 +0200
Message-Id: <DHG9BXUEUEU4.2DTNLE8Z61DKX@kernel.org>
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
 <eperezma@redhat.com>, "Alex Williamson" <alex@shazbot.org>, "Juergen
 Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Christophe Leroy
 (CS GROUP)" <chleroy@kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <platform-driver-x86@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <kvm@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
 <linux-arm-kernel@lists.infradead.org>, "Gui-Dong Han"
 <hanguidong02@gmail.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260324005919.2408620-6-dakr@kernel.org>
 <20260326180825.GA1330769@bhelgaas>
In-Reply-To: <20260326180825.GA1330769@bhelgaas>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-9829-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71DE235EE66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu Mar 26, 2026 at 7:08 PM CET, Bjorn Helgaas wrote:
> On Tue, Mar 24, 2026 at 01:59:09AM +0100, Danilo Krummrich wrote:
>> When a driver is probed through __driver_attach(), the bus' match()
>> callback is called without the device lock held, thus accessing the
>> driver_override field without a lock, which can cause a UAF.
>>=20
>> Fix this by using the driver-core driver_override infrastructure taking
>> care of proper locking internally.
>>=20
>> Note that calling match() from __driver_attach() without the device lock
>> held is intentional. [1]
>>=20
>> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@ker=
nel.org/ [1]
>> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
>> Fixes: 782a985d7af2 ("PCI: Introduce new device binding path using pci_d=
ev.driver_override")
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  drivers/pci/pci-driver.c           | 11 +++++++----
>>  drivers/pci/pci-sysfs.c            | 28 ----------------------------
>>  drivers/pci/probe.c                |  1 -
>>  include/linux/pci.h                |  6 ------
>
> For the above:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> "driver_override" is mentioned several places in
> Documentation/ABI/testing/sysfs-bus-*.  I assume this series doesn't
> change the behavior documented there?

Correct, none of this is altered.

