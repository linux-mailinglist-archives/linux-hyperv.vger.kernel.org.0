Return-Path: <linux-hyperv+bounces-1866-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D5890912
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 20:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013A71C211E5
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAFD137C26;
	Thu, 28 Mar 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBGRgtAY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3410E41757;
	Thu, 28 Mar 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653794; cv=none; b=bu//DYiCGmuj2alEfr45xIJM6tF7LAYMaUM7tXZ/5oljd0miADsZ8aDaEXxJSt/BFT8T7im4qF2kiriOI3Y81rbEGHpI78J7nfEHFWRouT8OLz9FoZ07JiB7wkuzOuv1TzeInj7IudhBmizlqfNr7Sv6Kj71zZfLN5kvgOzStcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653794; c=relaxed/simple;
	bh=Qkh+5aM9AgMrPiE9S446jPnPgfztZdsPallUAN8x3Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZGaWBu54moYyOZ7U1PWnh9z9YLyAHoYL105+GzRNOFXm6w1P00r86E5tJCMDdyb6VMMPp0ECHWkEEM4H0/vbuwaVxSi7cZTv0dD9/Ljre1sw+x2khR4N/g6OmrY8lFeiYUJGx5guFDRvrETepl1sOwB2MTAkwcoak8dtklnyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBGRgtAY; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c3ab85050cso901644b6e.1;
        Thu, 28 Mar 2024 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711653790; x=1712258590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GyFGSwdDS+8X5fWOjo2s+K1AMkRQoOt7S254R+rI76g=;
        b=WBGRgtAYY1ul09qAQP15jHMyDDv17c6U7/Ep4/YYWw35GKpQHLjwAwuQSHdloWIIeA
         gW9Jt7Q5sV2fVwkj9HapX68tvUyfaQsiZnWp8m7SLVErSzrowhkaNAlk56e0IN/GzyjG
         PC5mhNeEoemZdnaWUg9v14+ihNarMnOAdJG8DWJ+lQd6jK3un4VImm3KnUV/XwYRoc1h
         IXDBTINXMKmckjTOs1lJalMm1jPYjpvd+AF1IYu3DfwmClF9h8wEt8bSwWWZQIJFiwLK
         EVRzw/49hHDKOsXMYFnH4v7sh2FKwO2xspmYv3kvxsgIKKiGB6r5O6PiupWfNXLWMtaM
         7FfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711653790; x=1712258590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyFGSwdDS+8X5fWOjo2s+K1AMkRQoOt7S254R+rI76g=;
        b=mk1wel8mvvt4cwLLAIyFMeaKgtXNLdN1CKLxowQ2Sr6xBw4BftjDunmovdCaQm/ZaW
         Lk5O33PepRMxRqznla05KIoAdJ+GwwwtIlHiGOgfM+MFers74i0vLRCt6gvWktpXf9kr
         SAFafc/BRl+l1kaP4Ph7LXChkLjCE7OAwoi6bjZ25vqkXDSyXbrUXBs6kf6mGULB81Py
         aofehRa2i2ajWT4Q9hol6O/GAuZuRDGAlAogHOfxyvEhMBi0HLFNO+/XOKNN/kl9zVt7
         cIE/NKkCjy/SGzIr0lf6fnXxkH1g8QFCO4nvFki13sLdmk12bi+OYwD14a1P/8IWne/S
         VeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFEBTGVkl2TFh0G/95wWsR/AauuxWXhM/EiMOjvDLCnn7LMV7IW1jBQTQoqvyAZ4EbfPEIIU8Ob7mA4nT2YU5cKMUuCDvVL2T3YCW0URz6UN6RkNCLnWGSwQ2KTJI0pQGFfIQ2tDUGcNvJf9EaHo/t7yaQvvsSNgkg4H0BnPXwzpMCv5XVFaNHSsPya6gJ011OUvYnpO1SsKRSfBtNFFaWz9Ma1wIl2B7n0MryyUZ4RDVgNjtknKIAEHqJYOvpXU0ZOeakzs6Z0RV/lHpl+CmXYjeZDsmyXXhIDDVi8CxH7S6pWw4X5ChOr37S49gQ2WWTTH1ol67tCl892485svaYBlW3cZnG/BpgE3IAfPPHc+1Op3ymevp98T/L/uwkhVknQXIRSvtv2Br8qM0S0ROBtPSGK6Ute9aRR+/M6IuQPQr37TpOZOYE3ErxUrp+PFgr0i2x8x0dQN/ANrCJYeD++EcyF/vOCoRWn7z1o2FtTX8dK/p/ji3FjMtAh/KVRQjZzIZ/ZE5cS6e+b9L+p81EyHRpN9XUWlZd6kB+kIW60ze4K/lPyWJljypNFRvLmNYt6BVDgzctVjEpQgDouFc=
