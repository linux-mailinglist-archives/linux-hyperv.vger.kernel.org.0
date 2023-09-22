Return-Path: <linux-hyperv+bounces-197-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C027AB9A3
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 20:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id C5F5C1F2353D
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5496642C11;
	Fri, 22 Sep 2023 18:53:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F269243AAD
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 18:53:07 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2221EA9;
	Fri, 22 Sep 2023 11:53:07 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-692779f583fso1573487b3a.0;
        Fri, 22 Sep 2023 11:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408786; x=1696013586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wLBzChvWAaHXw0NzmtTui405IC0LIuO1ZABr92XOq4=;
        b=Y8Dw1Qt8QBBDWic8oj7A3gbC3aYpfSARv7esO3bwzJhZ4LhxkFqRN2mJpJ+YwxKxwS
         amIdQCVktMeXEspDfW4tmRbdOaLSSPtbZaOxEPv3ZlHnsy5QYBgVauHKm2cuLs//mZuQ
         dWr4LR5vGWEu/a6XvNrglfzg4wWdhdg65ahciIFdPDwvy2HyIlo/e9RCRVksqIjsnSpN
         z4s93n6aS385NeZTNUVjLjwjwqGYGMAumzET+Vb8JMOuOrdhjT2n3GzPvECOzhr7EuHF
         rzQmGvI9wuCOm0z+xYuNK31notePBl1FhQkIXavJfCq5TnYZX+9czD7yAK+p9aPYV4iu
         vBew==
X-Gm-Message-State: AOJu0Ywkyy5ZcloC1j3gw3rkpKIdJItUBzIYNPJEyJf5Yy1t01JA4ZGB
	VWUmaSk+D583SoMPxt+cQ04=
X-Google-Smtp-Source: AGHT+IEjoBVa60+ZQKSjWQpIoCIesiRffPKHRCzi43aByoaWcHWH1XO1QyyoWxdGTOA8xff1FjOW5A==
X-Received: by 2002:a05:6a20:3d21:b0:13d:a903:88e6 with SMTP id y33-20020a056a203d2100b0013da90388e6mr418305pzi.48.1695408786554;
        Fri, 22 Sep 2023 11:53:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id h19-20020a633853000000b0057c3b21c01dsm2276180pgn.49.2023.09.22.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:53:05 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:52:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	gregkh@linuxfoundation.org, haiyangz@microsoft.com,
	decui@microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
	mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
	jinankjain@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
	catalin.marinas@arm.com
Subject: Re: [PATCH v3 01/15] hyperv-tlfs: Change shared HV_REGISTER_*
 defines to HV_MSR_*
Message-ID: <ZQ3iZuuROFm4/7kc@liuwe-devbox-debian-v2>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-2-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695407915-12216-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 11:38:21AM -0700, Nuno Das Neves wrote:
> In x86 hyperv-tlfs, HV_REGISTER_ prefix is used to indicate MSRs
> accessed via rdmsrl/wrmsrl. But in ARM64, HV_REGISTER_ instead indicates
> VP registers accessed via get/set vp registers hypercall.
> 
> This is due to HV_REGISTER_* names being used by hv_set/get_register,
> with the arch-specific version delegating to the appropriate mechanism.
> 
> The problem is, using prefix HV_REGISTER_ for MSRs will conflict with
> VP registers when they are introduced for x86 in future.
> 
> This patch solves the issue by:
> 
> 1. Defining all the x86 MSRs with a consistent prefix: HV_X64_MSR_.
>    This is so HV_REGISTER_ can be reserved for VP registers.
> 
> 2. Change the non-arch-specific alias used by hv_set/get_register to
>    HV_MSR_. This is also happens to be the same name HyperV uses for this
>    purpose.

HyperV -> Hyper-V. I can fix this up when I apply this patch.

> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

