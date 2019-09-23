Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B0ABB9E2
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Sep 2019 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390629AbfIWQsa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Sep 2019 12:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387922AbfIWQsa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Sep 2019 12:48:30 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 342814E938
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Sep 2019 16:48:30 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id o188so6980172wmo.5
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Sep 2019 09:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tZRb6baOmGI150lVZ1gc8cSyiavau4pWVjiukU4sc/o=;
        b=Pslew4gwdRH6L/9Iiq++z8sK4Kpp4cO2bcEZ97aZqgOotuyJp0QSf3PYAuXMnkzNyk
         1dbvuR2i77r8F33C/3+/x0kVipcMHyqqXQKmIlBSKd7WiyW3xkxlFuytva5x4EayjvRm
         YF+9pF42nJbscJzyvUNMnYUbJ+qqsDP2fukAmKw9bvK1ePHBItk3K11S7dvGRVa/7irL
         8J5Jjx0KiHjMwMFfk6wpYGATqcamIybflxM07373TRKSggMNMaQJYYzb/dc1RBXMQvOt
         tITqFxmOd3GX9BiuG2qP6r3AFq/JwFOTjusGfOJd1o+lXiESKFGJMltjamNeh3YpEdVS
         S/Ng==
X-Gm-Message-State: APjAAAX152n6+FV7VlRbJcy2ACvRuYrrMvdQVGhc3rdH2wj0eIOLvin5
        Eb6mx0Q4Z06jdPkNXX05/J1AIh1fD5H6Tvs+Ixu8sBhQ+EWriD3yrhF3GtHZXLuT/1KBnjylaZ0
        sU7Xky9PaRUZRrXobKn70BYyv
X-Received: by 2002:a1c:5fd6:: with SMTP id t205mr435304wmb.124.1569257308762;
        Mon, 23 Sep 2019 09:48:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwKleoftvyPkeoDX6aFTInlvLMkcvJSxl8ouKtBOQtpSvrSkEsMlpES5OZY/GzkKzpGkare/g==
X-Received: by 2002:a1c:5fd6:: with SMTP id t205mr435269wmb.124.1569257308463;
        Mon, 23 Sep 2019 09:48:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id m62sm16138307wmm.35.2019.09.23.09.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:48:27 -0700 (PDT)
Subject: Re: [PATCH 2/3] KVM: x86: hyper-v: set NoNonArchitecturalCoreSharing
 CPUID bit when SMT is impossible
To:     Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, x86@kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
References: <20190916162258.6528-1-vkuznets@redhat.com>
 <20190916162258.6528-3-vkuznets@redhat.com>
 <20190923153713.GF2369@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <06687f31-0941-46ad-e05c-cb3cfe211051@redhat.com>
Date:   Mon, 23 Sep 2019 18:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923153713.GF2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 23/09/19 17:37, Peter Zijlstra wrote:
>> This patch reports NoNonArchitecturalCoreSharing bit in to userspace in the
>> first case. The second case is outside of KVM's domain of responsibility
>> (as vCPU pinning is actually done by someone who manages KVM's userspace -
>> e.g. libvirt pinning QEMU threads).
> This is purely about guest<->guest MDS, right? Ie. not worse than actual
> hardware.

Even within the same guest.  If vCPU 1 is on virtual core 1 and vCPU 2
is on virtual core 2, but they can share the same physical core, core
scheduling in the guest can do nothing about it.

Paolo
