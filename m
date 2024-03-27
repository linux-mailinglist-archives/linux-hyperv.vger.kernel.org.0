Return-Path: <linux-hyperv+bounces-1853-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7F88ED81
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627FF1F35B55
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA22214F130;
	Wed, 27 Mar 2024 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjH7+A2i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE012FF74;
	Wed, 27 Mar 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562309; cv=none; b=QvNv6WEUDVfxRRD5o6H6jsUlogP/n8jK9NVQK2lHU2GdBUpY1qR+PCR5uhQmEt2UUAx0umAyEXn0PGTjlGTWrf/pEMXEyVkpu8Weje0fuNFRdVKV34FHpMt3VNTnescBJy6oyG24RLykWTmy4Ueu3StFz2IVglZtK1gKsg0sAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562309; c=relaxed/simple;
	bh=/LAfZ8Nb5/IISyxpsj9ues9JEim1UydvELJxBBntuTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyGMfLASXFa+bBBHqJudNMYrwVHkV9reJT4pkRODxKyQnjkj/Eh6LuaRy+5xr1dNFNTbDohz5jNBuymEbyIr4lKym/IFsrVH9IwwuID2xLgKoN4UnKkJtyCaywc7DukvpyeMPScD+alJN0bDt6tGJLZqNC1U83kvM0dBBz33Lfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjH7+A2i; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a4a14c52fcso35112eaf.1;
        Wed, 27 Mar 2024 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711562307; x=1712167107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWR/88ZuStiYrDMS5UWD0VLDt0J6Sqyii5LmdWwCGKc=;
        b=CjH7+A2iUHNFpc5Ub0yrU/SBj9I1zaJOkzlsM7zo5J9GOmk0X/MDLo+r2ntG0DWp0a
         4Wm2laCBzMUg+y1PInO9Dhr+OKefCMUQfslxCkJYXzLsoPRP/ZIuZl7ZCPP+jJtrcR3s
         fyfPsugyYYQIlC5ObV0K9PzEyah0W/JZPY02Ep7Q2ikupHkII2Lew2ojUxGb4NdJiXym
         wl9T7ckfXW2O7iEubiZWsD9gjzd/RsCTcOxvDxC0eaFjWWuTjcHDaS1qoif9pShg9igE
         Db6me9cJP+AvLodHAqsPuwpd3Ve6aVfzSKJplXUThl8HqETmkOTJSC3BlBnMhpIkZYf7
         +1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711562307; x=1712167107;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWR/88ZuStiYrDMS5UWD0VLDt0J6Sqyii5LmdWwCGKc=;
        b=dYFdkB2fXDsBFJx8MP3U2dJx3gWSiXioVgT2H1RkhzkCkEFDzlnIYAmq08IH5zteL5
         0141jAAjdB3FDK2jBd8DVLfsbWF2IcyGufM5I7WHD3IgdbWmeNw7BpQjLwb3a1OJPf/2
         FS3HVuzNrtIwI1NobV/RTfcDH2NQzEkp4ohY6PSZfiXe9KFgKdXjFgtCyXHWp6jlAkdi
         sVCejt/myduj9MzdLtp6qdF0qgK0CBPns7EI+++/0sINvuSl0FIvkwZno17nGt1w1qbG
         NWNNJoHDeJbdavT6x2SY/5cPIxJIMz5INCj6gp19yFWFY14kbaQjeOMneZezuvgsPZGn
         Fe+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSaqYZ+9RmvN6WiP+kGGFyBzvHOWEBUiXySwsh4OAIGIvN+stMJvu93Ze+5FMCwvc+5pvy95LRfTtjmigHzhjtwl7N/nKkXCRkX/BFeGorSoQs3M/My4TrOcvqkIfrrsg5C3PMSizOgAzV2gT3cr/rTW2a8huqE7lW6yluyJ8RL3NW0fiwl2uOKzyzn0hpNGRtdLc+uGMkPOB0QsP1gEZHEKACK814e/iAaGZ6/dPWYLrzQXAfHia/+2+wKCHX35Ebwh6jfbNFLcr/1WeU7udkU4jDxbXXqRgh52NpuRGCmKgfKPDKlIpEXuxYQA+3V9RRl1ts+hmEr75mrxS2R+WGc1t1oEGotGgiQ7IyHbHNfnz45NFd620BqwbeJc/OMgxaCHDUj3sDjXh6R2X4FdZGmpADV5P1MJ39zg8atpFC6vE8ARjuYJObJjOTrXVSgoSAu25gqjkTXDfDnnGyc3+8LJ9xUHE/j0EfSu1eZFRPoTCLxuwUTTuVL2ge9KRVtCehybT9AiDeZS2hRx1A35B06wRSD4Zy6aPUjXR9NW8efFk=
