Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D6E20E98A
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2020 01:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgF2XpK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Jun 2020 19:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgF2XpK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Jun 2020 19:45:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E1AC061755;
        Mon, 29 Jun 2020 16:45:10 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so7715630pls.5;
        Mon, 29 Jun 2020 16:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zr9bjHoe5t2IZ795ERlDEmoQCHQtYYorfRKzQD5hK90=;
        b=QwZWD7lZPgSxTpH1THyX7KS8hYI8BYiaijETny4n3EvUUN2iMOkFNhy+Q9OQZMygtf
         eN45sAqvZRTW5GWzNs5g/mSZ5M5uHVAjzKs+big9GX7Y5eUA0/F9sXE6sX2u1LFvR45Y
         nA8W/Ywm6uRQMv/TqdXnvYbTD6j69+LmQEzk9P7MJAscOUC9iCDCzF7hIg2k7cEGBeIu
         ntrhT0s+sI9W2fsB8ejAUFjCUpZbVtWrirLFBoDB1/V8F1ljqU9lLHBdTghEXmzJ/PQ+
         aAfoykI3a7Ii1m69yIlFW61wGNDnpIfLBVcKHA0Dt2ney7q/L4PTu09szbdbGUyyCGWu
         i+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zr9bjHoe5t2IZ795ERlDEmoQCHQtYYorfRKzQD5hK90=;
        b=XAmzspSmQVr/w5MykwVYpmlNMcsjuUwqtdv7czQiOJQilwi2ZDIuzONGOWSdnNj/Bs
         qvxsvSkVj9oJhupftZoLHKMBGzOZElb1rpZwgLxRbs7bpM08alrJ9w81ZDe0QjxAmpsJ
         P3QRLFqTAetHCwXUmXRqLPP3oZ76pQuBZXv194Rq/EqaPLYdI8PWLRjDzOyNCyURSh5Y
         Spb0B0ccSrxIWEBrzrpuwE9DwrUjq9GuvXXVUI+r9eoTpBkwMS/I8k95ywWCXJfAVlPF
         moe/1Q89Jm9rodxQ45oBH3bYVGaB7doiirmh80FYBX8YBcrUWTegQ3KQJ1Tjd2kWKCBM
         cBag==
X-Gm-Message-State: AOAM533Sd97mSBNcWW5D5NzC0s1Grv6GpGW1l2z3aqURNLHd88tBLYSk
        bAL0l4VzJjUsUwsxNqNP4jRXCtmfoUBWpeFCl3rTJb7P
X-Google-Smtp-Source: ABdhPJzDnn2bIgg7gAfyGd2qVEHmJTIs7EtelrntJDFjSzeo01Jm6xhylRwdT1hmCN9uq4EQvmkC4vESWxaMcQaw3dE=
X-Received: by 2002:a17:90a:35c:: with SMTP id 28mr11213069pjf.63.1593474309411;
 Mon, 29 Jun 2020 16:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200629200227.1518784-1-lkmlabelt@gmail.com> <20200629200227.1518784-2-lkmlabelt@gmail.com>
 <20200629204653.o6q3a2fufgq62pzo@liuwe-devbox-debian-v2> <CAGpZZ6sUXOnggeQyPfxkdK50=1AhTUqbvBvc2bEs4qwwk+rSPg@mail.gmail.com>
 <20200629222040.bh7tkkridwt7sdlw@liuwe-devbox-debian-v2>
