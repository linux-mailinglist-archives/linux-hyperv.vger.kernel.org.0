Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC861361BE1
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhDPIkj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 04:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232442AbhDPIkh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 04:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618562413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/21KtrUJDrIPwXoawNEtFcajhDHUfFH4h+ED/BPh0I=;
        b=LoZq+lV/09ar6eica9yMXDuMH/+9B+zCQTn1sqsb4/jV03Rw+1wTcRl8KQX8eg5jOK5w4+
        m5Sw0rDm1lXvrwMP6UylGOPtNbMIRWWzACdE5D4XKKe4OA84LlGgBqG/kYcndsSI7onnFk
        RATNhrrysMUtQ6yN7IRHYclHAWMZCwQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-sGJzQwSPMJaetOoajY00VA-1; Fri, 16 Apr 2021 04:40:11 -0400
X-MC-Unique: sGJzQwSPMJaetOoajY00VA-1
Received: by mail-ed1-f72.google.com with SMTP id s4-20020a0564021644b0290384e9a246a7so2995948edx.7
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Apr 2021 01:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E/21KtrUJDrIPwXoawNEtFcajhDHUfFH4h+ED/BPh0I=;
        b=TsOIZRxEmwY5LhIwKuCdKKKIColBAHot5ttfSIHc9eKKB2qXC3+hRUpzR8VA5d74Cx
         5w5bo9C8nno6ZiAZkUF6pTAXu2bNBuNJkYsnP8fNbCbp+iSEXvFS87iyAd+JBz7wKOOD
         zqhqqaqZJBRMnGh+iAbRsk/CaadwBM1Gg1ZR3L/e1nT6T18bbmkCVkIM3dPcd6DAbkJc
         yzEes/RHiOSF1Mt6Ra3WuXHt2ntyV/Y6dV/m/06GR7rkmtW9kqGsLgZhB2R6u9D1qjNI
         ssEndisLXY09L7SLErV5dmhkv3SiKnXg5aSCEpObGWIlmuSiNnF1cgjCg7kI5xYkPcHB
         tzpg==
X-Gm-Message-State: AOAM533CFGKdszvVhuhC22jKhoXGyJtjDTV43N8405cAytOftFpw9UZ/
        aVsoRfZL10CE/XAmiodvyWi6pvMSOSDSHYE7xRIcgTIvHQfu9HNV8BFuWQfI4LLxO71lsHgreq1
        mkNsYILBbkWEkCgjlcaq490zc
X-Received: by 2002:a17:906:2596:: with SMTP id m22mr7477040ejb.175.1618562410232;
        Fri, 16 Apr 2021 01:40:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzNJnhs14GfiKHmwxiwSXkMkIYSx3t9HmyGiPAFsuoDS423ZgZVJAbSWmQrlHtBpNbXS2xKA==
X-Received: by 2002:a17:906:2596:: with SMTP id m22mr7477008ejb.175.1618562410070;
        Fri, 16 Apr 2021 01:40:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id b14sm4764203edx.39.2021.04.16.01.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:40:09 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] KVM: x86: hyper-v: Move the remote TLB flush logic
 out of vmx
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
References: <cover.1618492553.git.viremana@linux.microsoft.com>
 <92207433d0784e123347caaa955c04fbec51eaa7.1618492553.git.viremana@linux.microsoft.com>
 <87y2di7hiz.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a83b571-5c19-603e-193f-666b99a96461@redhat.com>
Date:   Fri, 16 Apr 2021 10:40:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87y2di7hiz.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 16/04/21 10:36, Vitaly Kuznetsov wrote:
> - Create a dedicated set of files, e.g. 'kvmonhyperv.[ch]' (I also
> thought about 'hyperv_host.[ch]' but then I realized it's equally
> misleading as one can read this as 'KVM is acting as Hyper-V host').
> 
> Personally, I'd vote for the later. Besides eliminating confusion, the
> benefit of having dedicated files is that we can avoid compiling them
> completely when !IS_ENABLED(CONFIG_HYPERV) (#ifdefs in C are ugly).

Indeed.  For the file, kvm-on-hv.[ch] can do.

Paolo

