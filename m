Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18B2A09B2
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Oct 2020 16:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgJ3PY0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Oct 2020 11:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgJ3PY0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Oct 2020 11:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604071464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wDeHKm34zve+2LwoR+7mEkyC1+h5TyYSYeSuFZNavsY=;
        b=QNCi/3xDP0MxUmIxDfTVmRtuQK8TRM57xUXYniwR6pLPH9JlVrlXqYi879LWjJzOoNc+C/
        vxTdOWJ6e9K7vOjjJ9TKbauLTwudhO/xIRxH2hoVButRaSC3xtwiBNO+0aQiM2Vom4O4wG
        PhalZtc3ZF15zAG9AHNbpFjolaCzQ2I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-MNWIlTaOPpKf5zQMlsfN8g-1; Fri, 30 Oct 2020 11:24:22 -0400
X-MC-Unique: MNWIlTaOPpKf5zQMlsfN8g-1
Received: by mail-ej1-f70.google.com with SMTP id mm21so2537407ejb.18
        for <linux-hyperv@vger.kernel.org>; Fri, 30 Oct 2020 08:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wDeHKm34zve+2LwoR+7mEkyC1+h5TyYSYeSuFZNavsY=;
        b=AD/B3dFDzNkqmbf5AtEVawOCOnG9UnAlUvuSC9TiIHTZYVqfAZWXscDmx2PpbnjB/Q
         oKso2bA8mZ8IoSvbHXyNELejOhCqK9+wKYq8t6AQtmXnspE5Ri2ShGdB1ZZGlcmDAlP1
         u1xQ1ukmm3NZHDfrJg7rnofCty/u1r/vWF+xrK4mbheV1BPopbfXs0+fMVwaCZ9qiwOE
         eta05H7gdMWkgsoGlNstCIRR+OWxUBXtbrsFl4J/Vl3hEPDJCsrLuQpz4w8f2cpP2PO/
         uYbaEa3N+aH+5XdE5XVqAzHKNTZU/6gGdnMQRUTbc6Oo05AIHrXic9q6L2br66V7EOIV
         q/Lg==
X-Gm-Message-State: AOAM532UdUWeG/3cccxbShHctWCWhGrbx4a4G8nSc4d/NnYn6zz0WGKF
        3gZqOUhWv9zfCktclHn6b6K9q+qFCjP3SkkF+Hqm9sPZf8RoFH7xFbOh4IOhSau3DQSUdGHhBqb
        UZEwD4DHLdBwLbVTyIplf6CPR
X-Received: by 2002:a17:906:4816:: with SMTP id w22mr3170205ejq.458.1604071460710;
        Fri, 30 Oct 2020 08:24:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEVkDy+HSfBs1jrEzMB6Hwe8D7gH9UX5XDZGN+GggyfNycbKYlnkipY+MXcz2Yfmk1EcrInQ==
X-Received: by 2002:a17:906:4816:: with SMTP id w22mr3170188ejq.458.1604071460513;
        Fri, 30 Oct 2020 08:24:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t15sm3086498ejs.3.2020.10.30.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:24:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: Field names inside ms_hyperv_info
In-Reply-To: <20201028150323.tz5wamibt42dgx7f@liuwe-devbox-debian-v2>
References: <20201028150323.tz5wamibt42dgx7f@liuwe-devbox-debian-v2>
Date:   Fri, 30 Oct 2020 16:24:18 +0100
Message-ID: <87lffnzqhp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> Hi all
>
> During my work to make Linux boot as root partition on MSHV, I found out
> that a privilege mask was not collected in ms_hyperv_info.
>
> Looking at the code, the field names of ms_hyperv_info are not
> consistent with the names defined in TLFS. That makes it difficult to
> choose a name for the field that stores the privilege mask.
>
> I've got a local patch to make the existing fields closer to TLFS. The
> suffix "_a" means the value comes from EAX.
>
> Given that this structure is also used on ARM, so having x86 suffix is
> probably not the best idea. Do people care?
>
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index c57799684170..913af5e93cce 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -26,9 +26,9 @@
>  #include <asm/hyperv-tlfs.h>
>
>  struct ms_hyperv_info {
> -       u32 features;
> -       u32 misc_features;
> -       u32 hints;
> +       u32 features_a;
> +       u32 features_d;
> +       u32 recommendations;
>         u32 nested_features;
>         u32 max_vp_index;
>         u32 max_lp_index;
>
> Any comment on this? I'm normally bad at naming things so any suggestion
> is welcomed.

My take: let's avoid ambiguous '_a', '_d' and use full register names,
it's only three letters after all. Let's also avoid suffix-less names as
eventually we'll need to add non-eax parts. That is:

       u32 features_eax;
       u32 features_edx;
       u32 recommendations_eax;
       u32 nested_features_eax;
...

I would also feel comfortable with these names sortened,

       u32 feat_eax;
       u32 feat_edx;
       u32 recomm_eax;
       u32 nested_feat_eax;
...

-- 
Vitaly

