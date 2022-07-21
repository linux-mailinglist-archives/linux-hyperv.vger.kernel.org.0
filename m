Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22AA57D666
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Jul 2022 00:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiGUWAJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Jul 2022 18:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiGUWAI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Jul 2022 18:00:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8244A32E
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 15:00:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p8so3021384plq.13
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 15:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7gujx4/vn7+YQjww67d8XBsvreA1sJCQ6MzDAhjTGYE=;
        b=fuqsh1fdgWgyWIc3fyOeUlM0zge5cMl9ja2YPhfmZaLQUb4GzD/h/rXb4XU5wYi5gz
         emIaaSuEyLgh3bCaXJVJ/NFX0ntkQZnOtKlVYksiAGvxFLct8I91wYSSh3wvRVVUFJHO
         8Vj9F9FNB2ZcxFiPlFey/al8u/sSTFnSrTNkc3iXHEM0ZAaNjDfV0O3q3JpA0s9pyjWt
         oMD1/v0EyEu8iSCu63aJLtVvQy5qhW6Fi7afpnn5Bg8E2k35c5xxI7NRLkzj6ddOOGDN
         friI4hPRN++XZFhEe4saVRA+N8GcvRbmA4NLvfLVFfR7Ppy4g8XTu734gCXm+h3ZiGWs
         Wlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gujx4/vn7+YQjww67d8XBsvreA1sJCQ6MzDAhjTGYE=;
        b=LHDvIlDtaMCVeETPQtCtDZ6RQarnlAdMWbj0sCJPqWcbaFDIetvJz7wm8hX+0dga+M
         tEX/BfyxfirnYuBKeKDTWjhCvjDuny1FtMJ40ybqzyAegIiBGP4QNidBTWATn6uBi/Ng
         UkZCcr6C3MQP7lkvuRVhFXbb6StSSVVHjT0TpVKo2LLq1ACfaEM9PtMBtmPmqE0SGGz0
         8Cese4M3YfiFMvm6/N5hqtiOozT8V8ps2BHH85MVUQc4V5PVouzSXoI87PDUj2z8ADn4
         yRsIexPAd+kLpbd5lREF7nbLe5Bm3m2g1GzGT7c3XnpXAwqqwMULK3Ziebw9Pdb49aFx
         q4eQ==
X-Gm-Message-State: AJIora/KoeE9t6Xp0IrnvBDs+NMPFDPNVORYBKnPCx3j9faOHtpBE7EH
        2YAL+u9K7GY6JMNX/kL7QHe7ZA==
X-Google-Smtp-Source: AGRyM1sY/4JL0WvYhndZ87X4aQbb6i7KlSC28zRbWT8KnZlwPKrRh5hGkUHGV+oWANevxZgcFbtYWQ==
X-Received: by 2002:a17:903:11d2:b0:167:8a0f:8d33 with SMTP id q18-20020a17090311d200b001678a0f8d33mr509111plh.95.1658440804817;
        Thu, 21 Jul 2022 15:00:04 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id 82-20020a621455000000b0052bae7b2af8sm2243275pfu.201.2022.07.21.15.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:00:04 -0700 (PDT)
Date:   Thu, 21 Jul 2022 22:00:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/25] KVM: VMX: Check VM_ENTRY_IA32E_MODE in
 setup_vmcs_config()
Message-ID: <YtnMYNR9VCNOXRi5@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-13-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714091327.1085353-13-vkuznets@redhat.com>
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

On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
> VM_ENTRY_IA32E_MODE control is toggled dynamically by vmx_set_efer()
> and setup_vmcs_config() doesn't check its existence. On the contrary,
> nested_vmx_setup_ctls_msrs() doesn set it on x86_64. Add the missing
> check and filter the bit out in vmx_vmentry_ctrl().
> 
> No (real) functional change intended as all existing CPUs supporting
> long mode and VMX are supposed to have it.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
