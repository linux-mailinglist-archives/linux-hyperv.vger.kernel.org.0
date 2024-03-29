Return-Path: <linux-hyperv+bounces-1874-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272478921D2
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Mar 2024 17:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9911F24332
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Mar 2024 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8D780600;
	Fri, 29 Mar 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW7qxP8y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1422075;
	Fri, 29 Mar 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730379; cv=none; b=W0SvH0vhQF5Daz/mkL2FjSexSefYH+RudWNOQ9mM9pziEPMGYTFGKxWLV92lKlTFzZ4/ZvBwKl3nsGXRWqGpWwDSP2Cg2gwzkMhgceq7Mn3Bn6E1kxg4/U2K+q/Y68BX4OncRfDy9EueLLmOrqFvagA1GRau7CB9enAwYRmnRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730379; c=relaxed/simple;
	bh=bg+h7PlnfTedz1YBjzApxZkMOAnsBGDd8/EzMTXhZfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFqDq9Fg2X0yRxLQCIq4kT74ICYEQkQ9Ig+AV/efNoNp6CpybpsL4e3Jyq4r4aFWahKP8xbk1E4uWsOACZiyzlpiwTBlfGuxlVcBWACjSC8KNy5BpcE1QOlHAXFaic/nr72DLOu7evcB0CXVangeKuZi8wxvigdTvQSTIgSahRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW7qxP8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D9DC433C7;
	Fri, 29 Mar 2024 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711730378;
	bh=bg+h7PlnfTedz1YBjzApxZkMOAnsBGDd8/EzMTXhZfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uW7qxP8y8ACgUR891lLqNXK4nRCSSexkXmk3NVlX/43RdUbJKhMUBo+3F7ImHHCLd
	 EgMy3VnFONlXXBX8N/84xV65QgEoe3byfIcVSoYOnvkYvas222h0lZkI0ts/7GK5dK
	 RXDBa+pCTcdJsCx5bNqP+0NeWpjfPDjTw0LzbJBD2TGFbdPiUtd9S2xCHSf/YkWg3h
	 LkeVRnbJmAa4tPbrg134PWkZdQ7HBQC4t3veXbL+goDjmVnDap5Tj4fOkvn8ClJwbk
	 uuZW1rzs8wZhLpPlp2dMwsOxB3VXY8Xf/XxfLnuX/VdqMAE2Sw5BpezoMJa9uZRiGz
	 dYTGMY6Ps7ZVQ==
Date: Fri, 29 Mar 2024 22:09:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Allen Pais <apais@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Kees Cook <keescook@chromium.org>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Paul Cercueil <paul@crapouillou.net>, Eugeniy.Paltsev@synopsys.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Viresh Kumar <vireshk@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Leo Li <leoyang.li@nxp.com>, zw@zh-kernel.org,
	Zhou Wang <wangzhou1@hisilicon.com>, haijie1@huawei.com,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	logang@deltatee.com, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>, peter.ujfalusi@gmail.com,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	maintainers@bluecherrydvr.com, aubin.constans@microchip.com,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	"jh80.chung" <jh80.chung@samsung.com>, oakad@yahoo.com,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, brucechang@via.com.tw,
	HaraldWelte@viatech.com, pierre@ossman.eu, duncan.sands@free.fr,
	Alan Stern <stern@rowland.harvard.edu>,
	Oliver Neukum <oneukum@suse.com>,
	openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-mediatek@lists.infradead.org,
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	linux-s390@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/9] dma: Convert from tasklet to BH workqueue
Message-ID: <ZgbuxmxncU0-0jhA@matsya>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-3-apais@linux.microsoft.com>
 <ZgUGXTKPVhrA1tam@matsya>
 <2e9257af-c123-406b-a189-eaebeecc1d71@app.fastmail.com>
 <ZgW3j1qkLA-QU4iM@matsya>
 <CAOMdWSKY9D75FM3bswUfXn2o7bGtrei3G5kLt6JdcdOPDXaG8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSKY9D75FM3bswUfXn2o7bGtrei3G5kLt6JdcdOPDXaG8g@mail.gmail.com>

On 28-03-24, 12:39, Allen wrote:

> > I think that is very great idea. having this wrapped in dma_chan would
> > be very good way as well
> >
> > Am not sure if Allen is up for it :-)
> 
>  Thanks Arnd, I know we did speak about this at LPC. I did start
> working on using completion. I dropped it as I thought it would
> be easier to move to workqueues.
> 
> Vinod, I would like to give this a shot and put out a RFC, I would
> really appreciate review and feedback.

Sounds like a good plan to me

-- 
~Vinod

