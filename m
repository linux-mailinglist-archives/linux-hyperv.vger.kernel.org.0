Return-Path: <linux-hyperv+bounces-1658-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6B786FA68
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Mar 2024 08:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B35C281094
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Mar 2024 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F277D12E4F;
	Mon,  4 Mar 2024 07:02:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D523BF;
	Mon,  4 Mar 2024 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535750; cv=none; b=f43vX48nyiliMDGPgR2Hu+sR4U0jlTiO5J1Ztf0YjpE/KcNa9xD3X2lUux+xNFTogBScP/ZzvIZalQsARpgEdHA6vRmAv+KFPMth7O35g9kXu34XPuhp70dtc2crUCmt6tRmI6nH69ivYDSQlhGgOhLWCFAd4AyDLQZmLCJcKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535750; c=relaxed/simple;
	bh=aJ5p6h5NqLe9ao8JDZwx1yQrcK2zZckmbFQEaEraWyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+5rOXeXB97+edXCMMQencbMKACnoBZzEM/qiSc1wJK3YV861WazPNSzjYOtnWss5EiHn8lPdQ7rAqSotKTvOMNLCwA2amTwCZHP9edOngGJyxajRQCPTvK02rZolPEJ7ba3LGgdq5Sn85aLTC+i+qb97sdZT4ItbRbADbeUdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e56787e691so3432052b3a.0;
        Sun, 03 Mar 2024 23:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535749; x=1710140549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC37bSzdBtUBBNQV5iUBpdKi76PLoPq1WFB5wKrjzOU=;
        b=vFho0Evpsrjo4SCPv/Y4C7DfSDUw3gy1sTp9Zb2yhvVaznz/es9WuKz5DNc0WW2eTt
         YVmtMBsA1FkfqMW74hvoBlChoYkVmFN6aU2GGin3L8dSyTTed0ezOriq2UgFwtJY3czu
         KppgZKvqWf4ilT2qhVtj0t4KNtd1KqAg+3nmH0MpzYmq40PXr5XkR3uS7FtCFWjdmNO4
         UbsbxAFFpBd62tEtriYQ/3mnzhQ6uzaYpJ6k1DQYu2Sk776lPi/9ikMp816SgoYr4u1L
         Cr/Nx8q+m/iaLfWREmQpWCkDHwrzvJecfKoVb0NF6q2ftKYQnBdidQXh8pUW3uP/6O9a
         nrkw==
X-Forwarded-Encrypted: i=1; AJvYcCUotx62lDEMnN0nlk9pFw7BkqDeTBNX1ijNFfWSE/52zNLg1Bsp3Mj2tjbrKVKtOImJWfpVu9IrNJq+2oGmxpHo0L2erKI7MBW0AEja
X-Gm-Message-State: AOJu0Yyo9Cf6j9EG8C/JTpWHPNriIVztpnbx/OiA6uEUdmWj02300DjF
	RvgNY+7du5/hzumdgE0Rqu7HDbVsTvI4dR1YinYkRW2Ec4Z2Xt1I
X-Google-Smtp-Source: AGHT+IGyBcLbz/mSpNte4API3iNxozhQfHaByYVikAgJ+U4M8Qfh/8xzGaEPldFUWT1aqNHhoPo6WQ==
X-Received: by 2002:a05:6a20:938e:b0:1a1:215a:335e with SMTP id x14-20020a056a20938e00b001a1215a335emr10567710pzh.27.1709535748986;
        Sun, 03 Mar 2024 23:02:28 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id r8-20020aa79ec8000000b006e50cedb59bsm6724928pfq.16.2024.03.03.23.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:02:28 -0800 (PST)
Date: Mon, 4 Mar 2024 07:02:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	haiyangz@microsoft.com, mhklinu@outlook.com, kys@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
	tglx@linutronix.de, daniel.lezcano@linaro.org, arnd@arndb.de
Subject: Re: [PATCH v2] hyperv-tlfs: Change prefix of generic HV_REGISTER_*
 MSRs to HV_MSR_*
Message-ID: <ZeVyAB96VIYCxfRh@liuwe-devbox-debian-v2>
References: <1708440933-27125-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708440933-27125-1-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Feb 20, 2024 at 06:55:33AM -0800, Nuno Das Neves wrote:
> The HV_REGISTER_ are used as arguments to hv_set/get_register(), which
> delegate to arch-specific mechanisms for getting/setting synthetic
> Hyper-V MSRs.
> 
> On arm64, HV_REGISTER_ defines are synthetic VP registers accessed via
> the get/set vp registers hypercalls. The naming matches the TLFS
> document, although these register names are not specific to arm64.
> 
> However, on x86 the prefix HV_REGISTER_ indicates Hyper-V MSRs accessed
> via rdmsrl()/wrmsrl(). This is not consistent with the TLFS doc, where
> HV_REGISTER_ is *only* used for used for VP register names used by
> the get/set register hypercalls.
> 
> To fix this inconsistency and prevent future confusion, change the
> arch-generic aliases used by callers of hv_set/get_register() to have
> the prefix HV_MSR_ instead of HV_REGISTER_.
> 
> Use the prefix HV_X64_MSR_ for the x86-only Hyper-V MSRs. On x86, the
> generic HV_MSR_'s point to the corresponding HV_X64_MSR_.
> 
> Move the arm64 HV_REGISTER_* defines to the asm-generic hyperv-tlfs.h,
> since these are not specific to arm64. On arm64, the generic HV_MSR_'s
> point to the corresponding HV_REGISTER_.
> 
> While at it, rename hv_get/set_registers() and related functions to
> hv_get/set_msr(), hv_get/set_nested_msr(), etc. These are only used for
> Hyper-V MSRs and this naming makes that clear.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next. Thanks.

