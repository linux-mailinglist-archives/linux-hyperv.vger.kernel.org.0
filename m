Return-Path: <linux-hyperv+bounces-1872-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4C6890A7F
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 21:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4BD294BF9
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 20:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F81139589;
	Thu, 28 Mar 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnFeXEgR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE61386A3;
	Thu, 28 Mar 2024 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656129; cv=none; b=i2zazoDTWaJ+6MLHup7TFr8mzieYqWXiKSqhmuRE8whDzvNM5moDrLnA5iTtntp6lh5hbpHHT7Cf513ObGPScB1GEyxgE5MBS+GckX0UkagcFfO4WU4l381154kCm8FUZA6MQnjFtB72tDWzwD/fN1qVnY7pnEgFZTD2NriNav8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656129; c=relaxed/simple;
	bh=vbVoj5mONYHNgf9JQ9GQnrB9tevCRqpIKROsT3wC2Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQDn780sZYebxjKuWtxtArXsoQWS8YUE2abjTwhaNi3kbxUgwTAWELPJ4cIkHFTfMmNmqLcNLjLU3rLSJs5enN7TARthl/qriO+GyTaTGZen/evS6B+ykAw9On6aihH6BOloC174SLUXGK0H0/X94B65tsXsx2iknOTJm2nJjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnFeXEgR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78bbed7adaaso62353085a.0;
        Thu, 28 Mar 2024 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711656126; x=1712260926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQZIemFmXjC6xyiLulQ43Ea/EhoY/GbG4RXFhJQU0/8=;
        b=MnFeXEgRmJ8f/Thf359xa0PfiBqvx125ew/dpKNWEckOjf+6AdypIilBzVHgmUxEB8
         j/cK6vSO/lus03UI2oeny9YgY2tG255XXyfkePANTbNipm3m9ifqWOVyecfIecWIfTpc
         7i4bmaI5QKpg9+xrUptRwlLzDXTR257RcAZUMgeZLInnagtlfVgsSZnnEPVAYg8kEGOU
         C1h3kCzgYWjPoO+XBGKACSt9Dlq571mr1I0iYroLoSPuaSX8x/6h+cKRNoMOmDVxan3a
         W6FK82S7VSZf36gvXV89NWkjuU2y2q9EGzU4UiIsjze2gfYHYL25kHnUR6CCS12s8k3h
         tAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656126; x=1712260926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQZIemFmXjC6xyiLulQ43Ea/EhoY/GbG4RXFhJQU0/8=;
        b=SLJlE9zejPDz7sGl+6KhHJKo4U1/cpYXZ4Os2DgJbhosAJz5VrFBFjN0tRNnp4V49R
         kw6Nd9SAX9LvEqH3wfDDtc1zBk26gntuUsqbBzjuIXmC3IvcylFsINa5OJla2fdTmSWv
         z2ahcSGbAvqwMaI3gA8f0t2Tr2AAd63z2EyNQSB1MxYqUWvh45mWfEo3VxKDAxk+ITNf
         flWdWLCchQHpurvnpJZ59cKM7sSdb2AtNSJPlGCrffM24H1R5MV1x9t/6ox8ScAf/D3N
         1/qAlKJVk9SG9u5t/nXoMBF/7fOsJFEHJStHCE2fypxxMxmMQCjw5BuHtXlzF8STbIYr
         Rjbw==
