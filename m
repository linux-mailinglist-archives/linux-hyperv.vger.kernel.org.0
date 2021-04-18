Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC80363567
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Apr 2021 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhDRNJh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 18 Apr 2021 09:09:37 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33626 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRNJf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 18 Apr 2021 09:09:35 -0400
Received: by mail-wr1-f45.google.com with SMTP id g9so15177376wrx.0;
        Sun, 18 Apr 2021 06:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ZUeIciP6NTjRRy3hWXPiKcVedDmBXRhvWpAyqIu7Co=;
        b=l0gU2yChu3RD8T0+jb0kXwsGOX9sD+uP+WdUSGCdMP9uWr8luB6x4Mp05BzE2zgJ8L
         8r2QMJt4UIMiX1LJUz64zd6kc+YnC88rWtH/tdGrEUoUL7oI8ei4IP0v4G9e/hHUTfq3
         0/AVdRp8f3a1Nbe8gyEfG0AprjRl9eaxa1eUPLxPVeHA81xjZvWECWSZns0Ro+2bGbJ6
         QpJRvRb2EnSvsQzRPK5VZ1R/s9KgNLkNQE0/kL/KEc3WssVDK9XU3lC7tsRay38xondz
         oHRrBApKZTSNrz4nbotiCjJXKJx4p0Nysc88ns+FBh8JxeWMTzh97o1Wp4hcIb/4jSiL
         k1ww==
X-Gm-Message-State: AOAM533vlw+r5xnw/8kT68LGA/PK9CiiVGXVYC/vHXDL6f+vPfKmNzcB
        vhgA04cUKvibfCjZxwlzR5J1c+aUgOs=
X-Google-Smtp-Source: ABdhPJynPlhNm6AYFeFwRpZtzl1hssaeaMbRzdDjRxZP5w1iuaQW2C79O5FeZ9VdpIkyLy5Lu8L5/g==
X-Received: by 2002:a5d:6605:: with SMTP id n5mr9018275wru.116.1618751345104;
        Sun, 18 Apr 2021 06:09:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a15sm18287943wrr.53.2021.04.18.06.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 06:09:04 -0700 (PDT)
Date:   Sun, 18 Apr 2021 13:09:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     joseph.salisbury@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, mikelley@microsoft.com,
        x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/hyperv: Move hv_do_rep_hypercall to asm-generic
Message-ID: <20210418130903.5r66yzm6qxizfrop@liuwe-devbox-debian-v2>
References: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Apr 16, 2021 at 05:43:02PM -0700, Joseph Salisbury wrote:
> From: Joseph Salisbury <joseph.salisbury@microsoft.com>
> 
> This patch makes no functional changes.  It simply moves hv_do_rep_hypercall()
> out of arch/x86/include/asm/mshyperv.h and into asm-generic/mshyperv.h
> 
> hv_do_rep_hypercall() is architecture independent, so it makes sense that it
> should be in the architecture independent mshyperv.h, not in the x86-specific
> mshyperv.h.
> 
> This is done in preperation for a follow up patch which creates a consistent
> pattern for checking Hyper-V hypercall status.
> 
> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> ---
[...]
> +static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
> +				      void *input, void *output)
> +{
> +	u64 control = code;
> +	u64 status;
> +	u16 rep_comp;
> +
> +	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
> +	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
> +
> +	do {
> +		status = hv_do_hypercall(control, input, output);
> +		if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS)
> +			return status;
> +
> +		/* Bits 32-43 of status have 'Reps completed' data. */
> +		rep_comp = (status & HV_HYPERCALL_REP_COMP_MASK) >>
> +			HV_HYPERCALL_REP_COMP_OFFSET;
> +
> +		control &= ~HV_HYPERCALL_REP_START_MASK;
> +		control |= (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
> +
> +		touch_nmi_watchdog();

This seems to be missing in Arm. Does it compile?

Wei.

> +	} while (rep_comp < rep_count);
> +
> +	return status;
> +}
>  
>  /* Generate the guest OS identifier as described in the Hyper-V TLFS */
>  static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
> -- 
> 2.17.1
> 
