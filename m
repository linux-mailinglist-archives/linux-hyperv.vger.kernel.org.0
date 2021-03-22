Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538CE345166
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 22:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCVVJB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 17:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVVId (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 17:08:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7170C061574;
        Mon, 22 Mar 2021 14:08:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j3so21039196edp.11;
        Mon, 22 Mar 2021 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MeMyP6yxpEyI8O18iLMWHARj/2oI4TtzSo5lwW4fJW4=;
        b=k5ZGdyQ0UwJMm0SwLsEVo76cQvkNMXFAqTOh+dAJ1+3/dwFvDk8Qfk9LlXI+HULT2T
         LQekvdF2sqsyQDjh23IpBUHLWUwX7c+9LTWKmXmExAqDs5UiaBgBfrmSSFZ07G7k6WNI
         DVWdl8ZP4p0a7AlAn1c763j8WLiEBQO8tGMwDTQZGwr1YbhM+DsMyUfUyCDNEMBP0Sw0
         Ly8TglYJLFeUrCKRlMHPzay9ybP6GaWMOMj+lsRvyyH9TWjB5MofI9gG6Ssqif+lrfMi
         /0SI2Fv/ppGBf8mqqBdNlbnDyOrtNF1GbWowpmAO0vlYeMwRkHWeDICTgJ61ItlzB0gk
         YQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=MeMyP6yxpEyI8O18iLMWHARj/2oI4TtzSo5lwW4fJW4=;
        b=lBm3gQQCavVrg4hQGme67zQV78EWGPTyeXU63XIBOR/HyuoHuA8s9q1IltuRl3+QSX
         pH+cR4VNDubxxWL/TrYGlwQISM/qLei6jvXNAEpDHdILLsMHGy0J0j9jsfHlkiwlHLNK
         AFEgQI9nL78toTnZvxnQjgMxes2XCSAjxYwWoKYrlEiSeSDGlEmL83zpsRVZmXZQeWFz
         baHaYUqQ4D59gaKls8Kn9orqW7NV51QFYfjrONXCdNkXDrWqVLYliws8pO0AWOrXfVMR
         fNe/j5l6xw2sdtgARcTiImR/7ucj4wPfuF1bNmgaVJ3Rz6DpHqTC3OSD2QScq3y7Ngm1
         k5lw==
X-Gm-Message-State: AOAM532yciLPntDDbFHoc0j3mtKRphwnYhIGS02fqugWHmFHal1kd9Qe
        YzAv2Nw8UKogoaYY0gRMcV4=
X-Google-Smtp-Source: ABdhPJyJy6b4NgHlWF7ybHfmpOB4WIT/W3vU8jy382mzzp7k6G9l2p2gO8bGRlUepZunXM3MIpJoKg==
X-Received: by 2002:aa7:cd16:: with SMTP id b22mr1514895edw.357.1616447310498;
        Mon, 22 Mar 2021 14:08:30 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v22sm10184101ejj.103.2021.03.22.14.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 14:08:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 22 Mar 2021 22:08:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnny.chenyi@huawei.com, heying24@huawei.com
Subject: Re: [PATCH -next] x86: Fix unused variable 'msr_val' warning
Message-ID: <20210322210828.GA1961861@gmail.com>
References: <20210322031713.23853-1-xuyihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322031713.23853-1-xuyihang@huawei.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


* Xu Yihang <xuyihang@huawei.com> wrote:

> Fixes the following W=1 kernel build warning(s):
> arch/x86/hyperv/hv_spinlock.c:28:16: warning: variable ‘msr_val’ set but not used [-Wunused-but-set-variable]
>   unsigned long msr_val;
> 
> As Hypervisor Top-Level Functional Specification states in chapter 7.5 Virtual Processor Idle Sleep State, "A partition which possesses the AccessGuestIdleMsr privilege (refer to section 4.2.2) may trigger entry into the virtual processor idle sleep state through a read to the hypervisor-defined MSR HV_X64_MSR_GUEST_IDLE". That means only a read is necessary, msr_val is not uesed, so __maybe_unused should be added.
> 
> Reference:
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Yihang <xuyihang@huawei.com>
> ---
>  arch/x86/hyperv/hv_spinlock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
> index f3270c1fc48c..67bc15c7752a 100644
> --- a/arch/x86/hyperv/hv_spinlock.c
> +++ b/arch/x86/hyperv/hv_spinlock.c
> @@ -25,7 +25,7 @@ static void hv_qlock_kick(int cpu)
>  
>  static void hv_qlock_wait(u8 *byte, u8 val)
>  {
> -	unsigned long msr_val;
> +	unsigned long msr_val __maybe_unused;
>  	unsigned long flags;

Please don't add new __maybe_unused annotations to the x86 tree - 
improve the flow instead to help GCC recognize the initialization 
sequence better.

Thanks,

	Ingo
