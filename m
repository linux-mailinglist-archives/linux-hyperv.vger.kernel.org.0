Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2618599B
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Mar 2020 04:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgCODQC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 14 Mar 2020 23:16:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33787 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbgCODQC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 14 Mar 2020 23:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584242161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a97+Df7ov789sy1dUrQf2ip/rUJBLWnpFYIx0FFhbAY=;
        b=KNThzAY99ieQka1vAaq/RJqpHFfAZeu5Il0TSMg0tPAciNqyJF4a/LbDKEgUB7FSOUmkjG
        GIb6+syQLBpPHFH/ZJ+v5Bppn3G2GN95p8g3uqkeRCaD+RH1NgnlpTEd+0pc+cOh0qSn2J
        +GrCFfEFAyCINFmkxjw0gYd9AZiWGgg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-C1F79mkmO7G8vasiZA-FQA-1; Sat, 14 Mar 2020 07:14:16 -0400
X-MC-Unique: C1F79mkmO7G8vasiZA-FQA-1
Received: by mail-wr1-f72.google.com with SMTP id 94so1115028wrr.3
        for <linux-hyperv@vger.kernel.org>; Sat, 14 Mar 2020 04:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a97+Df7ov789sy1dUrQf2ip/rUJBLWnpFYIx0FFhbAY=;
        b=uaF7C5H0/YDffGKFlbw2XOlmQfP9N83oAHGVuxq4mJ+8tNsohGKonzNWt71xbb7DAo
         3ueLC3UjT/MmxgiKksITF+QouksWVJ2UDzeyPD7e3UNMISpQimY1CvCIYuYs2xxgXid1
         oqza+ZYkD3Wi9pCpCTUiBBRaXg+dFgPLU5kJwH86ny/TL4SKI3bTW6CIJhSqoLD+D35f
         /juHRbSuTw2Q4ZrOTNkVr5OAtNR5jBXb3Ca+Oi5kTd0AhjM2aCeOEB24L8RyY+0M9Hnw
         m7ScLtxVtU5hTCdXdM+CR6335iJ8rV6LWwf+Hz6FV/5igmm4zxHX3N38Pzr6k6TFVJXV
         MI/g==
X-Gm-Message-State: ANhLgQ2RyvwNQ+uJ0qOX8UP8ZXL//DIkYrle3drT42tKrtEBxGG2Tqmj
        r1QlLeXpysUR5EGofeu38MwUR/3ZohFC4mnttBoY8K8DTYb73koJ67sw5qFxXsEBxTTyIBeI6s7
        zG40A/e4omYtzoMd1bBW91JoN
X-Received: by 2002:a5d:4c47:: with SMTP id n7mr6703131wrt.254.1584184455377;
        Sat, 14 Mar 2020 04:14:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vspYTZUq3KJfifWUW/XTOvXTc1qsx25s1jBEUFu51U/OrTqfY6pI8+7wYMFcbRRtzK8nl0a/A==
X-Received: by 2002:a5d:4c47:: with SMTP id n7mr6703105wrt.254.1584184455082;
        Sat, 14 Mar 2020 04:14:15 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.174.5])
        by smtp.gmail.com with ESMTPSA id n4sm5329135wrs.64.2020.03.14.04.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 04:14:14 -0700 (PDT)
Subject: Re: [PATCH v8 0/5] Add a unified parameter "nopvspin"
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
        peterz@infradead.org
Cc:     mingo@redhat.com, bp@alien8.de, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, will@kernel.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
References: <1571829384-5309-1-git-send-email-zhenzhong.duan@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e31f932b-9838-09a7-49d4-f90dc673960c@redhat.com>
Date:   Sat, 14 Mar 2020 12:14:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1571829384-5309-1-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Peter/Thomas, can you apply this to tip or give your Acked-by?

Thanks,

Paolo

On 23/10/19 13:16, Zhenzhong Duan wrote:
> There are cases folks want to disable spinlock optimization for
> debug/test purpose. Xen and hyperv already have parameters "xen_nopvspin"
> and "hv_nopvspin" to support that, but kvm doesn't.
> 
> The first patch adds that feature to KVM guest with "nopvspin".
> 
> For compatibility reason original parameters "xen_nopvspin" and
> "hv_nopvspin" are retained and marked obsolete.
> 
> v8:
> PATCH2: use 'kvm-guest' instead of 'kvm_guest'        [Sean Christopherson]
> PATCH3: add a comment to explain missed 'return'      [Sean Christopherson]
> 
> v7:
> PATCH3: update comment and use goto, add RB              [Vitaly Kuznetsov]
> 
> v6:
> PATCH1: add Reviewed-by                                  [Vitaly Kuznetsov]
> PATCH2: change 'pv' to 'PV', add Reviewed-by             [Vitaly Kuznetsov]
> PATCH3: refactor 'if' branch in kvm_spinlock_init()      [Vitaly Kuznetsov]
> 
> v5:
> PATCH1: new patch to revert a currently unnecessory commit,
>         code is simpler a bit after that change.         [Boris Ostrovsky]
> PATCH3: fold 'if' statement,add comments on virt_spin_lock_key,
>         reorder with PATCH2 to better reflect dependency                               
> PATCH4: fold 'if' statement, add Reviewed-by             [Boris Ostrovsky]
> PATCH5: add Reviewed-by                                  [Michael Kelley]
> 
> v4:
> PATCH1: use variable name nopvspin instead of pvspin and
>         defined it as __initdata, changed print message,
>         updated patch description                     [Sean Christopherson]
> PATCH2: remove Suggested-by, use "kvm-guest:" prefix  [Sean Christopherson]
> PATCH3: make variable nopvsin and xen_pvspin coexist
>         remove Reviewed-by due to code change         [Sean Christopherson]
> PATCH4: make variable nopvsin and hv_pvspin coexist   [Sean Christopherson]
> 
> v3:
> PATCH2: Fix indentation
> 
> v2:
> PATCH1: pick the print code change into separate PATCH2,
>         updated patch description             [Vitaly Kuznetsov]
> PATCH2: new patch with print code change      [Vitaly Kuznetsov]
> PATCH3: add Reviewed-by                       [Juergen Gross]
> 
> Zhenzhong Duan (5):
>   Revert "KVM: X86: Fix setup the virt_spin_lock_key before static key
>     get initialized"
>   x86/kvm: Change print code to use pr_*() format
>   x86/kvm: Add "nopvspin" parameter to disable PV spinlocks
>   xen: Mark "xen_nopvspin" parameter obsolete
>   x86/hyperv: Mark "hv_nopvspin" parameter obsolete
> 
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++-
>  arch/x86/hyperv/hv_spinlock.c                   |  4 ++
>  arch/x86/include/asm/qspinlock.h                |  1 +
>  arch/x86/kernel/kvm.c                           | 79 ++++++++++++++++---------
>  arch/x86/xen/spinlock.c                         |  4 +-
>  kernel/locking/qspinlock.c                      |  7 +++
>  6 files changed, 76 insertions(+), 33 deletions(-)
> 

