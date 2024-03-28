Return-Path: <linux-hyperv+bounces-1867-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D7B890959
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 20:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4996E1C27ACB
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01EF137C55;
	Thu, 28 Mar 2024 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/b7d3R1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A541757;
	Thu, 28 Mar 2024 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654784; cv=none; b=Fy/MY4fagtOn21d9nuVTsBLvuRjeXh1EWpZu5TKedSwy4C1pJd5eShW7krXlmo4ChLTmJ0iHWdEn6drPUI8siJKjAHGOAmj0zR4oiHRrM0cwC9jEBeqfCADoKrH4NTWqij4FXx3XXBMACvb2p5gAdcgugf4g/9P5v0Lu72CX/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654784; c=relaxed/simple;
	bh=622VK9NVBI6NV/BHlHroiE+gl2GqatwpJmnEQrqKhSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAiJpcXwdgg5DvIlDQ9mjTcXNUrXMnoZ692sxpEf1JCtuqpleI8IclxaGol+ttZ3HQqbDvg12OM68havwHG3iw8QheT18vBhOZbQKpmc+JItJVVaNbE0/dAXODpAOI5he/A8uthcNp2upuMMx47r5Mnd8RJAq8gyspqZtFMRpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/b7d3R1; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d43a1f0188so539825e0c.2;
        Thu, 28 Mar 2024 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711654782; x=1712259582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=622VK9NVBI6NV/BHlHroiE+gl2GqatwpJmnEQrqKhSw=;
        b=k/b7d3R1fU5uK+kSotRkB0lCHcUaksiunEIO+7V/B4ZHd2mTvo0WZ83tSH/kXbEyoA
         caceaoMwHso01SQxXTjgUFOhd+76A6Wc4+kTngdWJuBIdQZ1u6BthS9JKwyxXUjfaFH1
         KM8jWVzJg+wxcbf4Xpb1XzQw7hYBGxSmIeBOYQy4sj9MLKY0tXkKY64rtKpRqcDOOi/9
         PA8t7rwlbEa9OqB5aG7zC1lR1MFamBHia2IlmQrpl4CiIdSB9WXEKGyEnfZjO6naNJOD
         na6U5pDUB/3VN6ICO/w1hxi0VB2RFyjqAj7crGbhWabVk0pqeDZgJWI2vykTaMHZ+Uxv
         C9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654782; x=1712259582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=622VK9NVBI6NV/BHlHroiE+gl2GqatwpJmnEQrqKhSw=;
        b=gCr1ihnBI54swZRQY4zSQnn+LgOfMthcDa+naOl06FWwUNL3cXHsyACSaKmFiT+5gn
         u1l+1EXlRU/H+AeNKrjm36g5EyeztxavrKwZsjUgbYu9G64/3OSjwvMLHJmkplg5qVgc
         cKrZaz3AiJwTs81gX486x7t1zl/pihZxlwwNtTFbFzbG8OjUcPQ1SCb42jNsYdbC8gz2
         qrDsuB3mk8GQ89MzzymDG/ar8OBm8Hen3WzE0tlflkRqEfLT0fkvP11Xji8NC0HzNWJz
         ESYUb4GI1+HDFqS8U8Kv+nCpPHxeXL2EsCQjY5Lpd3KCwU+l7n+14v9JeUXGtb/2QXE7
         Br8A==
X-Forwarded-Encrypted: i=1; AJvYcCWf1W2N+dIzvu1ZEcwy51w6Z80zLjimand/ShK4RyBCcJOv4ouZdTwD6Tdm/hs7qltF3cYHRm2yVhcKuVckxMgrb2ZaiEQnhWgj03I+50qae3dpybEcXuT+GEZ89atWWkSXoRwF2IZLEUgmt7Smgk4Wq/ApwcJUm954UI8fycvmP2jXUz5XXMab1eLr5accZ1THQ6y/vTcmLTZJzO5DZbRAAQNG99FQlZUbczVTA5jTZCZ1G1oYEufa9toyLjnFngqIzqHN2idPFdFkKYhCm674+TkVdlXmilhdY+F5fPB2r4QO5gjw5HFXKtBF7wU5qwNnXB5xKwKuDFUTf/2A893wkLyVeGuTY7AKR85Id+DYJBy1xwi9uiZEfdC5sWk5Mr69bbgKJWeXYDQiX48PYe/WgU7V/hAnV7SHfyfe10aFFyR4cuRCX9ZovdX0GmgW6LEPZugPuz5T5iu92dV6wpX6bvdIuj1/vwJQxjVFTLIWWmMyI659PTd5h2tJGVfNr+xOu3JNmFUhevlijdXXg5zVFDxymv3wB5OIN6EsxirJCG+Fx61d0qwF1hFS6g0r65zqzq5lZZkVgwlJSwzq1hI=
X-Gm-Message-State: AOJu0YzfS/AMGNK0/ET20aRpT1/VuF8TPj9PhPtR8AL2+JXXpnTnAMrv
	qoxveckXjBDu4sU6SAmK0TP1BG4hbwwYqG+ygt4bK0e0EMk4YD/4nZ1rbjlMFy/5dT2yRsKFTkH
	xvhKqKpSpQbFqWzzJbGkWZ9BVp1o=
