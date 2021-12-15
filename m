Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7489D475A46
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Dec 2021 15:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhLOOFU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Dec 2021 09:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243132AbhLOOFU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Dec 2021 09:05:20 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED467C061574
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Dec 2021 06:05:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so74415683edd.9
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Dec 2021 06:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ih+fC0qJzx4JDbWrFdcxLb/SOWMOnLSlSaG6lGi1mc=;
        b=Kzbdhryxz/uMvgin2xqelJF3BvSEz2ILulDFHFxTKDe/Bx6CrDW6KjqPyZ9DnK8Ukq
         NQ5T7zyI7KHFTwp7dEX+Ggs/VJhUYfjMrh/NhisssnGD22+ZoYQ1zFHRJ65Xprg7K1Qp
         qioBy5qaRhonrAxrdu8+o//dGFPl3ywrMNlAQjs/Qs9VyvMMXrRG3C4q4doKw0GhddFu
         4yyOK/uKWvPzknwk3674TFW8uCofV3fV0UKk4rGs47/NCE8NogwCZQMCzHZde2r6pN7c
         JcQJcmjSuPnQitTZT2NACiDCd68Xg6qumU6+0urijYEj//pbGOGu02vu2u1kXY/3PDdS
         HBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ih+fC0qJzx4JDbWrFdcxLb/SOWMOnLSlSaG6lGi1mc=;
        b=oL9kQosk66PJVV+guhcXwoLfWj+HIUHHi24vBVdtoAPFB6Y4z5ZNDC4nBa8Cb6UL95
         6aemeixKa2ZjdfpQqBLD6/Y5XSA1jNVp98FTvRu0X1JlOTgTx0+D6AwnoESOlqXMzp5V
         g/xecLjcUq54YQ4Ddl99b7koQL5Txs0rR/jyKYIElAoCcrBGMb2VMUMTKZ4WdKD6sqyE
         Ymbnklc61aZnMK2nBLLMuGYp1wMS1zazQBHH38FdkA1xiITIxB3L4g6bm91KkrAA2/nd
         E5kEL8+s0K0eTQsBcpesxpM3OMjSpPfI/CaQrSAoA24mVuaflGCI3abiDghqbe2CRb1B
         hN8Q==
X-Gm-Message-State: AOAM531KemUbVOvx5r8lQ1EY6Mo0XCV1/aojkxXziHMd+gxOKs1Z9SMM
        mRnvnEig7UrqjOJGhLJEJL25llsRpqY=
X-Google-Smtp-Source: ABdhPJyjNVg2siZG8ef2fqITWK9xqAeH2Gw0gKouRuyWzYsMFwxJzLFUyFrKEUIaCqRrUqkKkiWKxQ==
X-Received: by 2002:aa7:d510:: with SMTP id y16mr14785394edq.338.1639577117915;
        Wed, 15 Dec 2021 06:05:17 -0800 (PST)
Received: from anparri (host-79-23-180-143.retail.telecomitalia.it. [79.23.180.143])
        by smtp.gmail.com with ESMTPSA id 24sm751295eje.52.2021.12.15.06.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 06:05:17 -0800 (PST)
Date:   Wed, 15 Dec 2021 15:05:08 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Yanming Liu <yanminglr@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] hv: account for packet descriptor in maximum packet size
Message-ID: <20211215140508.GA3330@anparri>
References: <20211212121326.215377-1-yanminglr@gmail.com>
 <20211213014709.GA2316@anparri>
 <CAH+BkoF-Y55MCSoFes3QYJqXEEH3ZsjHMjmtrKmN3UHv9S_0iw@mail.gmail.com>
 <20211214020658.GA439610@anparri>
 <20211214042804.GA1934@anparri>
 <CAH+BkoE51_zAtgOo5ZGJk+32cycQ+OetL_U8hyO8oNMJaymAGg@mail.gmail.com>
 <20211214213659.GA2550@anparri>
 <CAH+BkoFBugMf442jPiwbjm1hvESpw8gvN6uaQvMez0gifBHtGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+BkoFBugMf442jPiwbjm1hvESpw8gvN6uaQvMez0gifBHtGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > AFAICT, the above #define is fine, i.e., it represents an upper bound
> > on pkt_len as used in hv_pkt_iter_first() (this is all is required on
> > max_pkt_size, cf. the memcpy() in hv_pkt_iter_first()).
> >
> > The same consideration, AFAICT, holds for NETVSC_MAX_PKT_SIZE.
> >
> > The remarks about pkt_offset targetted the cases, such as hv_balloon,
> > where we can somehow upper bound
> >
> >         (pkt_len - pkt_offset)
> >
> > (the "packet payload"), since then an upper bound on pkt_offset would
> 
> I don't get it. Isn't it the same for storvsc? For storvsc we just
> have an upper bound of ("the packet payload") (pkt_len - pkt_offset)
> == sizeof(struct vstor_packet).
> 
> With more details:
> 
> drivers/scsi/storvsc_drv.c:storvsc_on_channel_callback:
> 
> foreach_vmbus_pkt(desc, channel) {
>         struct vstor_packet *packet = hv_pkt_data(desc);
> 
> where foreach_vmbus_pkt is a macro calling hv_pkt_iter_first, and
> hv_pkt_data is defined as:
> 
> /* Get data payload associated with descriptor */
> static inline void *hv_pkt_data(const struct vmpacket_descriptor *desc)
> {
>         return (void *)((unsigned long)desc + (desc->offset8 << 3));
> }
> 
> i.e. it expects that 'desc' points to a buffer at least
> '(desc->offset8 << 3) + sizeof(struct vstor_packet)' bytes long.
> 
> As Hyper-V is proprietary I can only guess what is the purpose of
> desc->offset8 (being forward compatible), so I agree with you that
> this is a real problem.
> Currently, Hyper-V only sends vmbus packets with offset8 == 2, so the
> expression above equals STORVSC_MAX_PKT_SIZE. If future Hyper-V
> somehow sends a packet with offset8 == 3, hv_storvsc certainly breaks.

It actually looks to me like we're on a same page.  ;) IOW, pkt_offset
is expected to be <= sizeof(struct vmpacket_descriptor) (=16 now) *for
storvsc.

With the risk of adding to the confusion, ;) pkt_offset is expected to
be > sizeof(struct vmpacket_descriptor) for netvsc (cf. the validation
of offset8 performed in netvsc_receive()).

  Andrea


> 
> Or, is it guaranteed that desc->offset8 will always be 2 and never
> change in future Hyper-V?
> 
> > give us an upper bound on pkt_len "for free" (associativity):
> >
> >         ptk_len = (pkt_len - pkt_offset) + pkt_offset
> >
> >   Andrea
> 
> Regards,
> Yanming
