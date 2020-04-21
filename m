Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448F61B2707
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2020 15:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgDUNCv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Apr 2020 09:02:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44572 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728391AbgDUNCs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Apr 2020 09:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587474166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aaEA8A65Hjd1q8vy0RpNkfQhEN5T+ZQ/o66hncuahbw=;
        b=AfJG8XE5o3IkJ1i7B4gT4lzKiaofaLfRH6urS+78GvSsCON0vV2NFuHoVQeVlMeZWTlCF5
        E2H8waSAfagiDK87mDFDlGW6sFn/Lq/HQa6QM5d76IovoDqJDykWVppZ+vSa6Bh9CwHzaq
        240sGymr+SuYtI0e1inHmjnYMsx+Sew=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-agT8fbM-PHaXLLDwhgkuKQ-1; Tue, 21 Apr 2020 09:02:44 -0400
X-MC-Unique: agT8fbM-PHaXLLDwhgkuKQ-1
Received: by mail-wm1-f71.google.com with SMTP id v185so1352422wmg.0
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Apr 2020 06:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aaEA8A65Hjd1q8vy0RpNkfQhEN5T+ZQ/o66hncuahbw=;
        b=LZ5Sc3b3cnwqCWMbyb4pGfVP0lI4mCXJMEVOsMK7hlW2Y0phJtgLOqDULSjDVDXTvr
         gf+eAqsFWeP9aSyeCwhzEXNRlHgF/MULv5OKFpN/gz+Cf6R/I+aFvxwVRNfUxvztC4GN
         HS+FH2o1zU2WGt0IDvNKwC++L/vtXCdp0E6Hkd38lOS6bxXR2uSiURJSLO0bxtKApAnC
         R7Ogv8G7TM7bEKzomxrUqjteJJZ7StcdC1cwY2dkTCYoRpZhd+6gY9dC9TE8wUyt9sKp
         rQqtbPsesW2Yszr7dx00775HdfCi/2Odlaumpi94rUhW1sArZeoSFUKat8wWjGrGs+hK
         qU4w==
X-Gm-Message-State: AGi0Puauv+jSF3HzMweAeG1JJZqE5F8VX4o7T1NLmvYYT8COdHd8TUvz
        VHMpguUjsDV+CoItFZVGIjeKew3SCYu9y0lhwRY1In/YwvpSlq/3b5VcrXpbo1dWhA2bxLXR6NR
        u0HUs7uBeCsejugwRR1Fca7xA
X-Received: by 2002:adf:ab09:: with SMTP id q9mr16345113wrc.240.1587474162910;
        Tue, 21 Apr 2020 06:02:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKNiKj9wds+sx5QIkXpkgfDNGj8TNZk53XoVrqBO6RLLn2LkQt5e4hi3w/czp7u6Ns5Jcm8Fg==
X-Received: by 2002:adf:ab09:: with SMTP id q9mr16345068wrc.240.1587474162502;
        Tue, 21 Apr 2020 06:02:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b2sm3941512wrn.6.2020.04.21.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:02:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        pbonzini@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/hyperv: Add definitions for Get/SetVpRegister hypercalls
In-Reply-To: <20200420173838.24672-5-mikelley@microsoft.com>
References: <20200420173838.24672-1-mikelley@microsoft.com> <20200420173838.24672-5-mikelley@microsoft.com>
Date:   Tue, 21 Apr 2020 15:02:40 +0200
Message-ID: <87y2qpq9e7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> Add definitions for GetVpRegister and SetVpRegister hypercalls, which
> are implemented for both x86 and ARM64.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  include/asm-generic/hyperv-tlfs.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 1f92ef92eb56..29b60f5b6323 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -141,6 +141,8 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> +#define HVCALL_GET_VP_REGISTERS			0x0050
> +#define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_POST_MESSAGE			0x005c
>  #define HVCALL_SIGNAL_EVENT			0x005d
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
> @@ -439,4 +441,30 @@ struct hv_retarget_device_interrupt {
>  	struct hv_device_interrupt_target int_target;
>  } __packed __aligned(8);
>  
> +
> +/* HvGetVPRegister hypercall */

Nit: 'HvGetVpRegisters' in TLFS

> +struct hv_get_vp_register_input {

Nit: I would also to name it 'hv_get_vp_registers_input' (plural, like
the hypercall).

> +	u64 partitionid;
> +	u32 vpindex;
> +	u8  inputvtl;
> +	u8  padding[3];
> +	u32 name0;
> +	u32 name1;
> +} __packed;

Isn't it a REP hypercall where we can we can pass a list? In that case
this should look like

struct hv_get_vp_registers_input {
	struct {
		u64 partitionid;
		u32 vpindex;
		u8  inputvtl;
		u8  padding[3];
        } header;
	struct {
		u32 name0;
		u32 name1;
        } elem[];
} __packed;

> +
> +struct hv_get_vp_register_output {

Ditto.

> +	union {
> +		struct {
> +			u32 a;
> +			u32 b;
 > +			u32 c;
> +			u32 d;
> +		} as32 __packed;
> +		struct {
> +			u64 low;
> +			u64 high;
> +		} as64 __packed;
> +	};
> +};

I'm wondering why you define both
HVCALL_GET_VP_REGISTERS/HVCALL_SET_VP_REGISTERS but only add 'struct
hv_get_vp_register_input' and not 'struct hv_set_vp_register_input'. 

The later should look similar, AFAIU it is:

struct hv_set_vp_registers_input {
	struct {
		u64 partitionid;
		u32 vpindex;
		u8  inputvtl;
		u8  padding[3];
        } header;
	struct {
		u32 name;
		u32 padding1;
		u64 padding2; //not sure this is not a mistake in TLFS
            	u64 regvallow;
            	u64 regvalhigh;
	} elem[];
} __packed;

> +
>  #endif

-- 
Vitaly

