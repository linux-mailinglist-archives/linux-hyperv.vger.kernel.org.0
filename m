Return-Path: <linux-hyperv+bounces-9988-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCI2K7tC0WlUHAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-9988-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 18:56:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5136D39BCDE
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 18:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAFC2300BD9F
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE1A274B58;
	Sat,  4 Apr 2026 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvkgz2VY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AEA1E515;
	Sat,  4 Apr 2026 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775321785; cv=none; b=YPNnJYdFs20DsfTQkg6WHGGOPvI1HAnvPTokJ/eH31mnrbI9I+AS9omqPrfWV5j5BGk8NHU7PcoQY7URjBrtgRUBLaxc1Gncjgyp5TrsrtW8hEpdUPRHnrT5KRzVPMA55mQhjMoTAXJ4y8jfPVAMhH55CQRQxVFaTqJ5TAC88w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775321785; c=relaxed/simple;
	bh=z0EKK9uCRclvxyjrhd1+SN0RRq/OFfBzrXy9eOqqb1Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j8rmXVfDsFTAyFGrkhr0F2czxvHmFU3BIqSGMyGvNZAvO+vcb/NywYLQGRFIbug0c7sSc4eQ7+C2qMblfeM1fgHOVhKCfV8umTaBF85VTPJGylfHayw2c1lhcrr5YJ5rPiNFUOC7BDFoDCNnJG/bHcdu4TRH7AkNmUFtOOg72h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvkgz2VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A189EC19421;
	Sat,  4 Apr 2026 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775321784;
	bh=z0EKK9uCRclvxyjrhd1+SN0RRq/OFfBzrXy9eOqqb1Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Pvkgz2VYtss1MeKDd1hCnXOqFhZSJT7sCBgib4Ld40MuoHbsbTzaQtqEQlHI315/z
	 sSsTrUhsdTJPdFsI6MsazCxIagVra3Yz7Nj6ieza8kV78SqaqqkR1jw4ERelqbogu8
	 P2C5HKTLPE156wtoOmaEhBjNWmWs1/5XjIm7Pn+IztUEvzTxOWgE4ijDSgxwxt7sHW
	 /z+by/VjXh6iXK4C6vfLmsq7Ld8muhOBjOIJmJuiMgdiDbMtkSfkPxjp0+PDXt64DF
	 SAsEhipno3UJ1XHvp0XZyChIymjhWJhckqoZh6Dfi1SExI1b8SJikdcJieSIN27yIj
	 n1QGwKpOYjS/A==
Message-ID: <faa68f96-5b10-45d0-a5dc-fac4350a7dd7@kernel.org>
Date: Sat, 4 Apr 2026 18:56:08 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] bus: fsl-mc: use generic driver_override
 infrastructure
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
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
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C4=82=C2=A9rez?=
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
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org,
 Gui-Dong Han <hanguidong02@gmail.com>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-3-dakr@kernel.org>
 <cvcetxkxjq2tz6n2vsofhyzove3qdi2e4r6rq6yxou3joejk2h@rmt5ygav7ssu>
 <4c5e9bad-82f0-4714-99c2-8ccd79a45043@kernel.org>
Content-Language: fr-FR
In-Reply-To: <4c5e9bad-82f0-4714-99c2-8ccd79a45043@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9988-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 5136D39BCDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 28/03/2026 à 13:10, Christophe Leroy (CS GROUP) a écrit :
> 
> 
> Le 25/03/2026 à 13:01, Ioana Ciornei a écrit :
>> On Tue, Mar 24, 2026 at 01:59:06AM +0100, Danilo Krummrich wrote:
>>> When a driver is probed through __driver_attach(), the bus' match()
>>> callback is called without the device lock held, thus accessing the
>>> driver_override field without a lock, which can cause a UAF.
>>>
>>> Fix this by using the driver-core driver_override infrastructure taking
>>> care of proper locking internally.
>>>
>>> Note that calling match() from __driver_attach() without the device lock
>>> held is intentional. [1]
>>>
>>> Link: https://eur01.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Flore.kernel.org%2Fdriver- 
>>> core%2FDGRGTIRHA62X.3RY09D9SOK77P%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4b9262ddecdd4ce29f9808de8a66485e%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639100369055903282%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BRfjlUkq7oWV%2F0v2S2B%2BEuxCY%2FLRQv6qHiEWiupd6kc%3D&reserved=0 [1]
>>> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
>>> Closes: https://eur01.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D220789&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4b9262ddecdd4ce29f9808de8a66485e%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639100369055936232%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=XL1K1ICiygOZnlvDUbQFe192KnLsBQms0HFNGCuyz%2Fw%3D&reserved=0
>>> Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' 
>>> in the mc-bus")
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>
>> Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>>
> 
> 
> Applied, thanks

Have to drop it for now, build fails:

   CALL    scripts/checksyscalls.sh
   CC      drivers/bus/fsl-mc/fsl-mc-bus.o
drivers/bus/fsl-mc/fsl-mc-bus.c: In function 'fsl_mc_bus_match':
drivers/bus/fsl-mc/fsl-mc-bus.c:92:15: error: implicit declaration of 
function 'device_match_driver_override' 
[-Werror=implicit-function-declaration]
    92 |         ret = device_match_driver_override(dev, drv);
       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bus/fsl-mc/fsl-mc-bus.c: At top level:
drivers/bus/fsl-mc/fsl-mc-bus.c:321:10: error: 'const struct bus_type' 
has no member named 'driver_override'
   321 |         .driver_override = true,
       |          ^~~~~~~~~~~~~~~
drivers/bus/fsl-mc/fsl-mc-bus.c:321:28: warning: initialization of 
'const char *' from 'int' makes pointer from integer without a cast 
[-Wint-conversion]
   321 |         .driver_override = true,
       |                            ^~~~
drivers/bus/fsl-mc/fsl-mc-bus.c:321:28: note: (near initialization for 
'fsl_mc_bus_type.dev_name')
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:289: 
drivers/bus/fsl-mc/fsl-mc-bus.o] Error 1
make[4]: *** [scripts/Makefile.build:546: drivers/bus/fsl-mc] Error 2
make[3]: *** [scripts/Makefile.build:546: drivers/bus] Error 2
make[2]: *** [scripts/Makefile.build:546: drivers] Error 2
make[1]: *** [/home/chleroy/linux-powerpc/Makefile:2101: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Christophe