X-Forwarded-Encrypted: i=1; AJvYcCV5QhxBVq8GyDhaCGFeAz6pR3XPLpM5Es5GPX9kwesJYRAvjaqpb06hcjEhOFeOpDuBjTh2o2jOqR3kDGaoyYVTW1Sex+WVrD9BgfvUuUnD1H2RLrJ3KUkH5iEMTlzsNAh64w6NXONGjFo7NChEWUb0VzHwLQt+xGlqZG3BKWe2ReVKJxiAQXUwwDladpdMkSyVpksHR1vGzJ2TPeyfJr1VtWyh7SLF2ONkmwS4qalkuNP+5oDsXSEWlghadgfxJtYZaI6f1WKggVLfXEzJYiCXaDJ9C/d0TJTYFVFGH26c1WgB630WsrjUXYZ/XDa+vF4/QBTNclbcGOtaest0/byACtXI02nRhyF0d195J0qGljlVl0o+c2ETyDVJHlb3j26aE6FBcr7axDReDaRi78nqgNn/LB//szg02P3iBymBEWhZb76uQpkMtLiXBxQjKQOUwPv2ZPN23I4skbRfcCd9haSOuuSwCWE6+1FU6sAOb1BhlbBKk2dqcIMAtyRvxtsUne5RF3QjfhFwnuajS91Ex7PowdCTrz0KA9SE4oohSuP7RQhfx6MSA4fMoue0bDy9e3v1zIkI2TtP1GJG2yQ=
X-Gm-Message-State: AOJu0Ywga9JRFfjU/ra9iEZPIfgKMhFv5i2QAwcQedg1c/WcRSZ1+fGt
	j09Clmr3sygLEyltgYhZcU2vxs9wgVTl74VjDweQ2kNKYEzV4Hyp4PrxpW1l13qRWESm5VfH14K
	tDzhUbwUTq933fg/SNrczhExWjyQ=
X-Google-Smtp-Source: AGHT+IFQNOvoxYEranyGbOCvmAR4etDDhau+OcrTFex7JkKGx6yINzP/h18hs1c4qiY1arvh6SuEYWtwfkxWkgaJ4wM=
X-Received: by 2002:a05:620a:c4e:b0:78a:62a6:7e2f with SMTP id
 u14-20020a05620a0c4e00b0078a62a67e2fmr5081544qki.5.1711656126274; Thu, 28 Mar
 2024 13:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-3-apais@linux.microsoft.com> <ZgUGXTKPVhrA1tam@matsya>
 <2e9257af-c123-406b-a189-eaebeecc1d71@app.fastmail.com> <ZgW3j1qkLA-QU4iM@matsya>
 <CAOMdWSKY9D75FM3bswUfXn2o7bGtrei3G5kLt6JdcdOPDXaG8g@mail.gmail.com> <678ba20b-9f1d-41cb-8a25-e716b61ffafe@app.fastmail.com>
In-Reply-To: <678ba20b-9f1d-41cb-8a25-e716b61ffafe@app.fastmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 28 Mar 2024 13:01:55 -0700
Message-ID: <CAOMdWSKC4B8zn6N+=5DssB_BiR6JkHBEpJr0ohKb149eJvCKMQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] dma: Convert from tasklet to BH workqueue
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vkoul@kernel.org>, Allen Pais <apais@linux.microsoft.com>, 
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
	Duncan Sands <duncan.sands@free.fr>, Alan Stern <stern@rowland.harvard.edu>, 
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

> >> > Since almost every driver associates the tasklet with the
> >> > dma_chan, we could go one step further and add the
> >> > work_queue structure directly into struct dma_chan,
> >> > with the wrapper operating on the dma_chan rather than
> >> > the work_queue.
> >>
> >> I think that is very great idea. having this wrapped in dma_chan would
> >> be very good way as well
> >>
> >> Am not sure if Allen is up for it :-)
> >
> >  Thanks Arnd, I know we did speak about this at LPC. I did start
> > working on using completion. I dropped it as I thought it would
> > be easier to move to workqueues.
>
> It's definitely easier to do the workqueue conversion as a first
> step, and I agree adding support for the completion right away is
> probably too much. Moving the work_struct into the dma_chan
> is probably not too hard though, if you leave your current
> approach for the cases where the tasklet is part of the
> dma_dev rather than the dma_chan.
>

 Alright, I will work on moving work_struck into the dma_chan and
leave the dma_dev as is (using bh workqueues) and post a RFC.
Once reviewed, I could move to the next step.

Thank you.

- Allen

