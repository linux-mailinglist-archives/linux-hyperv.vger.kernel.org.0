Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACE764550
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Jul 2023 07:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjG0FNb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jul 2023 01:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjG0FN3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jul 2023 01:13:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C8E2724;
        Wed, 26 Jul 2023 22:13:25 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5768a7e3adbso25780197b3.0;
        Wed, 26 Jul 2023 22:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690434805; x=1691039605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc2iF7zyvIQRZQViezTnM3M7DWBbv3484xuglbYBePo=;
        b=jI3Ew8cfqJbKUTa9Nis7dkVYeEEuOLY7PYnlip/+Xcs7S4CAyeBNOoJfgvyVVNBtfZ
         iIMJ66GIjwWTrlrw4Pbf8Bsgd3jmOcsDmVc9a1gxuAQH9PFyk6PLfuIMohUN+l9cAC/B
         6r7ZtXbh7QsGkE0ouY8Ci6eGAibCzfPzK+PPp69dsnPFA2ny8lENoZDI/2ztiEkdVgvd
         BPfhRfVy59qBfx9gVphh7Rt+TlFXHtuexV5YhxL2Cv7QuBCL8I+wmBfvroh2XTiRPUwu
         f+mj1jx07UULer6nJgZVpyetVHPWpRBgfYizy/SQXUbGiGCfNyV9PHJZomJgMQqfkRFs
         sCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690434805; x=1691039605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc2iF7zyvIQRZQViezTnM3M7DWBbv3484xuglbYBePo=;
        b=ZW67x7rMXOLMa8QfCFreaZSt8ABZW8u/zm0Q09P0S9hndKb/Tukrk0oXV/LrhwFH+I
         bB0lP8TqRV5aMI6dZg+olqndVjIkt9o0S+cEPU2rR05/qqip/o1QjmbVPtB5iRjCTE9P
         ixBu9L4JR5WNFCkgUf6Fl5qqCk65/R9GE+84Uuq2Srq94rBiEd73Uf2i/cFvX3SKed4k
         i1J44OBsd5FytCogMbikPP+d6rwnPdWYy4ELAh+Kt34SoGO/79PAN7dMYibkMWaCninV
         LMdhh2v27crEUCIEENagyDECcz6bkNUGF1JKSjuIp4mUO6+fBAqnobLSvpXu8XGl0Mq6
         4cAA==
X-Gm-Message-State: ABy/qLb8y6jAb3ttEghm+9BfSimxrARfXaGoLV4NpkSy8Q9MUkwb2bbK
        jFjHxdc/FkWR5BghW4fETLC3Z7DSb5A/gtVwkN6YzlZD
X-Google-Smtp-Source: APBJJlE7T/W9W1hCjdIskW6DU4QgxrnAxOmX5Qf7N1kEmh3y+G5Hs0rHTAdkhs3KKZZ+zvfjielGXhKAu/4uIPceSdE=
X-Received: by 2002:a81:91cb:0:b0:577:2aa4:70aa with SMTP id
 i194-20020a8191cb000000b005772aa470aamr1923520ywg.21.1690434804053; Wed, 26
 Jul 2023 22:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <1690377336-1353-1-git-send-email-schakrabarti@linux.microsoft.com>
 <519602aa-0a6a-70a5-23c7-ce190045e4af@linux.dev>