X-Gm-Message-State: AOJu0YyoTSR7/t3dMCxkTCSMA7VBosr7rFLL1MuzpBdsB16Qtrn+ZEcu
	/k1Ht/Qi1zshsCobgzpCbB/KZb8u4beaNDx6A5bGz928tKY9JFo=
X-Google-Smtp-Source: AGHT+IHGFL5Y4vBO4pyfj4PH1IfUYef9kiur/wYx9MERAj7ZhpX+bQrG7CGeqTsmrIqsWvwI+SjvGQ==
X-Received: by 2002:a05:6820:260f:b0:5a4:ae86:118f with SMTP id cy15-20020a056820260f00b005a4ae86118fmr856230oob.8.1711562306422;
        Wed, 27 Mar 2024 10:58:26 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm2445897oob.30.2024.03.27.10.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 10:58:26 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:ac74:4d5d:21e4:a88a])
	by serve.minyard.net (Postfix) with ESMTPSA id 6CA7D1800B9;
	Wed, 27 Mar 2024 17:58:24 +0000 (UTC)
Date: Wed, 27 Mar 2024 12:58:23 -0500
From: Corey Minyard <minyard@acm.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org,
	vkoul@kernel.org, marcan@marcan.st, sven@svenpeter.dev,
	florian.fainelli@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, paul@crapouillou.net,
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
Subject: Re: [PATCH 6/9] ipmi: Convert from tasklet to BH workqueue
Message-ID: <ZgRePyo2zC4A1Fp4@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-7-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327160314.9982-7-apais@linux.microsoft.com>

