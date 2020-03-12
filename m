Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553B8183205
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2020 14:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgCLNv3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Mar 2020 09:51:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25621 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726299AbgCLNv3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584021087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2nAfdnCM9aEuiGPmfbZ3pIUNPPugXK/vVGLzpCG2PUc=;
        b=heJVnOMQNsEeTcCYKXSXbUV++Wpb0mBA7BumHjiSoXaxC8FPxRMx6e2kQ+2sLKL/L/qtAT
        6vtOvK/hksGHBDMSLS+Jq3FXGZuoqSlbMX4pVeuHRTq1izxgOKmxht3HkhYSOiRz0jXsb0
        T0aqrtVPdLRZhSBzly/3fW6nxaflKoM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-nk1G9uFUOvOyM83tJ-f7Fw-1; Thu, 12 Mar 2020 09:51:26 -0400
X-MC-Unique: nk1G9uFUOvOyM83tJ-f7Fw-1
Received: by mail-wm1-f72.google.com with SMTP id t2so1893963wmj.2
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Mar 2020 06:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2nAfdnCM9aEuiGPmfbZ3pIUNPPugXK/vVGLzpCG2PUc=;
        b=JZIb8YNNw4GAys8du7ecStYAsuI8lDoIKY2aNcnLU6IrymG5MTcLhGrY+Yd7jbwoo2
         oNVQK58flTdvX7cqMtusEtAttpfv5dsopsw9Gev0NJxX/cQ06cP0QX/L8rsiTlCua+Vh
         E/1h8XhvnhSwyYfPAs1rRwM7ucKrMFpcdEqQN++sqnm3m4UQ3/3k4l4RV0VQk4NgkTu1
         CMBj29erlRN/X5I64xorEz5aDP6RFBJuHsJCMakNFF+NDHH8YKdQvXE3hfwn9fV1btH9
         bpYFTtf5oWIKUVzOv/w8qTqFkQ50gTa+7IBHRJL7ONViK4pdpQ7KIU2ngJqrp3umQnC6
         934Q==
X-Gm-Message-State: ANhLgQ3g2yNcWvV6dEu7NwZcBZyw6hsggud/Pq+x+Vso3uLFpKJ52QT9
        IbUPJiaX5KzY3dI/2YGxoyal83cgVM+E4erjWC3bdh7Djj96jyyUgvjj7DlZtaQ4aoHewVsoyZf
        TWzl/DY9ZUbhC0c7mPBI7xmh/
X-Received: by 2002:adf:ea42:: with SMTP id j2mr385414wrn.3.1584021084876;
        Thu, 12 Mar 2020 06:51:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtGpDPgE7pICtrNjLgGDlOHy9QvQAE7dJiUg+NXqqUyEmgbX2S2plfpUcE27zOfBojnrAgRow==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr385401wrn.3.1584021084647;
        Thu, 12 Mar 2020 06:51:24 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e1sm64177153wrx.90.2020.03.12.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:51:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Jon Doron <arilou@gmail.com>, Wei Liu <wei.liu@kernel.org>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v4 2/5] x86/hyper-v: Add synthetic debugger definitions
In-Reply-To: <MW2PR2101MB10522800EB048383C227F556D7FF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200309182017.3559534-1-arilou@gmail.com> <20200309182017.3559534-3-arilou@gmail.com> <DM5PR2101MB104761F98A44ACB77DA5B414D7FE0@DM5PR2101MB1047.namprd21.prod.outlook.com> <20200310032453.GC3755153@jondnuc> <MW2PR2101MB10522800EB048383C227F556D7FF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Thu, 12 Mar 2020 14:51:23 +0100
Message-ID: <87d09hr89w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> I'm flexible, and trying to not be a pain-in-the-neck. :-)  What would
> the KVM guys think about putting the definitions in a KVM specific
> #include file, and clearly marking them as deprecated, mostly
> undocumented, and used only to support debugging old Windows
> versions?

I *think* we should do the following: defines which *are* present in
TLFS doc (e.g. HV_FEATURE_DEBUG_MSRS_AVAILABLE,
HV_STATUS_OPERATION_DENIED, ...) go to asm/hyperv-tlfs.h, the rest
(syndbg) stuff goes to kvm-specific include (I'd suggest we just use
hyperv.h we already have).

What do you think?

-- 
Vitaly

