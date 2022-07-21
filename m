Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB9357D6E2
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Jul 2022 00:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiGUWaT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Jul 2022 18:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiGUWaS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Jul 2022 18:30:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B8C2D1E2
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 15:30:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q16so2919176pgq.6
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DXbmVLSQ/kF6PAAfuZldRiLPfHWkw3KMuA2Cj4p5KCc=;
        b=gq7l1cK+W8oZFwCWYHkKKHapRWrJZsiH/EliM+zZ13wNhqSehiBcUBZw5XgleoWibP
         VYKByIf9+6UyxiAKHKNiSzpoUsM+a4l911b6k+Pfz/VK0TVCfOYAu/x3fuKKnV5Klyv2
         EgekyMc7wcSwbRzn6f7Uu5tNRDq2BvH/J3YXJ4Y0SbqHSlGJMBwqc6NB5b2tOalWGpn+
         UrfZaAznGUDo7UPqQS+xabwQXm1JiR/aEhytyvYde76khXg6u5kEX5aWnKMk6jvBeHNb
         1M5VdxFgdU6f5D/EkytEmavNsZi3Rnrm133ecB29iRoX2GOzE6VQh013NjV3Bqdw/jOS
         Su9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DXbmVLSQ/kF6PAAfuZldRiLPfHWkw3KMuA2Cj4p5KCc=;
        b=4PfoibTeR1j8WQhg7tDf5JGOmzpojnnyvOvMfNWLTXiZC4u9+BW6YbY9J9WgS3Sn0L
         ctiINsml0Kym3sgqdz1VTvoDwyp/gJJxq1vYSSPqkl2oQbJkm1pXY8N8mamhlEz1LSyp
         RIdLFBdX3f5upvJMayqnMuWjdkK0r4tRm2qzWgaEIS12vczhefbdswU1tPMlO+62Ps04
         gK72vis5+YkB5VoEh+/+DYbPm08Kg8uGB+zW9Q9X3NjMMbU11tF5Hmnfuzlh0d/uSAqD
         +eDCE8s5yMst6s2NRofL3FPH//1sDBnV9JVGuPPHoaNbeDssMpSxZGPj+WBwSsBpqQW1
         yoBg==
X-Gm-Message-State: AJIora8cEcoq1927lW64gALxSP+A/1p6SLNr447YYCY3mDezJSyvroFP
        p1rybOdxPx8SlBsu1FWbB0mkgg==
X-Google-Smtp-Source: AGRyM1uwTVH1mO8sOka50FJ8zNCt0zM/avdSqJaZ8jKo9PDLwXTxlupeYMDuwIh2AxGHwGUJ2PJDWQ==
X-Received: by 2002:a05:6a00:1a44:b0:52a:ecd5:bbef with SMTP id h4-20020a056a001a4400b0052aecd5bbefmr382535pfv.28.1658442616341;
        Thu, 21 Jul 2022 15:30:16 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id x75-20020a62864e000000b0052b9747e0d1sm2248424pfd.189.2022.07.21.15.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:30:15 -0700 (PDT)
Date:   Thu, 21 Jul 2022 22:30:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/25] KVM: VMX: Move
 CPU_BASED_CR8_{LOAD,STORE}_EXITING filtering out of setup_vmcs_config()
Message-ID: <YtnTc/L5u5AuUhYN@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-17-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714091327.1085353-17-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, move CPU_BASED_CR8_{LOAD,STORE}_EXITING filtering
> to vmx_exec_control().
> 
> No functional change intended.
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
