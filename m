Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B2262CE1D
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Nov 2022 23:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiKPW4J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Nov 2022 17:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiKPW4I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Nov 2022 17:56:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA9C663D2;
        Wed, 16 Nov 2022 14:56:07 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668639366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NK4Bwp0egfkBgRZB5qVlgvCKsyg/1xF5g9aS06cw6Ik=;
        b=PZXDX4Zl+rEyGzQrzh0COw7/r5XBTH5PyZ61y9SUBZuNMOfgqRXB89J20hNxsIhysyeSp+
        6U5sT8Mmv8vhKVvzbhhy6gY1oNUFogP93MQMxZcpCDWJ3FrXkjOtByK4U9M6pwhMM2nsg5
        OgVNmDjlDCpoLwTpHlQnzNJ2aeRaJIw0BXciPk7eEKN6GGcAUkm+p65/x+rFvP1l6TE0Xo
        Ak8rshlkVecnk3OGHoZew+okXLoqEY33TXYreoSlG8PB3TNxP/9T1VEgI/T13dh3emDBga
        wLOs6yl/Nw46yVxVteiCcnc6LtbCqCrl3NoS9cwm3gF22vYwpLoGzoec8gs4MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668639366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NK4Bwp0egfkBgRZB5qVlgvCKsyg/1xF5g9aS06cw6Ik=;
        b=rmBuUuHaoybCBSHZPnCMZmSPzVOb1+ukTwbiySw7xdGME3z04JTyH4BbNQRZnFlTD6T9lU
        +6RZewDH9PHKeNCQ==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: RE: [PATCH] clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h
 not asm/mshyperv.h
In-Reply-To: <BYAPR21MB1688424DD14B46712F2992E9D7079@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <87zgcwt2qg.ffs@tglx>
 <BYAPR21MB1688C5BCDF3269BA070DB884D7039@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87wn7ztc89.ffs@tglx> <87sfinta8q.ffs@tglx> <87leoft9w1.ffs@tglx>
 <87fsemtut0.ffs@tglx> <8735aipqph.ffs@tglx>
 <BYAPR21MB1688424DD14B46712F2992E9D7079@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Wed, 16 Nov 2022 23:56:05 +0100
Message-ID: <87cz9mo6ey.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Nov 16 2022 at 22:34, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, November 16, 2022 12:52 PM
>> On Sun, Nov 13 2022 at 22:21, Thomas Gleixner wrote:
>> > Subject: clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h not
>> asm/mshyperv.h
>> > From: Thomas Gleixner <tglx@linutronix.de>
>> > Date: Sat, 12 Nov 2022 19:08:15 +0100
>> >
>> > clocksource/hyperv_timer.h is included into the VDSO build. It includes
>> > asm/mshyperv.h which in turn includes the world and some more. This worked
>> > so far by chance, but any subtle change in the include chain results in a
>> > build breakage because VDSO builds are building user space libraries.
>> >
>> > Include asm/hyperv-tlfs.h instead which contains everything what the VDSO
>> > build needs and move the hv_get_raw_timer() define into the header file.
>> >
>> > Fixup drivers/hv/vmbus_drv.c which relies on the indirect include of
>> > asm/mshyperv.h.
>> 
>> Any comments on this latest version?
>
> Sorry.  This looks good to me.  Maybe the commit message needs a
> bit of tweaking -- it's not clear what "move hv_get_raw_timer()
> define into the header file" exactly refers to.  But otherwise,

That should obviously be 'into a separate header file, which is included
from clocksource/hyperv_timer.h' or something like that.

Thanks,

        tglx
