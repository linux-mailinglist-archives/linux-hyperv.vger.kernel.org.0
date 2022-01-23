Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6A4975DD
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Jan 2022 23:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiAWWAH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jan 2022 17:00:07 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:46972 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiAWWAH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jan 2022 17:00:07 -0500
Received: by mail-wm1-f52.google.com with SMTP id a203-20020a1c98d4000000b0034d2956eb04so73903wme.5;
        Sun, 23 Jan 2022 14:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJh9I1eoTbpKvrdJo2eHmYHAPVSdA5hOmWOCZfSky6s=;
        b=aKkJbByhqFlDlCbXlxy3T4jgwHBdLW482Ch6JAUO0wStadqYQtHE1EOkIKZvALxcbW
         SUxWvknSQ3mnGzG5Iv4NmESj+BVpFT5xisy18EYsgWfXr0L6GXaNewARP+r9iM2yoFNc
         RyynaJNZ3qdpxv019H412dWA76jMH+SYX051yWBW/Ef/QbE2JW/P7zozYBH6jHeJ4dXi
         dwZ3Z5T8cposzPlLG2yPdVthMaYsQCiE64QJFawNQVcw+wr3TLj9Ft6lZL7SAjKEsfkE
         gNo3Vs95EYC8mzg6bXAsKLE+xp9Y2BT7qXcDs8rfw8B16cDlW0tV8oLcI6uWprrW/vgA
         U/tQ==
X-Gm-Message-State: AOAM531//IflXssx0RymEdR9KbKLWJ4RbmIv0h7i7ljPLhQfXl8lI5k1
        wVKKisDpHGr1YuucSIRwIL8=
X-Google-Smtp-Source: ABdhPJzZn47WeoeSIMPoijTnR2fL6aguIsedH9zK6nT/Am/W7pO/Xy6z8ACeayxR6q302f79ZC6Wcw==
X-Received: by 2002:a05:600c:5127:: with SMTP id o39mr9231510wms.81.1642975206017;
        Sun, 23 Jan 2022 14:00:06 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c14sm15908197wri.32.2022.01.23.14.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:00:05 -0800 (PST)
Date:   Sun, 23 Jan 2022 22:00:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 43/54] drivers/hv: replace cpumask_weight with
 cpumask_weight_eq
Message-ID: <20220123220004.qtwdl5oqufiy4elj@liuwe-devbox-debian-v2>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-44-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-44-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Jan 23, 2022 at 10:39:14AM -0800, Yury Norov wrote:
> init_vp_index() calls cpumask_weight() to compare the weights of cpumasks
> We can do it more efficiently with cpumask_weight_eq because conditional
> cpumask_weight may stop traversing the cpumask earlier (at least one), as
> soon as condition is met.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
