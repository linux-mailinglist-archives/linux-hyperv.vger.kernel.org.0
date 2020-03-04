Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 288A61792CB
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2020 15:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgCDOzw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Mar 2020 09:55:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725795AbgCDOzw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Mar 2020 09:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583333750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oKVK8TwDwaGEB6ayUlSBTUyLsbqiCprj+fuuCbfWt8c=;
        b=cFWnPGwecYHq6TiQBNMWMq5NL4NhZ5F5Q14K1CBzy+sU3qUItacu0PDlcq2dMZsMTlbtNO
        7F8V+feRUDML4DdEZlT5IIpMjCwMqUNM+d7jUILncOlalPF9qvVXXAoiaspzTCBBOAUvx7
        kWFeVlQOGn0FNAUo8cYLaZTHNriK3ao=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-IES4NnVoNEaX7D9Hc_0XjQ-1; Wed, 04 Mar 2020 09:55:46 -0500
X-MC-Unique: IES4NnVoNEaX7D9Hc_0XjQ-1
Received: by mail-qk1-f199.google.com with SMTP id k194so1459634qke.10
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Mar 2020 06:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKVK8TwDwaGEB6ayUlSBTUyLsbqiCprj+fuuCbfWt8c=;
        b=YJvP0VgfbToOtZyxvNZLY4FuzC+aMduhOwS/J2GlkeC3BxClc2QHSJ3JYJlgC3bkr3
         VzfZvDy1DrixL6EwHDDJsByhnrETIjW2LCJlaiJwyo/TJ7PpyhnKhhKs/znCHYRUgGgi
         IAlpkibCMHBIMhD/GwbN8iclpb0kIE5Rdm3YBUnq/SY5hwMm96Bi2piqpQYiNaV1+5n4
         VO3LZEwmGot87Y1glrW6BuHDt2AYINB963malLVZxH9EEatbtA90MX5oR/Oxw376rKwO
         XIoonggs7w7LfQtmgRyHvwFIxsBUgNdPunrOR2kxfOuW0PbRF1AZaZb7ue0EM1en0HRS
         DceQ==
X-Gm-Message-State: ANhLgQ28FscBqANmivXOurrgZsIdISYYknkATKxkUiAuwT220dMgMPil
        GZTmwBtO9hjFfDhbI17JK4jBwdcBtgZeLSIbVt6NI55XHIZdMzCrxQP2X9BAPCYbz8kHp0OldfW
        HWE3nyzFUlDU3tEr9zChU09e4bdHq+ENLEOp1Ga1f
X-Received: by 2002:a05:620a:1517:: with SMTP id i23mr3121556qkk.459.1583333746199;
        Wed, 04 Mar 2020 06:55:46 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsCAa2/9q1HqrDGCRKmEqLJ4HJoEC8U/Z96fo7d9Ti23/A7BUH/Rq0FcHkVHybbcOgLpahxaE1ZwaDldnelFJ8=
X-Received: by 2002:a05:620a:1517:: with SMTP id i23mr3121533qkk.459.1583333745910;
 Wed, 04 Mar 2020 06:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20200229173007.61838-1-tanure@linux.com> <CAO-hwJJDv=LnOQDbgWwg2sOccM9Tt-h=082Coi0aYdwG-CG-Kg@mail.gmail.com>
 <20200302120951.fhdafzl5xtnmjrls@debian> <20200304144858.xc6ekcvbzrhbggsc@debian>
In-Reply-To: <20200304144858.xc6ekcvbzrhbggsc@debian>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 4 Mar 2020 15:55:34 +0100
Message-ID: <CAO-hwJ+-xZgiNhOcRo1k3hGQxxkPd2RVrAbA3Gq1P28h7M1gdA@mail.gmail.com>
Subject: Re: [PATCH] HID: hyperv: NULL check before some freeing functions is
 not needed.
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Lucas Tanure <tanure@linux.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, linux-hyperv@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 4, 2020 at 3:49 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> On Mon, Mar 02, 2020 at 12:09:51PM +0000, Wei Liu wrote:
> > Hi Benjamin
> >
> > On Mon, Mar 02, 2020 at 11:16:30AM +0100, Benjamin Tissoires wrote:
> > > On Sat, Feb 29, 2020 at 6:30 PM Lucas Tanure <tanure@linux.com> wrote:
> > > >
> > > > Fix below warnings reported by coccicheck:
> > > > drivers/hid/hid-hyperv.c:197:2-7: WARNING: NULL check before some freeing functions is not needed.
> > > > drivers/hid/hid-hyperv.c:211:2-7: WARNING: NULL check before some freeing functions is not needed.
> > > >
> > > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > > ---
> > >
> > > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > Sasha, do you prefer taking this through your tree or through the HID
> > > one. I don't think we have much scheduled for hyperv, so it's up to
> > > you.
> >
> > Sasha stepped down as a hyperv maintainer a few days back. I will be
> > taking over maintenance of the hyperv tree.
> >
> > The problem is at the moment I haven't got write access to the
> > repository hosted on git.kernel.org. That's something I will need to
> > sort out as soon as possible.
> >
> > In the meantime, it would be great if you can pick up this patch so that
> > it doesn't get lost while I sort out access on my side.
>
> Hi Benjamin
>
> I got access to the Hyper-V tree. I will be picking this patch up since
> I haven't got a confirmation from your side.
>

Great, thanks.

Sorry, I am pulled in freedesktop tasks right now that are a little bit urgent.

Glad you quickly set up the access rights.

Cheers,
Benjamin