In-Reply-To: <20200629222040.bh7tkkridwt7sdlw@liuwe-devbox-debian-v2>
From:   Andres Beltran <lkmlabelt@gmail.com>
Date:   Mon, 29 Jun 2020 19:45:00 -0400
Message-ID: <CAGpZZ6teQ1KDKZ28Q50DSOZ3dF4oqEHagC2YSkb9WjKZ1io5Mw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Andres Beltran <t-mabelt@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 29, 2020 at 6:20 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> On Mon, Jun 29, 2020 at 05:51:05PM -0400, Andres Beltran wrote:
> > On Mon, Jun 29, 2020 at 4:46 PM Wei Liu <wei.liu@kernel.org> wrote:
> > >
> > > On Mon, Jun 29, 2020 at 04:02:25PM -0400, Andres Beltran wrote:
> > > > Currently, VMbus drivers use pointers into guest memory as request IDs
> > > > for interactions with Hyper-V. To be more robust in the face of errors
> > > > or malicious behavior from a compromised Hyper-V, avoid exposing
> > > > guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> > > > bad request ID that is then treated as the address of a guest data
> > > > structure with no validation. Instead, encapsulate these memory
> > > > addresses and provide small integers as request IDs.
> > > >
> > > > Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > >       - Get rid of "rqstor" variable in __vmbus_open().
> > > >
> > > >  drivers/hv/channel.c   | 146 +++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/hyperv.h |  21 ++++++
> > > >  2 files changed, 167 insertions(+)
> > > >
> > > > diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> > > > index 3ebda7707e46..c89d57d0c2d2 100644
> > > > --- a/drivers/hv/channel.c
> > > > +++ b/drivers/hv/channel.c
> > > > @@ -112,6 +112,70 @@ int vmbus_alloc_ring(struct vmbus_channel *newchannel,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(vmbus_alloc_ring);
> > > >
> > > > +/**
> > > > + * request_arr_init - Allocates memory for the requestor array. Each slot
> > > > + * keeps track of the next available slot in the array. Initially, each
> > > > + * slot points to the next one (as in a Linked List). The last slot
> > > > + * does not point to anything, so its value is U64_MAX by default.
> > > > + * @size The size of the array
> > > > + */
> > > > +static u64 *request_arr_init(u32 size)
> > > > +{
> > > > +     int i;
> > > > +     u64 *req_arr;
> > > > +
> > > > +     req_arr = kcalloc(size, sizeof(u64), GFP_KERNEL);
> > > > +     if (!req_arr)
> > > > +             return NULL;
> > > > +
> > > > +     for (i = 0; i < size - 1; i++)
> > > > +             req_arr[i] = i + 1;
> > > > +
> > > > +     /* Last slot (no more available slots) */
> > > > +     req_arr[i] = U64_MAX;
> > > > +
> > > > +     return req_arr;
> > > > +}
> > > > +
> > > > +/*
> > > > + * vmbus_alloc_requestor - Initializes @rqstor's fields.
> > > > + * Slot at index 0 is the first free slot.
> > > > + * @size: Size of the requestor array
> > > > + */
> > > > +static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
> > > > +{
> > > > +     u64 *rqst_arr;
> > > > +     unsigned long *bitmap;
> > > > +
> > > > +     rqst_arr = request_arr_init(size);
> > > > +     if (!rqst_arr)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     bitmap = bitmap_zalloc(size, GFP_KERNEL);
> > > > +     if (!bitmap) {
> > > > +             kfree(rqst_arr);
> > > > +             return -ENOMEM;
> > > > +     }
> > > > +
> > > > +     rqstor->req_arr = rqst_arr;
> > > > +     rqstor->req_bitmap = bitmap;
> > > > +     rqstor->size = size;
> > > > +     rqstor->next_request_id = 0;
> > > > +     spin_lock_init(&rqstor->req_lock);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +/*
> > > > + * vmbus_free_requestor - Frees memory allocated for @rqstor
> > > > + * @rqstor: Pointer to the requestor struct
> > > > + */
> > > > +static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
> > > > +{
> > > > +     kfree(rqstor->req_arr);
> > > > +     bitmap_free(rqstor->req_bitmap);
> > > > +}
> > > > +
> > > >  static int __vmbus_open(struct vmbus_channel *newchannel,
> > > >                      void *userdata, u32 userdatalen,
> > > >                      void (*onchannelcallback)(void *context), void *context)
> > > > @@ -132,6 +196,12 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
> > > >       if (newchannel->state != CHANNEL_OPEN_STATE)
> > > >               return -EINVAL;
> > > >
> > > > +     /* Create and init requestor */
> > > > +     if (newchannel->rqstor_size) {
> > > > +             if (vmbus_alloc_requestor(&newchannel->requestor, newchannel->rqstor_size))
> > > > +                     return -ENOMEM;
> > > > +     }
> > > > +
> > >
> > > Sorry for not noticing this in the last round: this infrastructure is
> > > initialized conditionally but used unconditionally.
> > >
> > > I can think of two options here:
> > >
> > >   1. Mandate rqstor_size to be non-zero. Always initialize this
> > >      infra.
> > >   2. Modify vmbus_next_request_id and vmbus_request_addr to deal with
> > >      uninitialized state.
> > >
> > > For #2, you can simply check rqstor->size _before_ taking the lock
> > > (because it may be uninitialized, and the assumption is ->size will not
> > > change during the channel's lifetime, hence no lock is needed) and
> > > simply return the same value to the caller.
> > >
> > > Wei.
> >
> > Right. I think option #2 would be preferable in this case, because #1 works
> > if we had a default non-zero size for cases where rqstor_size has not been
> > set to a non-zero value before calling vmbus_alloc_requestor(). For #2, what
> > do you mean by "same value"? I think we would need to return
> > VMBUS_RQST_ERROR if the size is 0, because otherwise we would be
> > returning the same guest memory address which we don't want to expose.
>
> By "same value", I meant reverting back to using guest memory address.
> I thought downgrading gracefully is better than making the driver stop
> working.
>
> If exposing guest address is not acceptable, you can return
> VMBUS_RQST_ERROR -- but at the point you may as well mandate requestor
> infrastructure to be always initialized, right?
>

If the allocation of the requestor fails during runtime, vmbus_open()
fails too and therefore,
the channel and the requestor will not be created. So, the 2 functions
(next_id, requestor_addr)
will never get called, right? The only case in which we hit this edge
case is if a driver is using this
mechanism with a size of 0 (i.e. rqstor_size is not set to a non-zero
value before calling vmbus_open()),
but that would be more like a coding bug. So, I think it would be
better to return VMBUS_RQST_ERROR
as a way to assert that there is a bug in the code. I don't know if
I'm missing something here.

Andres.
