Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39FD2D34C6
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Dec 2020 22:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgLHVCf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Dec 2020 16:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgLHVCe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Dec 2020 16:02:34 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4E6C0613CF
        for <linux-hyperv@vger.kernel.org>; Tue,  8 Dec 2020 13:01:54 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id m12so172358lfo.7
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Dec 2020 13:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skpauNrCohQyEEsv7QYK47OFlZchJzrtvUvgvaYlI0g=;
        b=ROtEO+OVS9RfjVYt13rb9bXwl6vWUQ0uLL0X6wygCiWrpFFIQVJPjqgKkj1v7UrNXO
         KDiY9qw9NYnKeQXvq82LKIFRDtuWh/xJCBAirqtHokmUbbpCucKnihw7UAohXOfdUzST
         R/beNSF/szQK06awRivcQ/EdxP5ry8GrnSbts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skpauNrCohQyEEsv7QYK47OFlZchJzrtvUvgvaYlI0g=;
        b=CbKTOMzVmEiVQSI3N0zaKchU2mqpibGa3zPs0gAuiw+6B6CmDCYCRk+ig+4pSjYPzJ
         7COC64iEuPbQSm4kn2fXrcTzYSefvGd92AyoT2hgAuUY5R6vZ2M+A2eCu0wBudImj2X+
         6v0Qq9VjydQ+lVWKUIk2a11QeQo6OGNYWAOXPiDB4ibWM9zy/BBY8V+RXkFGu/GXpEWm
         SuMtqG782CVHmUjY6NXBhdv4aGy92EdiK84se8dwIMCj1d25XJWrK/dCT3R1+S9W/K3k
         aZ9KH9iYdG7gb24DtJXDUmnseo8mV2CV6N5TWiSO1S5uCWjqPRBCecg+RtQQ4jfrAD0R
         5NEA==
X-Gm-Message-State: AOAM531tsahkrafQktnaworN7xWtv/KXmantY7HL3+xriS+9s0L/J7ft
        FqIHrfFOIr+7uA25avv8tvyw2IIKRPO0Ow==
X-Google-Smtp-Source: ABdhPJzwfHK7+SH60c6mYfxhycVEam2SmFL9dcez+wvrDxe7iYIJxqWkBR4HdDu5mS1nV2O6szGSiw==
X-Received: by 2002:ac2:4ecd:: with SMTP id p13mr11069319lfr.430.1607461312724;
        Tue, 08 Dec 2020 13:01:52 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id a27sm3508811ljd.120.2020.12.08.13.01.48
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 13:01:49 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id u18so145044lfd.9
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Dec 2020 13:01:48 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr11218462lfb.421.1607461308477;
 Tue, 08 Dec 2020 13:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20201115233814.GT3576660@ZenIV.linux.org.uk> <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk> <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk> <20201127162902.GA11665@lst.de>
 <20201208163552.GA15052@lst.de> <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
 <20201208194935.GH3579531@ZenIV.linux.org.uk> <CAHk-=whGUXQzNEfPXiKUVZg-mGQjTC_WNZ0m9FKFoWDDrik85g@mail.gmail.com>
 <20201208205321.GI3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201208205321.GI3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 13:01:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjU6pebnM6ei51T-UyVok7u5MF6ndaFr6T0PA3zajEgSw@mail.gmail.com>
Message-ID: <CAHk-=wjU6pebnM6ei51T-UyVok7u5MF6ndaFr6T0PA3zajEgSw@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
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

On Tue, Dec 8, 2020 at 12:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  I've got
> fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()
> and
> fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set
> in "to apply" pile; if that's what you are talking about,

Yup, those were the ones.

> I don't
> think they are anywhere critical enough for 5.10-final, but I might
> be missing something...

No, I agree, no hurry with them. I just wanted to make sure you're
aware of them.

                 Linus
