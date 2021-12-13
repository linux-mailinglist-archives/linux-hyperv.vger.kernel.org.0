Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A52247329E
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Dec 2021 18:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhLMRBw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Dec 2021 12:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbhLMRBv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Dec 2021 12:01:51 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7594AC061574
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Dec 2021 09:01:51 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id cf39so19974177lfb.8
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Dec 2021 09:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1v/+HRGikRqrT+UkvpN7a6VIDckmDx/YyXRGTjmOEik=;
        b=AXSaBYIPypeQkNw7shV7p8muooOgvj3h3YpmAFxNZF9sUtEw6b+7ysTkPujCZ0btZN
         y3gDoMZ0XGzempsofTqwO/G72hcmtrgHL8NYnsvhKgkZ74uzBinzpT8kRilZlFRLti21
         +g4XE82MOSDDn1U2pb4JRJL/hRkCokzb4d4HBQs9zBFDQzrSHiyvmEf8CGOUHdfWv21R
         +bs5CdGYYvQ2pnoQElkauFpYrZgNP6QvpCLPuuk/kL7sfmBizeE+5AvD9jJxgEKRAHOl
         qjsHbx/qo3vXuvszI3puRvjeGycQ2YlnkuECYHd3ydOkqXHRWuS1CdUmgfsfIsRKT+HY
         nH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1v/+HRGikRqrT+UkvpN7a6VIDckmDx/YyXRGTjmOEik=;
        b=2IYK1VBGECaV1ZD4JkZEbbq2xHglodPLx8FV10ZRNdIDtwfsNxEz02zHaoKEKxjxRH
         a5C3H3Qq3g2x4M0JkNhjLpH1DV9FDQyDTJUYWsN9kcQlChOJ7LTtnZVkLnnemEcPeopp
         AaKUwBTZQn/fPKyux2xtBNlW8UUAZzf2cxovZJFxE+Tgu8uBh4cZSeU5iyearlHSY3A/
         YQRjNo7oLfzryIwfDCK3kQ0LnASJK8kBCiIy5PsAndoBSl2/i04pKBYQ20gWkBZQeLH9
         3cby61xXN73yeweFhX5akZoserNYQkY/yUbndWLrJYCNChTMC6b2oDxpFJLjVuNWMz4u
         3Vfg==
X-Gm-Message-State: AOAM532G9+Gc4xVwQLqn4CN1daRFMRCkIzy8NznbytLh7ojkTIEu1Rq0
        fwEFqJYuxW9znyfAiwW4TZ62Jz5YEM9x0LZOgQE=
X-Google-Smtp-Source: ABdhPJyjOE4wcFNhuRv0dwtMzmQwS0H7FzJoxizs/ikcWqdVZVM3waFZ2qfUCdzUnAvwuP6IeEs61TQxDHi5+pvwSfM=
X-Received: by 2002:a05:6512:33d4:: with SMTP id d20mr30058863lfg.618.1639414909362;
 Mon, 13 Dec 2021 09:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20211212121326.215377-1-yanminglr@gmail.com> <20211213014709.GA2316@anparri>
In-Reply-To: <20211213014709.GA2316@anparri>
From:   Yanming Liu <yanminglr@gmail.com>
Date:   Tue, 14 Dec 2021 01:01:38 +0800
Message-ID: <CAH+BkoF-Y55MCSoFes3QYJqXEEH3ZsjHMjmtrKmN3UHv9S_0iw@mail.gmail.com>
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

On Mon, Dec 13, 2021 at 9:47 AM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> Yanming,
>
> [...]
>
> > Specifically, in hv_balloon I have observed of a dm_unballoon_request
> > message of 4096 bytes being truncated to 4080 bytes. When the driver
> > tries to read next packet it starts from the wrong read_index, receives
> > garbage and prints a lot of "Unhandled message: type: <garbage>" in
> > dmesg.
>
> To make sure I understand your observations: Can you please print/share the
> values of (desc->len8 << 3) and (desc->offset8 << 3) for such a "truncated"
> packet, say, right after the
>
>         desc = hv_pkt_iter_first(channel);
>
> in hv_ringbuffer_read()?  Also, it'd be interesting to know whether any of

Truncated packet:
module("hv_vmbus").statement("hv_pkt_iter_first@drivers/hv/ring_buffer.c:457"):
desc->offset8 = 2, desc->len8 = 514, rbi->pkt_buffer_size = 4096
module("hv_vmbus").statement("hv_ringbuffer_read@drivers/hv/ring_buffer.c:382"):
desc->offset8 = 2, desc->len8 = 512
balloon_onchannelcallback: recvlen = 4080, dm_hdr->type = 8

First garbage packet:
module("hv_vmbus").statement("hv_pkt_iter_first@drivers/hv/ring_buffer.c:457"):
desc->offset8 = 21, desc->len8 = 16640, rbi->pkt_buffer_size = 4096
module("hv_vmbus").statement("hv_ringbuffer_read@drivers/hv/ring_buffer.c:382"):
desc->offset8 = 21, desc->len8 = 512
balloon_onchannelcallback: recvlen = 3928, dm_hdr->type = 63886

The trace proved my hypothesis above.

> the two validations on pkt_len and pkt_offset in hv_pkt_iter_first() fails
> (so that pkt_len/pkt_offset get updated in there).
>
> Thanks,
>   Andrea

Regards,
Yanming
