Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7959381AA4
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 May 2021 21:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhEOTHx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 15 May 2021 15:07:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44130 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhEOTHw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 15 May 2021 15:07:52 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621105598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o6wTd/giKJYoy1NqyWY3ZdEQ6o/XvhP1g3+b/tPjlmg=;
        b=OqGq9NNCxURDKAs9NISZWffnUohYrr7iUOFdn5fbhjX8zmUs2lNmOS97scwZ2A4gSOc0ZU
        J2iHB2Piw8IzW3vHAwCMF3zMyhf13/AECkqn5nxJFmlLJofkUquQpXTCRgdmGinqEAs5Ci
        X6SNt8usJM7LGNhhUoTP+9e77ZQAo7I3JpA62VzhhAX266OXDH94XMsR40xAm7vupvurCl
        jSWypDEOUH7loqRuY28D/rp/cH3JKLzDMrJSnFMdr4hwaak5CDx7jyDiWtPaU81pHeBq+8
        Se8dTj4MqAP/6nRTqTS0gaDWpdB19usxHnaAy7UlFG0JaSn7T9QFtgwXtpeykQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621105598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o6wTd/giKJYoy1NqyWY3ZdEQ6o/XvhP1g3+b/tPjlmg=;
        b=42Eh+N0XcLO0v2YYmpz/1ZU85nviuLIKlqJgZknuhwxTTz4WWd++58HiUHS2wckJknnMGJ
        by7lZ+gS3cQi/uDg==
To:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mohammed Gamal <mgamal@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] clocksource/drivers/hyper-v: Re-enable VDSO_CLOCKMODE_HVCLOCK on X86
In-Reply-To: <20210515154335.lr4hrbcmt25u7m45@liuwe-devbox-debian-v2>
References: <20210513073246.1715070-1-vkuznets@redhat.com> <MWHPR21MB15932C5EC2FA75D50B268951D7519@MWHPR21MB1593.namprd21.prod.outlook.com> <20210515154335.lr4hrbcmt25u7m45@liuwe-devbox-debian-v2>
Date:   Sat, 15 May 2021 21:06:37 +0200
Message-ID: <87h7j324w2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, May 15 2021 at 15:43, Wei Liu wrote:

> On Thu, May 13, 2021 at 01:29:12PM +0000, Michael Kelley wrote:
>> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, May 13, 2021 12:33 AM
>> > 
>> > Mohammed reports (https://bugzilla.kernel.org/show_bug.cgi?id=213029)
>> > the commit e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO
>> > differences inline") broke vDSO on x86. The problem appears to be that
>> > VDSO_CLOCKMODE_HVCLOCK is an enum value in 'enum vdso_clock_mode' and
>> > '#ifdef VDSO_CLOCKMODE_HVCLOCK' branch evaluates to false (it is not
>> > a define). Use a dedicated HAVE_VDSO_CLOCKMODE_HVCLOCK define instead.
>> > 
>> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> > Reported-by: Mohammed Gamal <mgamal@redhat.com>
>> > Fixes: e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO differences inline")
>> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> [...]
>> 
>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>> 
> Applied to hyperv-fixes. Thanks.

It's already in the tip tree...
