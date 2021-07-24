Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366E23D4864
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jul 2021 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGXPCx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Jul 2021 11:02:53 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43854 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGXPCw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Jul 2021 11:02:52 -0400
Received: by mail-wr1-f49.google.com with SMTP id y8so5548422wrt.10;
        Sat, 24 Jul 2021 08:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v+XwUBU81RLKN4NEcpt+u5/wJc7NImqRbxoHg9MG7AQ=;
        b=lRKtP2Wk+Q/bdjlJqCprk5L96EBNPCKJU2j6fI+GGRGDLc3kuAUst+sEb8T0OVRA5t
         JHi4Rte5D176sEHE/tILHL45QZKMhH5gHdR/pA05AqscdRt9MWs2egJB57EaOveKLwOV
         dO6NOFpw4m/jQECoyvR1NBnd+3BHyvp7SENb0pHTCmZAPcgVFrMAg9WbHlzm8F4sFT51
         /bTeQNeNnrOc5OVQSWSp7g36D1KmeYJ5tosJhu0idYIErzD4Jt+jxhJjaTDuSIyuded9
         Q54oEcOoCG+JuX9BVFyiLhOmcXNYS9IkJimPe9SVef94l+iMgKrPq9GATjItqmhm+aTp
         8MEQ==
X-Gm-Message-State: AOAM532iN1FgXnmtxw7kY91Ca/4hij0X9vOVXTm2coQ77a1B8peEbLME
        +uTd+rwA15ddj3wsh2yWEhQ=
X-Google-Smtp-Source: ABdhPJwdusdPl3V8JeOAX9njNPiPJ73/C6tD4zUtKI1WRTxa2fG1Lvxm7Qn80xZSoUz/eM/87m1sZQ==
X-Received: by 2002:adf:f9c8:: with SMTP id w8mr10527540wrr.143.1627141402874;
        Sat, 24 Jul 2021 08:43:22 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w18sm38861848wrg.68.2021.07.24.08.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 08:43:22 -0700 (PDT)
Date:   Sat, 24 Jul 2021 15:43:20 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v2] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Message-ID: <20210724154320.apc7lm2pclfzig7n@liuwe-devbox-debian-v2>
References: <20210721180302.18764-1-kumarpraveen@linux.microsoft.com>
 <20210722102741.vl4fvv3abifru2ge@liuwe-devbox-debian-v2>
 <bd019dc6-75e9-ac89-18fa-c09561000188@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd019dc6-75e9-ac89-18fa-c09561000188@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 22, 2021 at 09:45:36PM +0530, Praveen Kumar wrote:
> > 
> > I think about this a bit more, the NULL check for *hvp in hv_cpu_init in
> > the original code is perhaps due to the code has opted to not free the
> > page when disabling the VP assist page. When the CPU is brought back
> > online, it does not want to allocate another page, but to use the one
> > that's already allocated.
> > 
> > So, since you listened to my suggestion to add a similar check, you need
> > to reset hv_vp_assist_page to NULL here. Alternatively the check for
> > *hvp can be dropped for the root path. Either way, the difference
> > between root and non-root should be documented.
> > 
> 
> I would make it as NULL post memunmap as you suggested, so that we
> don't end up reusing the old/cached value. Before doing that, is there
> any use-case where hypervisor can allocate or change the VP assist
> page that can impact root kernel execution ?

I don't think a sane hypervisor will change the page in such a way.

Wei.
