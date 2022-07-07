Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC65569F03
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 12:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiGGJ6r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiGGJ6p (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 05:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12A664D4FF
        for <linux-hyperv@vger.kernel.org>; Thu,  7 Jul 2022 02:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657187922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHwrl27E0EeeOGu38G3zOF3hR+C+aXkp6gH0jh13XhA=;
        b=V5gK9hXBTBSNtSad98p9y92PFF2QuMdltWBFQsFv/EHOorhmEEbOGCoZadHSI07jadxVpp
        TOzH9bT+FotQQgZZbuNVaFtWsoDi/uDwzckt7fPAoSy74ST4E0BmHOheBZzeWiU6/j6zHI
        WxAOKBVvQ6clpb5Fxave9oG4S57y42o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-l7rtE4MTP623EIRKL0EphA-1; Thu, 07 Jul 2022 05:58:41 -0400
X-MC-Unique: l7rtE4MTP623EIRKL0EphA-1
Received: by mail-ed1-f70.google.com with SMTP id m20-20020a056402431400b0043a699cdd6eso7752152edc.9
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Jul 2022 02:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cHwrl27E0EeeOGu38G3zOF3hR+C+aXkp6gH0jh13XhA=;
        b=2Hqx9stBu/Xc6hvJC3+AnnTB/90ep5qUo4Lthi50M1PAEsCLrb2f1CgeBLSSF4W3Hw
         OEFUhIF7P5DbZvobSjtopnhmFgHeCGM03qWwxKkpwdeGjOHQdt1s8iNPf9rngALAxHfG
         xyGZo6UQKdoSJUmfdcFDnzaRH25QjSJyrGPPp3NP9b6umfwsyu5dqMnSZPBKz0pM5A6H
         DxNzh43bhsng4ZTOv6qBPohUUHNvOlzrABCYE3eiu04GOMOj7Dck45Y8CgJCwoWfujaX
         MKnog58ZGBMq7ZYso1QhXOnk6qw6OX/Wl1lHJZsYa26dMIejnaI7w6pftlsBo8FVn6D/
         147g==
X-Gm-Message-State: AJIora/7rLWoshtQ42emTeWsSaXP7gE+uf1lS+5IgAiDSgvft7fo9BXH
        3EBOYVMPFbB00NrFiSjpI+Wbd2VPI++bBCzfMw0bvzmr6LYBTqo6PsalIjAIC34+U2Og8JS0/jT
        gGcficu8mIDcP64UXIHk/vwAR
X-Received: by 2002:a17:907:a07c:b0:72a:b390:ee8a with SMTP id ia28-20020a170907a07c00b0072ab390ee8amr24435275ejc.96.1657187920449;
        Thu, 07 Jul 2022 02:58:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLN8nFMmLxs9+8R8k/ZJmvejQdi+P9YfmR4vwmTSGFH2CRKzZN/QUUdlB4y3gq/oL96BYUNg==
X-Received: by 2002:a17:907:a07c:b0:72a:b390:ee8a with SMTP id ia28-20020a170907a07c00b0072ab390ee8amr24435259ejc.96.1657187920243;
        Thu, 07 Jul 2022 02:58:40 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906068500b00703671ebe65sm18516064ejb.198.2022.07.07.02.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 02:58:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/28] KVM: nVMX: Introduce
 KVM_CAP_HYPERV_ENLIGHTENED_VMCS2
In-Reply-To: <YsYAPL1UUKJB3/MJ@google.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-7-vkuznets@redhat.com>
 <YsYAPL1UUKJB3/MJ@google.com>
Date:   Thu, 07 Jul 2022 11:58:38 +0200
Message-ID: <87o7y1qm5t.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 29, 2022, Vitaly Kuznetsov wrote:
>> Turns out Enlightened VMCS can gain new fields without version change
>> and KVM_CAP_HYPERV_ENLIGHTENED_VMCS which KVM currently has cant's
>> handle this reliably. In particular, just updating the current definition
>> of eVMCSv1 with the new fields and adjusting the VMX MSR filtering will
>> inevitably break live migration to older KVMs. Note: enabling eVMCS and
>> setting VMX feature MSR can happen in any order.
>> 
>> Introduce a notion of KVM internal "Enlightened VMCS revision" and add
>> a new capability allowing to add fields to Enlightened VMCS while keeping
>> its version.
>
> Bumping a "minor" version number in KVM is going to be a nightmare.  KVM is going
> to be stuck "supporting" old revisions in perpetuity, and userspace will be forced
> to keep track of which features are available with which arbitrary revision (is
> that information even communicated to userspace?).

My brain is certainly tainted with how we enable this in QEMU but why
would userspace be interested in which features are actually filtered
out?

Currently (again, by QEMU), eVMCS is treated as a purely software
feature. When enabled, certain controls are filtered out "under the
hood" as VMX MSRs reported to VMM remain unfiltered (see
'!msr_info->host_initiated' in vmx_get_msr()). Same stays true with any
new revision: VMM's job is just to check that a) all hardware features
are supported on both source and destination and b) the requested 'eVMCS
revision' is supported by both. No need to know what's filtered out and
what isn't.

>
> I think a more maintainable approach would be to expose the "filtered" VMX MSRs to
> userspace, e.g. add KVM_GET_EVMCS_VMX_MSRS.  Then KVM just needs to document what
> the "filters" are for KVM versions that don't support KVM_GET_EVMCS_VMX_MSRS.
> KVM itself doesn't need to maintain version information because it's userspace's
> responsibility to ensure that userspace doesn't try to migrate to a KVM that doesn't
> support the desired feature set.

That would be a reasonable (but complex for VMM) approach too but I
don't think we need this (and this patch introducing 'eVMCS revisions'
to this matter): luckily, Microsoft added a new PV CPUID feature bit
inidicating the support for the new features in eVMCSv1 so KVM can just
observe whether the bit was set by VMM or not and filter accordingly.

>
> That also avoids messes like unnecessarily blocking migration from "incompatible"
> revisions when running on hardware that doesn't even support the control.

Well yea, in case the difference between 'eVMCS revisions' is void
because the hardware doesn't support these, it would still be possible
to migrate to an older KVM which doesn't support the new revision but
I'd stay strict: if a newer revision was requested it must be supported,
no matter the hardware.

-- 
Vitaly

