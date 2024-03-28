Return-Path: <linux-hyperv+bounces-1862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F65890783
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 18:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CDE298FFA
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEB112FB35;
	Thu, 28 Mar 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyisGnYt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95B40BF0;
	Thu, 28 Mar 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648205; cv=none; b=Yn98youfu960pknWfF3fk4/OL4Z1Kcz+zYt0NJ1CX1dI6AXrmH5WsrNsDF2T8ARPttzZVilsU2sP1hQqd9n5PKrMOT1bwa9zgr/qm6SS3jQPvfzWQ/DIYD092TCk8sWopOAK98kWZqhMiGx09liw2vq6RbuYBtrC+NgYouvNvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648205; c=relaxed/simple;
	bh=Iej72BNJx4tvbxf0BKGGkiCIvv6XDZ2rEZ8pQA2q7xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIKprOKsSmN+kizLIo3jD3HksTB0aiNaG7mBNTtQfMn7mtq7ybG4OY7xMI+r5zmr8PseOZw6rzQh4NHqTO22vV/GYZp0b5SiGNsziDHbQ2ZaLCLXF0eZ22KI7Y9kWKUvJXziuQmDPidDweIAGwQAZsgYVc+WomuubjJMEIMhhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyisGnYt; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7e0ae718e36so296651241.2;
        Thu, 28 Mar 2024 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711648202; x=1712253002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hWHCqghfJDvViQtrnjDyRBjptIr10JmWbLdcHeOE900=;
        b=QyisGnYtE1+0HfEaP7Y6/aTXeIvv6rK9xK4hMsy4QqyE4MI1M00wAu16S+YlbNFruK
         AdvaG23qLOyvEsvUKBCBk5v1bw2h5yRrQicVfd58yucSvBUVWmlRAXQ1dB/ADlPLr81f
         nEFUAmUUSxQLmteU8Kncf/ta2wm0IcSrRUeLmW2AquN7jcZXfIIg577lg2ca4g7rIaJ1
         Kq5sBbUVVvXSSZVKMfh0MQgJUV99SPcVR7E4rLBoMsobEOXeg6U2pEtFZycMewnuDvLY
         qE89+PkdVyxUvP4aH7yDQEsd8vPhC2tyWoNFj5lK74ZGheOpQol2mr19vMlbTf+NaDt9
         UJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648202; x=1712253002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWHCqghfJDvViQtrnjDyRBjptIr10JmWbLdcHeOE900=;
        b=izlTjAFKQIhE1ITFl3fuqnzDTfELHVmCQ9j2AcH90Ltu2hdUCemB+EkiNox5cu4eR2
         CGg69ZBvGlWU5C2l0R+fMrV70OSxkwPxyTBxaVSOplPqKxv8Uz4DdNSLLKj+dkGzRDUf
         /Uyw1GiYgQ0OluXFN6u6FVtuQ9jjnnAiLqF+9CCK4sUTZLFlFCcizHkpy8HWUpXaEcw5
         Hx9v7XVx3N/LwkH8hWgouER1UL0y2pIdLn6VSOtxYefyGFzKKYCBnRYNa/CAuK1KcH6I
         8Qtc+ycGgRz+84jpALy/qZyWIEUuez9rkipgmXq97og7ubQfgdcVEpEOwSG8iZWXTfDI
         OVaA==