On Wed, Mar 27, 2024 at 04:03:11PM +0000, Allen Pais wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/infiniband/* from tasklet to BH workqueue.

I think you mean drivers/char/ipmi/* here.

I believe that work queues items are execute single-threaded for a work
queue, so this should be good.  I need to test this, though.  It may be
that an IPMI device can have its own work queue; it may not be important
to run it in bh context.

-corey

> 
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 30 ++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index b0eedc4595b3..fce2a2dbdc82 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -36,12 +36,13 @@
>  #include <linux/nospec.h>
>  #include <linux/vmalloc.h>
>  #include <linux/delay.h>
> +#include <linux/workqueue.h>
>  
>  #define IPMI_DRIVER_VERSION "39.2"
>  
>  static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
>  static int ipmi_init_msghandler(void);
> -static void smi_recv_tasklet(struct tasklet_struct *t);
> +static void smi_recv_work(struct work_struct *t);
>  static void handle_new_recv_msgs(struct ipmi_smi *intf);
>  static void need_waiter(struct ipmi_smi *intf);
>  static int handle_one_recv_msg(struct ipmi_smi *intf,
> @@ -498,13 +499,13 @@ struct ipmi_smi {
>  	/*
>  	 * Messages queued for delivery.  If delivery fails (out of memory
>  	 * for instance), They will stay in here to be processed later in a
> -	 * periodic timer interrupt.  The tasklet is for handling received
> +	 * periodic timer interrupt.  The work is for handling received
>  	 * messages directly from the handler.
>  	 */
>  	spinlock_t       waiting_rcv_msgs_lock;
>  	struct list_head waiting_rcv_msgs;
>  	atomic_t	 watchdog_pretimeouts_to_deliver;
> -	struct tasklet_struct recv_tasklet;
> +	struct work_struct recv_work;
>  
>  	spinlock_t             xmit_msgs_lock;
>  	struct list_head       xmit_msgs;
> @@ -704,7 +705,7 @@ static void clean_up_interface_data(struct ipmi_smi *intf)
>  	struct cmd_rcvr  *rcvr, *rcvr2;
>  	struct list_head list;
>  
> -	tasklet_kill(&intf->recv_tasklet);
> +	cancel_work_sync(&intf->recv_work);
>  
>  	free_smi_msg_list(&intf->waiting_rcv_msgs);
>  	free_recv_msg_list(&intf->waiting_events);
> @@ -1319,7 +1320,7 @@ static void free_user(struct kref *ref)
>  {
>  	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
>  
> -	/* SRCU cleanup must happen in task context. */
> +	/* SRCU cleanup must happen in work context. */
>  	queue_work(remove_work_wq, &user->remove_work);
>  }
>  
> @@ -3605,8 +3606,7 @@ int ipmi_add_smi(struct module         *owner,
>  	intf->curr_seq = 0;
>  	spin_lock_init(&intf->waiting_rcv_msgs_lock);
>  	INIT_LIST_HEAD(&intf->waiting_rcv_msgs);
> -	tasklet_setup(&intf->recv_tasklet,
> -		     smi_recv_tasklet);
> +	INIT_WORK(&intf->recv_work, smi_recv_work);
>  	atomic_set(&intf->watchdog_pretimeouts_to_deliver, 0);
>  	spin_lock_init(&intf->xmit_msgs_lock);
>  	INIT_LIST_HEAD(&intf->xmit_msgs);
> @@ -4779,7 +4779,7 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf)
>  			 * To preserve message order, quit if we
>  			 * can't handle a message.  Add the message
>  			 * back at the head, this is safe because this
> -			 * tasklet is the only thing that pulls the
> +			 * work is the only thing that pulls the
>  			 * messages.
>  			 */
>  			list_add(&smi_msg->link, &intf->waiting_rcv_msgs);
> @@ -4812,10 +4812,10 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf)
>  	}
>  }
>  
> -static void smi_recv_tasklet(struct tasklet_struct *t)
> +static void smi_recv_work(struct work_struct *t)
>  {
>  	unsigned long flags = 0; /* keep us warning-free. */
> -	struct ipmi_smi *intf = from_tasklet(intf, t, recv_tasklet);
> +	struct ipmi_smi *intf = from_work(intf, t, recv_work);
>  	int run_to_completion = intf->run_to_completion;
>  	struct ipmi_smi_msg *newmsg = NULL;
>  
> @@ -4866,7 +4866,7 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
>  
>  	/*
>  	 * To preserve message order, we keep a queue and deliver from
> -	 * a tasklet.
> +	 * a work.
>  	 */
>  	if (!run_to_completion)
>  		spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
> @@ -4887,9 +4887,9 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
>  		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
>  
>  	if (run_to_completion)
> -		smi_recv_tasklet(&intf->recv_tasklet);
> +		smi_recv_work(&intf->recv_work);
>  	else
> -		tasklet_schedule(&intf->recv_tasklet);
> +		queue_work(system_bh_wq, &intf->recv_work);
>  }
>  EXPORT_SYMBOL(ipmi_smi_msg_received);
>  
> @@ -4899,7 +4899,7 @@ void ipmi_smi_watchdog_pretimeout(struct ipmi_smi *intf)
>  		return;
>  
>  	atomic_set(&intf->watchdog_pretimeouts_to_deliver, 1);
> -	tasklet_schedule(&intf->recv_tasklet);
> +	queue_work(system_bh_wq, &intf->recv_work);
>  }
>  EXPORT_SYMBOL(ipmi_smi_watchdog_pretimeout);
>  
> @@ -5068,7 +5068,7 @@ static bool ipmi_timeout_handler(struct ipmi_smi *intf,
>  				       flags);
>  	}
>  
> -	tasklet_schedule(&intf->recv_tasklet);
> +	queue_work(system_bh_wq, &intf->recv_work);
>  
>  	return need_timer;
>  }
> -- 
> 2.17.1
> 
> 

