Return-Path: <linux-hyperv+bounces-1860-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA58904E6
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 17:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665951C2F77E
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8C5130A78;
	Thu, 28 Mar 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVuIXyRn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6454773;
	Thu, 28 Mar 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642898; cv=none; b=BHUkZ6vvnwRgFvZ6jxndEHokw+bnU5zvpjpPKKkXUT+ZhjMdskH8bffiyC3mA3YkF07ItCn3eGOFzjeni6DC9OFQG7+EVJuJoHvtG2nkUZMmCdmxXWwwK2vsTEAvWUXM+DMAfLUexdP+bv3LALltiFfPBwqRBuMOKAEnO2kgBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642898; c=relaxed/simple;
	bh=cb1ZOrJZuOdP2ez095r01xUHOIJ2EXFtH/u5E76hFpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAhf7W5BBJMJ3JZlhj6tK4Y1CsQk7EUJvVfC80lWKgREqWMNqXlf/ocVGknyxh5SDRV1yyydgQno6frJ/+VV5GIrZfWNP2hAR89j6QBAiI9UUcXx+LGljNLQaibuKlMk7y1PHr9Aup9Q/+YgNXU/5Qbwo1sw5shnsM++cljPDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVuIXyRn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ea80de0e97so860362b3a.2;
        Thu, 28 Mar 2024 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711642896; x=1712247696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpQlnbUKf5vfOk3TpOVHNGMqh00k5XUuxEvlHT+naYc=;
        b=GVuIXyRnEOti+ZArUGMdas65Ycfks2BEQJ4q6b3IftsM7hrnlM5TcjQrmI9itmCfCA
         JricJsaqQJnC6govb5/aWFTyxzJKmUcvAg9+QstTk8xKKRvfKuA0Z330a1GfhBQSs9mY
         5h+sdUlJ1osXdd+W8DbS3t32g0GraRuodbQp+As2heEByotL5ahFqNZUc8SCu9MAC5zv
         g+BIpTZCcdg0fuMpFCvVo/GfpPglVlL616W4yGw3XQasSu35z7h1iOJvh1w3NZk28srh
         A9F/+jcc2sRAVGM8NcNp2o5dLfYuvGHfzLTz0FETHx5DFIe9kLBtYHWFpz07qaFnVprw
         Jurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711642896; x=1712247696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpQlnbUKf5vfOk3TpOVHNGMqh00k5XUuxEvlHT+naYc=;
        b=WbhvvZVXvqXNwxGifGABAucJq7CdaeEHdPTIEZIYFUasPntOMj/VixM1/OnE+SIMsj
         bm8yrbb2xqV5Bvg9d8Zu49KEfVDU4pPsbfjDfHc+YTjnTFK0c9HsnuQ3G9CglMEbYXLc
         WJjlsOeqFKktVkmg/HsMLRFx5zP7g6FaWBy/AAuJgRI1nfvfIjqRGznFObauVFqRdtYy
         Ls0HjEkAX3fqvgdFqPrlj0IyOaU0gDciDzMJfT5hEsYTvb0NjW/nKiEUMUXNYXQonTTO
         K1eiceMx5nbX0yxHurqel5DMCaawJyYUxOQjmtsiyVMF6m56G27cvot0ledIkzgJN6uK
         EkSg==
X-Forwarded-Encrypted: i=1; AJvYcCXA4VnwcHmiG3PLYRXiRv3RSsC7Zw9+nMj3WMq9kgtD6t7Ao5zynCAeMmP44jmQYozq0PlpiZPkvz9ivy6hDSSnWpKFrKZx+fui3ZPogELN1Pu4gdqGwmpEvyoJaIxj7z6eL3D6lVhKUZX3fltZDnhnNK19ogzNAoQhqqMXX5Ridk+mzQnxzjSSz2/6i3nyyzb+b2d3ExW4jQKYlBmV016TPz0x0mirUU3/DfeaDGi8XMY/FJLo6y12ubr1R2u2rirEu8jjsryxqVSFIsNxFJSv/HW5IlOVx7RD6nGAY+6Z81jN6cG8R1f78H0iVzlcRHO82yzFBr5BB8Qstre5/lgCru+y57AS5/i1EOcV3za0QTPcIkVbq8v45uOr1HfoEuJlwbQty0LoQXEv+fGk7Ust8bVC562BR73AAegs6nv6m5xs69gUxH9IHco2drv15MFhoyjZBE/10Aj6DSEP3TRMtqERwRltPzTjAIYDskyiRaa78rJMU3zM1wLNT6vhscCDTs4GKbFmox2yykuIbm3KEiF5l7a3JzLmQqbrAruXqZwbYHAglrvcVnDGcD4VWDKjk+blSPz0inKKFz2kQqQ=
X-Gm-Message-State: AOJu0Yy8eOH7vv0e0wUekk9QIfnTvtX/McJ3TqODamXZt2p/lIv1AviE
	vSp3MAyO/hu/kc0MhmmbPaC2lArjiUX/ji4wCbhNW2tnapf1W/ff
