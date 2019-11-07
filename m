Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAFB1F3A62
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2019 22:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfKGVVk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Nov 2019 16:21:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49659 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfKGVVj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Nov 2019 16:21:39 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSpDk-00061v-Lo; Thu, 07 Nov 2019 22:21:36 +0100
Date:   Thu, 7 Nov 2019 22:21:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] x86/hyper-v: micro-optimize send_ipi_one case
In-Reply-To: <877e4bbyw2.fsf@vitty.brq.redhat.com>
Message-ID: <alpine.DEB.2.21.1911072220590.27903@nanos.tec.linutronix.de>
References: <20191027151938.7296-1-vkuznets@redhat.com> <877e4bbyw2.fsf@vitty.brq.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 7 Nov 2019, Vitaly Kuznetsov wrote:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
> > When sending an IPI to a single CPU there is no need to deal with cpumasks.
> > With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
> > cycles) improvement with smp_call_function_single() loop benchmark. The
> > optimization, however, is tiny and straitforward. Also, send_ipi_one() is
> > important for PV spinlock kick.
> >
> > I was also wondering if it would make sense to switch to using regular
> > APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CPU
> > cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
> > vector)).
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> > Changes since v2:
> >  - Check VP number instead of CPU number against >= 64 [Michael]
> >  - Check for VP_INVAL
> 
> Hi Sasha,
> 
> do you have plans to pick this up for hyperv-next or should we ask x86
> folks to?

I'm picking up the constant TSC one anyway, so I can just throw that in as
well.

Thanks,

	tglx