X-Forwarded-Encrypted: i=1; AJvYcCX+17YUop3HdqaTX6+pghEIqO+uqf14S/La5x+QYQINpBA75dyIBXuVl3iG8zrfctgQ1Gjt9TcDQpdFCrTDCTeZ73Marm9lxohdHv8UtZ5C7xeDB+M6d7st8weVqdD8x86kamMojC0RA/JGeuyHjP5UO9diRvXsTfGC3jlFFP8Fz39p3OiXX0frlQQlkO3s/H+pOKHFIgqKzm+AHMQsDAVdjJvGh4C1y5+/lM14HCNrvo13Cq3pEh+dhbdZ5KjligMwyUe6Jooe5oNPTE9vSQiObmvOjWrW3EqLtgkZ1Pdq9kPoHWQBX9ioW+LP9JPRtInbxYxXIilXdymQPnGP9BeCu70x/V5mou1ltOicdrXTBndDyZKcxBOWNsn1ICVXWEr6azkfGEMsVS8cSTBy8kepNRqlhW3Ujt1+JloMKn9Od5/DKyTB3gckpPBzhCYLRMsiuWvqc8o3rFc4ydb1XAHN2On6JpjY4wI3ZhFo4ed62WFmIJtIhdY4mDFW0BncWYKByDrg1mLIo75GDQLZj6aSH8gKNwU8yRvJ/vP2LGRlOFQXi5QdMgmxt5n4GPmA0F5g7kndlA7GMmd02kl2gcg=
X-Gm-Message-State: AOJu0YyaymDfNFSU+EL2D5Po9EUGZENLtaZpJOXLfyIzuF0SW5jFp0Wc
	o92tB46ytj1Rhn1LvaBpjQXyJ8EruHHmIRX/x4vYbSU3Za5uif+K6lxtxGCKgc5Xffu8CnvBvHQ
	6smwb5ip/0MWkNRP80rNqqZ6VVbI=
X-Google-Smtp-Source: AGHT+IG9ir7Qv5o8Rj+SB4p+I2Iv/yEJXMt0i85p6DOUBIUWCoVLWKyvCgsi6TT17MsYpR3xksNQ2srolzx+ehJ8uf4=
X-Received: by 2002:a05:6102:5e1:b0:478:2339:cef6 with SMTP id
 w1-20020a05610205e100b004782339cef6mr3607473vsf.5.1711648202174; Thu, 28 Mar
 2024 10:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-3-apais@linux.microsoft.com> <ZgUGXTKPVhrA1tam@matsya>
In-Reply-To: <ZgUGXTKPVhrA1tam@matsya>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 28 Mar 2024 10:49:51 -0700
Message-ID: <CAOMdWSJxDAFKLVbH7wrB16m2nNXHm0b45dCRhvitVCP1Wf1aEg@mail.gmail.com>
Subject: Re: [PATCH 2/9] dma: Convert from tasklet to BH workqueue
To: Vinod Koul <vkoul@kernel.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org, tj@kernel.org, 
	keescook@chromium.org, marcan@marcan.st, sven@svenpeter.dev, 
	florian.fainelli@broadcom.com, rjui@broadcom.com, sbranden@broadcom.com, 
	paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com, 
	manivannan.sadhasivam@linaro.org, vireshk@kernel.org, Frank.Li@nxp.com, 
	leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com, 
	haijie1@huawei.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, afaerber@suse.de, 
	logang@deltatee.com, daniel@zonque.org, haojian.zhuang@gmail.com, 
	robert.jarzmik@free.fr, andersson@kernel.org, konrad.dybcio@linaro.org, 
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, 
	patrice.chotard@foss.st.com, linus.walleij@linaro.org, wens@csie.org, 
	jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	jassisinghbrar@gmail.com, mchehab@kernel.org, maintainers@bluecherrydvr.com, 
	aubin.constans@microchip.com, ulf.hansson@linaro.org, manuel.lauss@gmail.com, 
	mirq-linux@rere.qmqm.pl, jh80.chung@samsung.com, oakad@yahoo.com, 
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org, brucechang@via.com.tw, 
	HaraldWelte@viatech.com, pierre@ossman.eu, duncan.sands@free.fr, 
	stern@rowland.harvard.edu, oneukum@suse.com, 
	openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-mediatek@lists.infradead.org, linux-actions@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Subsytem is dmaengine, can you rename this to dmaengine: ...

 My apologies, will have it fixed in v2.

