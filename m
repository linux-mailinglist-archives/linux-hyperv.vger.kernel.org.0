Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6A241162
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Aug 2020 22:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgHJUIs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Aug 2020 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgHJUIr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Aug 2020 16:08:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE6C061756;
        Mon, 10 Aug 2020 13:08:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597090122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=leuJ2cS4njXouvUH1nceMaicvIDbA474Ycye27vo0NI=;
        b=gnAotPclsedy4kdrlHh6Dm+4wPaURAqVECo5AVQCcNreMF3KpuZUbhr+zJ/ePE4BovDrxN
        WE5aBmBrHF0e1kvKO9iGYMYXialBoC7Wrnm2qbJpNPzPxskNznQD8+iDYjjuzdwI9ZV3Dt
        e1TXM8KoVp3YCYAPfqEzC0/Gfzv6olsdeFe4g9xz9q0bxbw3uLgoKMJxUFKZEYor+oWgRg
        52ZtXbRvDccJ9YN3zW+3C9havugmaMc98sMfoLO42UEIQJHQ4RRLju+DdXoEjJoI/m9+S0
        W/iN6So4+RtxrF4tbyje2a66jOLrIB8AO3aCJYJyFq4O11VGKZ/4ytlz7Hp6VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597090122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=leuJ2cS4njXouvUH1nceMaicvIDbA474Ycye27vo0NI=;
        b=bPMYFJS9ro2yZz2FNVrNkMTqBpu1Kuka1Vw2LFpvPTj6EwTnVMlCJNRPqJnBosS2CR8V13
        L+PsO+SrvJbNH6Cw==
To:     Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        kys@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: Re: [PATCH 1/1] x86/hyperv: Make hv_setup_sched_clock inline
In-Reply-To: <1597022991-24088-1-git-send-email-mikelley@microsoft.com>
References: <1597022991-24088-1-git-send-email-mikelley@microsoft.com>
Date:   Mon, 10 Aug 2020 22:08:41 +0200
Message-ID: <87sgcuxnzq.fsf@nanos>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:
> Make hv_setup_sched_clock inline so the reference to pv_ops works
> correctly with objtool updates to detect noinstr violations.
> See https://lore.kernel.org/patchwork/patch/1283635/
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
