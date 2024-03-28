Return-Path: <linux-hyperv+bounces-1858-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D988FFA9
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 13:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7F21F26D2F
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 12:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F2780023;
	Thu, 28 Mar 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+pxDyCs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925ED7F7C3
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Mar 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630447; cv=none; b=WyPYI5OL3gRkeUc8qVj3taVxytXZqB7cYGd53zpVzIqEjqxk6f1vv4AGjreyEtQyr1K6YsSf1+uiGzu0z15XrbUtQKUYU1BKrhfjPtxnD7e+PzH0K4HsAmBWztHCucgpZJgkZGUYgr4ojQIzQUB/5E/fyCTJEij/kNPI1n6grjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630447; c=relaxed/simple;
	bh=5TCpjsckKUJH2Vyyr3jKi48ADggaJQL1+D4m0WdDjNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYn/35+ylZsN+soBJRvCeIZ1Hj3YOYTZ8bGO1VGKUKktXhnuDIkqj9qZw1Xs4EIrmDTvBvkpZA1qkMVQMzJ1ymGeuCy2XwAxSh+s9eVEpZR4KdVx6Gk41eRJTkyTHxlhFFFR8sLff/FVdYkz2vGNFgTxrz+EdxhVyzFAQV2GAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y+pxDyCs; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso863823276.0
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Mar 2024 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711630442; x=1712235242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v1k5/f6q+Q/w1jFRkd0GjI7DV6a3ySNeWdRSbY80foE=;
        b=Y+pxDyCsiv0FVSNgC0tCgosN+i52UIuYgDQBCGcQxeWSdW64iRuc2oNmi/UhhikZWI
         8aIsFGMR7GnGSLQ+h3t2wdIDH77PwZLVmfY/m9yyj16pA4PDz8fprlHNLT1gJZ9X7Ng3
         Vwk8VbVFp9nMuXDAnwwvqVhRBe7rJiDvaoiF9JXOKC7Ld31acYcClavkQrd9bMtm+QPn
         i72ZaVO/MCAwZgbrPMhMksglppjg9oFXLABmvRo1dbMR686Mc6FbX2IzaCyYqUHXFc3I
         NjPatT1tPE6LKEjI3y8NZnZrLRTjHDlHoa/3PhGB7VGOhbQS645Ra8H27F88lz+brsPQ
         QUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711630442; x=1712235242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1k5/f6q+Q/w1jFRkd0GjI7DV6a3ySNeWdRSbY80foE=;
        b=LRlW/UXSeMxKD/4M3Hk5UeNW+KK1fTeRQ6ydiB2JYZR/MyeKJseUSlph8B1WVx/lkY
         M3VGZ9foa4R36kIs7QdAJGRs+F12fEDtgqXVFh5+qF93vUPoM43kmDUMkLJWJgq+pQAO
         bJF8joHKEc6DpLj+9vrRZmAAN4nLI2PUZS9DdR78MLf9OhlfFfdrQCFKvhK/CHQK9MXz
         xdpxz7R2BcAhIVv0FOo9eRq3Wp6Re3SUlsLJfvFaTIUOTicEEzWSSxujwHPD0TCQNUNJ
         X56UHE1jySDhiXJuOtGoG+DRwYaadkpmxlF//xZCIlJyTtev5FA3mv4s/KYYHc/YuDsn
         oojQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFm+TWaqxUHpPUkI2MEVUGCaytNpMYQbmzHQre8amIznMNH2CfAERMNOKrfPv8owaJPdO4o0JlhA6hGScJSCjXQ4V2h6m3TGhBr7PY
X-Gm-Message-State: AOJu0YzjBmvzLR9rDsdiqFlpbmxVfwCICfzJWfj85XiQySix6YCp3pBC
	ofXqU9gnm2ApgQF1gDpskHauZ1WBZQsVnFe3drYc5n3XY5i8xSvEFrVldhlx3RSKnY0oS1MaivW
	SZBlZSyQibzgJvaeZljkFMdkmVaLV/T8oFDpdKg==
X-Google-Smtp-Source: AGHT+IEm2Rq9XjvRvF1Gc4lsv4kGx5qbg+5ZM7vcXzz64h8UswdJjg7AyAejkrusteq5Jr0rDKgp2IxQuuw3+bz69NU=
X-Received: by 2002:a25:dc0b:0:b0:dc7:46e7:7aea with SMTP id
 y11-20020a25dc0b000000b00dc746e77aeamr2934828ybe.47.1711630441038; Thu, 28
 Mar 2024 05:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com> <20240327160314.9982-10-apais@linux.microsoft.com>