>
> On 27-03-24, 16:03, Allen Pais wrote:
> > The only generic interface to execute asynchronously in the BH context is
> > tasklet; however, it's marked deprecated and has some design flaws. To
> > replace tasklets, BH workqueue support was recently added. A BH workqueue
> > behaves similarly to regular workqueues except that the queued work items
> > are executed in the BH context.
>
> Thanks for conversion, am happy with BH alternative as it helps in
> dmaengine where we need shortest possible time between tasklet and
> interrupt handling to maximize dma performance
>
> >
> > This patch converts drivers/dma/* from tasklet to BH workqueue.
>
> >
> > Based on the work done by Tejun Heo <tj@kernel.org>
> > Branch: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
> >
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> > ---
> >  drivers/dma/altera-msgdma.c                   | 15 ++++----
> >  drivers/dma/apple-admac.c                     | 15 ++++----
> >  drivers/dma/at_hdmac.c                        |  2 +-
> >  drivers/dma/at_xdmac.c                        | 15 ++++----
> >  drivers/dma/bcm2835-dma.c                     |  2 +-
> >  drivers/dma/dma-axi-dmac.c                    |  2 +-
> >  drivers/dma/dma-jz4780.c                      |  2 +-
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |  2 +-
> >  drivers/dma/dw-edma/dw-edma-core.c            |  2 +-
> >  drivers/dma/dw/core.c                         | 13 +++----
> >  drivers/dma/dw/regs.h                         |  3 +-
> >  drivers/dma/ep93xx_dma.c                      | 15 ++++----
> >  drivers/dma/fsl-edma-common.c                 |  2 +-
> >  drivers/dma/fsl-qdma.c                        |  2 +-
> >  drivers/dma/fsl_raid.c                        | 11 +++---
> >  drivers/dma/fsl_raid.h                        |  2 +-
> >  drivers/dma/fsldma.c                          | 15 ++++----
> >  drivers/dma/fsldma.h                          |  3 +-
> >  drivers/dma/hisi_dma.c                        |  2 +-
> >  drivers/dma/hsu/hsu.c                         |  2 +-
> >  drivers/dma/idma64.c                          |  4 +--
> >  drivers/dma/img-mdc-dma.c                     |  2 +-
> >  drivers/dma/imx-dma.c                         | 27 +++++++-------
> >  drivers/dma/imx-sdma.c                        |  6 ++--
> >  drivers/dma/ioat/dma.c                        | 17 ++++-----
> >  drivers/dma/ioat/dma.h                        |  5 +--
> >  drivers/dma/ioat/init.c                       |  2 +-
> >  drivers/dma/k3dma.c                           | 19 +++++-----
> >  drivers/dma/mediatek/mtk-cqdma.c              | 35 ++++++++++---------
> >  drivers/dma/mediatek/mtk-hsdma.c              |  2 +-
> >  drivers/dma/mediatek/mtk-uart-apdma.c         |  4 +--
> >  drivers/dma/mmp_pdma.c                        | 13 +++----
> >  drivers/dma/mmp_tdma.c                        | 11 +++---
> >  drivers/dma/mpc512x_dma.c                     | 17 ++++-----
> >  drivers/dma/mv_xor.c                          | 13 +++----
> >  drivers/dma/mv_xor.h                          |  5 +--
> >  drivers/dma/mv_xor_v2.c                       | 23 ++++++------
> >  drivers/dma/mxs-dma.c                         | 13 +++----
> >  drivers/dma/nbpfaxi.c                         | 15 ++++----
> >  drivers/dma/owl-dma.c                         |  2 +-
> >  drivers/dma/pch_dma.c                         | 17 ++++-----
> >  drivers/dma/pl330.c                           | 31 ++++++++--------
> >  drivers/dma/plx_dma.c                         | 13 +++----
> >  drivers/dma/ppc4xx/adma.c                     | 17 ++++-----
> >  drivers/dma/ppc4xx/adma.h                     |  5 +--
> >  drivers/dma/pxa_dma.c                         |  2 +-
> >  drivers/dma/qcom/bam_dma.c                    | 35 ++++++++++---------
> >  drivers/dma/qcom/gpi.c                        | 18 +++++-----
> >  drivers/dma/qcom/hidma.c                      | 11 +++---
> >  drivers/dma/qcom/hidma.h                      |  5 +--
> >  drivers/dma/qcom/hidma_ll.c                   | 11 +++---
> >  drivers/dma/qcom/qcom_adm.c                   |  2 +-
> >  drivers/dma/sa11x0-dma.c                      | 27 +++++++-------
> >  drivers/dma/sf-pdma/sf-pdma.c                 | 23 ++++++------
> >  drivers/dma/sf-pdma/sf-pdma.h                 |  5 +--
> >  drivers/dma/sprd-dma.c                        |  2 +-
> >  drivers/dma/st_fdma.c                         |  2 +-
> >  drivers/dma/ste_dma40.c                       | 17 ++++-----
> >  drivers/dma/sun6i-dma.c                       | 33 ++++++++---------
> >  drivers/dma/tegra186-gpc-dma.c                |  2 +-
> >  drivers/dma/tegra20-apb-dma.c                 | 19 +++++-----
> >  drivers/dma/tegra210-adma.c                   |  2 +-
> >  drivers/dma/ti/edma.c                         |  2 +-
> >  drivers/dma/ti/k3-udma.c                      | 11 +++---
> >  drivers/dma/ti/omap-dma.c                     |  2 +-
> >  drivers/dma/timb_dma.c                        | 23 ++++++------
> >  drivers/dma/txx9dmac.c                        | 29 +++++++--------
> >  drivers/dma/txx9dmac.h                        |  5 +--
> >  drivers/dma/virt-dma.c                        |  9 ++---
> >  drivers/dma/virt-dma.h                        |  9 ++---
> >  drivers/dma/xgene-dma.c                       | 21 +++++------
> >  drivers/dma/xilinx/xilinx_dma.c               | 23 ++++++------
> >  drivers/dma/xilinx/xilinx_dpdma.c             | 21 +++++------
> >  drivers/dma/xilinx/zynqmp_dma.c               | 21 +++++------
> >  74 files changed, 442 insertions(+), 395 deletions(-)
> >
> > diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> > index a8e3615235b8..611b5290324b 100644
> > --- a/drivers/dma/altera-msgdma.c
> > +++ b/drivers/dma/altera-msgdma.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/of_dma.h>
> > +#include <linux/workqueue.h>
> >
> >  #include "dmaengine.h"
> >
> > @@ -170,7 +171,7 @@ struct msgdma_sw_desc {
> >  struct msgdma_device {
> >       spinlock_t lock;
> >       struct device *dev;
> > -     struct tasklet_struct irq_tasklet;
> > +     struct work_struct irq_work;
>
> Can we name these as bh_work to signify that we are always in bh
> context? here and everywhere please

 Sure, will address it in v2.
>
>
> >       struct list_head pending_list;
> >       struct list_head free_list;
> >       struct list_head active_list;
> > @@ -676,12 +677,12 @@ static int msgdma_alloc_chan_resources(struct dma_chan *dchan)
> >  }
> >
> >  /**
> > - * msgdma_tasklet - Schedule completion tasklet
> > + * msgdma_work - Schedule completion work
>
> ..
>
> > @@ -515,7 +516,7 @@ struct gpii {
> >       enum gpi_pm_state pm_state;
> >       rwlock_t pm_lock;
> >       struct gpi_ring ev_ring;
> > -     struct tasklet_struct ev_task; /* event processing tasklet */
> > +     struct work_struct ev_task; /* event processing work */
> >       struct completion cmd_completion;
> >       enum gpi_cmd gpi_cmd;
> >       u32 cntxt_type_irq_msk;
> > @@ -755,7 +756,7 @@ static void gpi_process_ieob(struct gpii *gpii)
> >       gpi_write_reg(gpii, gpii->ieob_clr_reg, BIT(0));
> >
> >       gpi_config_interrupts(gpii, MASK_IEOB_SETTINGS, 0);
> > -     tasklet_hi_schedule(&gpii->ev_task);
> > +     queue_work(system_bh_highpri_wq, &gpii->ev_task);
>
> This is good conversion, thanks for ensuring system_bh_highpri_wq is
> used here

 Thank you very much for the review, will have v2 sent soon.

- Allen

> --
> ~Vinod
>

