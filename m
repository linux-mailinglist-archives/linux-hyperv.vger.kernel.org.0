Return-Path: <linux-hyperv+bounces-1900-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648798954E0
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 15:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B60C0B25220
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0578625D;
	Tue,  2 Apr 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLBmLWbF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7B84A52;
	Tue,  2 Apr 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063487; cv=none; b=Ab+4DOG88HjoOiv4xBM47NxBmgiUFTY3Hy9u7A04HCzOSu5NaXU36utXhJrr9XqYteA58Vepp88PWfxm6gwz+AkPWWY6MSEYgos95d9h2owMCb5CDLtcG02ywQd3NJT2J8z8KmBjuZNtjiGNR8lguydLm74MZtOuQ/1o9cukWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063487; c=relaxed/simple;
	bh=9zAsnZKUtdaB+0oUBoSFWoiBkfOWRDSb/L5GPa9FOno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxBMH/vw9BRleuY+Tgiarjh9bwd72GPxFeu0mmPcJREbnWAJBZN/yKpfG4Kaaw+TbuiZXI9i0CP5GUV3A+mByQFFdOpijlcJdW5RjXrn4OVvBEWp4ZFd+dDZ7/Uk5W0BYB24fbqwaTmKHhiEhGZq2SnC/vrbfUdgjDel2Xq/w7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLBmLWbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE50C433F1;
	Tue,  2 Apr 2024 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712063486;
	bh=9zAsnZKUtdaB+0oUBoSFWoiBkfOWRDSb/L5GPa9FOno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLBmLWbFq8b7R4iZ1CSvRnROpQc318dtdynLw3zTplx/2SSnxsPhnBaGB0KWLxJLw
	 gtTVGsvy4tfXtBGJpBXwq9+p3MCPwkvK/hDkMvCwjFUh5usnZu6XFTibfhvcKn+2H6
	 bNq+gdNLc+F4UpxqMWgGKmEwi+KPVyCSJwAIqsT2U4GGmN/LnMTaAplp/AjMnXlBu3
	 Ft/ordeAQQOyjQYy8NAB2+7Nq/5pKWCsboYnCGnNR1VKTyBFWEf/lcch7254rsWnWE
	 MLVvNT3x0cyP38rdvhtkwlombEcbUi6JLHcn3CjFq0MSnQTG+8Cf+UPPNEYFD7jwHP
	 CjyG1mwKRgoUQ==
Date: Tue, 2 Apr 2024 18:41:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	tj@kernel.org, keescook@chromium.org, marcan@marcan.st,
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
	patrice.chotard@foss.st.com, wens@csie.org,
	jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jassisinghbrar@gmail.com, mchehab@kernel.org,
	maintainers@bluecherrydvr.com, aubin.constans@microchip.com,
	ulf.hansson@linaro.org, manuel.lauss@gmail.com,
	mirq-linux@rere.qmqm.pl, jh80.chung@samsung.com, oakad@yahoo.com,
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
Subject: Re: [PATCH 2/9] dma: Convert from tasklet to BH workqueue
Message-ID: <ZgwD-iScEb9zzB8H@matsya>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-3-apais@linux.microsoft.com>
 <CACRpkdaSBGe0EFm1gK-7qPK4e6T2H1dxFXjhJqO2hWCm1-bNdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaSBGe0EFm1gK-7qPK4e6T2H1dxFXjhJqO2hWCm1-bNdA@mail.gmail.com>

On 02-04-24, 14:25, Linus Walleij wrote:
> Hi Allen,
> 
> thanks for your patch!
> 
> On Wed, Mar 27, 2024 at 5:03 PM Allen Pais <apais@linux.microsoft.com> wrote:
> 
> > The only generic interface to execute asynchronously in the BH context is
> > tasklet; however, it's marked deprecated and has some design flaws. To
> > replace tasklets, BH workqueue support was recently added. A BH workqueue
> > behaves similarly to regular workqueues except that the queued work items
> > are executed in the BH context.
> >
> > This patch converts drivers/dma/* from tasklet to BH workqueue.
> >
> > Based on the work done by Tejun Heo <tj@kernel.org>
> > Branch: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
> >
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> (...)
> > diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> (...)
> >         if (d40c->pending_tx)
> > -               tasklet_schedule(&d40c->tasklet);
> > +               queue_work(system_bh_wq, &d40c->work);
> 
> Why is "my" driver not allowed to use system_bh_highpri_wq?
> 
> I can't see the reasoning between some drivers using system_bh_wq
> and others being highpri?
> 
> Given the DMA usecase I would expect them all to be high prio.

It didnt use tasklet_hi_schedule(), I guess Allen has done the
conversion of tasklet_schedule -> system_bh_wq and tasklet_hi_schedule
-> system_bh_highpri_wq

Anyway, we are going to use a dma queue so should be better performance

-- 
~Vinod

