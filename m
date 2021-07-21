Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE9B3D068E
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 03:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhGUBPT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 21:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhGUBPH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 21:15:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC5AC6044F;
        Wed, 21 Jul 2021 01:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626832545;
        bh=udoAwfxkz2c3+6bRQCgcDtKski/cNMY8ohh4yK73Tso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOUtAI/4UX6ZSX/WqH40ms5XuNKclmxsf9ByxBxR1YeMHhmuGjX5cW0REJZj+1QCJ
         MVt10zmqJAZD+Si81q49Vi2ijLgikeMBrym0jqg/OoggGtTRPm+OMY4hBs5/vy5IEz
         0kvms9zOVERaw2CP0vXGzUvHTM0PIzrjt+KjFH7k/fNYmk0hwIJXFKwutqgOvM9vYY
         IFzz43q9q16ohDtTRHSpLRZneMNNzsSMBH24dEOGpCVuEYIWj58oIQ8YrfeO1/mJ5O
         Htc66L8MBi4h8wwwhNyo/PIr9gfbcWdQvt8PBZzh9krjCpNlbaYnvN8KXhtwAH9t2/
         e3x6Z5frbSgqg==
Date:   Tue, 20 Jul 2021 18:55:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] Input: serio - make write method mandatory
Message-ID: <YPd+nl30LwKWpEZa@Ryzen-9-3900X.localdomain>
References: <YFgUxG/TljMuVeQ3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFgUxG/TljMuVeQ3@google.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Mar 21, 2021 at 08:53:40PM -0700, Dmitry Torokhov wrote:
> Given that all serio drivers except one implement write() method
> let's make it mandatory to avoid testing for its presence whenever
> we attempt to use it.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/serio/ams_delta_serio.c | 6 ++++++
>  drivers/input/serio/serio.c           | 5 +++++
>  include/linux/serio.h                 | 5 +----
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index 1c0be299f179..a1c314897951 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -89,6 +89,11 @@ static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static int ams_delta_serio_write(struct serio *serio, u8 data)
> +{
> +	return -EINVAL;
> +}
> +
>  static int ams_delta_serio_open(struct serio *serio)
>  {
>  	struct ams_delta_serio *priv = serio->port_data;
> @@ -157,6 +162,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  	priv->serio = serio;
>  
>  	serio->id.type = SERIO_8042;
> +	serio->write = ams_delta_serio_write;
>  	serio->open = ams_delta_serio_open;
>  	serio->close = ams_delta_serio_close;
>  	strlcpy(serio->name, "AMS DELTA keyboard adapter", sizeof(serio->name));
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 29f491082926..8d229a11bb6b 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -694,6 +694,11 @@ EXPORT_SYMBOL(serio_reconnect);
>   */
>  void __serio_register_port(struct serio *serio, struct module *owner)
>  {
> +	if (!serio->write) {
> +		pr_err("%s: refusing to register %s without write method\n",
> +		       __func__, serio->name);
> +		return;
> +	}
>  	serio_init_port(serio);
>  	serio_queue_event(serio, owner, SERIO_REGISTER_PORT);
>  }
> diff --git a/include/linux/serio.h b/include/linux/serio.h
> index 6c27d413da92..075f1b8d76fa 100644
> --- a/include/linux/serio.h
> +++ b/include/linux/serio.h
> @@ -121,10 +121,7 @@ void serio_unregister_driver(struct serio_driver *drv);
>  
>  static inline int serio_write(struct serio *serio, unsigned char data)
>  {
> -	if (serio->write)
> -		return serio->write(serio, data);
> -	else
> -		return -1;
> +	return serio->write(serio, data);
>  }
>  
>  static inline void serio_drv_write_wakeup(struct serio *serio)
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
> 
> -- 
> Dmitry

This patch as commit 81c7c0a350bf ("Input: serio - make write method
mandatory") in -next breaks input for my Hyper-V VM, which prevents me
from logging in. I attempted to do something like the following (-1 or
-EINVAL) which should be equivalent but it does not resolve the issue.

Cheers,
Nathan

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 1a7b72a9016d..d3eee2d4c327 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -311,6 +311,11 @@ static void hv_kbd_stop(struct serio *serio)
        spin_unlock_irqrestore(&kbd_dev->lock, flags);
 }

+static int hv_kbd_write(struct serio *serio, u8 data)
+{
+       return -1;
+}
+
 static int hv_kbd_probe(struct hv_device *hv_dev,
                        const struct hv_vmbus_device_id *dev_id)
 {
@@ -341,6 +346,7 @@ static int hv_kbd_probe(struct hv_device *hv_dev,

        hv_serio->start = hv_kbd_start;
        hv_serio->stop = hv_kbd_stop;
+       hv_serio->write = hv_kbd_write;

        error = vmbus_open(hv_dev->channel,
                           KBD_VSC_SEND_RING_BUFFER_SIZE,