X-Google-Smtp-Source: AGHT+IHNLtSIfLiMjPgdNbH73n29Rqo4mQsh/oBERN464FH6NwbPkAtXL24hv7Aec7RU+H+HqkGb1w==
X-Received: by 2002:a05:6a20:7495:b0:1a5:7308:3297 with SMTP id p21-20020a056a20749500b001a573083297mr1591044pzd.0.1711642896210;
        Thu, 28 Mar 2024 09:21:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4d4e])
        by smtp.gmail.com with ESMTPSA id fd37-20020a056a002ea500b006eab6ac1f83sm1576815pfb.0.2024.03.28.09.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:21:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 06:21:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	keescook@chromium.org, vkoul@kernel.org, marcan@marcan.st,
	sven@svenpeter.dev, florian.fainelli@broadcom.com,
	rjui@broadcom.com, sbranden@broadcom.com, paul@crapouillou.net,
	Eugeniy.Paltsev@synopsys.com, manivannan.sadhasivam@linaro.org,
	vireshk@kernel.org, Frank.Li@nxp.com, leoyang.li@nxp.com,
	zw@zh-kernel.org, wangzhou1@hisilicon.com, haijie1@huawei.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	afaerber@suse.de, logang@deltatee.com, daniel@zonque.org,
	haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
	andersson@kernel.org, konrad.dybcio@linaro.org, orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
	patrice.chotard@foss.st.com, linus.walleij@linaro.org,
	wens@csie.org, jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jassisinghbrar@gmail.com, mchehab@kernel.org,
	maintainers@bluecherrydvr.com, aubin.constans@microchip.com,
	manuel.lauss@gmail.com, mirq-linux@rere.qmqm.pl,
	jh80.chung@samsung.com, oakad@yahoo.com,
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	brucechang@via.com.tw, HaraldWelte@viatech.com, pierre@ossman.eu,
	duncan.sands@free.fr, stern@rowland.harvard.edu, oneukum@suse.com,
	openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-mediatek@lists.infradead.org,
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 9/9] mmc: Convert from tasklet to BH workqueue
Message-ID: <ZgWZDtNU4tCwqyeu@slm.duckdns.org>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-10-apais@linux.microsoft.com>
 <CAPDyKFpuKadPQv6+61C2pE4x4FE-DUC5W6WCCPu9Nb2DnDB56g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpuKadPQv6+61C2pE4x4FE-DUC5W6WCCPu9Nb2DnDB56g@mail.gmail.com>

Hello,

On Thu, Mar 28, 2024 at 01:53:25PM +0100, Ulf Hansson wrote:
> At this point we have suggested to drivers to switch to use threaded
> irq handlers (and regular work queues if needed too). That said,
> what's the benefit of using the BH work queue?

BH workqueues should behave about the same as tasklets which have more
limited interface and is subtly broken in an expensive-to-fix way (around
freeing in-flight work item), so the plan is to replace tasklets with BH
workqueues and remove tasklets from the kernel.

The [dis]advantages of BH workqueues over threaded IRQs or regular threaded
workqueues are the same as when you compare them to tasklets. No thread
switching overhead, so latencies will be a bit tighter. Wheteher that
actually matters really depends on the use case. Here, the biggest advantage
is that it's mostly interchangeable with tasklets and can thus be swapped
easily.

Thanks.

-- 
tejun

