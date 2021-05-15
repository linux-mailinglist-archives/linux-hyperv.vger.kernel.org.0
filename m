Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A465381AC5
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 May 2021 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhEOTd0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 15 May 2021 15:33:26 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:41730 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhEOTd0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 15 May 2021 15:33:26 -0400
Received: by mail-wm1-f46.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so1361282wmq.0;
        Sat, 15 May 2021 12:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S3oOMBHELsi4j/8LwXv2KTVQIqoFC8N6A2IW2H3UcJE=;
        b=WNJ+5TYQIDhL4USLVMQp9CgVSCQWrlaXy257miBXvggKPoFZaAdZR30sRnUZu7lUh1
         nbbMO8L/VWEFwGMJmQzTR9h+H0Z2PJGj8a7gKtb/v+ue993jJIPmIgiwg+D4NrLBf/hA
         iVebj/31mb8/1UQDzy4aZmtMbM0QfTfUeLqfetq/Acc95r1LFgD7fpsEabfvIBEhYrgj
         rxfDEUM0eoqwQcgMZ2fGvVuZGFs9ShP59slNN4sp4E2D3d7gX9XGmXV9ZYVfNPctySEQ
         seE+lFhPz3E5sGcLzViJv17ryvq0guZq2rnE5HnK/Bb4m66sjEKqVGx1+zQWmuS63EcJ
         aXiQ==
X-Gm-Message-State: AOAM530TyjkEnpSLPhmbrYZrhu3ZUAqxi7BIGAqgMYoPH8UczJZvCOAU
        RYHo1tt+Xj1FIoxFLNmS2yA/aZhfszU=
X-Google-Smtp-Source: ABdhPJxqqSTaOxYsuajbqL7dr3Y9SNfk2S/IJPsG42wJNO3j2XdZDSZVaVe8A3xiVQj4pxeNN1/4Nw==
X-Received: by 2002:a05:600c:293:: with SMTP id 19mr56272007wmk.144.1621107130762;
        Sat, 15 May 2021 12:32:10 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l7sm5298841wmq.22.2021.05.15.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 12:32:10 -0700 (PDT)
Date:   Sat, 15 May 2021 19:32:08 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mohammed Gamal <mgamal@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] clocksource/drivers/hyper-v: Re-enable
 VDSO_CLOCKMODE_HVCLOCK on X86
Message-ID: <20210515193208.dy57jmbhfdmzt2mz@liuwe-devbox-debian-v2>
References: <20210513073246.1715070-1-vkuznets@redhat.com>
 <MWHPR21MB15932C5EC2FA75D50B268951D7519@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210515154335.lr4hrbcmt25u7m45@liuwe-devbox-debian-v2>
 <87h7j324w2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7j324w2.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, May 15, 2021 at 09:06:37PM +0200, Thomas Gleixner wrote:
> On Sat, May 15 2021 at 15:43, Wei Liu wrote:
> 
> > On Thu, May 13, 2021 at 01:29:12PM +0000, Michael Kelley wrote:
> >> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, May 13, 2021 12:33 AM
> >> > 
> >> > Mohammed reports (https://bugzilla.kernel.org/show_bug.cgi?id=213029)
> >> > the commit e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO
> >> > differences inline") broke vDSO on x86. The problem appears to be that
> >> > VDSO_CLOCKMODE_HVCLOCK is an enum value in 'enum vdso_clock_mode' and
> >> > '#ifdef VDSO_CLOCKMODE_HVCLOCK' branch evaluates to false (it is not
> >> > a define). Use a dedicated HAVE_VDSO_CLOCKMODE_HVCLOCK define instead.
> >> > 
> >> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> >> > Reported-by: Mohammed Gamal <mgamal@redhat.com>
> >> > Fixes: e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO differences inline")
> >> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > [...]
> >> 
> >> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> >> 
> > Applied to hyperv-fixes. Thanks.
> 
> It's already in the tip tree...

Okay. I will drop it. Thanks.
