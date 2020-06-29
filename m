Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16EF20E6D8
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2020 00:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgF2VvR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Jun 2020 17:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbgF2VvP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Jun 2020 17:51:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A62C061755;
        Mon, 29 Jun 2020 14:51:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so8928454pgk.4;
        Mon, 29 Jun 2020 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QD5DEy/jVvw/j5XLElSOzb3HgHrMTHj6k7kJYHldTlE=;
        b=UmKdj7zzQGovaJHoZDjRCUfbnKZO9fy/KOV7Ye7XkNX3XRaahNF/EOOZULEPDHzNFX
         5O/UE8pbIdcVAEKrK2oVN4z3jBU40Zy0LPNPgMRfqmA3lDNqA0IXGmds2cG/Y38iIh17
         9psRG4xwGUi4zqt161P5yEKou3mzHuY/2f74sM3JUp1n6NIHLg5gCCOTHJ0BEP/mm16q
         8Rj4ByGJDje8G0YaHV5Ly4P+6AlGRPkT83d+oZiG+/Leog1eiWMLN7hEZH2axlfWSplZ
         6Y5ml8nX/hh9/8slGJwiipD0bSU+PZrleBG58YzEvG/eebD3b6Z3VlGQU1B4FKrs/mOe
         Virw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QD5DEy/jVvw/j5XLElSOzb3HgHrMTHj6k7kJYHldTlE=;
        b=Cx5dfIprIQkcXxm53a0Rl9Eev3W0M1MWX6qbGaNTwQaS5+SOoidGLrHojsJqIgZ5AI
         AZZS7HKAehwWyJsAd0y+higVEz1DlgLuuJOkfSkXpTWW78N+gy6kK1ZqMOFOwOzr1mKc
         p51duAQ3g8vfuFnI7mWHNATJ8axXisEInNG41L7Z4qnnuXdGNG4PTJYIRV0mWXc2w4BG
         pPvD8zaE9G6TCyzUVPZVjJ/unTYuw1RsrjFCd34sCjibUh+uttyWRIY+Zji56XuT3Lel
         94fAiw9vYCkA18YXH7GUr5RMf2nR1QtQsX111EqppEgISYlcMiQcPuRnBoX1RaSuXfB8
         iPgg==
X-Gm-Message-State: AOAM5334UbxLhw/GX4m7/Aazqq1UQ0Q4cQnS7XSzscpsgEo6+S4/7Y30
        MX+PTeP4RF9zscNKZ8tSHdQruXT9feVnbMchoj0=
X-Google-Smtp-Source: ABdhPJxxUX+SId++y236FyrS13rQ65Xb1fQ62IsrNWMa+Tu1woI6xPPfiUo2cxoKlxyk5ZP5iW+ASe43unUJBUOWGr0=
X-Received: by 2002:a63:db18:: with SMTP id e24mr8993393pgg.192.1593467475038;
 Mon, 29 Jun 2020 14:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200629200227.1518784-1-lkmlabelt@gmail.com> <20200629200227.1518784-2-lkmlabelt@gmail.com>
 <20200629204653.o6q3a2fufgq62pzo@liuwe-devbox-debian-v2>
