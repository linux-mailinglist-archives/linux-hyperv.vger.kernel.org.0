Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F822D33D0
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Dec 2020 21:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgLHU0f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Dec 2020 15:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgLHU0f (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Dec 2020 15:26:35 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8349C0613CF
        for <linux-hyperv@vger.kernel.org>; Tue,  8 Dec 2020 12:26:19 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r24so26053760lfm.8
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Dec 2020 12:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4rfdB1itUPJzwPX2Po0DzKsfVLu6c50Jbl8+ApJIs4=;
        b=gjXtM9gA8YK4ZCg8BJC8Pa3iGb+RtJZzHwFcdtxxrHUSznzdQ+ZeGIlHNbYSebjGpR
         yK+Ynkl9e7k+Ve5Mjo6kCGM788cdVq2NSwCT1g42MEc+y2m/yO29Ks2lx5+abA9p6CCz
         jJkRy/aRTHlkcix67CQ4mfT7m2WY5vsI4/rAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4rfdB1itUPJzwPX2Po0DzKsfVLu6c50Jbl8+ApJIs4=;
        b=MHvm0etlE6FA5F4C8nqsEdDU3LJsfkIp0Fh3sByhpuQDCb1DaP1MksviPDXgqUBBg8
         vtgDAMYsWY4nyjdkgIW9Go8ESN8tDKWnOZ2spEkOijFR5UvIoQOrMndb5CDurdvpjnKg
         xMBXs5UExLBNlIhxNBNOvSjYCrdQDVfYjngTYk+tq1vgggwKdnuPvLfM+V86isMAafn5
         U6A0Jetx+BBkMkYohXzQhtiSOUaMBbznX8at9uLotz99EDb64i06MwjHh0wOdMUkmO8o
         N2QcreDPxb/45sENlh9EimqPHILzJzC19XBlx1LWsRJv5jgqkyTNggV9Lv60eI8p3HDa
         HHOw==
X-Gm-Message-State: AOAM533GLW/QM16fW0bpsCgCxdYIGrW+1OvNIIRfp4aaaZxnwjBqamji
        Sufy/B/xHf6wlRvIgnleo+Ondqop6TM3tw==
X-Google-Smtp-Source: ABdhPJwlLOnNiasoJxGS8las5kpFLqkWnosBJ2tzsFQHanqdEE3jh+HU7hPcVyAWDEHeoiTOd8ZjKQ==
X-Received: by 2002:a05:6512:491:: with SMTP id v17mr10548765lfq.142.1607459177784;
        Tue, 08 Dec 2020 12:26:17 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q23sm915452lfo.278.2020.12.08.12.26.15
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 12:26:16 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id s11so13132112ljp.4
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Dec 2020 12:26:15 -0800 (PST)
X-Received: by 2002:a2e:5750:: with SMTP id r16mr11173514ljd.61.1607459175646;
 Tue, 08 Dec 2020 12:26:15 -0800 (PST)
MIME-Version: 1.0
References: <20201115155355.GR3576660@ZenIV.linux.org.uk> <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk> <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk> <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk> <20201127162902.GA11665@lst.de>
 <20201208163552.GA15052@lst.de> <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
 <20201208194935.GH3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201208194935.GH3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 12:25:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGUXQzNEfPXiKUVZg-mGQjTC_WNZ0m9FKFoWDDrik85g@mail.gmail.com>
Message-ID: <CAHk-=whGUXQzNEfPXiKUVZg-mGQjTC_WNZ0m9FKFoWDDrik85g@mail.gmail.com>
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

On Tue, Dec 8, 2020 at 11:49 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Said that, it does appear to survive all beating, and it does fix
> a regression introduced in this cycle, so, provided that amount of
> comments in there is OK with you...

Ok, considering Greg's note, I've pulled it. It's early in the last
week, if something comes up we can still fix it.

That said, considering that I think the only use-case was that odd
/proc splice use, and the really special WSL2 thing, and both of those
are verified, it does sound safe to pull.

Famous last words...

Al, since you're around, would you mind looking at the two
DCACHE_DONTCACHE patches too? Honestly, since they seem to be an issue
only for DAX, and only for DAX policy changes, I don't consider them
critical for 5.10, but they've been around for a while now.

         Linus
