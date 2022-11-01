Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1303614E3B
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Nov 2022 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiKAPVq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Nov 2022 11:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKAPVo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Nov 2022 11:21:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5B64C9
        for <linux-hyperv@vger.kernel.org>; Tue,  1 Nov 2022 08:21:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id io19so13851204plb.8
        for <linux-hyperv@vger.kernel.org>; Tue, 01 Nov 2022 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKUktzJobGLa4RUQqqtpc7jRFObyGQwxNLMmlvJ9T7U=;
        b=tEeFfuDw0iFt+XzU3fPPG4AkzSwbX8gsVkne9pwztUFj9h0+4nATAj6m8i6q4xqtHy
         cV0qNMYoxP//k85iWzb/xKkusd90kUxTnQd2Jv3X8Z3loUBChrq+wQsJwfgPc91FnW0c
         XKZy7g1Yf+K10H9tZxTAdefelWKUlCZmcjtOBZ2SUBWdR3loyXYJN+XujuTaKdWIRYmJ
         HxsHQB/5boPv0ZtRCFQRAHf6gvUgjT/lJ6hQ++/YNoY/9vrFHPTxrax0/NXdTTObo//U
         SmZ73+jVc/CaK3zbUmphdNzIP4c0xg3kZVxgJOWdfdwkvCxqagSjvBGAdvqlSAYt5sDf
         roNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKUktzJobGLa4RUQqqtpc7jRFObyGQwxNLMmlvJ9T7U=;
        b=t0s8IOIL2s1lkGt5TWfbjq2sWrecrSMGTpQ/eEErMolIpV397N7OAY+77qizVjCSQn
         PnPxGU1fLwmFssNQ7OsLtFwgOgNXIPC0TckxjYNEY/+58Yx8UMCFmQ6coEPscWatqgg6
         KhlBEWH1d9xufhhrz9/HL1ddd4eugg94Stg1ZRtzfiOev/ktazivaOOMnVP+palC/erN
         rQMAOql9xnt0xQXCq7k9O27A9TF/P1vWS//EsQDLCocxgP19T8Jz7iHbHtspYio9tqBl
         IhcR6B1o5viL/LWHIgz1O9Lz3wRtFS9gWTm4gPXOif7iXwYfvi286BpUoPySmxNXke+S
         O24Q==
X-Gm-Message-State: ACrzQf3FckalAw9jUEQQPYSSplf1yjvKaYrh2nxanZN3RRTw4Qt3leIM
        uxSAqUtRKowkE7z5kzuqyPJ4gQ==
X-Google-Smtp-Source: AMsMyM6Aqrf1p6UEVHlc5IuYLxVEQ2H86G925Unu5gi7LJGvfsJ2wxOYFr88XPRn6vtKFk8iFN+OkA==
X-Received: by 2002:a17:902:6bc5:b0:183:4bef:1b20 with SMTP id m5-20020a1709026bc500b001834bef1b20mr19658004plt.158.1667316102001;
        Tue, 01 Nov 2022 08:21:42 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902e1cd00b001754e086eb3sm6483576pla.302.2022.11.01.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 08:21:41 -0700 (PDT)
Date:   Tue, 1 Nov 2022 15:21:38 +0000
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
Subject: Re: [PATCH v13 44/48] KVM: selftests: Stuff RAX/RCX with 'safe'
 values in vmmcall()/vmcall()
Message-ID: <Y2E5gv8yY/r5J+i2@google.com>
References: <20221101145426.251680-1-vkuznets@redhat.com>
 <20221101145426.251680-45-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101145426.251680-45-vkuznets@redhat.com>
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
> vmmcall()/vmcall() are used to exit from L2 to L1 and no concrete hypercall
> ABI is currenty followed. With the introduction of Hyper-V L2 TLB flush
> it becomes (theoretically) possible that L0 will take responsibility for
> handling the call and no L1 exit will happen. Prevent this by stuffing RAX
> (KVM ABI) and RCX (Hyper-V ABI) with 'safe' values.
> 
> While on it, convert vmmcall() to 'static inline', make it setup stack
> frame and move to include/x86_64/svm_util.h.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
