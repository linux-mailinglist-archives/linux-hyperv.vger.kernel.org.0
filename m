Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31FC241A04
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Aug 2020 12:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgHKK5c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Aug 2020 06:57:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39015 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgHKK5b (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Aug 2020 06:57:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id g75so1939521wme.4;
        Tue, 11 Aug 2020 03:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1j4nbOfxJc3XexsBz4p680H37CuZTs9tKZjltQ04x8=;
        b=mZzmqtK0CKBU6bU4FzZoBpwqjiFkXqcyKRQEjoVjFQhzEXf6FPqleAsZb8S4yQGkLR
         a46QmMdx4L7jOyZ/w9pyxQDSenBJ4Saru2hGf/8o61aYSWFYFIiBZnp/SpCYoaJb9XHL
         rcwSIo0YiCtmsSokA3depGyI3wBnlgCC+rQ5QY6ah05PeK0F/MEUxvJeG0Ov9S6Zkh5c
         hHCERA7hdYJr6xuCabOR5kdgaG0EM+yFWY/qF3eDp98qYH8dUY4KSqxaRMOOQjo9IwKe
         OmukstXbCm/NqHjDIE2bqwAyL/WaE2PnAanvq8OJt43IGkSsSdHpObi+vDV4h31+P8oc
         XDSA==
X-Gm-Message-State: AOAM530MojrKAoyZZUppwxBl1yRcCENROJ0Zs/J5KXNO4ck1n+7QQq+Z
        Kj1ZMG15mToCl2pH+s2kdPo=
X-Google-Smtp-Source: ABdhPJxBJ9WKr3DgQX0cvWnvbLYtZuAYSo6tuw9dNaLRwaWC/X0djkd1O3v3XOd4gQXYD9ieuAgTfw==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr3422822wma.121.1597143449201;
        Tue, 11 Aug 2020 03:57:29 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d7sm27400711wra.29.2020.08.11.03.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 03:57:28 -0700 (PDT)
Date:   Tue, 11 Aug 2020 10:57:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        kys@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Make hv_setup_sched_clock inline
Message-ID: <20200811105727.hgcpqrha6hydp5zv@liuwe-devbox-debian-v2>
References: <1597022991-24088-1-git-send-email-mikelley@microsoft.com>
 <87sgcuxnzq.fsf@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgcuxnzq.fsf@nanos>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 10, 2020 at 10:08:41PM +0200, Thomas Gleixner wrote:
> Michael Kelley <mikelley@microsoft.com> writes:
> > Make hv_setup_sched_clock inline so the reference to pv_ops works
> > correctly with objtool updates to detect noinstr violations.
> > See https://lore.kernel.org/patchwork/patch/1283635/
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thomas and Peter, thank you for your acks.

I have applied to hyperv-fixes and plan to submit it to Linus in a few
days' time.

Thomas, let me know if you want this patch to go through the tip tree. I
will revert it from hyperv-fixes if that's the case.

Wei.
