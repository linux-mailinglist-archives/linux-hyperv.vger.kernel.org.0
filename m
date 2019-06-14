Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0546C0F
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2019 23:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfFNVok (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 17:44:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36845 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfFNVok (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 17:44:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so3982140wrs.3
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Jun 2019 14:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ld3jYaYOalugs6NakkhvxfE6gQQVFoIIwwhNaKu9MOs=;
        b=Ap9CPiQfxlTyWA669udOM9H+Wb1RS8tvB7KFl/5fBBdEnyM862ZQZmc4sWAxzCI7fS
         tNxmsRC9xj65dh9SKadZ3OIzRkme1ynNClzKvBSl6EEeYbCbsdUy+FYsN9wrDKM8cL6z
         f0ycdBlOyzqIMpCaaJSb3VzSbj+Ge2h3waqw32KhzhUdPodrzjU1+umIqrYqebHMhTGT
         P2qU20UCcbk0O0Q1iJA0ExwUBXDRtFPThKDMB+5c/M8tQ9PSoKiLXfyDDzTvBqjMws/4
         DiYOO6Nxdxwx7XdpHhlhS1rqnPXSVoOPYC2Z/fBgZZStuEv052O/ZSlSBd3EwSkQaV67
         xtqQ==
X-Gm-Message-State: APjAAAUBFc6rjfFs6j4EE4gf3zCcBzi2Nx1t5uM9abgBXn0neUahfKku
        JIYnSUCosycUojapoJfMV5moKw==
X-Google-Smtp-Source: APXvYqwtUzuPcck2AHyIXDAtw0zg3eNPDxrY9SB60wA2LaOW4/UoaSEnBo/i0WOqLauPH2dS3zi6EA==
X-Received: by 2002:a5d:4a0e:: with SMTP id m14mr19268175wrq.91.1560548678052;
        Fri, 14 Jun 2019 14:44:38 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-78-102-201-117.net.upcbroadband.cz. [78.102.201.117])
        by smtp.gmail.com with ESMTPSA id h23sm2938104wmb.25.2019.06.14.14.44.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 14:44:37 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Prasanna Panchamukhi <panchamukhi@arista.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Cathy Avery <cavery@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, x86@kernel.org,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH] x86/hyperv: Disable preemption while setting reenlightenment vector
In-Reply-To: <20190614122726.GL3436@hirez.programming.kicks-ass.net>
References: <20190611212003.26382-1-dima@arista.com> <8736kff6q3.fsf@vitty.brq.redhat.com> <20190614082807.GV3436@hirez.programming.kicks-ass.net> <877e9o7a4e.fsf@vitty.brq.redhat.com> <cb9e1645-98c2-4341-d6da-4effa4f57fb1@arista.com> <20190614122726.GL3436@hirez.programming.kicks-ass.net>
Date:   Fri, 14 Jun 2019 23:44:36 +0200
Message-ID: <87pnnf6dvf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

>
> I know you probably can't change the HV interface, but I'm thinking its
> rather daft you have to specify a CPU at all for this. The HV can just
> pick one and send the notification there, who cares.

Generally speaking, hypervisor can't know if the CPU is offline (or
e.g. 'isolated') from guest's perspective so I think having an option to
specify affinity for reenlightenment notification is rather a good
thing, not bad.

(Actually, I don't remember if I tried specifying 'HV_ANY' (U32_MAX-1)
here to see what happens. But then I doubt it'll notice the fact that we 
offlined some CPU so we may get a totally unexpected IRQ there).

-- 
Vitaly