X-Gm-Message-State: AOJu0YwN+MOo5THiv+pYxZuUCeqtwbCA32SxJJXdQy4hFBY7Y+y3c/uE
	dQaAQyJCe/fdxMwlVGGubf3TyiWWF0e46C0rwXfda2mlAyT2D0E=
X-Google-Smtp-Source: AGHT+IFK1zqNOwufMazqscK9oHIt3Gnza7CUH20lAptPqfXk7u6zVWm/s/9LmWvz7C9QCTeD+gjnYA==
X-Received: by 2002:a05:6808:3087:b0:3c3:d324:33e5 with SMTP id bl7-20020a056808308700b003c3d32433e5mr320267oib.15.1711653790263;
        Thu, 28 Mar 2024 12:23:10 -0700 (PDT)
Received: from serve.minyard.net ([47.184.181.2])
        by smtp.gmail.com with ESMTPSA id v12-20020a9d7d0c000000b006e67ac8b8a2sm346096otn.78.2024.03.28.12.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:23:09 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:b987:69e:202a:697a])
	by serve.minyard.net (Postfix) with ESMTPSA id A60B1180011;
	Thu, 28 Mar 2024 19:23:08 +0000 (UTC)
Date: Thu, 28 Mar 2024 14:23:07 -0500
From: Corey Minyard <minyard@acm.org>
To: Allen <allen.lkml@gmail.com>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	tj@kernel.org, keescook@chromium.org, vkoul@kernel.org,
	marcan@marcan.st, sven@svenpeter.dev, florian.fainelli@broadcom.com,
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
Message-ID: <ZgXDmx1HvujsMYAR@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-7-apais@linux.microsoft.com>
 <ZgRePyo2zC4A1Fp4@mail.minyard.net>
 <CAOMdWS+1AFxEqmACiBYzPHc+q0Ut6hp15tdV50JHvfVeUNCGQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMdWS+1AFxEqmACiBYzPHc+q0Ut6hp15tdV50JHvfVeUNCGQw@mail.gmail.com>

On Thu, Mar 28, 2024 at 10:52:16AM -0700, Allen wrote:
> On Wed, Mar 27, 2024 at 11:05 AM Corey Minyard <minyard@acm.org> wrote:
> >
> > I believe that work queues items are execute single-threaded for a work
> > queue, so this should be good.  I need to test this, though.  It may be
> > that an IPMI device can have its own work queue; it may not be important
> > to run it in bh context.
> 
>   Fair point. Could you please let me know once you have had a chance to test
> these changes. Meanwhile, I will work on RFC wherein IPMI will have its own
> workqueue.
> 
>  Thanks for taking time out to review.

After looking and thinking about it a bit, a BH context is still
probably the best for this.

I have tested this patch under load and various scenarios and it seems
to work ok.  So:

Tested-by: Corey Minyard <cminyard@mvista.com>
Acked-by: Corey Minyard <cminyard@mvista.com>

Or I can take this into my tree.

-corey

