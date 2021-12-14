Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A107474805
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Dec 2021 17:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhLNQ2s (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Dec 2021 11:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhLNQ2r (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Dec 2021 11:28:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59084C061574
        for <linux-hyperv@vger.kernel.org>; Tue, 14 Dec 2021 08:28:47 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id k37so37936927lfv.3
        for <linux-hyperv@vger.kernel.org>; Tue, 14 Dec 2021 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ht7FhbogWe1LjybdJ4lfH5R0Tgghs68/vIMV7oWc9IU=;
        b=GntkFEqN66q4WdLK4GiRo9YuqCPKrLKJ5XbIQuVZTJBb7Z8pnMqOpXrJcYnSIXN8xd
         OfCBpZ0NV9YtFLkOp2X74+tsyDASg9Vry3fSEzD2aEBefYa2gXVxsglSBxKomo/60OUO
         yGPja1mNJUmvg1WSuaJKUM0Gr+VAWr0A9xKvV23M5W0uK994tV/i7BKVpGMfX0XN3WWK
         xEZj6u3iOKD/cNlvVRmDMpkczoYivXW1/yQtSqVWF9cBZ9JwevG8YyO1CmZcuBcFKb84
         tOSTqdo8OQzziHQeybRm6MtDN+iyMZfXdb1iOLQC5h7usolPpvWAeTy739AJ/jIG14AV
         krKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ht7FhbogWe1LjybdJ4lfH5R0Tgghs68/vIMV7oWc9IU=;
        b=aB44uo/tuL+kMUthBZ/UjpHnEfDr3uQrXGIoKCcbhs64QoqseWp22O821i6N3KDYIg
         pC/rLZzQSkZV6HJHxkW+5MpUTUJI3Nbr6ZitUQXWyD9uxvumUfqan1kis4H2gN3qajJV
         ZbiAFBfBsnjTPQLWg4ZqJdRlbCwPqRYai3v96xYESYmloCH1OFSjp83u4Z9OWRCkcMie
         /lWUQ221czDG0nwumhbg2pcCwDAAcY3IAa4cdRqxMPy/BPA3HF1MqKDDCbk3Y1BbIBW0
         hX0iYlHJhjWa7FQNr39jcy/ldmdmFWpvjDUqhDnN+gmNyZjPBu5AHOvk0qnmdiSuq/ar
         bOUw==
X-Gm-Message-State: AOAM533nuTCRJfbVoRQOFv0e8X0pJSsMY/E/qG9t5KZ//g+9yqEqcgqR
        cSOMiu+mxXy2QS7zXzkE07OddnaUZ0Bbdy7VK1pPgtHxomXz+Q==
X-Google-Smtp-Source: ABdhPJwF3Jy5OYtyG7XdbJpoUIE7lzYEFxJ05T/f47Z43oy/+bMXUkT8z5GzsGp8C8s9P8qZes+yBjz2MuI4qCncOcY=
X-Received: by 2002:a05:6512:10d2:: with SMTP id k18mr5659967lfg.259.1639499325559;
 Tue, 14 Dec 2021 08:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20211212121326.215377-1-yanminglr@gmail.com> <20211213014709.GA2316@anparri>
 <CAH+BkoF-Y55MCSoFes3QYJqXEEH3ZsjHMjmtrKmN3UHv9S_0iw@mail.gmail.com>
 <20211214020658.GA439610@anparri> <20211214042804.GA1934@anparri>
In-Reply-To: <20211214042804.GA1934@anparri>
From:   Yanming Liu <yanminglr@gmail.com>
Date:   Wed, 15 Dec 2021 00:28:33 +0800
Message-ID: <CAH+BkoE51_zAtgOo5ZGJk+32cycQ+OetL_U8hyO8oNMJaymAGg@mail.gmail.com>
Subject: Re: [PATCH] hv: account for packet descriptor in maximum packet size
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Andrea,

Thank you for your very detailed reply! I'm going to send a V2 which
should address all your comments.

On Tue, Dec 14, 2021 at 12:28 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> On Tue, Dec 14, 2021 at 03:06:58AM +0100, Andrea Parri wrote:
[...]
> > In fact, IIUC, similar considerations would apply to hv_fb and hv_drm *if
> > it were not for the fact that those drivers seem to have bogus values for
> > max_pkt_size:
> >
> >   6) drivers/video/fbdev/hyperv_fb.c
> >      (bufferlen = MAX_VMBUS_PKT_SIZE, max_pkt_size=VMBUS_DEFAULT_MAX_PKT_SIZE)
> >
> >   7) drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> >      (bufferlen = MAX_VMBUS_PKT_SIZE, max_pkt_size=VMBUS_DEFAULT_MAX_PKT_SIZE)
> >

