Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E98584850
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Jul 2022 00:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiG1WfP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Jul 2022 18:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiG1WfO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Jul 2022 18:35:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A37626A
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Jul 2022 15:35:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v18so2993322plo.8
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Jul 2022 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=QH1SswHogd2HYdm+DJGhURoSojlk/dCm4tDDpy+Plzc=;
        b=DWgbT7/SYnRGYxKp/73nM2bQFceSlVA3zb3AvExKGWdz6XwR3KqCuJ6tMopoNSTwhZ
         eRIWaAsjGsBzKoJLpgSXn/X1Rb5rYTvp96m87FPAX8pjQAaL0bAJ1a2qS2/XEY9sAUAG
         wlSocwL9FFsjh5l3rUCCSMbBEYKVHLaf7bLu91sxJBWbWynNrrpotygzZHJtHcGGTG5x
         REfu8SuEJ6iTKYLpB7DhRVq8pvy4lLMWQ8xsS196GMWGPWpwxR03Y8QbGeIuGrHFcSxE
         m8rLptXZeTOF/Y/UgNB1TgAHFr7LVURTKoVoEVeyvaCbVO37TsavGwXUMnetdD9CtNtp
         wD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=QH1SswHogd2HYdm+DJGhURoSojlk/dCm4tDDpy+Plzc=;
        b=sLQKIYZY+68cO0laziAmkBaUp/4C3vdLXkqBCjMiXkXFoVbJKZfRqLvCSP50RCH5hG
         Y9Qew1s5qO5ngg3g5EyJpWKVx+Bvn4wOrmroLckYnqGBHdFgNP0J7cTchbzMFIBmfkx8
         V9W3xUBaxJ2wkPmKzGnI5idqVCXHWiHxJILvvNyEsz1B6palLLn+u/CkFT4LiIcxhl5U
         Fvb6p/8HtuS4uVXCur832gJA9CW7Q1eOY6Ck7UxfUR8PZEnhn3qXGkjG+Gq+o4da9hLW
         i16cXbLo/nJSd/XaeU1e8CE7vw5/rBXgZk3QO6tZDBvolWIcTh2kr+P6Hl+HE+qrtFrG
         D/GQ==
X-Gm-Message-State: ACgBeo3g251oJXelaEnCnc/C8/DoPwRGiSJPsI5A3RmvFxJgn0CCT4H4
        uBEimzPEQeD3heukqHdzjgKNaA==
X-Google-Smtp-Source: AA6agR6XAn25lwoKn04LJu4ycH59kHbRg8DdCtEwqTycQaCiFYXeFkDEbZF8JhKF9qSbtzmZIYGbKA==
X-Received: by 2002:a17:902:d4c6:b0:16d:2f7f:9a71 with SMTP id o6-20020a170902d4c600b0016d2f7f9a71mr974863plg.36.1659047712638;
        Thu, 28 Jul 2022 15:35:12 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ix2-20020a170902f80200b0016c5306917fsm1883805plb.53.2022.07.28.15.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 15:35:11 -0700 (PDT)
Date:   Thu, 28 Jul 2022 22:35:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/25] KVM: VMX: nVMX: Support TSC scaling and
 PERF_GLOBAL_CTRL with enlightened VMCS
Message-ID: <YuMPHCanuPtYEN4j@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-10-vkuznets@redhat.com>
 <YtnMIkFI469Ub9vB@google.com>
 <48de7ea7-fc1a-6a83-3d6f-e04d26ea2f05@redhat.com>
 <Yt7ehL0HfR3b97FQ@google.com>
 <870d507d-a516-5601-4d21-2bfd571cf008@redhat.com>
 <YuMKBzeB2cE/NZ2K@google.com>
 <62ac29cb-3270-a810-bad1-3692da448016@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ac29cb-3270-a810-bad1-3692da448016@redhat.com>
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

On Fri, Jul 29, 2022, Paolo Bonzini wrote:
> On 7/29/22 00:13, Sean Christopherson wrote:
> > The only flaw in this is if KVM gets handed a CPUID model that enumerates support
> > for 2025 (or whenever the next update comes) but not 2022.  Hmm, though if Microsoft
> > defines each new "version" as a full superset, then even that theoretical bug goes
> > away.  I'm happy to be optimistic for once and give this a shot.  I definitely like
> > that it makes it easier to see the deltas between versions.
> 
> Okay, I have queued the series but I still haven't gone through all the
> comments.  So this will _not_ be in the 5.21 pull request.

I assume you meant 5.20?

> The first patch also needs a bit more thought to figure out the impact on
> userspace and whether we can consider syndbg niche enough to not care.
> 
> Paolo
> 
