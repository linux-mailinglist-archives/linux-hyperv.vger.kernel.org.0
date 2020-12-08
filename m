Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383F02D323F
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Dec 2020 19:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgLHSfr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Dec 2020 13:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgLHSfr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Dec 2020 13:35:47 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BB8C061749
        for <linux-hyperv@vger.kernel.org>; Tue,  8 Dec 2020 10:35:07 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l11so25391334lfg.0
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Dec 2020 10:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voLO0p3JKgBqdFAV+eE0VtYglGMqvAnD20Qcprcp1eU=;
        b=Rb3yB97rD4Jd09jB1o/7GugG34ZyX32ATZjk4sAGSTpj11Jg5M0x97OA7D/aj1dg8o
         tRtB/Md3dssWMo4XJjaEetlgq5hwf3cnlVq+rgiijO9tpW6gTVdxhrcQ3J58bsnPIlbg
         2+RmSGDu+naDhJQPeAR9B/tFcLahy4KmGnOcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voLO0p3JKgBqdFAV+eE0VtYglGMqvAnD20Qcprcp1eU=;
        b=qaXAZ2LmRL6v2mZ0Q2pCUdaMlVAnSKixv4haNRBb40kl/Q+Mix/5rbWdfwkgzzdgh4
         AF+eQln7cqHmFb0U/coR5sNjAUYx/A0W+t+7MRxcVlEUszvyN3h97BGRd0Z9RQn4sIHp
         0bGk0Y6bMMXbMqMNDQKiiTks140yfg8Wzx3OR67uu4fpLYOGMR1J+MMRLv6gKoh0at/y
         a+N03yBAc3+6T5xXbXZ2R4gME2qpRgMQNkd+fAVp8C1XQs01re5xtea1vvdsnNxcyO4E
         26wWCEe9VFxkGlrsf3Fi7EuxoKww8XQVKGyaSYDX6MtCngeqDCAqVFJhJJ/Wk3BmFwWV
         4Cmw==
X-Gm-Message-State: AOAM533tErATzzVboG7HSfxJjtoIPE8UDeD+BWVYPWBd5XxSG8Um6ZIk
        dlXFOKhP/6mxJk9+z+St+pttF6qy0n8Wcw==
X-Google-Smtp-Source: ABdhPJyf0STvhA+OF9TGfq4SdxzeTEiRDU/adxOVOgGr1gVYmCpIs9g6BgJGgpvA/POdkTvtMolTAA==
X-Received: by 2002:a19:7911:: with SMTP id u17mr10918650lfc.466.1607452505147;
        Tue, 08 Dec 2020 10:35:05 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t14sm777836ljg.48.2020.12.08.10.35.02
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 10:35:02 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id s30so25338244lfc.4
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Dec 2020 10:35:02 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr10997620lfb.421.1607452502153;
 Tue, 08 Dec 2020 10:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20201114070025.GO3576660@ZenIV.linux.org.uk> <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk> <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk> <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk> <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk> <20201127162902.GA11665@lst.de> <20201208163552.GA15052@lst.de>
In-Reply-To: <20201208163552.GA15052@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 10:34:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
Message-ID: <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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

On Tue, Dec 8, 2020 at 8:35 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Shouldn't this go to Linus before v5.10 is released?
>
> ping?

So by now I'm a bit worried about this series, because the early fixes
caused more problems than the current state.

So considering the timing and Al having been spotty, I think this is
post-5.10 and marked for stable.

Al, I'm willing to be convinced otherwise, but you need to respond..

              Linus