In-Reply-To: <20200629204653.o6q3a2fufgq62pzo@liuwe-devbox-debian-v2>
From:   Andres Beltran <lkmlabelt@gmail.com>
Date:   Mon, 29 Jun 2020 17:51:05 -0400
Message-ID: <CAGpZZ6sUXOnggeQyPfxkdK50=1AhTUqbvBvc2bEs4qwwk+rSPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Andres Beltran <t-mabelt@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 29, 2020 at 4:46 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> On Mon, Jun 29, 2020 at 04:02:25PM -0400, Andres Beltran wrote:
> > Currently, VMbus drivers use pointers into guest memory as request IDs
> > for interactions with Hyper-V. To be more robust in the face of errors
> > or malicious behavior from a compromised Hyper-V, avoid exposing
> > guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> > bad request ID that is then treated as the address of a guest data
> > structure with no validation. Instead, encapsulate these memory
> > addresses and provide small integers as request IDs.
> >
> > Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> > ---
> > Changes in v2:
> >       - Get rid of "rqstor" variable in __vmbus_open().
> >
> >  drivers/hv/channel.c   | 146 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/hyperv.h |  21 ++++++
> >  2 files changed, 167 insertions(+)
> >
> > diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> > index 3ebda7707e46..c89d57d0c2d2 100644
> > --- a/drivers/hv/channel.c
> > +++ b/drivers/hv/channel.c
> > @@ -112,6 +112,70 @@ int vmbus_alloc_ring(struct vmbus_channel *newchannel,
> >  }
> >  EXPORT_SYMBOL_GPL(vmbus_alloc_ring);
> >
> > +/**
> > + * request_arr_init - Allocates memory for the requestor array. Each slot
> > + * keeps track of the next available slot in the array. Initially, each
> > + * slot points to the next one (as in a Linked List). The last slot
> > + * does not point to anything, so its value is U64_MAX by default.
> > + * @size The size of the array
> > + */
> > +static u64 *request_arr_init(u32 size)
> > +{
> > +     int i;
> > +     u64 *req_arr;
> > +
> > +     req_arr = kcalloc(size, sizeof(u64), GFP_KERNEL);
> > +     if (!req_arr)
> > +             return NULL;
> > +
> > +     for (i = 0; i < size - 1; i++)
> > +             req_arr[i] = i + 1;
> > +
> > +     /* Last slot (no more available slots) */
> > +     req_arr[i] = U64_MAX;
> > +
> > +     return req_arr;
> > +}
> > +
> > +/*
> > + * vmbus_alloc_requestor - Initializes @rqstor's fields.
> > + * Slot at index 0 is the first free slot.
> > + * @size: Size of the requestor array
> > + */
> > +static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
> > +{
> > +     u64 *rqst_arr;
> > +     unsigned long *bitmap;
> > +
> > +     rqst_arr = request_arr_init(size);
> > +     if (!rqst_arr)
> > +             return -ENOMEM;
> > +
> > +     bitmap = bitmap_zalloc(size, GFP_KERNEL);
> > +     if (!bitmap) {
> > +             kfree(rqst_arr);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     rqstor->req_arr = rqst_arr;
> > +     rqstor->req_bitmap = bitmap;
> > +     rqstor->size = size;
> > +     rqstor->next_request_id = 0;
> > +     spin_lock_init(&rqstor->req_lock);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * vmbus_free_requestor - Frees memory allocated for @rqstor
> > + * @rqstor: Pointer to the requestor struct
> > + */
> > +static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
> > +{
> > +     kfree(rqstor->req_arr);
> > +     bitmap_free(rqstor->req_bitmap);
> > +}
> > +
> >  static int __vmbus_open(struct vmbus_channel *newchannel,
> >                      void *userdata, u32 userdatalen,
> >                      void (*onchannelcallback)(void *context), void *context)
> > @@ -132,6 +196,12 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
> >       if (newchannel->state != CHANNEL_OPEN_STATE)
> >               return -EINVAL;
> >
> > +     /* Create and init requestor */
> > +     if (newchannel->rqstor_size) {
> > +             if (vmbus_alloc_requestor(&newchannel->requestor, newchannel->rqstor_size))
> > +                     return -ENOMEM;
> > +     }
> > +
>
> Sorry for not noticing this in the last round: this infrastructure is
> initialized conditionally but used unconditionally.
>
> I can think of two options here:
>
>   1. Mandate rqstor_size to be non-zero. Always initialize this
>      infra.
>   2. Modify vmbus_next_request_id and vmbus_request_addr to deal with
>      uninitialized state.
>
> For #2, you can simply check rqstor->size _before_ taking the lock
> (because it may be uninitialized, and the assumption is ->size will not
> change during the channel's lifetime, hence no lock is needed) and
> simply return the same value to the caller.
>
> Wei.

Right. I think option #2 would be preferable in this case, because #1 works
if we had a default non-zero size for cases where rqstor_size has not been
set to a non-zero value before calling vmbus_alloc_requestor(). For #2, what
do you mean by "same value"? I think we would need to return
VMBUS_RQST_ERROR if the size is 0, because otherwise we would be
returning the same guest memory address which we don't want to expose.

Andres.
