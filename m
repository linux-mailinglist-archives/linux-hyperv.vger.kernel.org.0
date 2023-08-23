Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB14D785003
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Aug 2023 07:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjHWFmz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Aug 2023 01:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjHWFmz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Aug 2023 01:42:55 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A5D10B;
        Tue, 22 Aug 2023 22:42:53 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bf0b24d925so34362485ad.3;
        Tue, 22 Aug 2023 22:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692769373; x=1693374173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7SuHeADhiwKqTmvuzAw3dFizq+0uKLvXLc6/Gr+tX4=;
        b=NdhmuQgXNpHBll0NW0kyJ4/UKl5jw6jedfnIbLRry44aw3Ik2MgEeZQLUCWaE/8GQO
         1JgNJ6b31f9AXbcqFDNlfT0e9GbydonJrfWWB1Fvwc84Nn7wnvQ2aFfXTD6JAIEf/88m
         /m6WPoIhtPDiQJcizyJATHQW2N1Ju9J+dUhOfKnHmvmKX9KEmHBbJAabwGJlwvt0M4uL
         uiw04mFOIkrw+wllDFmkv6bq3bihk43Nh+w2GNfsCz9aVOdnL8n5R5M02g3D7sPmZPsf
         KdCQmBX7v3xwVq3GfsiV4tmxxUeTPO81Pt+J1PDtdzoz5WxDi+BRo16Vp+Ev+9sUHOOd
         WRmg==
X-Gm-Message-State: AOJu0Yz93yB2yIAZBTFxtrCtsrgn1ZffseYcuy4aygWbke+WD4KpW/tn
        ZgOa6POh64IxNaGLtxdyL4Q=
X-Google-Smtp-Source: AGHT+IHpBx9WJt0TP4xuv2JVlMBs97PJAKc9tws5wtGb13UtWB6SrdPNMYd/nSa0a1zrIqV6sF7E6g==
X-Received: by 2002:a17:903:32d2:b0:1bf:1181:a614 with SMTP id i18-20020a17090332d200b001bf1181a614mr10763436plr.26.1692769373273;
        Tue, 22 Aug 2023 22:42:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902b78900b001b5656b0bf9sm9921263pls.286.2023.08.22.22.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 22:42:52 -0700 (PDT)
Date:   Wed, 23 Aug 2023 05:42:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        tiala@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/hyperv: Fix undefined reference to
 isolation_type_en_snp without CONFIG_HYPERV
Message-ID: <ZOWcSKlonRpbNloN@liuwe-devbox-debian-v2>
References: <20230823032008.18186-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823032008.18186-1-decui@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 22, 2023 at 08:20:08PM -0700, Dexuan Cui wrote:
> When CONFIG_HYPERV is not set, arch/x86/hyperv/ivm.c is not built (see
> arch/x86/Kbuild), so 'isolation_type_en_snp' in the ivm.c is not defined,
> and this failure happens:
> 
> ld: arch/x86/kernel/cpu/mshyperv.o: in function `ms_hyperv_init_platform':
> arch/x86/kernel/cpu/mshyperv.c:417: undefined reference to `isolation_type_en_snp'
> 
> Fix the failure by testing hv_get_isolation_type() and
> ms_hyperv.paravisor_present for a fully enlightened SNP VM: when
> CONFIG_HYPERV is not set, hv_get_isolation_type() is defined as a
> static inline function that always returns HV_ISOLATION_TYPE_NONE
> (see include/asm-generic/mshyperv.h), so the compiler won't generate any
> code for the ms_hyperv.paravisor_present and static_branch_enable().
> 
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Closes: https://lore.kernel.org/lkml/b4979997-23b9-0c43-574e-e4a3506500ff@amd.com/
> Fixes: d6e2d6524437 ("x86/hyperv: Add sev-snp enlightened guest static key")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied. Thanks.
