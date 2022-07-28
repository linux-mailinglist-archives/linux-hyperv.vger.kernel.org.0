Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B647658484D
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Jul 2022 00:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiG1Weg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Jul 2022 18:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiG1Wef (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Jul 2022 18:34:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F33300
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Jul 2022 15:34:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c3so3086923pfb.13
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Jul 2022 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=LrHI82LSXzp9pNpBD5ijC+/gCGzJ+2cZU7BBLUbMNMU=;
        b=R4gkn8nTl8jEBMhK8iC0ES4IT6hATO9Vy4XF0CtygB03gu0CzNlgYZhwVabnguB1KU
         5SotJZEU4PRa2hg3foklk7gKPZ0WqWdRo2FTKd//zPqyMbKvarqN04zr+PQee0IDhwGX
         nlgknGblYAreX8TOmKn2sGIP/r5DQgWW6ntB0+BP0pvhRhtvmOJP7jFl3HQfp8w66Zd2
         yjcVj7T3sq9BxIPHLauwDiuAF8E4SoKdnUcG0D8sdWx86wTn2bl2nrPB88dLodw4R2ns
         REoDYTtki3YqgqG74IK9Nt/sV5T7nARTeVeI29B8q9mKkhFlltYHmibRdufbovXmf7AR
         CnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LrHI82LSXzp9pNpBD5ijC+/gCGzJ+2cZU7BBLUbMNMU=;
        b=GubLzlH6/zs1VvyqWddr82ayP8ZgwK08/+LJftt0t9z8miHo+o+6WEnUYOnRUboqtW
         T0gGe4egJOKd4erHBbRGPMWc9tvLxsACaQ/o4H3G/51LusIudIK8x7MpTIWHofcx0Yeb
         rRUD3Gjs4psCWD1/xSCMYzgyRk4+P7nOtTneqp+RB3XhXJuPjP160kRO42xorMlvLY0S
         gS0r6W6eSmacGxATojGIr1FGuk+QRbdoaD6Kjtp8hvoFJc0BikLEBG0UiPVAH0SO07Tu
         TUTC6HK2XHs+qejvAOAuqOZJYLbtbtD3wioFRbmMNXyOX7RYJzyUF5cFzJdIgmmIXGyn
         1KaA==
X-Gm-Message-State: AJIora9PGMooBUCD2U3G+nguyJgA3pm+dSEdysdR8yaLXb+c3Pot+qR0
        Z1aXaJSrzra5n5HnU3JZmDQ3og==
X-Google-Smtp-Source: AGRyM1ubhwyn/xqg+UTiJSkQ9gc8ORwXG+IoPnqnzKxE3TKzYjb0b0qtNqodFWxpcf73RpEMbMmJ6w==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:630e with SMTP id b12-20020a056a00114c00b005282c7a630emr658731pfm.86.1659047670900;
        Thu, 28 Jul 2022 15:34:30 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g18-20020a63fa52000000b0041a13b1d451sm1406553pgk.59.2022.07.28.15.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 15:34:30 -0700 (PDT)
Date:   Thu, 28 Jul 2022 22:34:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 21/25] KVM: VMX: Move LOAD_IA32_PERF_GLOBAL_CTRL
 errata handling out of setup_vmcs_config()
Message-ID: <YuMO8janLYtdWXth@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-22-vkuznets@redhat.com>
 <YtnZmCutdd5tpUmz@google.com>
 <2e60bd73-e4da-eb4e-4eae-e43be7fd5bcd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e60bd73-e4da-eb4e-4eae-e43be7fd5bcd@redhat.com>
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
> On 7/22/22 00:56, Sean Christopherson wrote:
> > Except the errata are based on FMS and the FMS exposed to the L1 hypervisor may
> > not be the real FMS.
> > 
> > But that's moot, because they_should_  be fully emulated by KVM anyways; KVM
> > runs L2 with a MSR value modified by perf, not the raw MSR value requested by L1.
> > 
> > Of course KVM screws things up and fails to clear the flag in entry controls...
> > All exit controls are emulated so at least KVM gets those right.
> 
> Can you send this as a separate patch?

Will do.