> 
> - Allen
> 
> >
> > -corey
> >
> > >
> > > Based on the work done by Tejun Heo <tj@kernel.org>
> > > Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-610
> > >
> > > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> > > ---
> > >  drivers/char/ipmi/ipmi_msghandler.c | 30 ++++++++++++++---------------
> > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > > index b0eedc4595b3..fce2a2dbdc82 100644
> > > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > > @@ -36,12 +36,13 @@
> > >  #include <linux/nospec.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/workqueue.h>
> > >
> > >  #define IPMI_DRIVER_VERSION "39.2"
> > >
> > >  static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
> > >  static int ipmi_init_msghandler(void);
> > > -static void smi_recv_tasklet(struct tasklet_struct *t);
> > > +static void smi_recv_work(struct work_struct *t);
> > >  static void handle_new_recv_msgs(struct ipmi_smi *intf);
> > >  static void need_waiter(struct ipmi_smi *intf);
> > >  static int handle_one_recv_msg(struct ipmi_smi *intf,
> > > @@ -498,13 +499,13 @@ struct ipmi_smi {
> > >       /*
> > >        * Messages queued for delivery.  If delivery fails (out of memory
> > >        * for instance), They will stay in here to be processed later in a
> > > -      * periodic timer interrupt.  The tasklet is for handling received
> > > +      * periodic timer interrupt.  The work is for handling received
> > >        * messages directly from the handler.
> > >        */
> > >       spinlock_t       waiting_rcv_msgs_lock;
> > >       struct list_head waiting_rcv_msgs;
> > >       atomic_t         watchdog_pretimeouts_to_deliver;
> > > -     struct tasklet_struct recv_tasklet;
> > > +     struct work_struct recv_work;
> > >
> > >       spinlock_t             xmit_msgs_lock;
> > >       struct list_head       xmit_msgs;
> > > @@ -704,7 +705,7 @@ static void clean_up_interface_data(struct ipmi_smi *intf)
> > >       struct cmd_rcvr  *rcvr, *rcvr2;
> > >       struct list_head list;
> > >
> > > -     tasklet_kill(&intf->recv_tasklet);
> > > +     cancel_work_sync(&intf->recv_work);
> > >
> > >       free_smi_msg_list(&intf->waiting_rcv_msgs);
> > >       free_recv_msg_list(&intf->waiting_events);
> > > @@ -1319,7 +1320,7 @@ static void free_user(struct kref *ref)
> > >  {
> > >       struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
> > >
> > > -     /* SRCU cleanup must happen in task context. */
> > > +     /* SRCU cleanup must happen in work context. */
> > >       queue_work(remove_work_wq, &user->remove_work);
> > >  }
> > >
> > > @@ -3605,8 +3606,7 @@ int ipmi_add_smi(struct module         *owner,
> > >       intf->curr_seq = 0;
> > >       spin_lock_init(&intf->waiting_rcv_msgs_lock);
> > >       INIT_LIST_HEAD(&intf->waiting_rcv_msgs);
> > > -     tasklet_setup(&intf->recv_tasklet,
> > > -                  smi_recv_tasklet);
> > > +     INIT_WORK(&intf->recv_work, smi_recv_work);
> > >       atomic_set(&intf->watchdog_pretimeouts_to_deliver, 0);
> > >       spin_lock_init(&intf->xmit_msgs_lock);
> > >       INIT_LIST_HEAD(&intf->xmit_msgs);
> > > @@ -4779,7 +4779,7 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf)
> > >                        * To preserve message order, quit if we
> > >                        * can't handle a message.  Add the message
> > >                        * back at the head, this is safe because this
> > > -                      * tasklet is the only thing that pulls the
> > > +                      * work is the only thing that pulls the
> > >                        * messages.
> > >                        */
> > >                       list_add(&smi_msg->link, &intf->waiting_rcv_msgs);
> > > @@ -4812,10 +4812,10 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf)
> > >       }
> > >  }
> > >
> > > -static void smi_recv_tasklet(struct tasklet_struct *t)
> > > +static void smi_recv_work(struct work_struct *t)
> > >  {
> > >       unsigned long flags = 0; /* keep us warning-free. */
> > > -     struct ipmi_smi *intf = from_tasklet(intf, t, recv_tasklet);
> > > +     struct ipmi_smi *intf = from_work(intf, t, recv_work);
> > >       int run_to_completion = intf->run_to_completion;
> > >       struct ipmi_smi_msg *newmsg = NULL;
> > >
> > > @@ -4866,7 +4866,7 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
> > >
> > >       /*
> > >        * To preserve message order, we keep a queue and deliver from
> > > -      * a tasklet.
> > > +      * a work.
> > >        */
> > >       if (!run_to_completion)
> > >               spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
> > > @@ -4887,9 +4887,9 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
> > >               spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
> > >
> > >       if (run_to_completion)
> > > -             smi_recv_tasklet(&intf->recv_tasklet);
> > > +             smi_recv_work(&intf->recv_work);
> > >       else
> > > -             tasklet_schedule(&intf->recv_tasklet);
> > > +             queue_work(system_bh_wq, &intf->recv_work);
> > >  }
> > >  EXPORT_SYMBOL(ipmi_smi_msg_received);
> > >
> > > @@ -4899,7 +4899,7 @@ void ipmi_smi_watchdog_pretimeout(struct ipmi_smi *intf)
> > >               return;
> > >
> > >       atomic_set(&intf->watchdog_pretimeouts_to_deliver, 1);
> > > -     tasklet_schedule(&intf->recv_tasklet);
> > > +     queue_work(system_bh_wq, &intf->recv_work);
> > >  }
> > >  EXPORT_SYMBOL(ipmi_smi_watchdog_pretimeout);
> > >
> > > @@ -5068,7 +5068,7 @@ static bool ipmi_timeout_handler(struct ipmi_smi *intf,
> > >                                      flags);
> > >       }
> > >
> > > -     tasklet_schedule(&intf->recv_tasklet);
> > > +     queue_work(system_bh_wq, &intf->recv_work);
> > >
> > >       return need_timer;
> > >  }
> > > --
> > > 2.17.1
> > >
> > >
> >
> 
> 
> -- 
>        - Allen
> 

