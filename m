Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDE85614AA
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Jun 2022 10:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiF3IR7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 Jun 2022 04:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiF3IQ4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 Jun 2022 04:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78A074161C
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jun 2022 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656576869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlMiGdcIrFpDBLHk8xJFJfVXR7N2zgyrgxr08eYwybI=;
        b=gIRqNkpwQ4fsYWN6IaVjdbDGAUmC9OymB9OGiWhHwS3wInZ2I4Gyr0Q0D/dgSGm1Ar5LTv
        kZvlIK2PneNXR5IpJRGaDfeJsvxJ5mOwSsh9QHnUhBwAHNxR9F9dSGKfRoExgtrtWYeLTc
        idKdW11XzkBfOmZi4KXAp1vxXBHievc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-MAyhJFRyPYSaj4jTViuAdw-1; Thu, 30 Jun 2022 04:14:27 -0400
X-MC-Unique: MAyhJFRyPYSaj4jTViuAdw-1
Received: by mail-ed1-f69.google.com with SMTP id c20-20020a05640227d400b004369cf00c6bso13746741ede.22
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jun 2022 01:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zlMiGdcIrFpDBLHk8xJFJfVXR7N2zgyrgxr08eYwybI=;
        b=leLIVFSBfrpj3JyQKKDFxS5cNkGeOy0WwDbLI2HclAxwpzjn5T7GRn5s+7pSTHHXoB
         gQk/gHvMN94XFph6aFeuqLDQD20kbwURpnz59hosnrXzkV2icF65RLn/4Y8sS3D2/uOn
         PMBW1+3mWZaA2XuF2IUpjhYRFMDmHp/9+CJcTCBXxhXRIu27j3GMMrY3l2NA1J0qTfkz
         h3wAFfFswVhvCuQ4rbnh3exePF/MADc9lGSNp8o4Oxb4cKKj5tnwmyqwPMJTsOWc93bu
         CXHNJoiMU52NBblbRD/nNA/XG6A+yomPdTYcFLSPK/Wqvb0w08N0O4Coa5zW5UVZFxiP
         dyEw==
X-Gm-Message-State: AJIora8D6xnzXGk2fVMAmJRZ7qUFOfWQaQiDjTTBgbvmmE6xXf9YdjoN
        QOLgcBcwzqx5GFqiRhOl/Hc+TRGtZ3gQP54IaBjkBJkmIm1yLnPa2qahzhLBhlba6vc/yjcfJ4X
        1Pn2tJ2J/GGpB+Uoxds0KXnzI
X-Received: by 2002:a17:906:2bda:b0:726:3b59:3ea9 with SMTP id n26-20020a1709062bda00b007263b593ea9mr7435895ejg.43.1656576866184;
        Thu, 30 Jun 2022 01:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tLG2WWX3FE42f0Pc7Gtu8T2vGqmsUiCHmaIDWC+JmhfkmKIzYY2TjuTHZ6kp+oNe8KDqo3FQ==
X-Received: by 2002:a17:906:2bda:b0:726:3b59:3ea9 with SMTP id n26-20020a1709062bda00b007263b593ea9mr7435876ejg.43.1656576865965;
        Thu, 30 Jun 2022 01:14:25 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r1-20020aa7cb81000000b004357b717a96sm12695498edt.85.2022.06.30.01.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 01:14:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Dong, Eddie" <eddie.dong@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: RE: [PATCH 04/14] KVM: VMX: Extend VMX controls macro shenanigans
In-Reply-To: <BL0PR11MB3042FA68F1EA02B5300E01168ABB9@BL0PR11MB3042.namprd11.prod.outlook.com>
References: <20220627160440.31857-1-vkuznets@redhat.com>
 <20220627160440.31857-5-vkuznets@redhat.com>
 <BL0PR11MB304264B62299D642FF906C298AB99@BL0PR11MB3042.namprd11.prod.outlook.com>
 <YrpbiWw1E4DXQ962@google.com>
 <BL0PR11MB3042FA68F1EA02B5300E01168ABB9@BL0PR11MB3042.namprd11.prod.outlook.com>
Date:   Thu, 30 Jun 2022 10:14:24 +0200
Message-ID: <87o7yash3z.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Dong, Eddie" <eddie.dong@intel.com> writes:

>> -----Original Message-----
>> From: Sean Christopherson <seanjc@google.com>
>> Sent: Monday, June 27, 2022 6:38 PM
>> To: Dong, Eddie <eddie.dong@intel.com>
>> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>; kvm@vger.kernel.org; Paolo
>> Bonzini <pbonzini@redhat.com>; Anirudh Rayabharam
>> <anrayabh@linux.microsoft.com>; Wanpeng Li <wanpengli@tencent.com>;
>> Jim Mattson <jmattson@google.com>; Maxim Levitsky
>> <mlevitsk@redhat.com>; linux-hyperv@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH 04/14] KVM: VMX: Extend VMX controls macro
>> shenanigans
>>=20
>> On Mon, Jun 27, 2022, Dong, Eddie wrote:
>> > >  static inline void lname##_controls_clearbit(struct vcpu_vmx *vmx, =
u##bits
>> > > val)	\
>> > >  {
>> > > 	\
>> > > +	BUILD_BUG_ON(!(val & (KVM_REQ_VMX_##uname |
>> > > KVM_OPT_VMX_##uname)));	\
>> > >  	lname##_controls_set(vmx, lname##_controls_get(vmx) & ~val);
>> > > 	\
>> > >  }
>> >
>> > With this, will it be safer if we present L1 CTRL MSRs with the bits
>> > KVM really uses? Do I miss something?
>>=20
>> KVM will still allow L1 to use features/controls that KVM itself doesn't=
 use, but
>> exposing features/controls that KVM doesn't use will require a more expl=
icit
>> "override" of sorts, e.g. to prevent advertising features that are suppo=
rted in
>> hardware, known to KVM, but disabled for whatever reason, e.g. a CPU bug,
>> eVMCS incompatibility, module param, etc...
> Mmm, that is fine too.
> But, do we consider the potential need of migration for a L1 VMM ?
> Normally the VM can be configured to be as hardware neutral for better
> compatibility, or exposing as close to hardware feature as possible
> for performance.
> For nested features, I thought we didn't support migration if L1 VMM
> yet, so exposing hardware capability by default is fine at moment. We
> may revisit one day in future if we need to support migration.

Not sure I got your point, nested state migration is fully supported in
KVM. When migrating a guest, KVM makes sure the list of features exposed
in VMX control MSRs remain the same. This may not be the case if you use
something like "-cpu host" in QEMU but the problems are not specific to
nesting.

>  This MACRO do help anyway =F0=9F=98=8A
>
>>=20
>> The intent of this BUILD_BUG_ON() is to detect KVM usage of bits that ar=
en't
>> enabled by default, i.e. to lower the probability that a control gets us=
ed by KVM
>> but isn't exposed to L1 because it's a dynamically enabled control.

--=20
Vitaly

