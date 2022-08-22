Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C007659C3D2
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Aug 2022 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiHVQNc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Aug 2022 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiHVQNX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Aug 2022 12:13:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB20ABC8E
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Aug 2022 09:13:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo14443582pjd.3
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Aug 2022 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=UvJx9+FEYI5OIrLAKKjR26v13dLPxbliBeR/lXbsskg=;
        b=DNpb3tFZCML7MqYbpRmaxEdD+a52S8g/qpeXjiKWkZLUrtrh4A6rseWJ0IIDGmbl2a
         sFdNSXz4liV6aRpQP2daQXAoZG3fHTHJWJ86CcWSanH/lD28ibkbSJTJ/85BfeKVh9wa
         /iWoYBBtT/X/Q6awAfhOldx8FwIsFEhJJroD0rjdScBX+C1SA+jubGHvoVY5F17KINRK
         urXSFuDh6YKiFbAq4R7u0gPBVVtAFygkaM4ouIOyIjdBIHfntIbbEeZdVahUd2l/1oyK
         D3L5DKjSpdhUbV5R8Qacb7bX4enX/2gMlyPM9N7CJx1MyDkpRJLBXryHCHc+kCDzPUqd
         3jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UvJx9+FEYI5OIrLAKKjR26v13dLPxbliBeR/lXbsskg=;
        b=ewpTiCtidg2d2idQ5Dwg+69c7EM1Gx3IgyaFL6DK52Oonmrqru/klqxwYIm/k6FDab
         679x47jiSZItWCtDU9h0FD1Xw40UmGf5iIKv6qAEcFDziSs5Hnar8B+qB3zK/TDfYA/p
         C4MaaJyjwnepSl3RXVCKbkYbFEiyuTQuUF6YbM1qDqaQy/Alw7Zt920MYGQQtsX3pYi+
         nIM9R71cs5IJUrwcvbYElx3StEADS7Y5Ziiio36WqcoGr3Yi3RBoAUThz1ygsipgJDR/
         938kSO1kKwW7J+1cLbr2Xx2gY80hUrk1yza502PEDS4iEyqDmA2Ri6XLL3OMaQdRwMMG
         aDnw==
X-Gm-Message-State: ACgBeo1wdxH0J0NGoVzCfwz9ASFty6sR3ekSbXl9Q/QZV2SRPad35aLJ
        UbHEWEQEf9o87KZ5atQRKdRvAw==
X-Google-Smtp-Source: AA6agR5O3f2KBXdwaPcI9TqoK/2TMHHcLKZEqJUKozItOTNCtDb1pJs78mwUAlxyD8P7U4366S1lPw==
X-Received: by 2002:a17:90a:ab14:b0:1fa:b97f:c28b with SMTP id m20-20020a17090aab1400b001fab97fc28bmr23897669pjq.71.1661184800329;
        Mon, 22 Aug 2022 09:13:20 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902bccc00b0016db7f49cc2sm8540708pls.115.2022.08.22.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 09:13:19 -0700 (PDT)
Date:   Mon, 22 Aug 2022 16:13:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/26] x86/hyperv: Update 'struct hv_enlightened_vmcs'
 definition
Message-ID: <YwOrG3W3zAZ7VNJu@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-4-vkuznets@redhat.com>
 <Yv5ZFgztDHzzIQJ+@google.com>
 <875yiptvsc.fsf@redhat.com>
 <Yv59dZwP6rNUtsrn@google.com>
 <87czcsskkj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czcsskkj.fsf@redhat.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 22, 2022, Vitaly Kuznetsov wrote:
> So I reached out to Microsoft and their answer was that for all these new
> eVMCS fields (including *PerfGlobalCtrl) observing architectural VMX
> MSRs should be enough. *PerfGlobalCtrl case is special because of Win11
> bug (if we expose the feature in VMX feature MSRs but don't set
> CPUID.0x4000000A.EBX BIT(0) it just doesn't boot).

Does this mean that KVM-on-HyperV needs to avoid using the PERF_GLOBAL_CTRL fields
when the bit is not set?
