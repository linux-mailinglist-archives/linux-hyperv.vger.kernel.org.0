Return-Path: <linux-hyperv+bounces-1869-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641678909B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870D31C2DA44
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3F13A890;
	Thu, 28 Mar 2024 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="X3sVGjuP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="er4EJv7v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC2D13A87F;
	Thu, 28 Mar 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655412; cv=none; b=Y9Bb4rzsF4fR355Mb8eM4k7P1bYCD8k33El6W4rz2T5DYhI9xdNaxXTDUD+m/gaARdp33mz2rG2TY3n0ko2XdR7kiK+WG2s5TISka+D+r7fsfcGezxRRolRY7Av7eexkDOJgtoEpFajRgCw7YeGGKOSxkm+KSRMg5JV2Lp7+QKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655412; c=relaxed/simple;
	bh=82WZ09r8X2wdE/vjUS1bY2Z6AeLXgQBKptYWCvEjiiY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YlOwbM24sHVz27nZkQhWE+YS53sVX9gwDY+QgDtw2i06Ro6zFe4mpCX7qtMde0cePtoVqsWYw9OgkHmi2APKAKz+rQ8KotLXutbz34Gi4k9M6r9Pk0brNkOPHi7BXDwPvu3QlDT+UQIu493UiaWWl6G6Z3HenDj/HY1O/jZlMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=X3sVGjuP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=er4EJv7v; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1AE681140139;
	Thu, 28 Mar 2024 15:50:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 15:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711655408; x=1711741808; bh=BW4gpjPip0
	MIz7Sv02WTjVBL1poTtTjeiFToXn5W8yQ=; b=X3sVGjuPXyGkNnz0RtLc111lKk
	iDA1+K/BClsRH/uoanrfo/6bUQanVYQGzizx/DSwhnCo9sAk53BamXVqtPGpHHDN
	IoMhB+caj4C2Zvu1VkwXJcOGhb00OnxZr7g1p1ImAxtXgScCWekOI3dh5lq7+kK8
	756x4TJzYdvoyrophAYiXt3KYjXHkYVzLL2RyHA1PDPWAJmACkkFpqeR6hEX5FWT
	8c+kLk7X+ZdAN3MXMwTxay2K4pZLpTmn7xiq0pgk0vvm3NWi8FMLAxTocO69OSqh
	iJ1J/qbrLrXkBf3IzrD8N71zNtnUgScU7RzH9WmVJ74k6IuTpmP08DQuCAXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711655408; x=1711741808; bh=BW4gpjPip0MIz7Sv02WTjVBL1poT
	tTjeiFToXn5W8yQ=; b=er4EJv7vpQ314GUweWPL7lb7mIhf28FJ1g9uM9zUGh2E
	2hJujbQy01D5uJiU+OhkzwzO5csza+Cp1GOmcNOUTlMRDQak6Pb9OSCJ6JkVwDj+
	gDz2/CPyETbRahetWWZUmB359hYjbZANj30LmxFaNIYCbGIXcp200wWOQ5C3lt7U
	wL2g3ZZiveDcSKL4doiViZZ/AzcmMVwa6UrlQu5ph8EFzqsMY7PlJiM3xVszFBkD
	3rej2/Dqt/gc5KWKhCEilqKC3u4JlI1NT0dd69L/vBrSbcox+G2fv831znRQvhaC
	sQ026xHWJtNDKBsnQOWf2mAIzAI88OLjwBwJfxQ+hQ==
X-ME-Sender: <xms:7ckFZpDNYIkA2t9-qcVzdID6qP0usEKGYUQS1-wNkxjQGRgV4mdp-w>
    <xme:7ckFZngCnR-uaOutDT0Ozn25YFLpIo5sfMlExSRSHoKsbJmDmjrcD3K2G3N_CwBJZ
    DKGyHFhmgTxY3gtzb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7ckFZkk1EtQiblf_nid5SaPE8zuqyhxTpV7P0da2Bb0LaW4sXaWF3g>
    <xmx:7ckFZjyyz1nYkhvxUzj050Ly1qSCgVqx7fsYn6ARf5x2Wv71j6WHAA>
    <xmx:7ckFZuSPJGtGvhHfRwwFtoqahvwu7HLZTmxZZkly_Ml1Y149BBocVQ>
    <xmx:7ckFZma47lZuxhffrZb_n6fjlCTBI66VWrbQLoiXue6vLyXCRdmOyw>
    <xmx:8MkFZuzi9SW-igSjg52_ZUIskJ4gzWDF5zWFAwTDZzhoC52P6Oh2pg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7B52EB6008D; Thu, 28 Mar 2024 15:50:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <678ba20b-9f1d-41cb-8a25-e716b61ffafe@app.fastmail.com>
In-Reply-To: 
 <CAOMdWSKY9D75FM3bswUfXn2o7bGtrei3G5kLt6JdcdOPDXaG8g@mail.gmail.com>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-3-apais@linux.microsoft.com> <ZgUGXTKPVhrA1tam@matsya>
 <2e9257af-c123-406b-a189-eaebeecc1d71@app.fastmail.com>
 <ZgW3j1qkLA-QU4iM@matsya>
 <CAOMdWSKY9D75FM3bswUfXn2o7bGtrei3G5kLt6JdcdOPDXaG8g@mail.gmail.com>
Date: Thu, 28 Mar 2024 20:49:44 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: Allen <allen.lkml@gmail.com>, "Vinod Koul" <vkoul@kernel.org>
Cc: "Allen Pais" <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "Tejun Heo" <tj@kernel.org>, "Kees Cook" <keescook@chromium.org>,
 "Hector Martin" <marcan@marcan.st>, "Sven Peter" <sven@svenpeter.dev>,
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
 HaraldWelte@viatech.com, pierre@ossman.eu,
 "Duncan Sands" <duncan.sands@free.fr>,
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

On Thu, Mar 28, 2024, at 20:39, Allen wrote:
>> >
>> > Since almost every driver associates the tasklet with the
>> > dma_chan, we could go one step further and add the
>> > work_queue structure directly into struct dma_chan,
>> > with the wrapper operating on the dma_chan rather than
>> > the work_queue.
>>
>> I think that is very great idea. having this wrapped in dma_chan would
>> be very good way as well
>>
>> Am not sure if Allen is up for it :-)
>
>  Thanks Arnd, I know we did speak about this at LPC. I did start
> working on using completion. I dropped it as I thought it would
> be easier to move to workqueues.

It's definitely easier to do the workqueue conversion as a first
step, and I agree adding support for the completion right away is
probably too much. Moving the work_struct into the dma_chan
is probably not too hard though, if you leave your current
approach for the cases where the tasklet is part of the
dma_dev rather than the dma_chan.

      Arnd

