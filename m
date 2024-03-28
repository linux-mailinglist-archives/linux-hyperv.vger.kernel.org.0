Return-Path: <linux-hyperv+bounces-1865-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB41890853
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 19:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23FE1C25363
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 18:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B711369AA;
	Thu, 28 Mar 2024 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ+Ol01e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3C1327F8;
	Thu, 28 Mar 2024 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650709; cv=none; b=SMfPpC/Ltxe6Y8bC5SBajqJZrUZLWeDjd2q2tPn0YmZY9VqROns4nCSEjN28OGtBPUoFVC6vNDa/1JN0QcGmhBt6aACp2g2UpXJYEOUrvYNlyQdao53zf+y/wfrcMLfoc7GQcKGxMhctD+J7/mfxBTufds1UkseUkYlu5fDxnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650709; c=relaxed/simple;
	bh=09Kq07Ctu1YK6YAopY47/y5AlbJwjHjNBMXfeYxKY3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mc+bmHU7JCh9T2qz/jKyKISblvHUMRyjYOEKwefhMp+SpBo+KEZunCDaUOfyxVqaH2nRtbEFzsaXfY7St2PHPArtNQ18jv3kbP8sMNYjt2B8WRyDhc54G3/LIVhXybYiD9uu0NBwwzc92ifzdPX4yIYM9RzRZUURIOKxpkoXwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ+Ol01e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9561C433C7;
	Thu, 28 Mar 2024 18:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711650709;
	bh=09Kq07Ctu1YK6YAopY47/y5AlbJwjHjNBMXfeYxKY3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQ+Ol01eGrtbmmXmm5UOF8z3YVrAFzrLyUinoyXQOw2oD/3BtgXxtRpcyL6qEGHMi
	 Fuf1dGmu1+mXVCx0A2v+QG1OZmZa5GwKeTprSp0vXiGl5WvN4w7glf0wb/Ho4jGsI6
	 A7WhuNfxRZ+SYEDd2EHDavctgY396ec7mZY6h+UmOVbwQhncgmm56Grgtq512eTU0I
	 juRVEJtAyO8mA2/2SAJmqgsMiWvU8lqDqaMAEVDmDUSGgn+tYLJ7mum23hafaIgM0S
	 0/cB+mlWradcKD4+nkGPqD1rFiy3Q7s73Qm1b4qRq5IHy2lK358t2WVn9s4EqNJkuF
	 qXaWYWlrz6OoQ==
Date: Fri, 29 Mar 2024 00:01:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
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
Message-ID: <ZgW3j1qkLA-QU4iM@matsya>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-3-apais@linux.microsoft.com>
 <ZgUGXTKPVhrA1tam@matsya>
 <2e9257af-c123-406b-a189-eaebeecc1d71@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e9257af-c123-406b-a189-eaebeecc1d71@app.fastmail.com>

On 28-03-24, 11:08, Arnd Bergmann wrote:
> On Thu, Mar 28, 2024, at 06:55, Vinod Koul wrote:
> > On 27-03-24, 16:03, Allen Pais wrote:
> >> The only generic interface to execute asynchronously in the BH context is
> >> tasklet; however, it's marked deprecated and has some design flaws. To
> >> replace tasklets, BH workqueue support was recently added. A BH workqueue
> >> behaves similarly to regular workqueues except that the queued work items
> >> are executed in the BH context.
> >
> > Thanks for conversion, am happy with BH alternative as it helps in
> > dmaengine where we need shortest possible time between tasklet and
> > interrupt handling to maximize dma performance
> 
> I still feel that we want something different for dmaengine,
> at least in the long run. As we have discussed in the past,
> the tasklet context in these drivers is what the callbacks
> from the dma client device is run in, and a lot of these probably
> want something other than tasklet context, e.g. just call
> complete() on a client-provided completion structure.
> 
> Instead of open-coding the use of the system_bh_wq in each
> dmaengine, how about we start with a custom WQ_BH
> specifically for the dmaengine subsystem and wrap them
> inside of another interface.
> 
> Since almost every driver associates the tasklet with the
> dma_chan, we could go one step further and add the
> work_queue structure directly into struct dma_chan,
> with the wrapper operating on the dma_chan rather than
> the work_queue.

I think that is very great idea. having this wrapped in dma_chan would
be very good way as well

Am not sure if Allen is up for it :-)

-- 
~Vinod

