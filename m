Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E741C3F19
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2020 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEDPzX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 May 2020 11:55:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21995 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729531AbgEDPzW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 May 2020 11:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588607721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zcu06Px3HfWIzeps5g66nRNvti217ZmUAEgFVFyuGCQ=;
        b=dUlzOYAzBZKzIdNRuHGarPnbFc4HUznrxbzkSNfLkomQZmc2Pji0V992rsTuMlBj5vzWIo
        XQ3+2xkuFG67ti9wgnnSPYvheD2BPnuCcJ0ibTeBCix8c6VrbcB1Mfv3bl9iSetXgHcpyC
        gG2aeIp2FXdJ9jQJoNezHnzTP537NXs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-V_qwxsyjPTKSdPZEHNoY3w-1; Mon, 04 May 2020 11:55:13 -0400
X-MC-Unique: V_qwxsyjPTKSdPZEHNoY3w-1
Received: by mail-wr1-f70.google.com with SMTP id f2so11042887wrm.9
        for <linux-hyperv@vger.kernel.org>; Mon, 04 May 2020 08:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zcu06Px3HfWIzeps5g66nRNvti217ZmUAEgFVFyuGCQ=;
        b=YaUYxvbBB79/wQ/AIIenBDaDyavGV0VWeK4CDnbh9KwW0WWyaB7f+6b7ovJnNWjhr4
         ayRkLvNWv5Uqh0UZOTIP3qt2lMYc+RYQ0lLq0B4pqf3cVuLbUH19sGG8/b7aEYmO2+eI
         50pSdOeLckn7968YTEU2lMW+3UjrKlcivkSkypt4HCd5Mok+Zx8DTrLNFYc8cKw9B4rM
         rYiMRkF7IL6aRDuoNIIun4hIoT0P/h94X6i22KIy0Env+IgX5J3CN1TTcb0T/NwpwCiE
         GskOECIUEHjS7S2hzFVTWn+/IT75bE8dxiaLmZfXxyRyzhZwktKxgZn1GmVwGGJcJqqi
         ajCg==
X-Gm-Message-State: AGi0PubgLi+7UdX5o7j4qpcwLvQuGzrMcgY5EGN44061WYjMO4bOh+/H
        XxiIPU7wsMCT0ktRO8/PxkBX67hG559crgGqMRa6UqhWjCrV2GPrdzQtgeiutY0pN70y5yNhU8m
        BRa2r8BhuosBqKrceXZlFADpE
X-Received: by 2002:adf:d0ca:: with SMTP id z10mr21780673wrh.172.1588607712231;
        Mon, 04 May 2020 08:55:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypLcbfKJHM1xBofC7P6FXO16OQiRP6dTUfxovFqqJdlElXN6GtF6sHXmbN0bGbmqvjjgTH7sEw==
X-Received: by 2002:adf:d0ca:: with SMTP id z10mr21780655wrh.172.1588607712026;
        Mon, 04 May 2020 08:55:12 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u2sm17535810wrd.40.2020.05.04.08.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:55:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rvkagan@yandex-team.ru>, Jon Doron <arilou@gmail.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 0/1] x86/kvm/hyper-v: Add support to SYNIC exit on EOM
In-Reply-To: <20200503191900.GA389956@rvkaganb>
References: <20200416083847.1776387-1-arilou@gmail.com> <20200416120040.GA3745197@rvkaganb> <20200416125430.GL7606@jondnuc> <20200417104251.GA3009@rvkaganb> <20200418064127.GB1917435@jondnuc> <20200424133742.GA2439920@rvkaganb> <20200425061637.GF1917435@jondnuc> <20200503191900.GA389956@rvkaganb>
Date:   Mon, 04 May 2020 17:55:10 +0200
Message-ID: <87a72nelup.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Roman Kagan <rvkagan@yandex-team.ru> writes:

> On Sat, Apr 25, 2020 at 09:16:37AM +0300, Jon Doron wrote:
>
>> If that's indeed the case then probably the only thing needs fixing in my
>> scenario is in QEMU where it should not really care for the SCONTROL if it's
>> enabled or not.
>
> Right.  However, even this shouldn't be necessary as SeaBIOS from that
> branch would enable SCONTROL and leave it that way when passing the
> control over to the bootloader, so, unless something explicitly clears
> SCONTROL, it should remain set thereafter.  I'd rather try going ahead
> with that scheme first, because making QEMU ignore SCONTROL appears to
> violate the spec.

FWIW, I just checked 'genuine' Hyper-V 2016 with

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index fd51bac11b46..c5ea759728d9 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -314,10 +314,14 @@ void __init hyperv_init(void)
        u64 guest_id, required_msrs;
        union hv_x64_msr_hypercall_contents hypercall_msr;
        int cpuhp, i;
+       u64 val;
 
        if (x86_hyper_type != X86_HYPER_MS_HYPERV)
                return;
 
+       hv_get_synic_state(val);
+       printk("Hyper-V: SCONTROL state: %llx\n", val);
+
        /* Absolutely required MSRs */
        required_msrs = HV_X64_MSR_HYPERCALL_AVAILABLE |
                HV_X64_MSR_VP_INDEX_AVAILABLE;


and it seems the default state of HV_X64_MSR_SCONTROL is '1', we should
probably do the same. Is there any reason to *not* do this in KVM when
KVM_CAP_HYPERV_SYNIC[,2] is enabled?

-- 
Vitaly

