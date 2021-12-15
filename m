Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F694758E1
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Dec 2021 13:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbhLOMbO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Dec 2021 07:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242512AbhLOMbO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Dec 2021 07:31:14 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F69EC061574
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Dec 2021 04:31:13 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id e24so17093451lfc.0
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Dec 2021 04:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7Eo/pigG0/ylNlezSeYD9pJA0SffCSnrRppAQ0jH80=;
        b=h2bK+gNM+YYtIEnLq5j34YzCEE3slaetONPzRbvP2Vs8pE73KmYdZ2kQNe/jOPqSDD
         wpmOLwPa46taqpzupdK/HzVACURUFfcqjj/lSKyPitzpq2KJrhvCASd+ZIPdaKg46QMi
         4EiZ9VnV4US6adlWHMhYKv9JnSUOo4fBdIpKAATBwk1jhmGb1h8g5Yqz2xqlS1OChWbs
         /Ukecl60QPz2PSu+h8kgibxU0yal57+x5wCMWU2vLk3jou7qgH1RWlYW4NS2C/OMJMyT
         5UsICxIc0QTl5MIxqEGJ4l2zFr+6eTjb8magcEZt+ykZmxz8jq62U46ZbSCpwRIk/EIB
         /cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7Eo/pigG0/ylNlezSeYD9pJA0SffCSnrRppAQ0jH80=;
        b=3KZu2G1Lrt8zhyJekEGg/g4cMOqLHgFdzuoKDQtiv4xpxwHAEFEf8RJjO0LGSHDp/h
         JBUPws4MCWdZGqUH6a1M2GPIJrIAsnVqMcY+PlDhuK8PSJe2pIzfjXs/jlyXvN+Q4zQg
         ZZSR3zs78yxgPpfkw50sjOWjQiyovD/vhT0fKcfNdY0L/yIwZgDP8cEFK+4p2oMi0Rck
         6tObod/Vfrm4QuPGmuH1s46cvdWTUczJsD8WeeaUDaLrh8gTmbP3FS9T+ddhhlm7lB1V
         /ayLPDo5vGzozZTIx2sWqYY01sc540RQvS4Ou37YlngYI2h76G3p/EMzC+Fw9ujoleka
         ctYQ==
X-Gm-Message-State: AOAM531TU2oJt2GMpUse4wxcub+TgXTAbO5jC9J0+yAYPJR+VtstSZcH
        ASanWEDUpm3/0pVzWfepVSS3i35hYMKPVADV6Yc=
X-Google-Smtp-Source: ABdhPJwO5l8hooPROSPM5V0NWAhuizzrh2kzrnZvIZdm6TQiuOIl4A03gaMKQ8DOKW8i1oZ8P3eyZmTW8l7Z+PJWmPc=
X-Received: by 2002:a05:6512:e92:: with SMTP id bi18mr9892430lfb.317.1639571471943;
 Wed, 15 Dec 2021 04:31:11 -0800 (PST)
MIME-Version: 1.0
References: <20211212121326.215377-1-yanminglr@gmail.com> <20211213014709.GA2316@anparri>
 <CAH+BkoF-Y55MCSoFes3QYJqXEEH3ZsjHMjmtrKmN3UHv9S_0iw@mail.gmail.com>
 <20211214020658.GA439610@anparri> <20211214042804.GA1934@anparri>
 <CAH+BkoE51_zAtgOo5ZGJk+32cycQ+OetL_U8hyO8oNMJaymAGg@mail.gmail.com> <20211214213659.GA2550@anparri>
In-Reply-To: <20211214213659.GA2550@anparri>
From:   Yanming Liu <yanminglr@gmail.com>
Date:   Wed, 15 Dec 2021 20:30:59 +0800
Message-ID: <CAH+BkoFBugMf442jPiwbjm1hvESpw8gvN6uaQvMez0gifBHtGQ@mail.gmail.com>
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

> > Provided that there are indeed drivers (hv_storvsc and hv_netvsc)
> > which explicitly account for vmpacket_descriptor header, changing
> > max_pkt_size for individual drivers makes more sense.
> > However in this case I'm not sure about our reasoning of 'pkt_offset'
> > above. In drivers/scsi/storvsc_drv.c:
> >
> > #define STORVSC_MAX_PKT_SIZE (sizeof(struct vmpacket_descriptor) +\
> >                               sizeof(struct vstor_packet))
> >
> > Should I also change this 'sizeof(struct vmpacket_descriptor)' to
> > VMBUS_MAX_PKT_DESCR_SIZE? Otherwise this would not match the check in
> > hv_pkt_iter_first.
>
> AFAICT, the above #define is fine, i.e., it represents an upper bound
> on pkt_len as used in hv_pkt_iter_first() (this is all is required on
> max_pkt_size, cf. the memcpy() in hv_pkt_iter_first()).
>
> The same consideration, AFAICT, holds for NETVSC_MAX_PKT_SIZE.
>
> The remarks about pkt_offset targetted the cases, such as hv_balloon,
> where we can somehow upper bound
>
>         (pkt_len - pkt_offset)
>
> (the "packet payload"), since then an upper bound on pkt_offset would

I don't get it. Isn't it the same for storvsc? For storvsc we just
have an upper bound of ("the packet payload") (pkt_len - pkt_offset)
== sizeof(struct vstor_packet).

With more details:

drivers/scsi/storvsc_drv.c:storvsc_on_channel_callback:

foreach_vmbus_pkt(desc, channel) {
        struct vstor_packet *packet = hv_pkt_data(desc);

where foreach_vmbus_pkt is a macro calling hv_pkt_iter_first, and
hv_pkt_data is defined as:

/* Get data payload associated with descriptor */
static inline void *hv_pkt_data(const struct vmpacket_descriptor *desc)
{
        return (void *)((unsigned long)desc + (desc->offset8 << 3));
}

i.e. it expects that 'desc' points to a buffer at least
'(desc->offset8 << 3) + sizeof(struct vstor_packet)' bytes long.

As Hyper-V is proprietary I can only guess what is the purpose of
desc->offset8 (being forward compatible), so I agree with you that
this is a real problem.
Currently, Hyper-V only sends vmbus packets with offset8 == 2, so the
expression above equals STORVSC_MAX_PKT_SIZE. If future Hyper-V
somehow sends a packet with offset8 == 3, hv_storvsc certainly breaks.

Or, is it guaranteed that desc->offset8 will always be 2 and never
change in future Hyper-V?

> give us an upper bound on pkt_len "for free" (associativity):
>
>         ptk_len = (pkt_len - pkt_offset) + pkt_offset
>
>   Andrea

Regards,
Yanming
