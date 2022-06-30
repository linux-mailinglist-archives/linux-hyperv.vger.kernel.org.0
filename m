Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7B561355
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Jun 2022 09:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiF3Hgq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 Jun 2022 03:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiF3Hgp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 Jun 2022 03:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21331396B5
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jun 2022 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656574604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PwzmZMvr1HwTOyfvLBeay0UNdb3hWyqojFY1Kj6edFc=;
        b=MoPbTaJeQG00PcDRwkjMJsqX/riFXLBOn1nz0sMCq4wW2qE/SK3+AU+c0vJNsaRwcJ1axE
        FB2Hkj095dTG9S9Xf/MVzDVgU4sgg7xrKnIM/Fhy1nnhg5vhx3ngy0UTS+S7WqhNB3U+E2
        g6mfH9cFf+xf8rIGzJHB/TUTheFSTOs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-FqzisuDKNhyr4lE084ZfNQ-1; Thu, 30 Jun 2022 03:36:42 -0400
X-MC-Unique: FqzisuDKNhyr4lE084ZfNQ-1
Received: by mail-wr1-f69.google.com with SMTP id a1-20020adfbc41000000b0021b90d6d69aso2839204wrh.1
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jun 2022 00:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PwzmZMvr1HwTOyfvLBeay0UNdb3hWyqojFY1Kj6edFc=;
        b=S9Ed64wPN9HHZTmXl2YBsltwEiwOQt1MAK9adpjLIm1Zc7Kr1sCRrLq/kX4L1xXNPE
         oRQ4/pMmISE3IqLL/kTNWBITQ83r3T7sw/nHG7DljlCf5W4VUyjrS0u1xyRtuBz+R8B8
         lTyYUd1aRkmqd3wdMR8sDW20AuhzOzuekgyMrS3UGCRf2Zmdra5g96Jn+5gf1SJN7qqU
         DG3xN9hIH57oqQtpQ5UG9Yux65dHaNu2IFBLcT6Pg7v7KyweIAuel5eXSXMvypz1lDBQ
         Ss5lQBk21QC2hSV98NMJvr/iFe3+ydcXCaL8Jrcm+eXU1tuuPgoptXzkR/BqlUUshERA
         N9PA==
X-Gm-Message-State: AJIora+axbid2xtKaJA85wEFkc9Ay9vh5YfxjQSXc2OTKpZ1CS31F9kR
        6wfUDqTbbh22iA/isdLeGDLeERmF/HMIYqm8vWShF51FKCalVRi+nuncBbAsYM4BoPMbl/9DObV
        cri6Zy2XoSWEuU/troSMUs7N6
X-Received: by 2002:a5d:6704:0:b0:21b:8258:b773 with SMTP id o4-20020a5d6704000000b0021b8258b773mr6600896wru.284.1656574601077;
        Thu, 30 Jun 2022 00:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vE3BOs0DEpp+YFr2cGu7j4qggJVT3ycC/Awg1J1DjBCXCJeDvJEASklLYOzQTIogJGAkKlxA==
X-Received: by 2002:a5d:6704:0:b0:21b:8258:b773 with SMTP id o4-20020a5d6704000000b0021b8258b773mr6600874wru.284.1656574600876;
        Thu, 30 Jun 2022 00:36:40 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0039c41686421sm1868636wmg.17.2022.06.30.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 00:36:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 28/28] KVM: nVMX: Use cached host MSR_IA32_VMX_MISC
 value for setting up nested MSR
In-Reply-To: <CALMp9eRCbgYVGtAwpDWhytQSjeGeAOuqKZXVg3RpV92uKV5u0A@mail.gmail.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-29-vkuznets@redhat.com>
 <CALMp9eRCbgYVGtAwpDWhytQSjeGeAOuqKZXVg3RpV92uKV5u0A@mail.gmail.com>
Date:   Thu, 30 Jun 2022 09:36:39 +0200
Message-ID: <87tu82siuw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> vmcs_config has cased host MSR_IA32_VMX_MISC value, use it for setting
>> up nested MSR_IA32_VMX_MISC in nested_vmx_setup_ctls_msrs() and avoid the
>> redundant rdmsr().
>>
>> No (real) functional change intended.
>
> Just imaginary functional change? :-)
>

Well, yea) The assumption here is that MSR_IA32_VMX_MISC's value doesn't
change underneath KVM, caching doesn't change anything then. It is, of
course, possible that when KVM runs as a nested hypervisor on top of
something else, it will observe different values. I truly hope this is
purely imaginary :-)

>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
>

Thanks!

-- 
Vitaly

