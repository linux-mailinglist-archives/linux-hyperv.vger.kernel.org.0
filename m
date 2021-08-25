Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682EB3F7D31
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Aug 2021 22:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbhHYUdd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Aug 2021 16:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231745AbhHYUdc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Aug 2021 16:33:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 964E6610CF;
        Wed, 25 Aug 2021 20:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629923566;
        bh=d3M9lANYL5a/udkmT2KhLMXNG+8ajitfC51a122X7IU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sQPa3uL4v6xEndBtg/BnVavcZCkLqtOeHVLlGqeIDSBB7FEHbAZmKIuOd7MbfdnRo
         8cUG2E+XdvxWBz6e4iA4EsYVYfoHLcYnPoFvO0N3vUWS7n8P6sdTBW/hM0TVjWTmXG
         pPegXoPytF6/wM1AvoNVKKSTG6ahJFTA2utLtOEfj5Mt6PNfNlCnnpjGdR1q33xHXR
         aIEDoo2KqF7Up6viDCtEQAiHYNL7AICI7vz8fksKoGVyo7W4jra4ji2gHZxCOcV7gT
         wW785z43g0WqTfSNELAfjq5h7OclkUGnYyETBJeTAvH9wxEizTk5pMrKX9UaRo/sB3
         C3AjMxrmT3fpA==
Received: by mail-ej1-f45.google.com with SMTP id mf2so1031973ejb.9;
        Wed, 25 Aug 2021 13:32:46 -0700 (PDT)
X-Gm-Message-State: AOAM5335cnPLDYx+MoY4myziBLNwNhMzyeMp+XbRzoGHqGV+2wf+3yFB
        Ep3lWapIxBumjviIQCE6X3l+CIaYQ0jRP/LMYg==
X-Google-Smtp-Source: ABdhPJwO8q64ruM37/4iZQI0+9NeIcY5OLDrxs/9RPpeE3IuY0avUuPPdxf6lUVHfvS4Bp1BJRRAv1LuU4CLD/QZVEc=
X-Received: by 2002:a17:907:b06:: with SMTP id h6mr471070ejl.130.1629923565214;
 Wed, 25 Aug 2021 13:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
 <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2> <BY5PR21MB1506270100DAE3BAFCA001E9CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15935D5B518ECA1361F2EB1BD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15935D5B518ECA1361F2EB1BD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Aug 2021 15:32:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ2TTBhcTRHXNneVYFgTSUdwnK1OO+GLQRSRb_b75qhRA@mail.gmail.com>
Message-ID: <CAL_JsqJ2TTBhcTRHXNneVYFgTSUdwnK1OO+GLQRSRb_b75qhRA@mail.gmail.com>
Subject: Re: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 25, 2021 at 2:11 PM Michael Kelley <mikelley@microsoft.com> wro=
te:
>
> From: Long Li <longli@microsoft.com> Sent: Tuesday, August 24, 2021 10:28=
 AM
> >
> > > Subject: Re: [PATCH] PCI: hv: Fix a bug on removing child devices on =
the bus
> > >
> > > On Tue, Aug 24, 2021 at 12:20:20AM -0700, longli@linuxonhyperv.com wr=
ote:
> > > > From: Long Li <longli@microsoft.com>
> > > >
> > > > In hv_pci_bus_exit, the code is holding a spinlock while calling
> > > > pci_destroy_slot(), which takes a mutex.
> > > >
> > > > This is not safe for spinlock. Fix this by moving the children to b=
e
> > > > deleted to a list on the stack, and removing them after spinlock is
> > > > released.
> > > >
> > > > Fixes: 94d22763207a ("PCI: hv: Fix a race condition when removing t=
he
> > > > device")
> > > >
> > > > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > > > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > > Cc: Wei Liu <wei.liu@kernel.org>
> > > > Cc: Dexuan Cui <decui@microsoft.com>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Rob Herring <robh@kernel.org>
> > > > Cc: "Krzysztof Wilczy=C5=84ski" <kw@linux.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Michael Kelley <mikelley@microsoft.com>
> > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > ---
> > > >  drivers/pci/controller/pci-hyperv.c | 15 ++++++++++++---
> > > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > > b/drivers/pci/controller/pci-hyperv.c
> > > > index a53bd8728d0d..d4f3cce18957 100644
> > > > --- a/drivers/pci/controller/pci-hyperv.c
> > > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > > @@ -3220,6 +3220,7 @@ static int hv_pci_bus_exit(struct hv_device *=
hdev,
> > > bool keep_devs)
> > > >   struct hv_pci_dev *hpdev, *tmp;
> > > >   unsigned long flags;
> > > >   int ret;
> > > > + struct list_head removed;
> > >
> > > This can be moved to where it is needed -- the if(!keep_dev) branch -=
- to limit its
> > > scope.
> > >
> > > >
> > > >   /*
> > > >    * After the host sends the RESCIND_CHANNEL message, it doesn't @=
@
> > > > -3229,9 +3230,18 @@ static int hv_pci_bus_exit(struct hv_device *hd=
ev, bool
> > > keep_devs)
> > > >           return 0;
> > > >
> > > >   if (!keep_devs) {
> > > > -         /* Delete any children which might still exist. */
> > > > +         INIT_LIST_HEAD(&removed);
> > > > +
> > > > +         /* Move all present children to the list on stack */
> > > >           spin_lock_irqsave(&hbus->device_list_lock, flags);
> > > > -         list_for_each_entry_safe(hpdev, tmp, &hbus->children,
> > > list_entry) {
> > > > +         list_for_each_entry_safe(hpdev, tmp, &hbus->children,
> > > list_entry)
> > > > +                 list_move_tail(&hpdev->list_entry, &removed);
> > > > +         spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> > > > +
> > > > +         /* Remove all children in the list */
> > > > +         while (!list_empty(&removed)) {
> > > > +                 hpdev =3D list_first_entry(&removed, struct hv_pc=
i_dev,
> > > > +                                          list_entry);
> > >
> > > list_for_each_entry_safe can also be used here, right?
> > >
> > > Wei.
> >
> > I will address your comments.
> >
> > Long
>
> I thought list_for_each_entry_safe() is for use when list manipulation
> is *not* protected by a lock and you want to safely walk the list
> even if an entry gets removed.  If the list is protected by a lock or
> not subject to contention (as is the case here), then
> list_for_each_entry() is the simpler implementation.  The original
> implementation didn't need to use the _safe version because of
> the spin lock.
>
> Or do I have it backwards?

"_safe" only means "safe against removal of list entry" as the
kerneldoc says. But that means removal within the loop iteration, not
any writer. A lock is needed in either case if there's another writer.

Don't ask me about the RCU variant though...

Rob
