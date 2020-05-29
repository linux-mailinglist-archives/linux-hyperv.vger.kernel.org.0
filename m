Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2E01E7C99
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2020 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgE2MIl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 May 2020 08:08:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36950 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726476AbgE2MIh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 May 2020 08:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590754116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gkkeI9/4O+LTTEQ+7u8ZuAx4cOWBRh3lwyxYXdlPlcc=;
        b=al4aZyJYU94MDwvF+FvnyFyrlIsw9/0MyGb+byotId1bUnf6erOdk0nmbAJexbB19dXT8s
        j2UVZRGR6oCvk2GM/FnforXL0H8lZ/9MZ//yv3YUrS8fwN7+VS7zTtPEyfBAMMIg3IIeOQ
        JEws5N7NZiEeY+TTMnSi+/YXCHT6KNg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28--E7yCknbPimPclxT8EEokA-1; Fri, 29 May 2020 08:08:35 -0400
X-MC-Unique: -E7yCknbPimPclxT8EEokA-1
Received: by mail-wr1-f70.google.com with SMTP id s17so964887wrt.7
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2020 05:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gkkeI9/4O+LTTEQ+7u8ZuAx4cOWBRh3lwyxYXdlPlcc=;
        b=KeMAn9UzPG9InHz/U5gMZiX1PTN2zsVUnxPQehM1gbQD1o4J08B39xoxXML9zET2Ve
         o/PD/t4G5f9IrGQsGtqPWkbuwC+LgNzl4MTbmRaRSaPDQ5UPS6Qrk8DMp1ce5fal+KJe
         YKasbdDBJvt0O3GkXKTiEKngGmXepKaEgIA9IRO+AL79+bisKPCIwv6N8lfAkoosynFm
         lMYHXAJN7eQuKBiHLuA5DzYQYGNnylF0QBPB/1YXG1mfUg/oxOadD35jPf3wHNagHE3r
         kUFV3tIfkoNlCUGtMOZFomzsh4eShmMCCQ96uUbg37+uYx9qrEmra9IhJq12Sn+8RBnT
         yAGA==
X-Gm-Message-State: AOAM532DutKtwJEmjjuiViBgRzPYc8BsHJJM1a230Npyb2P5CwV2/3PG
        LtadfZ2T/XzcwvwJgny6NdqK9CgtFstQzLSKfTaQb2fszpcYbm/0+HVZVR3DFw8lN7jAyhPV82I
        SHoMLW3iaeYZXk0qOS4DAr8BC
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr7719803wmj.146.1590754113432;
        Fri, 29 May 2020 05:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIUKYN6RpJQ13GHibiYf05FEqiCpNM7pxTEl/HoRQDNE4g/S/lPW2gzkydzA3AWHeqXJVAog==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr7719792wmj.146.1590754113190;
        Fri, 29 May 2020 05:08:33 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p65sm9911728wmp.36.2020.05.29.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 05:08:32 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jon Doron <arilou@gmail.com>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v11 4/7] x86/kvm/hyper-v: Add support for synthetic debugger capability
In-Reply-To: <12df4348-3dc1-a4cc-aa41-4492cd42dcc8@redhat.com>
References: <20200424113746.3473563-1-arilou@gmail.com> <20200424113746.3473563-5-arilou@gmail.com> <12df4348-3dc1-a4cc-aa41-4492cd42dcc8@redhat.com>
Date:   Fri, 29 May 2020 14:08:31 +0200
Message-ID: <87ftbjhrk0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 24/04/20 13:37, Jon Doron wrote:
>> +static int syndbg_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
>> +{
>> +	struct kvm_hv_syndbg *syndbg = vcpu_to_hv_syndbg(vcpu);
>> +
>> +	if (!syndbg->active && !host)
>> +		return 1;
>> +
>
> One small thing: is the ENABLE_CAP and active field needed?  Can you
> just check if the guest has the syndbg CPUID bits set?
>

Yes, we can probably get away with a static capability (so userspace
knows that the interface is supported and CPUID bit can be set) and
check guest_cpuid_has() here but we don't have Hyper-V feature leaves
exposed as X86_FEATURE_* (yet). It is probably possible to implement an
interim solution by open coding the check with kvm_find_cpuid_entry() or
something like that.

-- 
Vitaly