In-Reply-To: <519602aa-0a6a-70a5-23c7-ce190045e4af@linux.dev>
From:   Souradeep Chakrabarti <souradch.linux@gmail.com>
Date:   Thu, 27 Jul 2023 10:43:12 +0530
Message-ID: <CABNGXZrcW1tmJALpkx38QxkUs=8ivFzDEc0urgrKVWwybngs0Q@mail.gmail.com>
Subject: Re: [PATCH V6 net] net: mana: Fix MANA VF unload when hardware is
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 27, 2023 at 9:07=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> =E5=9C=A8 2023/7/26 21:15, Souradeep Chakrabarti =E5=86=99=E9=81=93:
> > When unloading the MANA driver, mana_dealloc_queues() waits for the MAN=
A
> > hardware to complete any inflight packets and set the pending send coun=
t
> > to zero. But if the hardware has failed, mana_dealloc_queues()
> > could wait forever.
> >
> > Fix this by adding a timeout to the wait. Set the timeout to 120 second=
s,
> > which is a somewhat arbitrary value that is more than long enough for
> > functional hardware to complete any sends.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Netwo=
rk Adapter (MANA)")
> >
> > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > ---
> > V5 -> V6:
> > * Added pcie_flr to reset the pci after timeout.
> > * Fixed the position of changelog.
> > * Removed unused variable like cq.
> >
> > V4 -> V5:
> > * Added fixes tag
> > * Changed the usleep_range from static to incremental value.
> > * Initialized timeout in the begining.
> >
> > V3 -> V4:
> > * Removed the unnecessary braces from mana_dealloc_queues().
> >
> > V2 -> V3:
> > * Removed the unnecessary braces from mana_dealloc_queues().
> >
> > V1 -> V2:
> > * Added net branch
> > * Removed the typecasting to (struct mana_context*) of void pointer
> > * Repositioned timeout variable in mana_dealloc_queues()
> > * Repositioned vf_unload_timeout in mana_context struct, to utilise the
> >   6 bytes hole
> > ---
> >   drivers/net/ethernet/microsoft/mana/mana_en.c | 38 +++++++++++++++++-=
-
> >   1 file changed, 34 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/ne=
t/ethernet/microsoft/mana/mana_en.c
> > index a499e460594b..ea039e2d4c4b 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -8,6 +8,7 @@
> >   #include <linux/ethtool.h>
> >   #include <linux/filter.h>
> >   #include <linux/mm.h>
> > +#include <linux/pci.h>
> >
> >   #include <net/checksum.h>
> >   #include <net/ip6_checksum.h>
> > @@ -2345,9 +2346,12 @@ int mana_attach(struct net_device *ndev)
> >   static int mana_dealloc_queues(struct net_device *ndev)
> >   {
> >       struct mana_port_context *apc =3D netdev_priv(ndev);
> > +     unsigned long timeout =3D jiffies + 120 * HZ;
> >       struct gdma_dev *gd =3D apc->ac->gdma_dev;
> >       struct mana_txq *txq;
> > +     struct sk_buff *skb;
> >       int i, err;
> > +     u32 tsleep;
> >
> >       if (apc->port_is_up)
> >               return -EINVAL;
> > @@ -2363,15 +2367,41 @@ static int mana_dealloc_queues(struct net_devic=
e *ndev)
> >        * to false, but it doesn't matter since mana_start_xmit() drops =
any
> >        * new packets due to apc->port_is_up being false.
> >        *
> > -      * Drain all the in-flight TX packets
> > +      * Drain all the in-flight TX packets.
> > +      * A timeout of 120 seconds for all the queues is used.
> > +      * This will break the while loop when h/w is not responding.
> > +      * This value of 120 has been decided here considering max
> > +      * number of queues.
> >        */
> > +
> >       for (i =3D 0; i < apc->num_queues; i++) {
> >               txq =3D &apc->tx_qp[i].txq;
> > -
> > -             while (atomic_read(&txq->pending_sends) > 0)
> > -                     usleep_range(1000, 2000);
> > +             tsleep =3D 1000;
> > +             while (atomic_read(&txq->pending_sends) > 0 &&
> > +                    time_before(jiffies, timeout)) {
> > +                     usleep_range(tsleep, tsleep + 1000);
> > +                     tsleep <<=3D 1;
> > +             }
> > +             if (atomic_read(&txq->pending_sends)) {
> > +                     err  =3D pcie_flr(to_pci_dev(gd->gdma_context->de=
v));
> > +                     if (err) {
> > +                             netdev_err(ndev, "flr failed %d with %d p=
kts pending in txq %u\n",
> > +                                        err, atomic_read(&txq->pending=
_sends),
> > +                                        txq->gdma_txq_id);
> > +                     }
> > +                     break;
> > +             }
> >       }
> >
> > +     for (i =3D 0; i < apc->num_queues; i++) {
> > +             txq =3D &apc->tx_qp[i].txq;
> > +             while (atomic_read(&txq->pending_sends)) {
> > +                     skb =3D skb_dequeue(&txq->pending_skbs);
> > +                     mana_unmap_skb(skb, apc);
> > +                     dev_consume_skb_any(skb);
> > +                     atomic_sub(1, &txq->pending_sends);
> > +             }
> If I get this commit correctly, txq->pending_sends should be equal to
> the length of txq->pending_skbs?
>
> If yes, can we only handle the pending_skbs?
>
> the above snippet can be changed to as below? So the performance is bette=
r?
> "
>                 while ((skb =3D skb_dequeue(&txq->pending_skbs))) {
>                         mana_unmap_skb(skb, apc);
>                         dev_consume_skb_any(skb);
>                 }
>                 atomic_set(&txq->pending_sends, 0);
> "
>
> Zhu Yanjun
Yes, we can do that, thanks for pointing. Will take care of it in next vers=
ion.
>
> > +     }
> >       /* We're 100% sure the queues can no longer be woken up, because
> >        * we're sure now mana_poll_tx_cq() can't be running.
> >        */
>
