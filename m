Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA3569488
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 23:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiGFVgD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 17:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiGFVgC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 17:36:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2747279
        for <linux-hyperv@vger.kernel.org>; Wed,  6 Jul 2022 14:36:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t3so2304379pfq.10
        for <linux-hyperv@vger.kernel.org>; Wed, 06 Jul 2022 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E//5ZA8uzfUdBafNOuQKisK6Qx4fv09+u0puRM54Yd4=;
        b=WYNY3+EZM7O23aAqdPFVrW/DUF8fqtHeku8lTPTokWqu4qo5ihKYdUaHcZWbwvv/uk
         8pSXVp4lrwvMkWw/I3pmkDXmnaHZGzkKLQfFWknorNkRdOAZ34z44bGUwMJFTFtav0az
         gm4V27G3TiZgAd6SfIrgB9fz0EOxM2PT3QKrjXYqlTNYE/nVNyiGONlx9/iQi7rRbONh
         /hlEJz3SBbw/A6hPaYmMguUx2TWyvJ5D43pCulKKsZ+mosv9JeeNvxWS8RbOy2/4uIVU
         gwHVRrlkgfaDmSmmD1HpaixNY4NrKhE4Mc0jzJ3HGiknRzhAmLsbIGxApWqP6xhzhjwU
         Sung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E//5ZA8uzfUdBafNOuQKisK6Qx4fv09+u0puRM54Yd4=;
        b=Rzevx84zraN5aRDjKzTiPLsyzVnPhb6QWAlhAKJ3kunUDFRihpyUEFtqLFVzqaH0vC
         AWcybHwas4TY0yyKrp1tTD6nAOvbXdFOh6c6P4XbGQpzV/lubei/smgygtSasfAPwhHt
         j+o5X+TALXukWXLzn815WbPUxQ5dGkIyVaij0Huq/TYPkze07n/HHr2jaUqyvB+t3f23
         Vwn3kq0Psk1a23u4BBh67QHwo0d+QMVMPs0S07ySUbngrSImYWTK3VpdGjUdU+g26gbv
         G57qrd/O1NbPs0PqV1LceDtnxRyfi2haV+7AzbbxOLuVbauXk4Wt3ucCQ+2s5I45P+Cz
         HOEQ==
X-Gm-Message-State: AJIora/2/TuALXhUYNE7QoMYg/C1CJFYqiwQIxlBObII2qiwIS7i8VFz
        71OvE5ju7+VQGGdJAlxqT/bsVA==
X-Google-Smtp-Source: AGRyM1vTi5E2bFkpKPPnm+ygtjra8noxOqMQi4yVuvfE/qj8l2tXrHYCvXKpy5UhaMgSliBROIV24A==
X-Received: by 2002:a05:6a00:80d:b0:525:520a:1736 with SMTP id m13-20020a056a00080d00b00525520a1736mr48216477pfk.36.1657143361099;
        Wed, 06 Jul 2022 14:36:01 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090a718100b001ef87123615sm7423406pjk.37.2022.07.06.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:36:00 -0700 (PDT)
Date:   Wed, 6 Jul 2022 21:35:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/28] KVM: nVMX: Introduce
 KVM_CAP_HYPERV_ENLIGHTENED_VMCS2
Message-ID: <YsYAPL1UUKJB3/MJ@google.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-7-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629150625.238286-7-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 29, 2022, Vitaly Kuznetsov wrote:
> Turns out Enlightened VMCS can gain new fields without version change
> and KVM_CAP_HYPERV_ENLIGHTENED_VMCS which KVM currently has cant's
> handle this reliably. In particular, just updating the current definition
> of eVMCSv1 with the new fields and adjusting the VMX MSR filtering will
> inevitably break live migration to older KVMs. Note: enabling eVMCS and
> setting VMX feature MSR can happen in any order.
> 
> Introduce a notion of KVM internal "Enlightened VMCS revision" and add
> a new capability allowing to add fields to Enlightened VMCS while keeping
> its version.

Bumping a "minor" version number in KVM is going to be a nightmare.  KVM is going
to be stuck "supporting" old revisions in perpetuity, and userspace will be forced
to keep track of which features are available with which arbitrary revision (is
that information even communicated to userspace?).

I think a more maintainable approach would be to expose the "filtered" VMX MSRs to
userspace, e.g. add KVM_GET_EVMCS_VMX_MSRS.  Then KVM just needs to document what
the "filters" are for KVM versions that don't support KVM_GET_EVMCS_VMX_MSRS.
KVM itself doesn't need to maintain version information because it's userspace's
responsibility to ensure that userspace doesn't try to migrate to a KVM that doesn't
support the desired feature set.

That also avoids messes like unnecessarily blocking migration from "incompatible"
revisions when running on hardware that doesn't even support the control.
