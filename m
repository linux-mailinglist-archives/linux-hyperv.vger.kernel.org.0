Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B96E3D0782
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 06:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhGUDbU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 23:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhGUDbT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 23:31:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F206BC061574;
        Tue, 20 Jul 2021 21:11:55 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id u14so674957pga.11;
        Tue, 20 Jul 2021 21:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/cGI+iVWCJGFFtwmPo17o5F5ePaIGRvj0d9XE8sJR3M=;
        b=FUY6TVUGKlmucS+kUxfuo9dGjDTYxFQxitjZR+aMsEGKvBi/nIWlGC36KEFw0cSaER
         kQH06QEAjqSJnU8GX8TTaodKsPivghuGqJ8z+Ci+NfR4/W0TCmKiN1soZKboZ2rxSpVC
         G892bKUAJBhGs4sS0UXlkfp18BtcHSdruZdLY4zAXdEbsccaXNrfWYNiV5S6KSb+3ekQ
         gWSKQGRrDQNp01klCrdE9PBMr/63kmkbshbp1WQ3RpHJ+txmBNfny28oiRjT2akM5zRP
         dukcJxzrDdcshsc+cjXP5+JKUYNIxLHlUdeVlGPdFRsxBKBcAhol3VEgx8oHK+K1uM6A
         qxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/cGI+iVWCJGFFtwmPo17o5F5ePaIGRvj0d9XE8sJR3M=;
        b=Jfr05yaCVawBlS/QF7JkyyLzEru7bgegJoIf+IsDfCPGlD4cU/3x0rAP9/XxviWbSQ
         sTjrYGCcmvrpAest6LwhLIFfWnJyS1mUAfCQHNJWdM2ZnA49v3mxzhJi5jlroRSYiFzk
         07529p3ZL2+oqPDKquabq28hbrJN7mMH3oG+dMQ6wCA05jqTIZPcoiNNONYOv098ZPv9
         JBOxf2CB3bbjaRgCb46DUjuIgCjCWd6jYbGETjI3Wn7Uv4IDmJJkROMfgPJk/wz8usZP
         rGBRqNeqkigN35APVdfx6MD+I7noMk0XejWOeKV5J9nL9Yml/qAFuBhzlsNTePH6Tubo
         YlAQ==
X-Gm-Message-State: AOAM5301guLAVSzGIAc4kou8YJtFoMyuLaxJ1SWO/6Ml3X0y7ODxUn9p
        8kiwilvAFTfnm+g97I2w9HA=
X-Google-Smtp-Source: ABdhPJz5owIwN6ceBYNMycQB5BvpEZZsONLgLmzJAkwS0zAHI5ZmUOGwSS7Cvl8CofWJ6ya9pJo9RQ==
X-Received: by 2002:aa7:8392:0:b029:2db:4a7:d866 with SMTP id u18-20020aa783920000b02902db04a7d866mr34334316pfm.66.1626840715282;
        Tue, 20 Jul 2021 21:11:55 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:3ca3:c5c9:5db2:10e2])
        by smtp.gmail.com with ESMTPSA id m34sm28705732pgb.85.2021.07.20.21.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 21:11:54 -0700 (PDT)
Date:   Tue, 20 Jul 2021 21:11:51 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] Input: serio - make write method mandatory
Message-ID: <YPeeh/s/pp4DOVR3@google.com>
References: <YFgUxG/TljMuVeQ3@google.com>
 <YPd+nl30LwKWpEZa@Ryzen-9-3900X.localdomain>
 <MWHPR21MB159385686CD54855A5FBE251D7E39@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159385686CD54855A5FBE251D7E39@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 21, 2021 at 03:19:36AM +0000, Michael Kelley wrote:
