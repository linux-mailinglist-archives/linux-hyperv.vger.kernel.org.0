Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4CC363664
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Apr 2021 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhDRPfq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 18 Apr 2021 11:35:46 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:42704 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhDRPfp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 18 Apr 2021 11:35:45 -0400
Received: by mail-wm1-f46.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso4980304wmq.1;
        Sun, 18 Apr 2021 08:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OwBBLy1oDm16tPPpep8TDYqrx2ASx8N2yBCY3Dbf4IM=;
        b=YbR6XnmA02Fkciy4jPgTcy62tLE/xksltAMSq4q2+cadDqCG8KQJBL+2eLq+aGE7Ig
         jkAhgVjP3SDkfE9hwLesgPkS3HaUftF8hPrdwCGomqnNvrwvtRXhuwxoIaiwtwKEVtyF
         iu8MDHR2+Gd0SgFWFPs4ZmgDSw4WzgEwXIl8rCfBaaeS/Wu69EA+1PSPhIfsWVkvm38s
         TwPw/8IQf+vRLtxFB1y6WHOARzUlla3+zTBd5sVBnBkw2K3JnrT3Q7GwRPK512U7yXfw
         x0LMRF55gSOc0HeO+qZFh45eBn3ixlTaHasYvA9wA1wQGsip0GuRv+QNpGbwmqyqlxxv
         Datw==
X-Gm-Message-State: AOAM533bhDyLwJcrRZUHqREt4IVapHygqkgW8Uck/cVkfNLxLUEhZANN
        /Uu0ncFNfhalvSPujxs6bD8Hahy0RbI=
X-Google-Smtp-Source: ABdhPJy8//XSFwN2oZM/770La9QYsmV7qKDKtUDfRme+Xg+3qL7q3UVJ2Wq1uIkTtoc6uG9VhczpzA==
X-Received: by 2002:a05:600c:35cc:: with SMTP id r12mr1406390wmq.147.1618760116790;
        Sun, 18 Apr 2021 08:35:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z14sm18267124wrs.96.2021.04.18.08.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 08:35:16 -0700 (PDT)
Date:   Sun, 18 Apr 2021 15:35:15 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Joseph Salisbury <Joseph.Salisbury@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/hyperv: Move hv_do_rep_hypercall to asm-generic
Message-ID: <20210418153515.tdhbcmwbquv7hbdp@liuwe-devbox-debian-v2>
References: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
 <20210418130903.5r66yzm6qxizfrop@liuwe-devbox-debian-v2>
 <CY4PR21MB15863413859BBF15CADD214CD74A9@CY4PR21MB1586.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB15863413859BBF15CADD214CD74A9@CY4PR21MB1586.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Apr 18, 2021 at 02:42:55PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Sunday, April 18, 2021 6:09 AM
> > On Fri, Apr 16, 2021 at 05:43:02PM -0700, Joseph Salisbury wrote:
> > > From: Joseph Salisbury <joseph.salisbury@microsoft.com>
> > >
> > > This patch makes no functional changes.  It simply moves hv_do_rep_hypercall()
> > > out of arch/x86/include/asm/mshyperv.h and into asm-generic/mshyperv.h
> > >
> > > hv_do_rep_hypercall() is architecture independent, so it makes sense that it
> > > should be in the architecture independent mshyperv.h, not in the x86-specific
> > > mshyperv.h.
> > >
> > > This is done in preperation for a follow up patch which creates a consistent
> > > pattern for checking Hyper-V hypercall status.
> > >
> > > Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> > > ---
> > [...]
> > > +static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
> > > +				      void *input, void *output)
> > > +{
> > > +	u64 control = code;
> > > +	u64 status;
> > > +	u16 rep_comp;
> > > +
> > > +	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
> > > +	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
> > > +
> > > +	do {
> > > +		status = hv_do_hypercall(control, input, output);
> > > +		if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS)
> > > +			return status;
> > > +
> > > +		/* Bits 32-43 of status have 'Reps completed' data. */
> > > +		rep_comp = (status & HV_HYPERCALL_REP_COMP_MASK) >>
> > > +			HV_HYPERCALL_REP_COMP_OFFSET;
> > > +
> > > +		control &= ~HV_HYPERCALL_REP_START_MASK;
> > > +		control |= (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
> > > +
> > > +		touch_nmi_watchdog();
> > 
> > This seems to be missing in Arm. Does it compile?
> > 
> > Wei.
> 
> touch_nmi_watchdog() is defined as "static inline" in include/linux/nmi.h.  So
> it should be present in all architectures.  It calls arch_touch_nmi_watchdog,
> which is an empty function if CONFIG_HAVE_NMI_WATCHDOG is not defined,
> as is the case on ARM64.

I see. I couldn't find arch_touch_nmi_watchdog on Arm but missed the
stub function. Thanks for the information.

Wei.
