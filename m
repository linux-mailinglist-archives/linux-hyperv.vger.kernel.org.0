Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1222E3A68A3
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Jun 2021 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhFNOFF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Jun 2021 10:05:05 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:44586 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhFNOFF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Jun 2021 10:05:05 -0400
Received: by mail-pf1-f177.google.com with SMTP id u18so10601295pfk.11;
        Mon, 14 Jun 2021 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rxN6qots3gftmYmzarjE1MfJoAMa+HkQ1sXzj7TBE+4=;
        b=lob5dTvi9uizmuj+tUdDynOO9jvwCr0ZDF8C0p4XA9CUWjEtUEb4iP5nx/JU49Tg6g
         1NEuc8YpZRgt6emmX0JgxGoUCX/0QsQGKoaVhVkni76t0b07YLZyrWFLmiGsB+kmOLLg
         4UL6Gu3vMUGV1h+1wNe9nqsGAjHmU73fzjrX0JABmg15fBfUzfRybKW1jJMHVAG1IO91
         jri9BfiF2YfZLHo/5JC3PWFkvLFrqfyZ9D2+n+DKVdgprQhrObhku+FpfJAg627OR/bt
         1dAsjGYImXJV1kwo+CxN5NJPF/IzD5Q4EfR8saUOdOIs5hMGSl6reCvLeVGdWDJg0KSz
         6RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rxN6qots3gftmYmzarjE1MfJoAMa+HkQ1sXzj7TBE+4=;
        b=E6fxsI8VYyiNZVvw+AODUso2bCml69iHOvCr62ewWpNavOJQrjGiHcz4j+2RUfv7D4
         ZfRf0BXANSArzMUROVLyHb6cuBoxYL7UTZ6HOMA6dipMgmqhYCl9vozP7+VtoT8R1jAI
         H1b1Y488g/WDPYTacFVtBejK2BP07/DqUVja2eBi+PqfmDjbXxPiHcMGIpE1D2VuZ1/8
         dkaHkC0kC3HKo57uUF2CFNaCcmQJMNEFktldogw2z8G4IdY0FYYiRLowFNO0tubR/iHJ
         6H6MNmmdj+5zvkNZItJdDJJLxfyybKQ7/VeYGuitaOCoVK/Xvgb1+nDr7CG3+EIowvIl
         kRqw==
X-Gm-Message-State: AOAM533EhJ8Xh74CpRYmY97Lyvg7m6pMrQg2kZOkPQT8q+jkGth+LLJc
        snyyDiZOPoshxQ4qZOJXIQo=
X-Google-Smtp-Source: ABdhPJyva6fsoFPamr3e/ZFu0g9Kw0nLUqIcZlXw8VINUW4Wv9YM/Ic7v/Mdt/3OQEjODPy2UTKMJQ==
X-Received: by 2002:a63:ce4f:: with SMTP id r15mr17119844pgi.387.1623679322246;
        Mon, 14 Jun 2021 07:02:02 -0700 (PDT)
Received: from [192.168.1.8] ([50.47.106.83])
        by smtp.gmail.com with ESMTPSA id h18sm13273645pgl.87.2021.06.14.07.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 07:01:55 -0700 (PDT)
Message-ID: <2bf51ac723cb097685dd4c89926599d939d31765.camel@gmail.com>
Subject: Re: [PATCH -next] drm/hyperv: Remove unused variable
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Pu Lehui <pulehui@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     zhangjinhao2@huawei.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Mon, 14 Jun 2021 07:01:51 -0700
In-Reply-To: <078d9bb5-e7af-4961-f4c1-cd3ab415cff4@suse.de>
References: <20210609024940.34933-1-pulehui@huawei.com>
         <078d9bb5-e7af-4961-f4c1-cd3ab415cff4@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 2021-06-09 at 09:46 +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 09.06.21 um 04:49 schrieb Pu Lehui:
> > Fixes gcc '-Wunused-const-variable' warning:
> >    drivers/gpu/drm/hyperv/hyperv_drm_modeset.c:152:23: warning:
> >      'hyperv_modifiers' defined but not used [-Wunused-const-
> > variable=]
> > 
> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
> > ---
> >   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 5 -----
> >   1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> > b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> > index 02718e3e859e..3f83493909e6 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> > @@ -149,11 +149,6 @@ static const uint32_t hyperv_formats[] = {
> >         DRM_FORMAT_XRGB8888,
> >   };
> >   
> > -static const uint64_t hyperv_modifiers[] = {
> > -       DRM_FORMAT_MOD_LINEAR,
> > -       DRM_FORMAT_MOD_INVALID
> > -};
> 
> This constant should rather be used in the call to 
> drm_simple_display_pipe_init(). [1]
> 
> Best regards
> Thomas
> 
> [1] 
> https://cgit.freedesktop.org/drm/drm-misc/tree/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c#n161
> 
> 

Hi Pu,

Thanks for the patch. Is it possible to send another patch as per
suggestion by Thomas. There is a kernel test robot failure as well.

Deepak

