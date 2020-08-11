Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79CA241A4A
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Aug 2020 13:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgHKLYf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Aug 2020 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHKLYf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Aug 2020 07:24:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4114C06174A;
        Tue, 11 Aug 2020 04:24:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597145071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMRBcURMBXMe8gWGPpCx+GrHd1pDCTNfww0n/Z+32II=;
        b=CO+Gpay+zDE47c230mcCXUmSEVIN/e4FnxQRh0eU0WCWMd4INGJs0ma57jFyjCWrT9A9iX
        nUxKfubIbbogffxAKxh03l2kNLSmFIC+yzjwWY+Ue1JpUskxB1fGK4bSwE13eMq06z7VL4
        HB+vGfoTyalXZ04i13i60/t21aTv10GJMCAu6TfuXf4UX44ZBLR5Gbd1nI7RaXIzaKe1SC
        eLt6fEL2ct7HlZJhCMrAStv2rSi7mYvt1+c+0M/cGuKoG7jriIi8tY5kXeXIj/sQm5qJ+E
        85S7dGiRFIhg7y06eb7lfzgsaqmNYx8ihb+F4AwGa3Sj503XT0dWvXA5L+FKng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597145071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMRBcURMBXMe8gWGPpCx+GrHd1pDCTNfww0n/Z+32II=;
        b=J7gQjwLcyV+VKy3+RVRtazgEzpYgU22FH55iaTfn/NEe70Td14A3dfMWIeRYcyZMkO2Orn
        MKi5Wx/x29n0X8AQ==
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        kys@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Make hv_setup_sched_clock inline
In-Reply-To: <20200811105727.hgcpqrha6hydp5zv@liuwe-devbox-debian-v2>
References: <1597022991-24088-1-git-send-email-mikelley@microsoft.com> <87sgcuxnzq.fsf@nanos> <20200811105727.hgcpqrha6hydp5zv@liuwe-devbox-debian-v2>
Date:   Tue, 11 Aug 2020 13:24:30 +0200
Message-ID: <87364t8lxt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Mon, Aug 10, 2020 at 10:08:41PM +0200, Thomas Gleixner wrote:
>> Michael Kelley <mikelley@microsoft.com> writes:
>> > Make hv_setup_sched_clock inline so the reference to pv_ops works
>> > correctly with objtool updates to detect noinstr violations.
>> > See https://lore.kernel.org/patchwork/patch/1283635/
>> >
>> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>> 
>> Acked-by: Thomas Gleixner <tglx@linutronix.de>
>
> Thomas and Peter, thank you for your acks.
>
> I have applied to hyperv-fixes and plan to submit it to Linus in a few
> days' time.
>
> Thomas, let me know if you want this patch to go through the tip tree. I
> will revert it from hyperv-fixes if that's the case.

I acked it so you can pick it up :)
