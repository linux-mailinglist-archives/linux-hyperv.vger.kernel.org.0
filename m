Return-Path: <linux-hyperv+bounces-1856-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF888FC6E
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 11:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0031C24A88
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26E57BAFE;
	Thu, 28 Mar 2024 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kuMfx8bc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E7CyJ3/s"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118C53E28;
	Thu, 28 Mar 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620553; cv=none; b=EnaqEe2QUFIs8TC+WICkGDZbH4V8VpB9vOelr1DsNs9YtqAYOAIa/mBICx9YxJiwnEsxPvQS5vlFEWVUmlAvKQsRXykysudS9WqM7sEUZDvolOSPnv30jAG5PYAtHA2x8d5p0M4iPkY+BywZmg8+n+hp/he8ZVLTlPQr3XoCr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620553; c=relaxed/simple;
	bh=rjRj8lT9t8c0kTmFFh6anVK23ZDO/NaAc4KKhIVP/Dg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pgza2ybZzsFYyiDRMB00k8z+4gp+4nQ1/S3jErV3GuJ8R3SVhCGZn6iVeaacnIEWLdEE88n1HW1qqaHtFNDNDsP2T97nvLBlcTVTE6YnPn5VsxT50sYycS3D4MZCd64kB66n5ZcCtiHH575KJwjfztDT1XdLN/SnYNC1oghyDb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kuMfx8bc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E7CyJ3/s; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 93C1413800CC;
	Thu, 28 Mar 2024 06:09:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 06:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711620550; x=1711706950; bh=pYBjGEQadh
	25rkMc0fkoc5Y7p79L1tP3xKDkS0IogRA=; b=kuMfx8bc1R4WUipcKL3tIzF3N4
	t3zOBlcnNWDIjDe7ipHZ2vdT8gjFEPI1e+ODQbTkh7dUk5LNLdH719riG/7S23u9
	309OowkR1D0rX5rjd1oDDkcNZe/zfRVVl/h7s7JfZ0aDU1bPjSm0hIEnzbFG9z5d
	fZQs/LIhA7ZaDgthlMZZPByr7T+nIaqNafh0zRk/d9JNzTnIwNM75wPeatuGsvJu
	Vq9S8uOTkkaEMlwp3RXo+JBYMzLwFYLCKo/A1UzzbQWuBCuXekHkJzt6XPQ8TNq0
	tQYhv/S7h0++y+XLR2ohIzKvK/W4GKBW0sO7O0tHfshYhs7bYX0yHfgvb/2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711620550; x=1711706950; bh=pYBjGEQadh25rkMc0fkoc5Y7p79L
	1tP3xKDkS0IogRA=; b=E7CyJ3/sS3/gu76u1633stL9057wQIWYvG9vs6NHo239
	7KFVH5M+YFwRBpbadfOh0IrOE9j4E7XE2sRBAIPKToAbDSVOK/ax1a0sOrbNo1ee
	HE2lX3ra68I5G6+wDY65qsdnqLej3HDSJFNyvB6/pL9He2U4fdOMxGYaZ0mva4gx
	tJF6Lfvk2fEXAm0uFD9oIE3EiQrZhWq8TW2d9nb3vmsns61RTvDrPIxeT4GFvMi/
	wMG6FliHZtmYgvC6R+hGoAU23GBHUBuECiPfrHriLa5i6tczRd0gr63KSOr/UuG+
	wWszyTwz22LUBqLfZhgf0rb6euQgm1MTKFDblo6DTg==
