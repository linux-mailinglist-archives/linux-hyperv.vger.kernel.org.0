Return-Path: <linux-hyperv+bounces-1873-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130788921C1
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Mar 2024 17:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDEB1F24051
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Mar 2024 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C115B1E7;
	Fri, 29 Mar 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEituwgn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0452D781;
	Fri, 29 Mar 2024 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730344; cv=none; b=jc+9bkBL2wQj3pMdI6pGRf1yh1g6kQWknddt2ymYF8jQ3fSy3k6iN6650yXpifj7sZ9OpFONQjev/G1sGNtxzuI43/EXps+kXmgu59fnBU8w95EbOseMoObcX/MBOd8t0ncmbc0uVFc1se+v+u0yqw33SKNfEwmYqoeTWkb+Xgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730344; c=relaxed/simple;
	bh=mu709RK6RdUvGezRsei4fEVVFDMPGmRnjx++n5sjyL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAJmHWzesT5fcmCnQNJhS2UiH0VZFtmDrdxPLag8o3wp6bYMw2/bl4rr196gudTn1VkTGidnH5lc4nrgFE76iz3JCvL7KlGCv60R7zr7idekbnicm9VuQ5ZmC6xayuwCK2db1rAKY8424a/Kre+R7/+XcQtzQtkNUS7E5VW9pNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEituwgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717E8C433C7;
	Fri, 29 Mar 2024 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711730343;
	bh=mu709RK6RdUvGezRsei4fEVVFDMPGmRnjx++n5sjyL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uEituwgn1xxAMuURhdwt3/iaLtwEGCu1+Mclwo9+Ty7wLbaMiWmyQU0rOPlf9vJzM
	 o13NJKluh2NnMuLRvgLiGrQVrebzv3a2gzICu48+3LXXhQ45oB4NluNbhd7SB44a70
	 M0Wt2X6l0SJT7LJi3C8GA4V9BEhry7YR3ma4wI/3OylDT4TAEwBE8hLV/q3auS8o5H
	 9muF3kTL6rkQ20Iba0mAQK6pIs92yEx6N2CKY/CrPm5aLVKXPn+H3gbBFziiX6OMqC
	 zpP4PltZewjblpXJOZBFZ8cpmv8jSqFoiAAks6EZfkeP36KAWbWprPmsY2/9TNUion
	 NxXBlJGeFB7CQ==
Date: Fri, 29 Mar 2024 22:08:58 +0530
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
	HaraldWelte@viatech.com, pierre@ossman.eu,
	Duncan Sands <duncan.sands@free.fr>,
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
Message-ID: <ZgbuotY4IX4iHm9U@matsya>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-3-apais@linux.microsoft.com>
 <ZgUGXTKPVhrA1tam@matsya>
 <2e9257af-c123-406b-a189-eaebeecc1d71@app.fastmail.com>
 <ZgW3j1qkLA-QU4iM@matsya>
 <CAOMdWSKY9D75FM3bswUfXn2o7bGtrei3G5kLt6JdcdOPDXaG8g@mail.gmail.com>
 <678ba20b-9f1d-41cb-8a25-e716b61ffafe@app.fastmail.com>
 <CAOMdWSKC4B8zn6N+=5DssB_BiR6JkHBEpJr0ohKb149eJvCKMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSKC4B8zn6N+=5DssB_BiR6JkHBEpJr0ohKb149eJvCKMQ@mail.gmail.com>

On 28-03-24, 13:01, Allen wrote:
> > >> > Since almost every driver associates the tasklet with the
> > >> > dma_chan, we could go one step further and add the
> > >> > work_queue structure directly into struct dma_chan,
> > >> > with the wrapper operating on the dma_chan rather than
> > >> > the work_queue.
> > >>
> > >> I think that is very great idea. having this wrapped in dma_chan would
> > >> be very good way as well
> > >>
> > >> Am not sure if Allen is up for it :-)
> > >
> > >  Thanks Arnd, I know we did speak about this at LPC. I did start
> > > working on using completion. I dropped it as I thought it would
> > > be easier to move to workqueues.
> >
> > It's definitely easier to do the workqueue conversion as a first
> > step, and I agree adding support for the completion right away is
> > probably too much. Moving the work_struct into the dma_chan
> > is probably not too hard though, if you leave your current
> > approach for the cases where the tasklet is part of the
> > dma_dev rather than the dma_chan.
> >
> 
>  Alright, I will work on moving work_struck into the dma_chan and
> leave the dma_dev as is (using bh workqueues) and post a RFC.
> Once reviewed, I could move to the next step.

That might be better from a performance pov but the current design is a
global tasklet and not a per chan one... We would need to carefully
review and test this for sure

-- 
~Vinod