In-Reply-To: <20240327160314.9982-10-apais@linux.microsoft.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 28 Mar 2024 13:53:25 +0100
Message-ID: <CAPDyKFpuKadPQv6+61C2pE4x4FE-DUC5W6WCCPu9Nb2DnDB56g@mail.gmail.com>
Subject: Re: [PATCH 9/9] mmc: Convert from tasklet to BH workqueue
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org, 
	vkoul@kernel.org, marcan@marcan.st, sven@svenpeter.dev, 
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
	aubin.constans@microchip.com, manuel.lauss@gmail.com, mirq-linux@rere.qmqm.pl, 
	jh80.chung@samsung.com, oakad@yahoo.com, hayashi.kunihiko@socionext.com, 
	mhiramat@kernel.org, brucechang@via.com.tw, HaraldWelte@viatech.com, 
	pierre@ossman.eu, duncan.sands@free.fr, stern@rowland.harvard.edu, 
	oneukum@suse.com, openipmi-developer@lists.sourceforge.net, 
	dmaengine@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org, 
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 17:03, Allen Pais <apais@linux.microsoft.com> wrote:
>
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
>
> This patch converts drivers/infiniband/* from tasklet to BH workqueue.
>
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Overall, this makes sense to me. However, just to make things clear,
an mmc host driver shouldn't really need the tasklet. As I understand
it, the few remaining users are there for legacy reasons.

At this point we have suggested to drivers to switch to use threaded
irq handlers (and regular work queues if needed too). That said,
what's the benefit of using the BH work queue?

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c                  | 35 ++++-----
>  drivers/mmc/host/au1xmmc.c                    | 37 ++++-----
>  drivers/mmc/host/cb710-mmc.c                  | 15 ++--
>  drivers/mmc/host/cb710-mmc.h                  |  3 +-
>  drivers/mmc/host/dw_mmc.c                     | 25 ++++---
>  drivers/mmc/host/dw_mmc.h                     |  9 ++-
>  drivers/mmc/host/omap.c                       | 17 +++--
>  drivers/mmc/host/renesas_sdhi.h               |  3 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 24 +++---
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  9 +--
>  drivers/mmc/host/sdhci-bcm-kona.c             |  2 +-
>  drivers/mmc/host/tifm_sd.c                    | 15 ++--
>  drivers/mmc/host/tmio_mmc.h                   |  3 +-
>  drivers/mmc/host/tmio_mmc_core.c              |  4 +-
>  drivers/mmc/host/uniphier-sd.c                | 13 ++--
>  drivers/mmc/host/via-sdmmc.c                  | 25 ++++---
>  drivers/mmc/host/wbsd.c                       | 75 ++++++++++---------
>  drivers/mmc/host/wbsd.h                       | 10 +--
>  18 files changed, 167 insertions(+), 157 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index dba826db739a..0a92a7fd020f 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -33,6 +33,7 @@
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/workqueue.h>
>
>  #include <asm/cacheflush.h>
>  #include <asm/io.h>
> @@ -284,12 +285,12 @@ struct atmel_mci_dma {
>   *     EVENT_DATA_ERROR is pending.
>   * @stop_cmdr: Value to be loaded into CMDR when the stop command is
>   *     to be sent.
> - * @tasklet: Tasklet running the request state machine.
> + * @work: Work running the request state machine.
>   * @pending_events: Bitmask of events flagged by the interrupt handler
> - *     to be processed by the tasklet.
> + *     to be processed by the work.
>   * @completed_events: Bitmask of events which the state machine has
>   *     processed.
> - * @state: Tasklet state.
> + * @state: Work state.
>   * @queue: List of slots waiting for access to the controller.
>   * @need_clock_update: Update the clock rate before the next request.
>   * @need_reset: Reset controller before next request.
> @@ -363,7 +364,7 @@ struct atmel_mci {
>         u32                     data_status;
>         u32                     stop_cmdr;
>
> -       struct tasklet_struct   tasklet;
> +       struct work_struct      work;
>         unsigned long           pending_events;
>         unsigned long           completed_events;
>         enum atmel_mci_state    state;
> @@ -761,7 +762,7 @@ static void atmci_timeout_timer(struct timer_list *t)
>         host->need_reset = 1;
>         host->state = STATE_END_REQUEST;
>         smp_wmb();
> -       tasklet_schedule(&host->tasklet);
> +       queue_work(system_bh_wq, &host->work);
>  }
>
>  static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
> @@ -983,7 +984,7 @@ static void atmci_pdc_complete(struct atmel_mci *host)
>
>         dev_dbg(&host->pdev->dev, "(%s) set pending xfer complete\n", __func__);
>         atmci_set_pending(host, EVENT_XFER_COMPLETE);
> -       tasklet_schedule(&host->tasklet);
> +       queue_work(system_bh_wq, &host->work);
>  }
>
>  static void atmci_dma_cleanup(struct atmel_mci *host)
> @@ -997,7 +998,7 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
>  }
>
>  /*
> - * This function is called by the DMA driver from tasklet context.
> + * This function is called by the DMA driver from work context.
>   */
>  static void atmci_dma_complete(void *arg)
>  {
> @@ -1020,7 +1021,7 @@ static void atmci_dma_complete(void *arg)
>                 dev_dbg(&host->pdev->dev,
>                         "(%s) set pending xfer complete\n", __func__);
>                 atmci_set_pending(host, EVENT_XFER_COMPLETE);
> -               tasklet_schedule(&host->tasklet);
> +               queue_work(system_bh_wq, &host->work);
>
>                 /*
>                  * Regardless of what the documentation says, we have
> @@ -1033,7 +1034,7 @@ static void atmci_dma_complete(void *arg)
>                  * haven't seen all the potential error bits yet.
>                  *
>                  * The interrupt handler will schedule a different
> -                * tasklet to finish things up when the data transfer
> +                * work to finish things up when the data transfer
>                  * is completely done.
>                  *
>                  * We may not complete the mmc request here anyway
> @@ -1765,9 +1766,9 @@ static void atmci_detect_change(struct timer_list *t)
>         }
>  }
>
> -static void atmci_tasklet_func(struct tasklet_struct *t)
> +static void atmci_work_func(struct work_struct *t)
>  {
> -       struct atmel_mci        *host = from_tasklet(host, t, tasklet);
> +       struct atmel_mci        *host = from_work(host, t, work);
>         struct mmc_request      *mrq = host->mrq;
>         struct mmc_data         *data = host->data;
>         enum atmel_mci_state    state = host->state;
> @@ -1779,7 +1780,7 @@ static void atmci_tasklet_func(struct tasklet_struct *t)
>         state = host->state;
>
>         dev_vdbg(&host->pdev->dev,
> -               "tasklet: state %u pending/completed/mask %lx/%lx/%x\n",
> +               "work: state %u pending/completed/mask %lx/%lx/%x\n",
>                 state, host->pending_events, host->completed_events,
>                 atmci_readl(host, ATMCI_IMR));
>
> @@ -2141,7 +2142,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
>                         dev_dbg(&host->pdev->dev, "set pending data error\n");
>                         smp_wmb();
>                         atmci_set_pending(host, EVENT_DATA_ERROR);
> -                       tasklet_schedule(&host->tasklet);
> +                       queue_work(system_bh_wq, &host->work);
>                 }
>
>                 if (pending & ATMCI_TXBUFE) {
> @@ -2210,7 +2211,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
>                         smp_wmb();
>                         dev_dbg(&host->pdev->dev, "set pending notbusy\n");
>                         atmci_set_pending(host, EVENT_NOTBUSY);
> -                       tasklet_schedule(&host->tasklet);
> +                       queue_work(system_bh_wq, &host->work);
>                 }
>
>                 if (pending & ATMCI_NOTBUSY) {
> @@ -2219,7 +2220,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
>                         smp_wmb();
>                         dev_dbg(&host->pdev->dev, "set pending notbusy\n");
>                         atmci_set_pending(host, EVENT_NOTBUSY);
> -                       tasklet_schedule(&host->tasklet);
> +                       queue_work(system_bh_wq, &host->work);
>                 }
>
>                 if (pending & ATMCI_RXRDY)
> @@ -2234,7 +2235,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
>                         smp_wmb();
>                         dev_dbg(&host->pdev->dev, "set pending cmd rdy\n");
>                         atmci_set_pending(host, EVENT_CMD_RDY);
> -                       tasklet_schedule(&host->tasklet);
> +                       queue_work(system_bh_wq, &host->work);
>                 }
>
>                 if (pending & (ATMCI_SDIOIRQA | ATMCI_SDIOIRQB))
> @@ -2530,7 +2531,7 @@ static int atmci_probe(struct platform_device *pdev)
>
>         host->mapbase = regs->start;
>
> -       tasklet_setup(&host->tasklet, atmci_tasklet_func);
> +       INIT_WORK(&host->work, atmci_work_func);
>
>         ret = request_irq(irq, atmci_interrupt, 0, dev_name(&pdev->dev), host);
>         if (ret) {
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index b5a5c6a2fe8b..c86fa7d2ebb7 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -42,6 +42,7 @@
>  #include <linux/leds.h>
>  #include <linux/mmc/host.h>
>  #include <linux/slab.h>
> +#include <linux/workqueue.h>
>
>  #include <asm/io.h>
>  #include <asm/mach-au1x00/au1000.h>
> @@ -113,8 +114,8 @@ struct au1xmmc_host {
>
>         int irq;
>
> -       struct tasklet_struct finish_task;
> -       struct tasklet_struct data_task;
> +       struct work_struct finish_task;
> +       struct work_struct data_task;
>         struct au1xmmc_platform_data *platdata;
>         struct platform_device *pdev;
>         struct resource *ioarea;
> @@ -253,9 +254,9 @@ static void au1xmmc_finish_request(struct au1xmmc_host *host)
>         mmc_request_done(host->mmc, mrq);
>  }
>
> -static void au1xmmc_tasklet_finish(struct tasklet_struct *t)
> +static void au1xmmc_work_finish(struct work_struct *t)
>  {
> -       struct au1xmmc_host *host = from_tasklet(host, t, finish_task);
> +       struct au1xmmc_host *host = from_work(host, t, finish_task);
>         au1xmmc_finish_request(host);
>  }
>
> @@ -363,9 +364,9 @@ static void au1xmmc_data_complete(struct au1xmmc_host *host, u32 status)
>         au1xmmc_finish_request(host);
>  }
>
> -static void au1xmmc_tasklet_data(struct tasklet_struct *t)
> +static void au1xmmc_work_data(struct work_struct *t)
>  {
> -       struct au1xmmc_host *host = from_tasklet(host, t, data_task);
> +       struct au1xmmc_host *host = from_work(host, t, data_task);
>
>         u32 status = __raw_readl(HOST_STATUS(host));
>         au1xmmc_data_complete(host, status);
> @@ -425,7 +426,7 @@ static void au1xmmc_send_pio(struct au1xmmc_host *host)
>                 if (host->flags & HOST_F_STOP)
>                         SEND_STOP(host);
>
> -               tasklet_schedule(&host->data_task);
> +               queue_work(system_bh_wq, &host->data_task);
>         }
>  }
>
> @@ -505,7 +506,7 @@ static void au1xmmc_receive_pio(struct au1xmmc_host *host)
>                 if (host->flags & HOST_F_STOP)
>                         SEND_STOP(host);
>
> -               tasklet_schedule(&host->data_task);
> +               queue_work(system_bh_wq, &host->data_task);
>         }
>  }
>
> @@ -561,7 +562,7 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
>
>         if (!trans || cmd->error) {
>                 IRQ_OFF(host, SD_CONFIG_TH | SD_CONFIG_RA | SD_CONFIG_RF);
> -               tasklet_schedule(&host->finish_task);
> +               queue_work(system_bh_wq, &host->finish_task);
>                 return;
>         }
>
> @@ -797,7 +798,7 @@ static irqreturn_t au1xmmc_irq(int irq, void *dev_id)
>                 IRQ_OFF(host, SD_CONFIG_NE | SD_CONFIG_TH);
>
>                 /* IRQ_OFF(host, SD_CONFIG_TH | SD_CONFIG_RA | SD_CONFIG_RF); */
> -               tasklet_schedule(&host->finish_task);
> +               queue_work(system_bh_wq, &host->finish_task);
>         }
>  #if 0
>         else if (status & SD_STATUS_DD) {
> @@ -806,7 +807,7 @@ static irqreturn_t au1xmmc_irq(int irq, void *dev_id)
>                         au1xmmc_receive_pio(host);
>                 else {
>                         au1xmmc_data_complete(host, status);
> -                       /* tasklet_schedule(&host->data_task); */
> +                       /* queue_work(system_bh_wq, &host->data_task); */
>                 }
>         }
>  #endif
> @@ -854,7 +855,7 @@ static void au1xmmc_dbdma_callback(int irq, void *dev_id)
>         if (host->flags & HOST_F_STOP)
>                 SEND_STOP(host);
>
> -       tasklet_schedule(&host->data_task);
> +       queue_work(system_bh_wq, &host->data_task);
>  }
>
>  static int au1xmmc_dbdma_init(struct au1xmmc_host *host)
> @@ -1039,9 +1040,9 @@ static int au1xmmc_probe(struct platform_device *pdev)
>         if (host->platdata)
>                 mmc->caps &= ~(host->platdata->mask_host_caps);
>
> -       tasklet_setup(&host->data_task, au1xmmc_tasklet_data);
> +       INIT_WORK(&host->data_task, au1xmmc_work_data);
>
> -       tasklet_setup(&host->finish_task, au1xmmc_tasklet_finish);
> +       INIT_WORK(&host->finish_task, au1xmmc_work_finish);
>
>         if (has_dbdma()) {
>                 ret = au1xmmc_dbdma_init(host);
> @@ -1091,8 +1092,8 @@ static int au1xmmc_probe(struct platform_device *pdev)
>         if (host->flags & HOST_F_DBDMA)
>                 au1xmmc_dbdma_shutdown(host);
>
> -       tasklet_kill(&host->data_task);
> -       tasklet_kill(&host->finish_task);
> +       cancel_work_sync(&host->data_task);
> +       cancel_work_sync(&host->finish_task);
>
>         if (host->platdata && host->platdata->cd_setup &&
>             !(mmc->caps & MMC_CAP_NEEDS_POLL))
> @@ -1135,8 +1136,8 @@ static void au1xmmc_remove(struct platform_device *pdev)
>                 __raw_writel(0, HOST_CONFIG2(host));
>                 wmb(); /* drain writebuffer */
>
> -               tasklet_kill(&host->data_task);
> -               tasklet_kill(&host->finish_task);
> +               cancel_work_sync(&host->data_task);
> +               cancel_work_sync(&host->finish_task);
>
>                 if (host->flags & HOST_F_DBDMA)
>                         au1xmmc_dbdma_shutdown(host);
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
> index 0aec33b88bef..eebb6797e785 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/delay.h>
> +#include <linux/workqueue.h>
>  #include "cb710-mmc.h"
>
>  #define CB710_MMC_REQ_TIMEOUT_MS       2000
> @@ -493,7 +494,7 @@ static void cb710_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         if (!cb710_mmc_command(mmc, mrq->cmd) && mrq->stop)
>                 cb710_mmc_command(mmc, mrq->stop);
>
> -       tasklet_schedule(&reader->finish_req_tasklet);
> +       queue_work(system_bh_wq, &reader->finish_req_work);
>  }
>
>  static int cb710_mmc_powerup(struct cb710_slot *slot)
> @@ -646,10 +647,10 @@ static int cb710_mmc_irq_handler(struct cb710_slot *slot)
>         return 1;
>  }
>
> -static void cb710_mmc_finish_request_tasklet(struct tasklet_struct *t)
> +static void cb710_mmc_finish_request_work(struct work_struct *t)
>  {
> -       struct cb710_mmc_reader *reader = from_tasklet(reader, t,
> -                                                      finish_req_tasklet);
> +       struct cb710_mmc_reader *reader = from_work(reader, t,
> +                                                      finish_req_work);
>         struct mmc_request *mrq = reader->mrq;
>
>         reader->mrq = NULL;
> @@ -718,8 +719,8 @@ static int cb710_mmc_init(struct platform_device *pdev)
>
>         reader = mmc_priv(mmc);
>
> -       tasklet_setup(&reader->finish_req_tasklet,
> -                     cb710_mmc_finish_request_tasklet);
> +       INIT_WORK(&reader->finish_req_work,
> +                       cb710_mmc_finish_request_work);
>         spin_lock_init(&reader->irq_lock);
>         cb710_dump_regs(chip, CB710_DUMP_REGS_MMC);
>
> @@ -763,7 +764,7 @@ static void cb710_mmc_exit(struct platform_device *pdev)
>         cb710_write_port_32(slot, CB710_MMC_CONFIG_PORT, 0);
>         cb710_write_port_16(slot, CB710_MMC_CONFIGB_PORT, 0);
>
> -       tasklet_kill(&reader->finish_req_tasklet);
> +       cancel_work_sync(&reader->finish_req_work);
>
>         mmc_free_host(mmc);
>  }
> diff --git a/drivers/mmc/host/cb710-mmc.h b/drivers/mmc/host/cb710-mmc.h
> index 5e053077dbed..b35ab8736374 100644
> --- a/drivers/mmc/host/cb710-mmc.h
> +++ b/drivers/mmc/host/cb710-mmc.h
> @@ -8,10 +8,11 @@
>  #define LINUX_CB710_MMC_H
>
>  #include <linux/cb710.h>
> +#include <linux/workqueue.h>
>
>  /* per-MMC-reader structure */
>  struct cb710_mmc_reader {
> -       struct tasklet_struct finish_req_tasklet;
> +       struct work_struct finish_req_work;
>         struct mmc_request *mrq;
>         spinlock_t irq_lock;
>         unsigned char last_power_mode;
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 8e2d676b9239..ee6f892bc0d8 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -36,6 +36,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/of.h>
>  #include <linux/mmc/slot-gpio.h>
> +#include <linux/workqueue.h>
>
>  #include "dw_mmc.h"
>
> @@ -493,7 +494,7 @@ static void dw_mci_dmac_complete_dma(void *arg)
>          */
>         if (data) {
>                 set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
> -               tasklet_schedule(&host->tasklet);
> +               queue_work(system_bh_wq, &host->work);
>         }
>  }
>
> @@ -1834,7 +1835,7 @@ static enum hrtimer_restart dw_mci_fault_timer(struct hrtimer *t)
>         if (!host->data_status) {
>                 host->data_status = SDMMC_INT_DCRC;
>                 set_bit(EVENT_DATA_ERROR, &host->pending_events);
> -               tasklet_schedule(&host->tasklet);
> +               queue_work(system_bh_wq, &host->work);
>         }
>
>         spin_unlock_irqrestore(&host->irq_lock, flags);
> @@ -2056,9 +2057,9 @@ static bool dw_mci_clear_pending_data_complete(struct dw_mci *host)
>         return true;
>  }
>
> -static void dw_mci_tasklet_func(struct tasklet_struct *t)
> +static void dw_mci_work_func(struct work_struct *t)
>  {
> -       struct dw_mci *host = from_tasklet(host, t, tasklet);
> +       struct dw_mci *host = from_work(host, t, work);
>         struct mmc_data *data;
>         struct mmc_command *cmd;
>         struct mmc_request *mrq;
> @@ -2113,7 +2114,7 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>                                  * will waste a bit of time (we already know
>                                  * the command was bad), it can't cause any
>                                  * errors since it's possible it would have
> -                                * taken place anyway if this tasklet got
> +                                * taken place anyway if this work got
>                                  * delayed. Allowing the transfer to take place
>                                  * avoids races and keeps things simple.
>                                  */
> @@ -2706,7 +2707,7 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
>         smp_wmb(); /* drain writebuffer */
>
>         set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
> -       tasklet_schedule(&host->tasklet);
> +       queue_work(system_bh_wq, &host->work);
>
>         dw_mci_start_fault_timer(host);
>  }
> @@ -2774,7 +2775,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                                 set_bit(EVENT_DATA_COMPLETE,
>                                         &host->pending_events);
>
> -                       tasklet_schedule(&host->tasklet);
> +                       queue_work(system_bh_wq, &host->work);
>
>                         spin_unlock(&host->irq_lock);
>                 }
> @@ -2793,7 +2794,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                                         dw_mci_read_data_pio(host, true);
>                         }
>                         set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
> -                       tasklet_schedule(&host->tasklet);
> +                       queue_work(system_bh_wq, &host->work);
>
>                         spin_unlock(&host->irq_lock);
>                 }
> @@ -3098,7 +3099,7 @@ static void dw_mci_cmd11_timer(struct timer_list *t)
>
>         host->cmd_status = SDMMC_INT_RTO;
>         set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
> -       tasklet_schedule(&host->tasklet);
> +       queue_work(system_bh_wq, &host->work);
>  }
>
>  static void dw_mci_cto_timer(struct timer_list *t)
> @@ -3144,7 +3145,7 @@ static void dw_mci_cto_timer(struct timer_list *t)
>                  */
>                 host->cmd_status = SDMMC_INT_RTO;
>                 set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
> -               tasklet_schedule(&host->tasklet);
> +               queue_work(system_bh_wq, &host->work);
>                 break;
>         default:
>                 dev_warn(host->dev, "Unexpected command timeout, state %d\n",
> @@ -3195,7 +3196,7 @@ static void dw_mci_dto_timer(struct timer_list *t)
>                 host->data_status = SDMMC_INT_DRTO;
>                 set_bit(EVENT_DATA_ERROR, &host->pending_events);
>                 set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
> -               tasklet_schedule(&host->tasklet);
> +               queue_work(system_bh_wq, &host->work);
>                 break;
>         default:
>                 dev_warn(host->dev, "Unexpected data timeout, state %d\n",
> @@ -3435,7 +3436,7 @@ int dw_mci_probe(struct dw_mci *host)
>         else
>                 host->fifo_reg = host->regs + DATA_240A_OFFSET;
>
> -       tasklet_setup(&host->tasklet, dw_mci_tasklet_func);
> +       INIT_WORK(&host->work, dw_mci_work_func);
>         ret = devm_request_irq(host->dev, host->irq, dw_mci_interrupt,
>                                host->irq_flags, "dw-mci", host);
>         if (ret)
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 4ed81f94f7ca..d17f398a0432 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -17,6 +17,7 @@
>  #include <linux/fault-inject.h>
>  #include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
> +#include <linux/workqueue.h>
>
>  enum dw_mci_state {
>         STATE_IDLE = 0,
> @@ -89,12 +90,12 @@ struct dw_mci_dma_slave {
>   * @stop_cmdr: Value to be loaded into CMDR when the stop command is
>   *     to be sent.
>   * @dir_status: Direction of current transfer.
> - * @tasklet: Tasklet running the request state machine.
> + * @work: Work running the request state machine.
>   * @pending_events: Bitmask of events flagged by the interrupt handler
> - *     to be processed by the tasklet.
> + *     to be processed by the work.
>   * @completed_events: Bitmask of events which the state machine has
>   *     processed.
> - * @state: Tasklet state.
> + * @state: Work state.
>   * @queue: List of slots waiting for access to the controller.
>   * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
>   *     rate and timeout calculations.
> @@ -194,7 +195,7 @@ struct dw_mci {
>         u32                     data_status;
>         u32                     stop_cmdr;
>         u32                     dir_status;
> -       struct tasklet_struct   tasklet;
> +       struct work_struct      work;
>         unsigned long           pending_events;
>         unsigned long           completed_events;
>         enum dw_mci_state       state;
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 088f8ed4fdc4..d85bae7b9cba 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -28,6 +28,7 @@
>  #include <linux/slab.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/platform_data/mmc-omap.h>
> +#include <linux/workqueue.h>
>
>
>  #define        OMAP_MMC_REG_CMD        0x00
> @@ -105,7 +106,7 @@ struct mmc_omap_slot {
>         u16                     power_mode;
>         unsigned int            fclk_freq;
>
> -       struct tasklet_struct   cover_tasklet;
> +       struct work_struct      cover_work;
>         struct timer_list       cover_timer;
>         unsigned                cover_open;
>
> @@ -873,18 +874,18 @@ void omap_mmc_notify_cover_event(struct device *dev, int num, int is_closed)
>                 sysfs_notify(&slot->mmc->class_dev.kobj, NULL, "cover_switch");
>         }
>
> -       tasklet_hi_schedule(&slot->cover_tasklet);
> +       queue_work(system_bh_highpri_wq, &slot->cover_work);
>  }
>
>  static void mmc_omap_cover_timer(struct timer_list *t)
>  {
>         struct mmc_omap_slot *slot = from_timer(slot, t, cover_timer);
> -       tasklet_schedule(&slot->cover_tasklet);
> +       queue_work(system_bh_wq, &slot->cover_work);
>  }
>
> -static void mmc_omap_cover_handler(struct tasklet_struct *t)
> +static void mmc_omap_cover_handler(struct work_struct *t)
>  {
> -       struct mmc_omap_slot *slot = from_tasklet(slot, t, cover_tasklet);
> +       struct mmc_omap_slot *slot = from_work(slot, t, cover_work);
>         int cover_open = mmc_omap_cover_is_open(slot);
>
>         mmc_detect_change(slot->mmc, 0);
> @@ -1299,7 +1300,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>
>         if (slot->pdata->get_cover_state != NULL) {
>                 timer_setup(&slot->cover_timer, mmc_omap_cover_timer, 0);
> -               tasklet_setup(&slot->cover_tasklet, mmc_omap_cover_handler);
> +               INIT_WORK(&slot->cover_work, mmc_omap_cover_handler);
>         }
>
>         r = mmc_add_host(mmc);
> @@ -1318,7 +1319,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>                                         &dev_attr_cover_switch);
>                 if (r < 0)
>                         goto err_remove_slot_name;
> -               tasklet_schedule(&slot->cover_tasklet);
> +               queue_work(system_bh_wq, &slot->cover_work);
>         }
>
>         return 0;
> @@ -1341,7 +1342,7 @@ static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
>         if (slot->pdata->get_cover_state != NULL)
>                 device_remove_file(&mmc->class_dev, &dev_attr_cover_switch);
>
> -       tasklet_kill(&slot->cover_tasklet);
> +       cancel_work_sync(&slot->cover_work);
>         del_timer_sync(&slot->cover_timer);
>         flush_workqueue(slot->host->mmc_omap_wq);
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index 586f94d4dbfd..4fd2bfcacd76 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -11,6 +11,7 @@
>
>  #include <linux/dmaengine.h>
>  #include <linux/platform_device.h>
> +#include <linux/workqueue.h>
>  #include "tmio_mmc.h"
>
>  struct renesas_sdhi_scc {
> @@ -67,7 +68,7 @@ struct renesas_sdhi_dma {
>         dma_filter_fn filter;
>         void (*enable)(struct tmio_mmc_host *host, bool enable);
>         struct completion dma_dataend;
> -       struct tasklet_struct dma_complete;
> +       struct work_struct dma_complete;
>  };
>
>  struct renesas_sdhi {
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 53d34c3eddce..f175f8898516 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -336,7 +336,7 @@ static bool renesas_sdhi_internal_dmac_dma_irq(struct tmio_mmc_host *host)
>                 writel(status ^ dma_irqs, host->ctl + DM_CM_INFO1);
>                 set_bit(SDHI_DMA_END_FLAG_DMA, &dma_priv->end_flags);
>                 if (test_bit(SDHI_DMA_END_FLAG_ACCESS, &dma_priv->end_flags))
> -                       tasklet_schedule(&dma_priv->dma_complete);
> +                       queue_work(system_bh_wq, &dma_priv->dma_complete);
>         }
>
>         return status & dma_irqs;
> @@ -351,7 +351,7 @@ renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host)
>         set_bit(SDHI_DMA_END_FLAG_ACCESS, &dma_priv->end_flags);
>         if (test_bit(SDHI_DMA_END_FLAG_DMA, &dma_priv->end_flags) ||
>             host->data->error)
> -               tasklet_schedule(&dma_priv->dma_complete);
> +               queue_work(system_bh_wq, &dma_priv->dma_complete);
>  }
>
>  /*
> @@ -439,9 +439,9 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
>         renesas_sdhi_internal_dmac_enable_dma(host, false);
>  }
>
> -static void renesas_sdhi_internal_dmac_issue_tasklet_fn(unsigned long arg)
> +static void renesas_sdhi_internal_dmac_issue_work_fn(struct work_struct *t)
>  {
> -       struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
> +       struct tmio_mmc_host *host = from_work(host, t, dma_issue);
>         struct renesas_sdhi *priv = host_to_priv(host);
>
>         tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
> @@ -453,7 +453,7 @@ static void renesas_sdhi_internal_dmac_issue_tasklet_fn(unsigned long arg)
>                 /* on CMD errors, simulate DMA end immediately */
>                 set_bit(SDHI_DMA_END_FLAG_DMA, &priv->dma_priv.end_flags);
>                 if (test_bit(SDHI_DMA_END_FLAG_ACCESS, &priv->dma_priv.end_flags))
> -                       tasklet_schedule(&priv->dma_priv.dma_complete);
> +                       queue_work(system_bh_wq, &priv->dma_priv.dma_complete);
>         }
>  }
>
> @@ -483,9 +483,9 @@ static bool renesas_sdhi_internal_dmac_complete(struct tmio_mmc_host *host)
>         return true;
>  }
>
> -static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
> +static void renesas_sdhi_internal_dmac_complete_work_fn(struct work_struct *t)
>  {
> -       struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
> +       struct tmio_mmc_host *host = from_work(host, t, dam_complete);
>
>         spin_lock_irq(&host->lock);
>         if (!renesas_sdhi_internal_dmac_complete(host))
> @@ -543,12 +543,10 @@ renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
>         /* Each value is set to non-zero to assume "enabling" each DMA */
>         host->chan_rx = host->chan_tx = (void *)0xdeadbeaf;
>
> -       tasklet_init(&priv->dma_priv.dma_complete,
> -                    renesas_sdhi_internal_dmac_complete_tasklet_fn,
> -                    (unsigned long)host);
> -       tasklet_init(&host->dma_issue,
> -                    renesas_sdhi_internal_dmac_issue_tasklet_fn,
> -                    (unsigned long)host);
> +       INIT_WORK(&priv->dma_priv.dma_complete,
> +                       renesas_sdhi_internal_dmac_complete_work_fn);
> +       INIT_WORK(&host->dma_issue,
> +                       renesas_sdhi_internal_dmac_issue_work_fn);
>
>         /* Add pre_req and post_req */
>         host->ops.pre_req = renesas_sdhi_internal_dmac_pre_req;
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index 9cf7f9feab72..793595ad6d02 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -312,9 +312,9 @@ static void renesas_sdhi_sys_dmac_start_dma(struct tmio_mmc_host *host,
>         }
>  }
>
> -static void renesas_sdhi_sys_dmac_issue_tasklet_fn(unsigned long priv)
> +static void renesas_sdhi_sys_dmac_issue_work_fn(struct work_struct *t)
>  {
> -       struct tmio_mmc_host *host = (struct tmio_mmc_host *)priv;
> +       struct tmio_mmc_host *host = from_work(host, t, dma_issue);
>         struct dma_chan *chan = NULL;
>
>         spin_lock_irq(&host->lock);
> @@ -401,9 +401,8 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
>                         goto ebouncebuf;
>
>                 init_completion(&priv->dma_priv.dma_dataend);
> -               tasklet_init(&host->dma_issue,
> -                            renesas_sdhi_sys_dmac_issue_tasklet_fn,
> -                            (unsigned long)host);
> +               INIT_WORK(&host->dma_issue,
> +                               renesas_sdhi_sys_dmac_issue_work_fn);
>         }
>
>         renesas_sdhi_sys_dmac_enable_dma(host, true);
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index cb9152c6a65d..974f205d479b 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -107,7 +107,7 @@ static void sdhci_bcm_kona_sd_init(struct sdhci_host *host)
>   * Software emulation of the SD card insertion/removal. Set insert=1 for insert
>   * and insert=0 for removal. The card detection is done by GPIO. For Broadcom
>   * IP to function properly the bit 0 of CORESTAT register needs to be set/reset
> - * to generate the CD IRQ handled in sdhci.c which schedules card_tasklet.
> + * to generate the CD IRQ handled in sdhci.c which schedules card_work.
>   */
>  static int sdhci_bcm_kona_sd_card_emulate(struct sdhci_host *host, int insert)
>  {
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index b5a2f2f25ad9..c6285c577db0 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -13,6 +13,7 @@
>  #include <linux/highmem.h>
>  #include <linux/scatterlist.h>
>  #include <linux/module.h>
> +#include <linux/workqueue.h>
>  #include <asm/io.h>
>
>  #define DRIVER_NAME "tifm_sd"
> @@ -97,7 +98,7 @@ struct tifm_sd {
>         unsigned int          clk_div;
>         unsigned long         timeout_jiffies;
>
> -       struct tasklet_struct finish_tasklet;
> +       struct work_struct finish_work;
>         struct timer_list     timer;
>         struct mmc_request    *req;
>
> @@ -463,7 +464,7 @@ static void tifm_sd_check_status(struct tifm_sd *host)
>                 }
>         }
>  finish_request:
> -       tasklet_schedule(&host->finish_tasklet);
> +       queue_work(system_bh_wq, &host->finish_work);
>  }
>
>  /* Called from interrupt handler */
> @@ -723,9 +724,9 @@ static void tifm_sd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         mmc_request_done(mmc, mrq);
>  }
>
> -static void tifm_sd_end_cmd(struct tasklet_struct *t)
> +static void tifm_sd_end_cmd(struct work_struct *t)
>  {
> -       struct tifm_sd *host = from_tasklet(host, t, finish_tasklet);
> +       struct tifm_sd *host = from_work(host, t, finish_work);
>         struct tifm_dev *sock = host->dev;
>         struct mmc_host *mmc = tifm_get_drvdata(sock);
>         struct mmc_request *mrq;
> @@ -960,7 +961,7 @@ static int tifm_sd_probe(struct tifm_dev *sock)
>          */
>         mmc->max_busy_timeout = TIFM_MMCSD_REQ_TIMEOUT_MS;
>
> -       tasklet_setup(&host->finish_tasklet, tifm_sd_end_cmd);
> +       INIT_WORK(&host->finish_work, tifm_sd_end_cmd);
>         timer_setup(&host->timer, tifm_sd_abort, 0);
>
>         mmc->ops = &tifm_sd_ops;
> @@ -999,7 +1000,7 @@ static void tifm_sd_remove(struct tifm_dev *sock)
>         writel(0, sock->addr + SOCK_MMCSD_INT_ENABLE);
>         spin_unlock_irqrestore(&sock->lock, flags);
>
> -       tasklet_kill(&host->finish_tasklet);
> +       cancel_work_sync(&host->finish_work);
>
>         spin_lock_irqsave(&sock->lock, flags);
>         if (host->req) {
> @@ -1009,7 +1010,7 @@ static void tifm_sd_remove(struct tifm_dev *sock)
>                 host->req->cmd->error = -ENOMEDIUM;
>                 if (host->req->stop)
>                         host->req->stop->error = -ENOMEDIUM;
> -               tasklet_schedule(&host->finish_tasklet);
> +               queue_work(system_bh_wq, &host->finish_work);
>         }
>         spin_unlock_irqrestore(&sock->lock, flags);
>         mmc_remove_host(mmc);
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index de56e6534aea..bee13acaa80f 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -21,6 +21,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
> +#include <linux/workqueue.h>
>
>  #define CTL_SD_CMD 0x00
>  #define CTL_ARG_REG 0x04
> @@ -156,7 +157,7 @@ struct tmio_mmc_host {
>         bool                    dma_on;
>         struct dma_chan         *chan_rx;
>         struct dma_chan         *chan_tx;
> -       struct tasklet_struct   dma_issue;
> +       struct work_struct      dma_issue;
>         struct scatterlist      bounce_sg;
>         u8                      *bounce_buf;
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 93e912afd3ae..51bd2365795b 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -608,7 +608,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host, unsigned int stat)
>                         } else {
>                                 tmio_mmc_disable_mmc_irqs(host,
>                                                           TMIO_MASK_READOP);
> -                               tasklet_schedule(&host->dma_issue);
> +                               queue_work(system_bh_wq, &host->dma_issue);
>                         }
>                 } else {
>                         if (!host->dma_on) {
> @@ -616,7 +616,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host, unsigned int stat)
>                         } else {
>                                 tmio_mmc_disable_mmc_irqs(host,
>                                                           TMIO_MASK_WRITEOP);
> -                               tasklet_schedule(&host->dma_issue);
> +                               queue_work(system_bh_wq, &host->dma_issue);
>                         }
>                 }
>         } else {
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 1404989e6151..d1964111c393 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <linux/workqueue.h>
>
>  #include "tmio_mmc.h"
>
> @@ -90,9 +91,9 @@ static void uniphier_sd_dma_endisable(struct tmio_mmc_host *host, int enable)
>  }
>
>  /* external DMA engine */
> -static void uniphier_sd_external_dma_issue(struct tasklet_struct *t)
> +static void uniphier_sd_external_dma_issue(struct work_struct *t)
>  {
> -       struct tmio_mmc_host *host = from_tasklet(host, t, dma_issue);
> +       struct tmio_mmc_host *host = from_work(host, t, dma_issue);
>         struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
>
>         uniphier_sd_dma_endisable(host, 1);
> @@ -199,7 +200,7 @@ static void uniphier_sd_external_dma_request(struct tmio_mmc_host *host,
>         host->chan_rx = chan;
>         host->chan_tx = chan;
>
> -       tasklet_setup(&host->dma_issue, uniphier_sd_external_dma_issue);
> +       INIT_WORK(&host->dma_issue, uniphier_sd_external_dma_issue);
>  }
>
>  static void uniphier_sd_external_dma_release(struct tmio_mmc_host *host)
> @@ -236,9 +237,9 @@ static const struct tmio_mmc_dma_ops uniphier_sd_external_dma_ops = {
>         .dataend = uniphier_sd_external_dma_dataend,
>  };
>
> -static void uniphier_sd_internal_dma_issue(struct tasklet_struct *t)
> +static void uniphier_sd_internal_dma_issue(struct work_struct *t)
>  {
> -       struct tmio_mmc_host *host = from_tasklet(host, t, dma_issue);
> +       struct tmio_mmc_host *host = from_work(host, t, dma_issue);
>         unsigned long flags;
>
>         spin_lock_irqsave(&host->lock, flags);
> @@ -317,7 +318,7 @@ static void uniphier_sd_internal_dma_request(struct tmio_mmc_host *host,
>
>         host->chan_tx = (void *)0xdeadbeaf;
>
> -       tasklet_setup(&host->dma_issue, uniphier_sd_internal_dma_issue);
> +       INIT_WORK(&host->dma_issue, uniphier_sd_internal_dma_issue);
>  }
>
>  static void uniphier_sd_internal_dma_release(struct tmio_mmc_host *host)
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index ba6044b16e07..2777b773086b 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -12,6 +12,7 @@
>  #include <linux/interrupt.h>
>
>  #include <linux/mmc/host.h>
> +#include <linux/workqueue.h>
>
>  #define DRV_NAME       "via_sdmmc"
>
> @@ -307,7 +308,7 @@ struct via_crdr_mmc_host {
>         struct sdhcreg pm_sdhc_reg;
>
>         struct work_struct carddet_work;
> -       struct tasklet_struct finish_tasklet;
> +       struct work_struct finish_work;
>
>         struct timer_list timer;
>         spinlock_t lock;
> @@ -643,7 +644,7 @@ static void via_sdc_finish_data(struct via_crdr_mmc_host *host)
>         if (data->stop)
>                 via_sdc_send_command(host, data->stop);
>         else
> -               tasklet_schedule(&host->finish_tasklet);
> +               queue_work(system_bh_wq, &host->finish_work);
>  }
>
>  static void via_sdc_finish_command(struct via_crdr_mmc_host *host)
> @@ -653,7 +654,7 @@ static void via_sdc_finish_command(struct via_crdr_mmc_host *host)
>         host->cmd->error = 0;
>
>         if (!host->cmd->data)
> -               tasklet_schedule(&host->finish_tasklet);
> +               queue_work(system_bh_wq, &host->finish_work);
>
>         host->cmd = NULL;
>  }
> @@ -682,7 +683,7 @@ static void via_sdc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         status = readw(host->sdhc_mmiobase + VIA_CRDR_SDSTATUS);
>         if (!(status & VIA_CRDR_SDSTS_SLOTG) || host->reject) {
>                 host->mrq->cmd->error = -ENOMEDIUM;
> -               tasklet_schedule(&host->finish_tasklet);
> +               queue_work(system_bh_wq, &host->finish_work);
>         } else {
>                 via_sdc_send_command(host, mrq->cmd);
>         }
> @@ -848,7 +849,7 @@ static void via_sdc_cmd_isr(struct via_crdr_mmc_host *host, u16 intmask)
>                 host->cmd->error = -EILSEQ;
>
>         if (host->cmd->error)
> -               tasklet_schedule(&host->finish_tasklet);
> +               queue_work(system_bh_wq, &host->finish_work);
>         else if (intmask & VIA_CRDR_SDSTS_CRD)
>                 via_sdc_finish_command(host);
>  }
> @@ -955,16 +956,16 @@ static void via_sdc_timeout(struct timer_list *t)
>                                 sdhost->cmd->error = -ETIMEDOUT;
>                         else
>                                 sdhost->mrq->cmd->error = -ETIMEDOUT;
> -                       tasklet_schedule(&sdhost->finish_tasklet);
> +                       queue_work(system_bh_wq, &sdhost->finish_work);
>                 }
>         }
>
>         spin_unlock_irqrestore(&sdhost->lock, flags);
>  }
>
> -static void via_sdc_tasklet_finish(struct tasklet_struct *t)
> +static void via_sdc_work_finish(struct work_struct *t)
>  {
> -       struct via_crdr_mmc_host *host = from_tasklet(host, t, finish_tasklet);
> +       struct via_crdr_mmc_host *host = from_work(host, t, finish_work);
>         unsigned long flags;
>         struct mmc_request *mrq;
>
> @@ -1005,7 +1006,7 @@ static void via_sdc_card_detect(struct work_struct *work)
>                         pr_err("%s: Card removed during transfer!\n",
>                                mmc_hostname(host->mmc));
>                         host->mrq->cmd->error = -ENOMEDIUM;
> -                       tasklet_schedule(&host->finish_tasklet);
> +                       queue_work(system_bh_wq, &host->finish_work);
>                 }
>
>                 spin_unlock_irqrestore(&host->lock, flags);
> @@ -1051,7 +1052,7 @@ static void via_init_mmc_host(struct via_crdr_mmc_host *host)
>
>         INIT_WORK(&host->carddet_work, via_sdc_card_detect);
>
> -       tasklet_setup(&host->finish_tasklet, via_sdc_tasklet_finish);
> +       INIT_WORK(&host->finish_work, via_sdc_work_finish);
>
>         addrbase = host->sdhc_mmiobase;
>         writel(0x0, addrbase + VIA_CRDR_SDINTMASK);
> @@ -1193,7 +1194,7 @@ static void via_sd_remove(struct pci_dev *pcidev)
>                 sdhost->mrq->cmd->error = -ENOMEDIUM;
>                 if (sdhost->mrq->stop)
>                         sdhost->mrq->stop->error = -ENOMEDIUM;
> -               tasklet_schedule(&sdhost->finish_tasklet);
> +               queue_work(system_bh_wq, &sdhost->finish_work);
>         }
>         spin_unlock_irqrestore(&sdhost->lock, flags);
>
> @@ -1203,7 +1204,7 @@ static void via_sd_remove(struct pci_dev *pcidev)
>
>         del_timer_sync(&sdhost->timer);
>
> -       tasklet_kill(&sdhost->finish_tasklet);
> +       cancel_work_sync(&sdhost->finish_work);
>
>         /* switch off power */
>         gatt = readb(sdhost->pcictrl_mmiobase + VIA_CRDR_PCICLKGATT);
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index f0562f712d98..984e380abc71 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -32,6 +32,7 @@
>  #include <linux/mmc/sd.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
> +#include <linux/workqueue.h>
>
>  #include <asm/io.h>
>  #include <asm/dma.h>
> @@ -459,7 +460,7 @@ static void wbsd_empty_fifo(struct wbsd_host *host)
>          * FIFO threshold interrupts properly.
>          */
>         if ((data->blocks * data->blksz - data->bytes_xfered) < 16)
> -               tasklet_schedule(&host->fifo_tasklet);
> +               queue_work(system_bh_wq, &host->fifo_work);
>  }
>
>  static void wbsd_fill_fifo(struct wbsd_host *host)
> @@ -524,7 +525,7 @@ static void wbsd_fill_fifo(struct wbsd_host *host)
>          * 'FIFO empty' under certain conditions. So we
>          * need to be a bit more pro-active.
>          */
> -       tasklet_schedule(&host->fifo_tasklet);
> +       queue_work(system_bh_wq, &host->fifo_work);
>  }
>
>  static void wbsd_prepare_data(struct wbsd_host *host, struct mmc_data *data)
> @@ -746,7 +747,7 @@ static void wbsd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         struct mmc_command *cmd;
>
>         /*
> -        * Disable tasklets to avoid a deadlock.
> +        * Disable works to avoid a deadlock.
>          */
>         spin_lock_bh(&host->lock);
>
> @@ -821,7 +822,7 @@ static void wbsd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                  * Dirty fix for hardware bug.
>                  */
>                 if (host->dma == -1)
> -                       tasklet_schedule(&host->fifo_tasklet);
> +                       queue_work(system_bh_wq, &host->fifo_work);
>
>                 spin_unlock_bh(&host->lock);
>
> @@ -961,13 +962,13 @@ static void wbsd_reset_ignore(struct timer_list *t)
>          * Card status might have changed during the
>          * blackout.
>          */
> -       tasklet_schedule(&host->card_tasklet);
> +       queue_work(system_bh_wq, &host->card_work);
>
>         spin_unlock_bh(&host->lock);
>  }
>
>  /*
> - * Tasklets
> + * Works
>   */
>
>  static inline struct mmc_data *wbsd_get_data(struct wbsd_host *host)
> @@ -987,9 +988,9 @@ static inline struct mmc_data *wbsd_get_data(struct wbsd_host *host)
>         return host->mrq->cmd->data;
>  }
>
> -static void wbsd_tasklet_card(struct tasklet_struct *t)
> +static void wbsd_work_card(struct work_struct *t)
>  {
> -       struct wbsd_host *host = from_tasklet(host, t, card_tasklet);
> +       struct wbsd_host *host = from_work(host, t, card_work);
>         u8 csr;
>         int delay = -1;
>
> @@ -1020,7 +1021,7 @@ static void wbsd_tasklet_card(struct tasklet_struct *t)
>                         wbsd_reset(host);
>
>                         host->mrq->cmd->error = -ENOMEDIUM;
> -                       tasklet_schedule(&host->finish_tasklet);
> +                       queue_work(system_bh_wq, &host->finish_work);
>                 }
>
>                 delay = 0;
> @@ -1036,9 +1037,9 @@ static void wbsd_tasklet_card(struct tasklet_struct *t)
>                 mmc_detect_change(host->mmc, msecs_to_jiffies(delay));
>  }
>
> -static void wbsd_tasklet_fifo(struct tasklet_struct *t)
> +static void wbsd_work_fifo(struct work_struct *t)
>  {
> -       struct wbsd_host *host = from_tasklet(host, t, fifo_tasklet);
> +       struct wbsd_host *host = from_work(host, t, fifo_work);
>         struct mmc_data *data;
>
>         spin_lock(&host->lock);
> @@ -1060,16 +1061,16 @@ static void wbsd_tasklet_fifo(struct tasklet_struct *t)
>          */
>         if (host->num_sg == 0) {
>                 wbsd_write_index(host, WBSD_IDX_FIFOEN, 0);
> -               tasklet_schedule(&host->finish_tasklet);
> +               queue_work(system_bh_wq, &host->finish_work);
>         }
>
>  end:
>         spin_unlock(&host->lock);
>  }
>
> -static void wbsd_tasklet_crc(struct tasklet_struct *t)
> +static void wbsd_work_crc(struct work_struct *t)
>  {
> -       struct wbsd_host *host = from_tasklet(host, t, crc_tasklet);
> +       struct wbsd_host *host = from_work(host, t, crc_work);
>         struct mmc_data *data;
>
>         spin_lock(&host->lock);
> @@ -1085,15 +1086,15 @@ static void wbsd_tasklet_crc(struct tasklet_struct *t)
>
>         data->error = -EILSEQ;
>
> -       tasklet_schedule(&host->finish_tasklet);
> +       queue_work(system_bh_wq, &host->finish_work);
>
>  end:
>         spin_unlock(&host->lock);
>  }
>
> -static void wbsd_tasklet_timeout(struct tasklet_struct *t)
> +static void wbsd_work_timeout(struct work_struct *t)
>  {
> -       struct wbsd_host *host = from_tasklet(host, t, timeout_tasklet);
> +       struct wbsd_host *host = from_work(host, t, timeout_work);
>         struct mmc_data *data;
>
>         spin_lock(&host->lock);
> @@ -1109,15 +1110,15 @@ static void wbsd_tasklet_timeout(struct tasklet_struct *t)
>
>         data->error = -ETIMEDOUT;
>
> -       tasklet_schedule(&host->finish_tasklet);
> +       queue_work(system_bh_wq, &host->finish_work);
>
>  end:
>         spin_unlock(&host->lock);
>  }
>
> -static void wbsd_tasklet_finish(struct tasklet_struct *t)
> +static void wbsd_work_finish(struct work_struct *t)
>  {
> -       struct wbsd_host *host = from_tasklet(host, t, finish_tasklet);
> +       struct wbsd_host *host = from_work(host, t, finish_work);
>         struct mmc_data *data;
>
>         spin_lock(&host->lock);
> @@ -1156,18 +1157,18 @@ static irqreturn_t wbsd_irq(int irq, void *dev_id)
>         host->isr |= isr;
>
>         /*
> -        * Schedule tasklets as needed.
> +        * Schedule works as needed.
>          */
>         if (isr & WBSD_INT_CARD)
> -               tasklet_schedule(&host->card_tasklet);
> +               queue_work(system_bh_wq, &host->card_work);
>         if (isr & WBSD_INT_FIFO_THRE)
> -               tasklet_schedule(&host->fifo_tasklet);
> +               queue_work(system_bh_wq, &host->fifo_work);
>         if (isr & WBSD_INT_CRC)
> -               tasklet_hi_schedule(&host->crc_tasklet);
> +               queue_work(system_bh_highpri_wq, &host->crc_work);
>         if (isr & WBSD_INT_TIMEOUT)
> -               tasklet_hi_schedule(&host->timeout_tasklet);
> +               queue_work(system_bh_highpri_wq, &host->timeout_work);
>         if (isr & WBSD_INT_TC)
> -               tasklet_schedule(&host->finish_tasklet);
> +               queue_work(system_bh_wq, &host->finish_work);
>
>         return IRQ_HANDLED;
>  }
> @@ -1443,13 +1444,13 @@ static int wbsd_request_irq(struct wbsd_host *host, int irq)
>         int ret;
>
>         /*
> -        * Set up tasklets. Must be done before requesting interrupt.
> +        * Set up works. Must be done before requesting interrupt.
>          */
> -       tasklet_setup(&host->card_tasklet, wbsd_tasklet_card);
> -       tasklet_setup(&host->fifo_tasklet, wbsd_tasklet_fifo);
> -       tasklet_setup(&host->crc_tasklet, wbsd_tasklet_crc);
> -       tasklet_setup(&host->timeout_tasklet, wbsd_tasklet_timeout);
> -       tasklet_setup(&host->finish_tasklet, wbsd_tasklet_finish);
> +       INIT_WORK(&host->card_work, wbsd_work_card);
> +       INIT_WORK(&host->fifo_work, wbsd_work_fifo);
> +       INIT_WORK(&host->crc_work, wbsd_work_crc);
> +       INIT_WORK(&host->timeout_work, wbsd_work_timeout);
> +       INIT_WORK(&host->finish_work, wbsd_work_finish);
>
>         /*
>          * Allocate interrupt.
> @@ -1472,11 +1473,11 @@ static void  wbsd_release_irq(struct wbsd_host *host)
>
>         host->irq = 0;
>
> -       tasklet_kill(&host->card_tasklet);
> -       tasklet_kill(&host->fifo_tasklet);
> -       tasklet_kill(&host->crc_tasklet);
> -       tasklet_kill(&host->timeout_tasklet);
> -       tasklet_kill(&host->finish_tasklet);
> +       cancel_work_sync(&host->card_work);
> +       cancel_work_sync(&host->fifo_work);
> +       cancel_work_sync(&host->crc_work);
> +       cancel_work_sync(&host->timeout_work);
> +       cancel_work_sync(&host->finish_work);
>  }
>
>  /*
> diff --git a/drivers/mmc/host/wbsd.h b/drivers/mmc/host/wbsd.h
> index be30b4d8ce4c..942a64a724e4 100644
> --- a/drivers/mmc/host/wbsd.h
> +++ b/drivers/mmc/host/wbsd.h
> @@ -171,11 +171,11 @@ struct wbsd_host
>         int                     irq;            /* Interrupt */
>         int                     dma;            /* DMA channel */
>
> -       struct tasklet_struct   card_tasklet;   /* Tasklet structures */
> -       struct tasklet_struct   fifo_tasklet;
> -       struct tasklet_struct   crc_tasklet;
> -       struct tasklet_struct   timeout_tasklet;
> -       struct tasklet_struct   finish_tasklet;
> +       struct work_struct      card_work;      /* Work structures */
> +       struct work_struct      fifo_work;
> +       struct work_struct      crc_work;
> +       struct work_struct      timeout_work;
> +       struct work_struct      finish_work;
>
>         struct timer_list       ignore_timer;   /* Ignore detection timer */
>  };
> --
> 2.17.1
>