> From: Nathan Chancellor <nathan@kernel.org> Sent: Tuesday, July 20, 2021 6:56 PM
> > 
> > On Sun, Mar 21, 2021 at 08:53:40PM -0700, Dmitry Torokhov wrote:
> > > Given that all serio drivers except one implement write() method
> > > let's make it mandatory to avoid testing for its presence whenever
> > > we attempt to use it.
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/input/serio/ams_delta_serio.c | 6 ++++++
> > >  drivers/input/serio/serio.c           | 5 +++++
> > >  include/linux/serio.h                 | 5 +----
> > >  3 files changed, 12 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> > > index 1c0be299f179..a1c314897951 100644
> > > --- a/drivers/input/serio/ams_delta_serio.c
> > > +++ b/drivers/input/serio/ams_delta_serio.c
> > > @@ -89,6 +89,11 @@ static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
> > >  	return IRQ_HANDLED;
> > >  }
> > >
> > > +static int ams_delta_serio_write(struct serio *serio, u8 data)
> > > +{
> > > +	return -EINVAL;
> > > +}
> > > +
> > >  static int ams_delta_serio_open(struct serio *serio)
> > >  {
> > >  	struct ams_delta_serio *priv = serio->port_data;
> > > @@ -157,6 +162,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
> > >  	priv->serio = serio;
> > >
> > >  	serio->id.type = SERIO_8042;
> > > +	serio->write = ams_delta_serio_write;
> > >  	serio->open = ams_delta_serio_open;
> > >  	serio->close = ams_delta_serio_close;
> > >  	strlcpy(serio->name, "AMS DELTA keyboard adapter", sizeof(serio->name));
> > > diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> > > index 29f491082926..8d229a11bb6b 100644
> > > --- a/drivers/input/serio/serio.c
> > > +++ b/drivers/input/serio/serio.c
> > > @@ -694,6 +694,11 @@ EXPORT_SYMBOL(serio_reconnect);
> > >   */
> > >  void __serio_register_port(struct serio *serio, struct module *owner)
> > >  {
> > > +	if (!serio->write) {
> > > +		pr_err("%s: refusing to register %s without write method\n",
> > > +		       __func__, serio->name);
> > > +		return;
> > > +	}
> > >  	serio_init_port(serio);
> > >  	serio_queue_event(serio, owner, SERIO_REGISTER_PORT);
> > >  }
> > > diff --git a/include/linux/serio.h b/include/linux/serio.h
> > > index 6c27d413da92..075f1b8d76fa 100644
> > > --- a/include/linux/serio.h
> > > +++ b/include/linux/serio.h
> > > @@ -121,10 +121,7 @@ void serio_unregister_driver(struct serio_driver *drv);
> > >
> > >  static inline int serio_write(struct serio *serio, unsigned char data)
> > >  {
> > > -	if (serio->write)
> > > -		return serio->write(serio, data);
> > > -	else
> > > -		return -1;
> > > +	return serio->write(serio, data);
> > >  }
> > >
> > >  static inline void serio_drv_write_wakeup(struct serio *serio)
> > > --
> > > 2.31.0.rc2.261.g7f71774620-goog
> > >
> > >
> > > --
> > > Dmitry
> > 
> > This patch as commit 81c7c0a350bf ("Input: serio - make write method
> > mandatory") in -next breaks input for my Hyper-V VM, which prevents me
> > from logging in. I attempted to do something like the following (-1 or
> > -EINVAL) which should be equivalent but it does not resolve the issue.
> > 
> > Cheers,
> > Nathan
> > 
> > diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> > index 1a7b72a9016d..d3eee2d4c327 100644
> > --- a/drivers/input/serio/hyperv-keyboard.c
> > +++ b/drivers/input/serio/hyperv-keyboard.c
> > @@ -311,6 +311,11 @@ static void hv_kbd_stop(struct serio *serio)
> >         spin_unlock_irqrestore(&kbd_dev->lock, flags);
> >  }
> > 
> > +static int hv_kbd_write(struct serio *serio, u8 data)
> > +{
> > +       return -1;
> > +}
> > +
> >  static int hv_kbd_probe(struct hv_device *hv_dev,
> >                         const struct hv_vmbus_device_id *dev_id)
> >  {
> > @@ -341,6 +346,7 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
> > 
> >         hv_serio->start = hv_kbd_start;
> >         hv_serio->stop = hv_kbd_stop;
> > +       hv_serio->write = hv_kbd_write;
> > 
> >         error = vmbus_open(hv_dev->channel,
> >                            KBD_VSC_SEND_RING_BUFFER_SIZE,
> 
> I'm seeing the same problem.  I've added the code to hyperv-keyboard.c that Nathan
> proposed, and that solves the immediate problem in that the "refusing to register"
> message no longer occurs.
> 
> But there's now a different problem in that this error is output whenever a key
> is typed on the Hyper-V synthetic keyboard:
> 
> [   11.576716] atkbd serio0: keyboard reset failed on d34b2567-b9b6-42b9-8778-0a4ec0b
> 
> The Hyper-V keyboard driver depends on the AT Keyboard driver, and there's code in
> atkbd.c that checks for the existence of the serio->write function.  I haven't debugged all
> the details, but apparently hyperv-keyboard.c depends on atkbd.c finding that function
> as NULL in order to work properly.   See atkbd_connect().  These messages are output
> during boot when the two drivers are working properly together:
> 
> [    2.672693] hv_vmbus: registering driver hyperv_keyboard
> [    2.700587] input: AT Translated Set 2 keyboard as /devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:00/VMBUS:00/d34b2567-b9b6-42b9-8778-0a4ec0b955bf/serio0/input/input1
> 
> I'm not seeing the second message when running the latest linux-next.

Yeah, the patch is busted as several drivers actually check for the
presence of serio->write() to adjust their behavior. I will revert the
patch.

Thanks!

-- 
Dmitry
