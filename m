Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A3E459F6
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2019 12:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfFNKIF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 06:08:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36099 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfFNKIF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 06:08:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so1715129wmm.1
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Jun 2019 03:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rjUazryDHv7wuzJPfN35mvC+nqyi403EO56ab8UJ3vM=;
        b=OljZlxOA1XuVheV4cYQuLJ3xgvAodTkPab4K0zUuRYm9Q5tn4V5pflLjZDFoK8n3Ft
         uvkbIfY08caIua8WiaAJbgnaQGVr8rDHaqAe2HMqPUUYYGSPwn2l17J+byGxHpKH8hYT
         nuw2ecUQ6L2aUzJMNMffQM4grS/+6xvZKiGH6lcQDZwwdkSRr/scV9jCWz8qExa0uPQU
         rCb22aMbjoXuaG1ZwKLTJQ/lee/HeG4KW8LzMx6NIV7TkgYsWxqIKSKc2mO3Nfgj5BTN
         lPXUbOZfOOemUYcTTRPJGVEV7MqR1Nu35CtPphUiiehLmSFmBPvJjVOxdMzfS4MEk21Y
         6/Xg==
X-Gm-Message-State: APjAAAV4Y80Z8lxRenK3kao6mrxOpDglv9nEEBSBj5fISTub15sBxEAe
        Hqeuntk5ogQdvS4yFHa/6eL+9A==
X-Google-Smtp-Source: APXvYqzCWohsnjsTkpzB4opXNwIILIOK7t34ke5ERFVDtWha+QAnoaQQBbp73Yhj7uy5IC+qUKcSIQ==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr7451274wmb.19.1560506882990;
        Fri, 14 Jun 2019 03:08:02 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t7sm1683230wrn.52.2019.06.14.03.08.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 03:08:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
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
In-Reply-To: <20190614082807.GV3436@hirez.programming.kicks-ass.net>
References: <20190611212003.26382-1-dima@arista.com> <8736kff6q3.fsf@vitty.brq.redhat.com> <20190614082807.GV3436@hirez.programming.kicks-ass.net>
Date:   Fri, 14 Jun 2019 12:08:01 +0200
Message-ID: <877e9o7a4e.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> @@ -182,7 +182,7 @@ void set_hv_tscchange_cb(void (*cb)(void))
>  	struct hv_reenlightenment_control re_ctrl = {
>  		.vector = HYPERV_REENLIGHTENMENT_VECTOR,
>  		.enabled = 1,
> -		.target_vp = hv_vp_index[smp_processor_id()]
> +		.target_vp = hv_vp_index[raw_smp_processor_id()]
>  	};
>  	struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
>  

Yes, this should do, thanks! I'd also suggest to leave a comment like
	/* 
         * This function can get preemted and migrate to a different CPU
	 * but this doesn't matter. We just need to assign
	 * reenlightenment notification to some online CPU. In case this
         * CPU goes offline, hv_cpu_die() will re-assign it to some
 	 * other online CPU.
	 */
  
-- 
Vitaly