X-Google-Smtp-Source: AGHT+IEY59Ji/OARBUAoYgwqWp5p4Pop3R94bZWuKlJaRj9K8xYwJ5pD7jLBPmXxcg5SXNElqhUUtT98mEK7bvSO2Kc=
X-Received: by 2002:a1f:c801:0:b0:4d4:1cca:1a72 with SMTP id
 y1-20020a1fc801000000b004d41cca1a72mr369742vkf.6.1711654781874; Thu, 28 Mar
 2024 12:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-3-apais@linux.microsoft.com> <ZgUGXTKPVhrA1tam@matsya>
 <2e9257af-c123-406b-a189-eaebeecc1d71@app.fastmail.com> <ZgW3j1qkLA-QU4iM@matsya>
In-Reply-To: <ZgW3j1qkLA-QU4iM@matsya>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 28 Mar 2024 12:39:30 -0700
Message-ID: <CAOMdWSKY9D75FM3bswUfXn2o7bGtrei3G5kLt6JdcdOPDXaG8g@mail.gmail.com>
Subject: Re: [PATCH 2/9] dma: Convert from tasklet to BH workqueue
To: Vinod Koul <vkoul@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Allen Pais <apais@linux.microsoft.com>, 
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Paul Cercueil <paul@crapouillou.net>, Eugeniy.Paltsev@synopsys.com, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Viresh Kumar <vireshk@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Leo Li <leoyang.li@nxp.com>, zw@zh-kernel.org, 
	Zhou Wang <wangzhou1@hisilicon.com>, haijie1@huawei.com, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, logang@deltatee.com, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, peter.ujfalusi@gmail.com, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, maintainers@bluecherrydvr.com, 
	aubin.constans@microchip.com, Ulf Hansson <ulf.hansson@linaro.org>, 
	Manuel Lauss <manuel.lauss@gmail.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	"jh80.chung" <jh80.chung@samsung.com>, oakad@yahoo.com, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	brucechang@via.com.tw, HaraldWelte@viatech.com, pierre@ossman.eu, 
	duncan.sands@free.fr, Alan Stern <stern@rowland.harvard.edu>, 
	Oliver Neukum <oneukum@suse.com>, openipmi-developer@lists.sourceforge.net, 
	dmaengine@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org, 
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-s390@vger.kernel.org, 
	Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > >> The only generic interface to execute asynchronously in the BH context is
> > >> tasklet; however, it's marked deprecated and has some design flaws. To
> > >> replace tasklets, BH workqueue support was recently added. A BH workqueue
> > >> behaves similarly to regular workqueues except that the queued work items
> > >> are executed in the BH context.
> > >
> > > Thanks for conversion, am happy with BH alternative as it helps in
> > > dmaengine where we need shortest possible time between tasklet and
> > > interrupt handling to maximize dma performance
> >
> > I still feel that we want something different for dmaengine,
> > at least in the long run. As we have discussed in the past,
> > the tasklet context in these drivers is what the callbacks
> > from the dma client device is run in, and a lot of these probably
> > want something other than tasklet context, e.g. just call
> > complete() on a client-provided completion structure.
> >
> > Instead of open-coding the use of the system_bh_wq in each
> > dmaengine, how about we start with a custom WQ_BH
> > specifically for the dmaengine subsystem and wrap them
> > inside of another interface.
> >
> > Since almost every driver associates the tasklet with the
> > dma_chan, we could go one step further and add the
> > work_queue structure directly into struct dma_chan,
> > with the wrapper operating on the dma_chan rather than
> > the work_queue.
>
> I think that is very great idea. having this wrapped in dma_chan would
> be very good way as well
>
> Am not sure if Allen is up for it :-)

 Thanks Arnd, I know we did speak about this at LPC. I did start
working on using completion. I dropped it as I thought it would
be easier to move to workqueues.

Vinod, I would like to give this a shot and put out a RFC, I would
really appreciate review and feedback.

Thanks,
Allen

>
> --
> ~Vinod
>

