Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F68B614EDF
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Nov 2022 17:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKAQLi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Nov 2022 12:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKAQLh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Nov 2022 12:11:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EE1C427
        for <linux-hyperv@vger.kernel.org>; Tue,  1 Nov 2022 09:11:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso13297740pjc.5
        for <linux-hyperv@vger.kernel.org>; Tue, 01 Nov 2022 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ITgL/aRZdkahYdq9DTxD5baxb+nL5G3z8cZ8xPGuJc=;
        b=CJ1VxDqaf9Mq8KLKTU/A+QxYzNu53X1nM+wAZlnLPjc1gho4lLM4XUpMehJM8DDm9F
         aW00iOdhxiGW/G28foJ25h0vdG7TBPH6KAdX8fdpsqb2bD3IgayOFRCs5ZIoelEcgT1C
         XvOrrWfcD82H3afoXY//lnlo9QBdlhdOsIfJNVCUewtcR9qTQw9axCGJvgBTelMZWcGW
         H8bfCyRh+7bFR9df4dkhsUrzEtJXR/ICnPgcycpyMfT46X2/4+X6m2oAtZshlYMJQani
         t4cfscIJ4KL6kstTrsWtdlqxy+UEhF5SgTLwrAYqjp8J3oVoyczJZ1Qded2Zmtv0b//0
         Fpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ITgL/aRZdkahYdq9DTxD5baxb+nL5G3z8cZ8xPGuJc=;
        b=xzREYNFyvdWGMp6+mPLQODD+u1krEfpryMtf/Lb2Vf5m6EOYk8AgW6riOayE4TvW7/
         o385ViIDDohc/3d5PJz/Z5gVAqy0rgTw8n3fk2OrP6HyNyRG1G16sPeduLC2qUydZzxn
         af6kbfOs4nwArH01U8yE74MbTHQCTosnPRkdSw0UQMw4WpbnrWFD1bWp+jd2b3yjC99s
         vnRFfMGFrEvIsLLlkX/H1LDOowXMCGaJRw/aTW0f0GlZdSdJPMFs1kzmtNFVScR0S+Pv
         DfknV5FUsD8wWkVr35SDzAaD5jVBDIrIyt1YvrPk10fadCk2Bc11teNwbM1bDpCSf4I7
         Fj5A==
X-Gm-Message-State: ACrzQf01emSFo7epHEypxtRoDoY0dxYyxaA1LvTxY9YRReVcG5UVPi3s
        wjRyyM55uzTpXVyMutoM6EJPrA==
X-Google-Smtp-Source: AMsMyM7B/QtilNm+zs8uSvatkt1ja+6hcaCbfnjwiz6Hx3546KbbHK5koU/ojF7ynJ84zmCv+/PO5A==
X-Received: by 2002:a17:90a:8a16:b0:213:bc0c:74cd with SMTP id w22-20020a17090a8a1600b00213bc0c74cdmr16564783pjn.28.1667319096284;
        Tue, 01 Nov 2022 09:11:36 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x14-20020a62860e000000b0056c349f5c73sm6709027pfd.132.2022.11.01.09.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:11:35 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:11:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 45/48] KVM: selftests: Introduce rdmsr_from_l2() and
 use it for MSR-Bitmap tests
Message-ID: <Y2FFNO3Bu9Z3LtCW@google.com>
References: <20221101145426.251680-1-vkuznets@redhat.com>
 <20221101145426.251680-46-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101145426.251680-46-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 01, 2022, Vitaly Kuznetsov wrote:
> Hyper-V MSR-Bitmap tests do RDMSR from L2 to exit to L1. While 'evmcs_test'
> correctly clobbers all GPRs (which are not preserved), 'hyperv_svm_test'
> does not. Introduce and use common rdmsr_from_l2() to avoid code
> duplication and remove hardcoding of MSRs.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  .../selftests/kvm/include/x86_64/processor.h  |  9 +++++++
>  .../testing/selftests/kvm/x86_64/evmcs_test.c | 24 ++++---------------
>  .../selftests/kvm/x86_64/hyperv_svm_test.c    |  8 +++----
>  3 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index fbaf0b6cec4b..a14b7e4ea7c4 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -520,6 +520,15 @@ static inline void cpu_relax(void)
>  		"hlt\n"	\
>  		)
>  
> +/* Exit to L1 from L2 with RDMSR instruction */
> +static inline void rdmsr_from_l2(uint32_t msr)

I would prefer keeping this helper out of common x86-64 code, even if it means
duplicating code across multiple Hyper-V tests until the L1 VM-Enter/VM-Exit
sequences get cleaned up.  The name is misleading, e.g. it doesn't really read
the MSR since there are no outputs, and while we could obviously fix that with a
rename or a generic DO_VMEXIT_FROM_L2() macro, I would rather fix the underlying
problem of the world switches clobbering L2 state.  That way all the helpers that
exist for L1 can be used verbatim for L2 instead of needing dedicated helpers for
every instruction that is used to trigger a VM-Exit.
