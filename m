Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4B946BEF
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2019 23:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFNVgN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 17:36:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44448 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfFNVgN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 17:36:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so3919512wrl.11
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Jun 2019 14:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bCvKwbWJesvWCy0sKuZ4V0I/xR2OhzdiNEAy87dgHgM=;
        b=cFcc86w+JF+2raM+uZI0WreiFWqwjteiA0n/oMsCsXlDTmrYADNYmVu0ydS1Xh9CVs
         TMfan28owHKfgOjfJaLUPKFE+c9QoyaECITnFm4/1ykTjIKZAzC5+fjbRtX3X8wUuVpV
         2R0uopjCXJUxiTouYuNaU71aTJnRrA98s9urnpDe8CHP/MEGuaqs/p5Zi+sHfFkmsGDr
         NEccSEPPzHdfS2x3daFA+pnmlda1MDEeOGFXDJE0K6eswBgBHJbNTMntsMC6n5of2x5L
         5HoDw9okPKEaoyvzvdSzlmmJZuY/adS2OCtqHeGAoX+9EaGf2uUBdoWG23MQOe+VMvwA
         SA7w==
X-Gm-Message-State: APjAAAVj7YmGiv1967bL93fiOtsfYocpQsXuTk+WWtOX8DPBaUOUa8Bz
        3lsF55S9Ck+a1Fx5ZQvRCMSJXQ==
X-Google-Smtp-Source: APXvYqyaz9SMMAfY94vjBsF6aHQAfX+3a3A9OUyl0nhTjKgPhD32zJqRx7RQJvJahMVOLtJk25eU4Q==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr3847025wrt.337.1560548171165;
        Fri, 14 Jun 2019 14:36:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-78-102-201-117.net.upcbroadband.cz. [78.102.201.117])
        by smtp.gmail.com with ESMTPSA id y6sm2905993wma.6.2019.06.14.14.36.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 14:36:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dmitry Safonov <dima@arista.com>,
        Peter Zijlstra <peterz@infradead.org>
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
        linux-hyperv@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/hyperv: Disable preemption while setting reenlightenment vector
In-Reply-To: <cb9e1645-98c2-4341-d6da-4effa4f57fb1@arista.com>
References: <20190611212003.26382-1-dima@arista.com> <8736kff6q3.fsf@vitty.brq.redhat.com> <20190614082807.GV3436@hirez.programming.kicks-ass.net> <877e9o7a4e.fsf@vitty.brq.redhat.com> <cb9e1645-98c2-4341-d6da-4effa4f57fb1@arista.com>
Date:   Fri, 14 Jun 2019 23:36:09 +0200
Message-ID: <87sgsb6e9i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dmitry Safonov <dima@arista.com> writes:

> On 6/14/19 11:08 AM, Vitaly Kuznetsov wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> 
>>> @@ -182,7 +182,7 @@ void set_hv_tscchange_cb(void (*cb)(void))
>>>  	struct hv_reenlightenment_control re_ctrl = {
>>>  		.vector = HYPERV_REENLIGHTENMENT_VECTOR,
>>>  		.enabled = 1,
>>> -		.target_vp = hv_vp_index[smp_processor_id()]
>>> +		.target_vp = hv_vp_index[raw_smp_processor_id()]
>>>  	};
>>>  	struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
>>>  
>> 
>> Yes, this should do, thanks! I'd also suggest to leave a comment like
>> 	/* 
>>          * This function can get preemted and migrate to a different CPU
>> 	 * but this doesn't matter. We just need to assign
>> 	 * reenlightenment notification to some online CPU. In case this
>>          * CPU goes offline, hv_cpu_die() will re-assign it to some
>>  	 * other online CPU.
>> 	 */
>
> What if the cpu goes down just before wrmsrl()?
> I mean, hv_cpu_die() will reassign another cpu, but this thread will be
> resumed on some other cpu and will write cpu number which is at that
> moment already down?
>

Right you are, we need to guarantee wrmsr() happens before the CPU gets
a chance to go offline: we don't save the cpu number anywhere, we just
read it with rdmsr() in hv_cpu_die().

>
> And I presume it's guaranteed that during hv_cpu_die() no other cpu may
> go down:
> :	new_cpu = cpumask_any_but(cpu_online_mask, cpu);
> :	re_ctrl.target_vp = hv_vp_index[new_cpu];
> :	wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));

I *think* I got convinced that CPUs don't go offline simultaneously when
I was writing this.

-- 
Vitaly