X-ME-Sender: <xms:xEEFZolFPnT81Y-rndenCatO24lANcXwvUAv5AbEcS6B-fVcESzGpg>
    <xme:xEEFZn3NPqHUVb1AhRyUqb5lXl84u2sw1P5dnDZdhqRie4xQImtwjSJc52BIh0l55
    tLPsrk9hiHSfeAkQ-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xEEFZmok-OCemU4JAF5NU7jOeDZ0210zw_dLM7C15bHf57_OfZn3fQ>
    <xmx:xEEFZkkp-nxlq4w1XAeOI--fNjf8CgUJC5qdXlw0QOLYa6255LvI2g>
    <xmx:xEEFZm3uKpGPWEVtVjuP0m1GHYswkywEhk7aH97h7ry4lumVs3mO8w>
    <xmx:xEEFZrsO4DTwAwnWN8Y9emNtvmcbBvklHjtDyl9-an0DJHfoFqkixQ>
    <xmx:xkEFZk17tDydakQ4cViz-gWKfkvwjCrZ3ZRO6zwIJ5CzvibKhGcP5g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E6410B6008D; Thu, 28 Mar 2024 06:09:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2e9257af-c123-406b-a189-eaebeecc1d71@app.fastmail.com>
In-Reply-To: <ZgUGXTKPVhrA1tam@matsya>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-3-apais@linux.microsoft.com> <ZgUGXTKPVhrA1tam@matsya>
Date: Thu, 28 Mar 2024 11:08:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vinod Koul" <vkoul@kernel.org>, "Allen Pais" <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "Tejun Heo" <tj@kernel.org>,
 "Kees Cook" <keescook@chromium.org>, "Hector Martin" <marcan@marcan.st>,
 "Sven Peter" <sven@svenpeter.dev>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Ray Jui" <rjui@broadcom.com>, "Scott Branden" <sbranden@broadcom.com>,
 "Paul Cercueil" <paul@crapouillou.net>, Eugeniy.Paltsev@synopsys.com,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Viresh Kumar" <vireshk@kernel.org>, "Frank Li" <Frank.Li@nxp.com>,
 "Leo Li" <leoyang.li@nxp.com>, zw@zh-kernel.org,
 "Zhou Wang" <wangzhou1@hisilicon.com>, haijie1@huawei.com,
 "Shawn Guo" <shawnguo@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Sean Wang" <sean.wang@mediatek.com>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, logang@deltatee.com,
 "Daniel Mack" <daniel@zonque.org>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Orson Zhai" <orsonzhai@gmail.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Chunyan Zhang" <zhang.lyra@gmail.com>,
 "Patrice Chotard" <patrice.chotard@foss.st.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Chen-Yu Tsai" <wens@csie.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, peter.ujfalusi@gmail.com,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>,
 "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 maintainers@bluecherrydvr.com, aubin.constans@microchip.com,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Manuel Lauss" <manuel.lauss@gmail.com>,
 =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
 "jh80.chung" <jh80.chung@samsung.com>, oakad@yahoo.com,
 "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, brucechang@via.com.tw,
 HaraldWelte@viatech.com, pierre@ossman.eu, duncan.sands@free.fr,
 "Alan Stern" <stern@rowland.harvard.edu>,
 "Oliver Neukum" <oneukum@suse.com>,
 openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-mediatek@lists.infradead.org, linux-actions@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linux-s390@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/9] dma: Convert from tasklet to BH workqueue
Content-Type: text/plain

On Thu, Mar 28, 2024, at 06:55, Vinod Koul wrote:
> On 27-03-24, 16:03, Allen Pais wrote:
>> The only generic interface to execute asynchronously in the BH context is
>> tasklet; however, it's marked deprecated and has some design flaws. To
>> replace tasklets, BH workqueue support was recently added. A BH workqueue
>> behaves similarly to regular workqueues except that the queued work items
>> are executed in the BH context.
>
> Thanks for conversion, am happy with BH alternative as it helps in
> dmaengine where we need shortest possible time between tasklet and
> interrupt handling to maximize dma performance

I still feel that we want something different for dmaengine,
at least in the long run. As we have discussed in the past,
the tasklet context in these drivers is what the callbacks
from the dma client device is run in, and a lot of these probably
want something other than tasklet context, e.g. just call
complete() on a client-provided completion structure.

Instead of open-coding the use of the system_bh_wq in each
dmaengine, how about we start with a custom WQ_BH
specifically for the dmaengine subsystem and wrap them
inside of another interface.

Since almost every driver associates the tasklet with the
dma_chan, we could go one step further and add the
work_queue structure directly into struct dma_chan,
with the wrapper operating on the dma_chan rather than
the work_queue.

      Arnd