Nice catch! The reason why I tried to apply a delta in vmbus code is I
found that VMBUS_DEFAULT_MAX_PKT_SIZE helps hide where should we set
max_pkt_size (so that drivers like hv_balloon is not changed), but I
failed to realize there are more.

> > So, IIUC, some separate patch is needed in order to "adjust" those values
> > (say, by appropriately setting max_pkt_size in synthvid_connect_vsp() and
> > in hyperv_connect_vsp()), but I digress.
> >
> > Other comments on your patch:
> >
> >   a) You mentioned the problem that "pkt_offset may not match the packet
> >      descriptor size".  I think this is a real problem.  To address this
> >      problem, we can *presumably consider HV_HYP_PAGE_SIZE to be a valid
> >      upper bound for pkt_offset (and sizeof(struct vmpacket_descriptor))
> >      *and increase the value of max_pkt_size by HV_HYP_PAGE_SIZE (rather
> >      than sizeof(struct vmpacket_descriptor)), like in:
> >
IIUC, pkt_offset is used for being forward-compatible with future
Hyper-V which may expand vmpacket_descriptor. If so, isn't a whole
page a little bit too much?
Anyway, I'm going to introduce a new #define for that, presumably
VMBUS_MAX_PKT_DESCR_SIZE, set to HY_HYP_PAGE_SIZE for now.

> > @@ -256,6 +256,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> >
> >       /* Initialize buffer that holds copies of incoming packets */
> >       if (max_pkt_size) {
> > +             max_pkt_size += HV_HYP_PAGE_SIZE;
> >               ring_info->pkt_buffer = kzalloc(max_pkt_size, GFP_KERNEL);
> >               if (!ring_info->pkt_buffer)
> >                       return -ENOMEM;
> >
> >   b) We may then want to "enforce"/check that that bound on pkt_offset,
> >
> >         pkt_offset <= HV_HYP_PAGE_SIZE,
> >
> >      is met by adding a corresponding check to the (previously discussed)
> >      validation of pkt_offset included in hv_pkt_iter_first(), say:
> >
> > @@ -498,7 +498,8 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct vmbus_channel *channel)
> >        * If pkt_offset is invalid, arbitrarily set it to
> >        * the size of vmpacket_descriptor
> >        */
> > -     if (pkt_offset < sizeof(struct vmpacket_descriptor) || pkt_offset > pkt_len)
> > +     if (pkt_offset < sizeof(struct vmpacket_descriptor) || pkt_offset > pkt_len ||
> > +                     pkt_offset > HV_HYP_PAGE_SIZE)
> >               pkt_offset = sizeof(struct vmpacket_descriptor);
> >
> >       /* Copy the Hyper-V packet out of the ring buffer */
> >
> >      While there (since I have noticed that such validation as well the
> >      validation on pkt_len in hv_pkt_iter_first() tend to be the object
> >      of a somehow recurring discussion ;/), I wouldn't mind to add some
> >      "explicit" debug, pr_err_ratelimited() say, there.
Good idea!
> >
> >   c) Last but not least, I'd recommend to pair the above changes or any
> >      other change with some inline explanation/comments; these comments
> >      could be snippets from an (updated) patch description for example.
Sure, thanks for the detailed guide here!
> >
> >   Andrea
>
> One more thought.  The additional HV_HYP_PAGE_SIZE seems unnecessary for
> drivers such as hv_netvsc and hv_storvsc, which explicitly account for
> pkt_offset in their setting of max_pkt_size, as well as for drivers such
> as hv_pci, which uses vmbus_recvpacket_raw().
>
> This suggests an alternative approach: do not increase max_pkt_size in
> the generic vmbus code, instead set/adjust max_pkt_size (only) for the
> drivers, in (1-7) above, which require the additional HV_HYP_PAGE_SIZE
> /pkt_offset.  While putting on the driver(s) some additional "burden",
> this approach has the advantage of saving some memory (and keeping the
> generic code relatively simpler).
>
> Thoughts?

Provided that there are indeed drivers (hv_storvsc and hv_netvsc)
which explicitly account for vmpacket_descriptor header, changing
max_pkt_size for individual drivers makes more sense.
However in this case I'm not sure about our reasoning of 'pkt_offset'
above. In drivers/scsi/storvsc_drv.c:

#define STORVSC_MAX_PKT_SIZE (sizeof(struct vmpacket_descriptor) +\
                              sizeof(struct vstor_packet))

Should I also change this 'sizeof(struct vmpacket_descriptor)' to
VMBUS_MAX_PKT_DESCR_SIZE? Otherwise this would not match the check in
hv_pkt_iter_first.

>
>   Andrea

Regards,
Yanming
