Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F572B36D8
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 17:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgKOQ5F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 11:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgKOQ5E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 11:57:04 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77187C0613D1
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2020 08:57:04 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 142so3416328ljj.10
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2020 08:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZhWNdmrv7uNC+shuTB5UrdMpVq8cOfsO/67ny1dABo=;
        b=GKe8HtSGVpql7itwBeLIkBdzeQTDlLA/NMjuNvTbYEKWXB7yyVUDwFWl9MTbBscdEJ
         hObKcjWJK90+BTLO+zgzmCcH+qCmtS9aZD909pSoyW/0/+CSK0ggGgVgQQGW5k7uiBQQ
         9/PazKzHsYQiacJMrzhtp0dCF64qWviUt14wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZhWNdmrv7uNC+shuTB5UrdMpVq8cOfsO/67ny1dABo=;
        b=hkeEga/5z7e2kavSCVjWi02aDTPNJI2AimEblb4kE2K6DFwGmjl42a8QLGBBjO+P8V
         AYNQzNtEfVHrvfAcG1IY+HaXgkRFbjOEUBj/BrsT0br1OWMJGlbed7smzeTMvbo74gJa
         5SNAxjJGahYXU/06V1bRoc44+sFVcmLkxipd1b7ZFox2c3Qv/f5cOQ4eGX0OP47xgIMR
         ///oJYHQ5MEyyIrF7d4m0dlI7xywdkd33yHcLFMBPP0he5C2cMV71Vedwgf6M5l9FKGd
         bYULEG9i/5A/3/mVv6oziKtPEgbR4BbJ4PqW4CvuFIOoXidekyDqsFjqHDMKNIyLOuP+
         +l3A==
X-Gm-Message-State: AOAM5305xRC4kSGkDoIxOgzw9w3l2+jZznt3HSFsnAiM2DDjQiNCBWOR
        AvJ9CNL1ArjPYVuKJ3d4Imz/vfZ3sTtcXg==
X-Google-Smtp-Source: ABdhPJydEKeAq7QxT7bp5kOFzRftAewZCXTlmaQbbhMgHwejqQ2nEowE76QXu8dvadAKySFm8yeUww==
X-Received: by 2002:a2e:8090:: with SMTP id i16mr4930341ljg.162.1605459422536;
        Sun, 15 Nov 2020 08:57:02 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id g14sm2439828ljn.103.2020.11.15.08.57.00
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 08:57:01 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id j205so21465436lfj.6
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2020 08:57:00 -0800 (PST)
X-Received: by 2002:a19:7f55:: with SMTP id a82mr4592052lfd.603.1605459420530;
 Sun, 15 Nov 2020 08:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20201111222116.GA919131@ZenIV.linux.org.uk> <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk> <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk> <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk> <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk> <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201115155355.GR3576660@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Nov 2020 08:56:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wisaN3QOEYq6XBSKyW_74X5GhdbyE5AnbLkh9krarhDAA@mail.gmail.com>
Message-ID: <CAHk-=wisaN3QOEYq6XBSKyW_74X5GhdbyE5AnbLkh9krarhDAA@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Nov 15, 2020 at 7:54 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> OK, I think I understand what's going on.  Could you check if
> reverting the variant in -next and applying the following instead
> fixes what you are seeing?

Side note: if this ends up working, can you add a lot of comments
about this thing (both in the code and the commit message)? It
confused both Christoph and me, and clearly you were stumped too.
That's not a great sign.

                  Linus
