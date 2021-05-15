Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174F038199C
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 May 2021 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhEOPow (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 15 May 2021 11:44:52 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:34515 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhEOPov (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 15 May 2021 11:44:51 -0400
Received: by mail-wr1-f45.google.com with SMTP id r12so2057272wrp.1;
        Sat, 15 May 2021 08:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aLi+q4+fITY/9vJzQNwPaaIzGyuxiBdUvBE5MpOoWqA=;
        b=kaCtcRJISOVi5irJyVUQ/DY48QcdMP/zJlJov8oG36lvsowTd8ByHvcrFE5b2dLUH+
         FeyrGgrsvrV/wiU7dKe6I4iJYfdjTCZIpIK0vHx/XYghNjOnK53zAqbvgVnvnjjWiV1s
         oMhlqQiCnsLuzZzEwA5x1BlDF+LJfFrb0zmm0FldQkDOUmdHwk4kAKjcbXAE41w+irQY
         ZGh2F4ukdlAb9RcxQnzFlyA7bu0jO5bBIjrlnXhguGh01FX/wI610iFpgrZWYEKD5w/F
         dSb5s5gS3kHkTH6XR7IAFXRh+W/uQo63B7otSYTTRdh9ZsmTZBge3s3zgu10WRyJjrS3
         Cjpg==
X-Gm-Message-State: AOAM533UcG8ttl0ia234tI6TQ5r59JkOMdd/2E3XgcsFonqPCgCxzkaU
        vPrJDZam6oeso145IUVOkQM=
X-Google-Smtp-Source: ABdhPJxWLARebnf0UuBVKBoovk0lZhZcIw7lSCtN63JpxQfYyi3h9ZufjT6v//lLFu93+ZFZ6V40qw==
X-Received: by 2002:a5d:59a4:: with SMTP id p4mr9857559wrr.248.1621093417758;
        Sat, 15 May 2021 08:43:37 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r11sm3644090wrp.46.2021.05.15.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 08:43:37 -0700 (PDT)
Date:   Sat, 15 May 2021 15:43:35 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mohammed Gamal <mgamal@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] clocksource/drivers/hyper-v: Re-enable
 VDSO_CLOCKMODE_HVCLOCK on X86
Message-ID: <20210515154335.lr4hrbcmt25u7m45@liuwe-devbox-debian-v2>
References: <20210513073246.1715070-1-vkuznets@redhat.com>
 <MWHPR21MB15932C5EC2FA75D50B268951D7519@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15932C5EC2FA75D50B268951D7519@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 13, 2021 at 01:29:12PM +0000, Michael Kelley wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, May 13, 2021 12:33 AM
> > 
> > Mohammed reports (https://bugzilla.kernel.org/show_bug.cgi?id=213029)
> > the commit e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO
> > differences inline") broke vDSO on x86. The problem appears to be that
> > VDSO_CLOCKMODE_HVCLOCK is an enum value in 'enum vdso_clock_mode' and
> > '#ifdef VDSO_CLOCKMODE_HVCLOCK' branch evaluates to false (it is not
> > a define). Use a dedicated HAVE_VDSO_CLOCKMODE_HVCLOCK define instead.
> > 
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Reported-by: Mohammed Gamal <mgamal@redhat.com>
> > Fixes: e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO differences inline")
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
[...]
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-fixes. Thanks.
