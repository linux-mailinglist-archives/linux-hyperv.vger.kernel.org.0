Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD63D2B86
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jul 2021 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhGVRN2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jul 2021 13:13:28 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:56063 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhGVRN1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jul 2021 13:13:27 -0400
Received: by mail-wm1-f51.google.com with SMTP id p9so1737146wmq.5;
        Thu, 22 Jul 2021 10:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q0B/yryzjHjHCADhjVhPYgb/k0QAAR528CYj+zQWV20=;
        b=IQv87zHct9wHL93uRNZSnbLgCo2z7JfSL9FpUSobv5D8aCxqTepEbqEfTPwPixxiX6
         9QBsHrikgjUFGjAOWhppQvKeslgfrvGp7qQ5lKe6HDg4bQg1r1583GCiuuV73MERhqhc
         A4FIE30UY8Ko8HxpWPOwC6OokioMX/ufy7pQC6ZhX97GiH54zVZAj5bMFUGxz/KpSq33
         VeotmEGQoBxKAEkExq7ExHD7Sj7oO4L1P5K9YOvr6/tjwlwFEpkHAYN0YYXEdFZgwE7M
         ++eWMlifrDh/DRSf3Uj6XfFQtsupUjjbi3QayRabd3Rs0kYtjZ6fhgKGQS/VFwPUJa0C
         oO4w==
X-Gm-Message-State: AOAM530iiihtbjwlCVwdWrFd7BKbny/dL2Nbs6xG+hFLyf4Y2eLocZBD
        2afnavi2wOExHMejMfitUPY=
X-Google-Smtp-Source: ABdhPJxLeZKAtm1SRMjNh1hBzb9ffyWvFGt7/fvTcc0vAZDEPuo3/no+KosM2eB77D2pqbvflLLFwQ==
X-Received: by 2002:a05:600c:354e:: with SMTP id i14mr766889wmq.96.1626976440531;
        Thu, 22 Jul 2021 10:54:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o28sm32449730wra.71.2021.07.22.10.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 10:54:00 -0700 (PDT)
Date:   Thu, 22 Jul 2021 17:53:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, Stephen Hemminger <sthemmin@microsoft.com>,
        haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [GIT PULL] Hyper-V fixes for 5.14-rc3
Message-ID: <20210722175358.lnvjdhnx7frtgznc@liuwe-devbox-debian-v2>
References: <20210722140949.3knhduxozzaido2r@liuwe-devbox-debian-v2>
 <CAHk-=wirFvNqAvaNaABHc2mi7FKL4n6TEAwQ3WTyTJueJcHCvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wirFvNqAvaNaABHc2mi7FKL4n6TEAwQ3WTyTJueJcHCvA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 22, 2021 at 10:25:46AM -0700, Linus Torvalds wrote:
> On Thu, Jul 22, 2021 at 7:09 AM Wei Liu <wei.liu@kernel.org> wrote:
> >
> >   - Reversion of a bogus patch that went into 5.14-rc1
> 
> When doing a revert, please explain it.
> 
> Yes, they are simple in the sense that they just undo something, but
> at the same time, that "something" was done for a reason, and the
> reason why that original change was wrong, and how it was noticed (ie
> what the symptoms of the reverted patch were) is important.
> 
> I've pulled this, so it's too late now, but please please please
> explain reverts in the future, not just a "This reverts commit XYZ".
> 

Sure. Noted.

Thanks,
Wei.
