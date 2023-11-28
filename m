Return-Path: <linux-hyperv+bounces-1081-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683897FB2AF
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 08:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973061C20A5D
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F137134D7;
	Tue, 28 Nov 2023 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViYkU0kQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6381AE
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701156415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDhxfrZ6A0IBRHudGpkZAOoM1jn0urSkC0LwcNBapbI=;
	b=ViYkU0kQPWRym9rgySUPrmYgvewMwjphtyt8W2TlvLzoXg1GbxGJzQ+ZjQLjv7GaGM5Qgb
	vbCJsc7WGRBrEWdORICTz8qvizGDdkvne8CKW4siCOrizj81HzXhLZxRHjVNWE1aNsUCe8
	v4nRkZftUiYHy6cDA2wrBAleH5PzNmk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-HHOS2MoZNSOOpZDaIfCUHA-1; Tue, 28 Nov 2023 02:26:52 -0500
X-MC-Unique: HHOS2MoZNSOOpZDaIfCUHA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b3519a03aso35597245e9.3
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156411; x=1701761211;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDhxfrZ6A0IBRHudGpkZAOoM1jn0urSkC0LwcNBapbI=;
        b=sdjtdN8Sm5V5+3TupMHVV9jfiXLcFo4fEvIeO50uk83x2NvFXBgHx7Bk77ge/vrf4y
         tZOVP+TAx0v4aFu/9TliMe1+AL9iXWJPGr78NVofZ8FEzAhm+uPxOabRgKRCPLKr/8Ew
         qfIB1bh/Yi+GxbyIS0/7zU0C7g2TEKEHcOjjmCWghGhnhOE9ozVf2x5TaYQV1Wls9AJJ
         vhpFvFpmW07kcQMXoOodiyWgAFkLo60nfz8vXJvEkS/HrYpZ7tFh1De7i2WCzjJ95R2a
         I2WFE/7RLmtasFrywWgMV/tkFqSmsFrgT5Uk1SQbrI1CxeJ8s481zHw2Z2HJBXxDTuM6
         8L6A==
X-Gm-Message-State: AOJu0YzUlCvylBfO/sIlORiXUt95CnYtVriTUHCC/nvbNpF/ufeeNjY0
	Oc8TENz1tRMGGMIz3s8lmnxjY1DzAWlls/IpJuZY94mHbl/Af9piwV60NpOU8AQ++n2OVBWziB3
	g4JwfBzX8pi2/KS6U1jeK2vSS
X-Received: by 2002:a05:600c:1f93:b0:401:2ee0:7558 with SMTP id je19-20020a05600c1f9300b004012ee07558mr10641349wmb.32.1701156411736;
        Mon, 27 Nov 2023 23:26:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4M7NxKP9raF3yxSld89xnv352HPd9UfYd6M9jkbwCiMadp3oGAStD9ceWph2CLoGlKw1rNQ==
X-Received: by 2002:a05:600c:1f93:b0:401:2ee0:7558 with SMTP id je19-20020a05600c1f9300b004012ee07558mr10641324wmb.32.1701156411350;
        Mon, 27 Nov 2023 23:26:51 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b00405959bbf4fsm16310283wmq.19.2023.11.27.23.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:26:51 -0800 (PST)
Message-ID: <38e52b16dfb57d0759b0e196fc952f20a62b0d3f.camel@redhat.com>
Subject: Re: [RFC 11/33] KVM: x86: hyper-v: Handle GET/SET_VP_REGISTER hcall
 in user-space
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Alexander Graf <graf@amazon.com>, Nicolas Saenz Julienne
 <nsaenz@amazon.com>,  kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
 anelkz@amazon.com,  dwmw@amazon.co.uk, jgowans@amazon.com, corbert@lwn.net,
 kys@microsoft.com,  haiyangz@microsoft.com, decui@microsoft.com,
 x86@kernel.org,  linux-doc@vger.kernel.org
Date: Tue, 28 Nov 2023 09:26:48 +0200
In-Reply-To: <b9c6ad26-ce8b-45f3-b856-8e6be2497f6e@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
	 <20231108111806.92604-12-nsaenz@amazon.com>
	 <b9c6ad26-ce8b-45f3-b856-8e6be2497f6e@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2023-11-08 at 13:14 +0100, Alexander Graf wrote:
> On 08.11.23 12:17, Nicolas Saenz Julienne wrote:
> > Let user-space handle HVCALL_GET_VP_REGISTERS and
> > HVCALL_SET_VP_REGISTERS through the KVM_EXIT_HYPERV_HVCALL exit reason.
> > Additionally, expose the cpuid bit.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> > ---
> >   arch/x86/kvm/hyperv.c             | 9 +++++++++
> >   include/asm-generic/hyperv-tlfs.h | 1 +
> >   2 files changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index caaa859932c5..a3970d52eef1 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -2456,6 +2456,9 @@ static void kvm_hv_write_xmm(struct kvm_hyperv_xmm_reg *xmm)
> >   
> >   static bool kvm_hv_is_xmm_output_hcall(u16 code)
> >   {
> > +	if (code == HVCALL_GET_VP_REGISTERS)
> > +		return true;
> > +
> >   	return false;
> >   }
> >   
> > @@ -2520,6 +2523,8 @@ static bool is_xmm_fast_hypercall(struct kvm_hv_hcall *hc)
> >   	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
> >   	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
> >   	case HVCALL_SEND_IPI_EX:
> > +	case HVCALL_GET_VP_REGISTERS:
> > +	case HVCALL_SET_VP_REGISTERS:
> >   		return true;
> >   	}
> >   
> > @@ -2738,6 +2743,9 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
> >   			break;
> >   		}
> >   		goto hypercall_userspace_exit;
> > +	case HVCALL_GET_VP_REGISTERS:
> > +	case HVCALL_SET_VP_REGISTERS:
> > +		goto hypercall_userspace_exit;
> >   	default:
> >   		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
> >   		break;
> > @@ -2903,6 +2911,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
> >   			ent->ebx |= HV_POST_MESSAGES;
> >   			ent->ebx |= HV_SIGNAL_EVENTS;
> >   			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
> > +			ent->ebx |= HV_ACCESS_VP_REGISTERS;
> 
> Do we need to guard this?

I think so, check should be added to 'hv_check_hypercall_access'.

I do wonder though why KVM can't just pass all unknown hypercalls to userspace
instead of having a whitelist.


Best regards,
	Maxim Levitsky

> 
> 
> Alex
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 





