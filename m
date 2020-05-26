Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F461B22C2
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2020 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgDUJ3a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Apr 2020 05:29:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34144 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgDUJ3a (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Apr 2020 05:29:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id j1so10216169wrt.1;
        Tue, 21 Apr 2020 02:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/tISfwZ2P2IUPEnX9Ik/x1A1mBudIbHpjoDQ3zbjbU=;
        b=aLIpYqtp1056EycBKIvtLqPb1epUAERAHaUAT2DRgCXMRLARzXR90PZNEuwGnk7qzl
         5o7Rn9B1BjNFqQruvBmrOjtzNoLZWY9PFg8Oy9oLUdQUSPpNhFeHQ7845+3QMLNSqZ8N
         xZIWpxkWWLyq38IfdIbfSKSSCU++ApYSZg73ELd4IsO01Hfqym6iKvfCb6aqwfUUPH8I
         NsDj1T0nypUe/chwjqeg/Gs1tVvZV/QEvoSocauhBCYqJ9hsbKqevo+UQ8CKivgluYK0
         9yWBMk0X0VnN09lUVcDma1afaEEWBdvna3VRkCnuursNG+T0RN+wFdAndAWprqe0woxX
         /qvg==
X-Gm-Message-State: AGi0PuY2uKyr2rSze11p0UHc+I+vy/DuiWsIPU4+7G07qYibFpzw2Xyd
        Bhfwrx4qdeweuPCWB+BHaSA=
X-Google-Smtp-Source: APiQypIBBN/uGVX/DEWvjQAOpu65oajLoYZMjKknPf3JNM3a1RJdljdDjsSgYu4F31wtMTnmwqTd9A==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr23665401wrq.306.1587461368049;
        Tue, 21 Apr 2020 02:29:28 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id s14sm2609467wmh.18.2020.04.21.02.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 02:29:27 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:29:25 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] KVM: x86: hyperv: Remove duplicate definitions of
 Reference TSC Page
Message-ID: <20200421092925.rxb72yep4paruvi6@debian>
References: <20200420173838.24672-1-mikelley@microsoft.com>
 <20200420173838.24672-2-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420173838.24672-2-mikelley@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Apr 20, 2020 at 10:38:35AM -0700, Michael Kelley wrote:
> The Hyper-V Reference TSC Page structure is defined twice. struct
> ms_hyperv_tsc_page has padding out to a full 4 Kbyte page size. But
> the padding is not needed because the declaration includes a union
> with HV_HYP_PAGE_SIZE.  KVM uses the second definition, which is
> struct _HV_REFERENCE_TSC_PAGE, because it does not have the padding.
> 
> Fix the duplication by removing the padding from ms_hyperv_tsc_page.
> Fix up the KVM code to use it. Remove the no longer used struct
> _HV_REFERENCE_TSC_PAGE.
> 
> There is no functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 8 --------
>  arch/x86/include/asm/kvm_host.h    | 2 +-
>  arch/x86/kvm/hyperv.c              | 4 ++--

Paolo, this patch touches KVM code. Let me know how you would like to
handle this.

Wei.
