Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194CC59C40C
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Aug 2022 18:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiHVQYs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Aug 2022 12:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiHVQYq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Aug 2022 12:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2229840BF3
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Aug 2022 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661185484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+8JZGtkVxOmbIeQgHkw8hE6eGekXQYn3qmLX4nEH6U=;
        b=V20Jqrdc7BnugIBn6lnu7DJJ4hLLqgoUJlwifJpewMZrwiMcdrhfCNBrtbV6c08lRl61q3
        ki/u8D5MurtroLqft84sH8pYZuLJJMnYRdYUkeiguy5bquuSoxsMfplkEye0azQd+Etl0h
        /CFBqgAsBsc3/Aur5HM+N/0yuunlo7w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-576-7x2qptfUMhCSFRPv33xSUw-1; Mon, 22 Aug 2022 12:24:42 -0400
X-MC-Unique: 7x2qptfUMhCSFRPv33xSUw-1
Received: by mail-wm1-f71.google.com with SMTP id k24-20020a7bc418000000b003a62ad689feso1822413wmi.3
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Aug 2022 09:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=z+8JZGtkVxOmbIeQgHkw8hE6eGekXQYn3qmLX4nEH6U=;
        b=QC/P40QWZGb2iIIiaOY9PqNqL1EmmDeARCYXbm5SI+H+pbzZZ065MCOHZTNdXFQ4Bd
         +DRGvWmRbGuuGGGea39lhVjuVEC1TeQGIfCK+DBkRLz6Xx7EG9UL5pVqhKddgjPKbOpH
         b/o2aK4S1kTODvGzYLWawNFAQlizdgObNDh/ncN4aXAgh85FoMiQl3af+AfkrM4VU9Vw
         Ut7VnO7csEuJnh98CtPyNyCNQtrX2oCVDVIT7dmXiW5WEvXHWaD5TmckT7chVTjPtPhu
         7UY3enS5Y6rnzm/wNgs8qBF3x4EHq75crlX9v3YyCHzCSlFFDEnKlj0pAKW/f7poDEFK
         mmgw==
X-Gm-Message-State: ACgBeo0aBF9JnRX9F1aperRs3j9sxLbeJ9cu1bkEASH44Mprqtt5QJWT
        46qoMQpr/oHsrY6cgdDEhROR+YBQeSOQQ9T8pLrMh5v4wovVfXVlO34xaPkz2wvl6F6rfBfPRBv
        s50D4lBxaWjtnXfJdQuTzvy6k
X-Received: by 2002:a05:600c:4c21:b0:3a5:3c02:5f83 with SMTP id d33-20020a05600c4c2100b003a53c025f83mr12938079wmp.7.1661185481842;
        Mon, 22 Aug 2022 09:24:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4JktIIM3YnkZ0hZg4t+vSbZRizc51oECyEp4vgtwebh5kaTgN4SZT2vRicR3YFSKegjL7eRQ==
X-Received: by 2002:a05:600c:4c21:b0:3a5:3c02:5f83 with SMTP id d33-20020a05600c4c2100b003a53c025f83mr12938064wmp.7.1661185481675;
        Mon, 22 Aug 2022 09:24:41 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b18-20020a5d6352000000b002252751629dsm11907400wrw.24.2022.08.22.09.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 09:24:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/26] x86/hyperv: Update 'struct
 hv_enlightened_vmcs' definition
In-Reply-To: <YwOrG3W3zAZ7VNJu@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-4-vkuznets@redhat.com>
 <Yv5ZFgztDHzzIQJ+@google.com> <875yiptvsc.fsf@redhat.com>
 <Yv59dZwP6rNUtsrn@google.com> <87czcsskkj.fsf@redhat.com>
 <YwOrG3W3zAZ7VNJu@google.com>
Date:   Mon, 22 Aug 2022 18:24:40 +0200
Message-ID: <87bkscxn3r.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Aug 22, 2022, Vitaly Kuznetsov wrote:
>> So I reached out to Microsoft and their answer was that for all these new
>> eVMCS fields (including *PerfGlobalCtrl) observing architectural VMX
>> MSRs should be enough. *PerfGlobalCtrl case is special because of Win11
>> bug (if we expose the feature in VMX feature MSRs but don't set
>> CPUID.0x4000000A.EBX BIT(0) it just doesn't boot).
>
> Does this mean that KVM-on-HyperV needs to avoid using the PERF_GLOBAL_CTRL fields
> when the bit is not set?

It doesn't have to, based on the reply I got from Microsoft, if 
PERF_GLOBAL_CTRL is exposed in architectural VMX feature MSRs than eVMCS
fields are guaranteed to be present. The PV bit is 'extra'.

-- 
Vitaly

