Return-Path: <linux-hyperv+bounces-9991-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GWXF8xF0WnxHAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-9991-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 19:09:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A6639BE1C
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 19:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D217300B139
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E3274B58;
	Sat,  4 Apr 2026 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mur2l9g+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5386341;
	Sat,  4 Apr 2026 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322567; cv=none; b=c+DIP8f7lo4+dScQuqsDF7tEURBMHZTMVfjJWXQZar5TvrJhh9a4I2hmd4mQe8Ng7UtJ/XJrIGuFdLdOBkTH1yoGNzS25wWy5pgHqgvXtenfVMCgHmynejYatZg/nybHmmYycHsLBUVjfKLKDqKkGU5g0lz+a0VzeC6r56PFe5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322567; c=relaxed/simple;
	bh=u8kt7OrQ/vRwebR8QID4XnX8+JNDMp1i5iK/K6bdNDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5yVs8D+L635rIKbwam5DXkkF8SPfX2JABaAxaWPcmjeh4WVHD+IgKz/suHPRLNSAccd8uYsIINDe33xZ9l4vFYM8zbhGkwzGGMeBp38KUWe4G/HBhQxqet0piKNqoXmgJDSTPbYgTIajp4fLWE4rG6a32BbR8fPcIQjWRllPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mur2l9g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6956BC19421;
	Sat,  4 Apr 2026 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775322567;
	bh=u8kt7OrQ/vRwebR8QID4XnX8+JNDMp1i5iK/K6bdNDA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mur2l9g+deVKWOVOfXlkgvgdKFA4eMN3VFsDjrp+nvoKeM3X3pstiyexcKEvOeD0a
	 RbWpztozc0h4lQoSWYVOnXtkhFF+JRtMTTya2FNPQi3D7loBz93/IYN7Ge2fCwnYY6
	 Re4J05NhHq8kCVMn7SJKTXcUdNw54AUQcOdwffM3zMjz7evbLjl/s54+7J+0y2RhZM
	 +Mi+DO81POzfix85rvYo25MmliRWwTmiQ4w8GEjh3lU6Bg01dUBrobNBgfy2tPEGch
	 AFl8Q1R0jHMSDedYpY3Yug+qqjGh5y0LuX4UV4lD2NPGO2GuUGdy7lPrJwFQklpETH
	 wOUF3U6ODslbQ==
Message-ID: <a8c85884-e2ba-4a3a-a660-9715f0de2704@kernel.org>
Date: Sat, 4 Apr 2026 19:09:11 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
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
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org
References: <20260324005919.2408620-1-dakr@kernel.org>
 <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
 <76355cb5-0b5d-4a29-9702-8d020a79f4c0@kernel.org>
 <DHKJ7VWI1CHO.3ETHUGQVPFFDE@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <DHKJ7VWI1CHO.3ETHUGQVPFFDE@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9991-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8A6639BE1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 04/04/2026 à 19:04, Danilo Krummrich a écrit :
> On Sat Apr 4, 2026 at 6:58 PM CEST, Christophe Leroy (CS GROUP) wrote:
>>
>>
>> Le 04/04/2026 à 17:07, Danilo Krummrich a écrit :
>>> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
>>>> Danilo Krummrich (12):
>>>>     PCI: use generic driver_override infrastructure
>>>>     platform/wmi: use generic driver_override infrastructure
>>>>     vdpa: use generic driver_override infrastructure
>>>>     s390/cio: use generic driver_override infrastructure
>>>>     s390/ap: use generic driver_override infrastructure
>>>
>>> Applied to driver-core-testing, thanks!
>>>
>>>>     amba: use generic driver_override infrastructure
>>>>     cdx: use generic driver_override infrastructure
>>>>     hv: vmbus: use generic driver_override infrastructure
>>>>     rpmsg: use generic driver_override infrastructure
>>>
>>> I have not picked these up, as they have not received ACKs from the
>>> corresponding subsystem maintainers so far.
>>>
>>>>     bus: fsl-mc: use generic driver_override infrastructure
>>
>> I droped it from soc_fsl tree, some dependency must be missing.
>>
>> Feal free to take it if you can, it is acked-by Ioana.
> 
> It is based on v7.0-rc5; if you want I can pick it up.

Yes please pick it up as my tree is based on rc1.

Thanks
Christophe


> 
>>>>     spi: use generic driver_override infrastructure
>>>
>>> These have already been picked up via the respective subsystem trees -- thanks!
>>>
>>> Thanks,
>>> Danilo
> 


