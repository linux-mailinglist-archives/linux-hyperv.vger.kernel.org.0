Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39226BE764
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Mar 2023 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCQK6R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Mar 2023 06:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCQK6Q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Mar 2023 06:58:16 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C934C22;
        Fri, 17 Mar 2023 03:58:11 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id y14so4031847wrq.4;
        Fri, 17 Mar 2023 03:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679050689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vOkNaE/TWI3jduytxs7WicDzMHo3tHuCTXWmM7qHy0=;
        b=PBfRTFXLM1jxA72GoK5U04AsGVDrxZcDOCpWiH8p3v0sLqssFRhV+hXkxCj511Dkh2
         +6KNQE2E3LJB+y1r7XcIwK9fObIX7g9O4ZWr3KoeaYZ9ONL8EpBiJxs3SYNhw3odizTY
         AHyZtdTyhK0AGxIdPGwpA7IzCauBK6zjy3sG6L/BkSnBlSKZhYdm1QCCRGmLWrFgoUR3
         6n4H4oqPzNBh0fHLwheFypFRkfvMW2vUBPbg9X3DinIEoUKVjhrnRrFSmvuHEGznIGum
         EXr5KfDI49oScUdWtjD4ynxhQZaAuMSoe2B586zO/n49s4YVsVsjZ1CDkfgHumbuNbCR
         48LA==
X-Gm-Message-State: AO0yUKUhydtH2d2XULr7qk26m/JIyqmf4+w2+zTMF4rucmURfgsQsmAm
        xzh5Lc/NP7pHMHAsPX81/Sg=
X-Google-Smtp-Source: AK7set9sGw7iXXdVoiV+kOawF2/v4txV73NNutWJ6nOzM6nMIviPHfoLG/j+vEyZM7V8hvpN77gN7w==
X-Received: by 2002:adf:dc44:0:b0:2ce:6f5a:c3b8 with SMTP id m4-20020adfdc44000000b002ce6f5ac3b8mr7407058wrj.31.1679050689576;
        Fri, 17 Mar 2023 03:58:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d4a08000000b002c3f03d8851sm1688809wrq.16.2023.03.17.03.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 03:58:09 -0700 (PDT)
Date:   Fri, 17 Mar 2023 10:57:59 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Block root partition functionality in a
 Confidential VM
Message-ID: <ZBRHt9TnYLuA+tI3@liuwe-devbox-debian-v2>
References: <1678894453-95392-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678894453-95392-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 15, 2023 at 08:34:13AM -0700, Michael Kelley wrote:
> Hyper-V should never specify a VM that is a Confidential VM and also
> running in the root partition.  Nonetheless, explicitly block such a
> combination to guard against a compromised Hyper-V maliciously trying to
> exploit root partition functionality in a Confidential VM to expose
> Confidential VM secrets. No known bug is being fixed, but the attack
> surface for Confidential VMs on Hyper-V is reduced.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.

> ---
>  arch/x86/kernel/cpu/mshyperv.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index ff348eb..ac630ec 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -356,12 +356,16 @@ static void __init ms_hyperv_init_platform(void)
>  	 * To mirror what Windows does we should extract CPU management
>  	 * features and use the ReservedIdentityBit to detect if Linux is the
>  	 * root partition. But that requires negotiating CPU management
> -	 * interface (a process to be finalized).
> +	 * interface (a process to be finalized). For now, use the privilege
> +	 * flag as the indicator for running as root.
>  	 *
> -	 * For now, use the privilege flag as the indicator for running as
> -	 * root.
> +	 * Hyper-V should never specify running as root and as a Confidential
> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
> +	 * to exploit root behavior to expose Confidential VM memory, ignore
> +	 * the root partition setting if also a Confidential VM.
>  	 */
> -	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
> +	if ((ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
>  		hv_root_partition = true;
>  		pr_info("Hyper-V: running as root partition\n");
>  	}
> -- 
> 1.8.3.1
> 
