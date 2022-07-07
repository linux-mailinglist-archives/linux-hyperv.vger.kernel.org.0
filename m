Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9677D569F08
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 12:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiGGKBx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 06:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiGGKBu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 06:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80ABD4F193
        for <linux-hyperv@vger.kernel.org>; Thu,  7 Jul 2022 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657188108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9SHQnAznbKnOLY1gPlD68a+aIhyQn9db0oXlbPnBHao=;
        b=WINJp48zrjyo753x0yDtcByq7BODpTl26B9R+JbFIyospqqlldJnd/cdUIzJE5LcJqcwrB
        +vRQOn/H2wvVJSgyOjMy7fzvYB32A7iJvI1XWVd229v6Ubl9lSj8rs6cBlOMNAnffXTQ5j
        OBASdwXQOGKDFzRKXzYB622vpbwFnDs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-qox9ExJyNTae2BHVQiYgWQ-1; Thu, 07 Jul 2022 06:01:47 -0400
X-MC-Unique: qox9ExJyNTae2BHVQiYgWQ-1
Received: by mail-ed1-f70.google.com with SMTP id h16-20020a05640250d000b00435bab1a7b4so13631871edb.10
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Jul 2022 03:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9SHQnAznbKnOLY1gPlD68a+aIhyQn9db0oXlbPnBHao=;
        b=rIfKI0Ax6bAmv1cgFoX6ClMupaDvZFMGhhpBC0LbDko+8ilj59td/OA/Va4cKEkOWn
         SA2Tm6AYyu13MNqy1/FefIX/eidIo5vUMGLG68XrJgqzhbOdB7oQBFqaswYrWisLZ1tT
         WgdKFKwjMKU0vki0p1XY48yR74vGsEBCvzIfkTFNh999LAVsjyGWqOPw865fSRmJ0pfr
         92zR7EMb3ihfZOjDlX3gwQKcamilLZPKPgQX+1froiXTTz7U9NJ2dywdcXRWHQ21i3Az
         o+PE8Sz+HmJu72z3D99X8QjxihEE80aZSjgNe1k+qspTAIzSTApq9NAPnYdBBzTl4lX0
         bpYA==
X-Gm-Message-State: AJIora/+lXPda+86ZxLNBTWVEH/4RHETjQVlVl8BiO4BJxi+wMqkxggt
        lZ1LeP3vXCNoVZbT7sfViuRvvk7X5UrNZ3G3SqMR7IJCol6/dfMlPCSxonjyv43Fcz4NR9wze/a
        GQ1csBG360aFJNqhVewJ+fA9t
X-Received: by 2002:a05:6402:2708:b0:435:da6f:3272 with SMTP id y8-20020a056402270800b00435da6f3272mr59104337edd.160.1657188106221;
        Thu, 07 Jul 2022 03:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sa9itQk8MCQrfGJDkX4tSlr0nI31PyKDn+oNYxgsM/K4ovlzMK3VkwUF9dZvJf9KNmR/8YVg==
X-Received: by 2002:a05:6402:2708:b0:435:da6f:3272 with SMTP id y8-20020a056402270800b00435da6f3272mr59104311edd.160.1657188106004;
        Thu, 07 Jul 2022 03:01:46 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o13-20020a170906768d00b0072af6d20a9asm2372836ejm.75.2022.07.07.03.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:01:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/28] KVM: VMX: Support TSC scaling with enlightened
 VMCS
In-Reply-To: <20220629150625.238286-9-vkuznets@redhat.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-9-vkuznets@redhat.com>
Date:   Thu, 07 Jul 2022 12:01:44 +0200
Message-ID: <87let5qm0n.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

...

>
> While on it, update the comment why VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL/
> VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL are kept filtered out

...

> + *	While GUEST_IA32_PERF_GLOBAL_CTRL and HOST_IA32_PERF_GLOBAL_CTRL
> + *	are present in eVMCSv1, Windows 11 still has issues booting when
> + *	VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL/VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL
> + *	are exposed to it, keep them filtered out.

Finally, I got a piece of information from Microsoft on what's going on
and it solves a lot of our problems. They did introduce a new PV feature
bit indicating support for these new fields in eVMCSv1 and Win11 checks
for its presence. This means that we do not need to play the 'eVMCS
revisions' trick as CPUID information from VMM is enough.

-- 
Vitaly

