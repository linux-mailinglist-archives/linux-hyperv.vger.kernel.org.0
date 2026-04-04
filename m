Return-Path: <linux-hyperv+bounces-9989-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vfzWH2RD0WmNHAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-9989-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 18:59:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C639BD3E
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48C573004C86
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F95A3191C8;
	Sat,  4 Apr 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzHa0ltJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492BF30C61F;
	Sat,  4 Apr 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775321950; cv=none; b=Uf5A17L7BvppRwhMgQ9CAb/DPvDvVtxSxE43Ah4QXH3q/FV3nHVHdV9UohJizmPdTjEiaSPgxSgaQ9wbsx8RuP9GIdz6H42xX5BLhGwEeOp3QIb5C+1z4cPkGjIhmmEg2wenW8pfvDPvCZwDr9QLRkjr0AUBQXo+HsLZHvhfLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775321950; c=relaxed/simple;
	bh=2nmDBifOoextQmoTG695I77JtU4IfJ6hHi18F/uovOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkKaNHpPn3t07vFHA/asPgMaks8p5kCvArqzbHe4b5FuNnG8THyUTMK8+d3c/ANvtzxwQRXeDxM9UXneFfssowOm0tNwQHTGHdHHWvik0VxHNscIh65wrVPyN+jF9mSRRinJyFULY9gl67K14BRdnx/MxG2lG09ZCIg+XZ2HAYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzHa0ltJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDF2C19421;
	Sat,  4 Apr 2026 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775321949;
	bh=2nmDBifOoextQmoTG695I77JtU4IfJ6hHi18F/uovOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pzHa0ltJ7P/3nc4QK7/bV808HOZOGXaMyVekR/DB1WE+018orzHWLwztSYy1/aXtb
	 SzI8tsEInej9eoHjBzyIJaVGBr9u74dLFfrXcTThineYb99ODPDwsaOS5PNoPpADEf
	 RKWNJ7Ic0kSfp5FmUOXVQ6PFQBKcfI9b1bar1hvVu+oDjNbThyquuuXTFP/2f4hh2r
	 sNZXBYXoEYlp3D9Lzsjn9fgXUhLg5zak6jG42FprWSVJLQdnerHFANSStlrij56Tl/
	 nq4W3Agf2uSQ+xhFuLGyUpc0A63CtjXoWAelZzEtiaPysfp3k4jpj5PHDxaigPyBx2
	 FsekL+yzYor6g==
Message-ID: <76355cb5-0b5d-4a29-9702-8d020a79f4c0@kernel.org>
Date: Sat, 4 Apr 2026 18:58:53 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
To: Danilo Krummrich <dakr@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Armin Wolf <W_Armin@gmx.de>, Bjorn Andersson <andersson@kernel.org>,
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
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org
References: <20260324005919.2408620-1-dakr@kernel.org>
 <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,armlinux.org.uk,linuxfoundation.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9989-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 670C639BD3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 04/04/2026 à 17:07, Danilo Krummrich a écrit :
> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
>> Danilo Krummrich (12):
>>    PCI: use generic driver_override infrastructure
>>    platform/wmi: use generic driver_override infrastructure
>>    vdpa: use generic driver_override infrastructure
>>    s390/cio: use generic driver_override infrastructure
>>    s390/ap: use generic driver_override infrastructure
> 
> Applied to driver-core-testing, thanks!
> 
>>    amba: use generic driver_override infrastructure
>>    cdx: use generic driver_override infrastructure
>>    hv: vmbus: use generic driver_override infrastructure
>>    rpmsg: use generic driver_override infrastructure
> 
> I have not picked these up, as they have not received ACKs from the
> corresponding subsystem maintainers so far.
> 
>>    bus: fsl-mc: use generic driver_override infrastructure

I droped it from soc_fsl tree, some dependency must be missing.

Feal free to take it if you can, it is acked-by Ioana.

>>    spi: use generic driver_override infrastructure
> 
> These have already been picked up via the respective subsystem trees -- thanks!
> 
> Thanks,
> Danilo


