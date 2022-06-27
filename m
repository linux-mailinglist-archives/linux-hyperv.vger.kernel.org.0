Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A5D55CDC9
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jun 2022 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiF0PNL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Jun 2022 11:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbiF0PNF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Jun 2022 11:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38DBC60DA
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Jun 2022 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656342782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ARdvDRYqFQEpUSYWNh7p3WDzIDlCQtznR2856ZwQR38=;
        b=gW6/t2nJH8PAXDixQuQKnj/aHKA22vqsvEjs2CKz3/J+I8ul3HapcF9EMvCfJOzpnxtSvb
        uuz0iVQXIClDIDSuR+zbt4wqYNr9hy2OcZ08yY8ovSSMY+DeeeIT8ddSJ/rrTvIkZ51A8M
        rGkXTIt27RCmjiGsvEMsEpJVAC7+KoQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-KMsKkiIkOiGFBK8F1BhQeg-1; Mon, 27 Jun 2022 11:13:01 -0400
X-MC-Unique: KMsKkiIkOiGFBK8F1BhQeg-1
Received: by mail-ed1-f69.google.com with SMTP id g7-20020a056402424700b00435ac9c7a8bso7384968edb.14
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Jun 2022 08:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ARdvDRYqFQEpUSYWNh7p3WDzIDlCQtznR2856ZwQR38=;
        b=SQNea8wCDxDThdjTRIjlom+bScvD/7kBYJ3IfKL99p0aPxgoV0G94D6j3oICyuIEHs
         41Jyrs4OI2JZzInyuoU6j9ili0rfY5S3GQtuvNJ1A1YpOVAoSPl9SzCPEO1zK8YKCuek
         CBezAs13JcVBlpojc+oBwmWhiLozAwwPE+mRYsMUTkSH9Pvob9MKU+TXRFNe3d7t0kLw
         reoqwoCx44khmRgv7xFWRzqRHT8cDxceYYOzEEyRla5/FiIa3F4FrJtlhNJX5HXme6TD
         Ni2XmpKn0kUi0V9EF7ogSogR+UrIw3Wiv2lE8a6TVqqjobUnMXrEMV7zFtbLidUtM8+k
         jT2g==
X-Gm-Message-State: AJIora9HHqpv+Lus4l/lirn0NUNFMmgrQILS9AfF71XYyGzzxUjpb9Ru
        56+03rYbG3IT4JV8m1NL91OeRhihhcIalQo7xSkAEPHyAPyIT6Qr4VkJA+xRSW8QIbOF5ITx7Wn
        qfjS1rJCjLSL8rh2jqlh80uoA
X-Received: by 2002:a17:906:5512:b0:726:be2c:a2e5 with SMTP id r18-20020a170906551200b00726be2ca2e5mr2270030ejp.88.1656342779601;
        Mon, 27 Jun 2022 08:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ujLOPA2JVmlJ+R4KMLfx0HjYsH41cRwgwuV7mZUbliS5V6Ns2xRIbDBxPpYaLhiDmvcPjGPQ==
X-Received: by 2002:a17:906:5512:b0:726:be2c:a2e5 with SMTP id r18-20020a170906551200b00726be2ca2e5mr2270015ejp.88.1656342779400;
        Mon, 27 Jun 2022 08:12:59 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906d20d00b00726298147b1sm5049433ejz.161.2022.06.27.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:12:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 02/10] KVM: VMX: Add missing CPU based VM
 execution controls to vmcs_config
In-Reply-To: <YrUBYTXRxBGYsd1a@google.com>
References: <20220622164432.194640-1-vkuznets@redhat.com>
 <20220622164432.194640-3-vkuznets@redhat.com>
 <YrUBYTXRxBGYsd1a@google.com>
Date:   Mon, 27 Jun 2022 17:12:58 +0200
Message-ID: <87wnd2uolh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Maybe say "dynamically enabled" or so instead of "missing"?
>

...

> On Wed, Jun 22, 2022, Vitaly Kuznetsov wrote:
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 24da9e93bdab..01294a2fc1c1 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2483,8 +2483,14 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>  	      CPU_BASED_INVLPG_EXITING |
>>  	      CPU_BASED_RDPMC_EXITING;
>>  
>> -	opt = CPU_BASED_TPR_SHADOW |
>> +	opt = CPU_BASED_INTR_WINDOW_EXITING |
>> +	      CPU_BASED_RDTSC_EXITING |
>> +	      CPU_BASED_TPR_SHADOW |
>> +	      CPU_BASED_NMI_WINDOW_EXITING |
>> +	      CPU_BASED_USE_IO_BITMAPS |
>> +	      CPU_BASED_MONITOR_TRAP_FLAG |
>>  	      CPU_BASED_USE_MSR_BITMAPS |
>> +	      CPU_BASED_PAUSE_EXITING |
>>  	      CPU_BASED_ACTIVATE_SECONDARY_CONTROLS |
>>  	      CPU_BASED_ACTIVATE_TERTIARY_CONTROLS;

CPU_BASED_INTR_WINDOW_EXITING and CPU_BASED_NMI_WINDOW_EXITING are
actually "dynamically enabled" but CPU_BASED_RDTSC_EXITING/
CPU_BASED_USE_IO_BITMAPS/ CPU_BASED_MONITOR_TRAP_FLAG /
CPU_BASED_PAUSE_EXITING are not (and I found the first two immediately
after implementing 'macro shananigans' you suggested, of course :-), KVM
just doesn't use them for L1. So this is going to get splitted in two
patches.

-- 
Vitaly

