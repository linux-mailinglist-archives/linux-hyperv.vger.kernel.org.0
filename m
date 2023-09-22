Return-Path: <linux-hyperv+bounces-198-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6977AB9A8
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 20:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 785EEB209E2
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 18:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB342C11;
	Fri, 22 Sep 2023 18:53:55 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAE43AAD
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 18:53:54 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B012A9;
	Fri, 22 Sep 2023 11:53:53 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso2189348b3a.0;
        Fri, 22 Sep 2023 11:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408833; x=1696013633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyufS6U3IQklYUt2ci6ahYWNxLqO+WW3OlDCROay6ew=;
        b=sPoFebxaib2U4S8uTXnpB6NMVmZRqy9UEHjVWUAqsh6rxJLQK2p2OmkEyycx/ndPzB
         eNidHC9ht3XKSExPI2A2HQpWmwUIT2DLNpJoxW28c1wC1BfR9GjSS1tGFSQgiQD6iqJY
         pg8b15+HRm/RRymDfCx6murwKlmp0d/AmMZSxhcXa8zVixsPWzFPhQQBznUJSUQeA8b4
         eKpGYH+sJEQ0s8t+yP2XMjvML/iGm4Ne3zRnil+v3WJh0+O+kdAHlWPFwnrKnZfyLCq6
         yv0sJEwa+X/219J4dpB/Wj63UER9mgLcy6CkglMP7P/Mlq46y9LQ+Dy4xP1e9IPTADUd
         jSAQ==
X-Gm-Message-State: AOJu0Yy1QkKPEXzOc8niMIZDxpzmhEU+bZI0I469e0H4u+NWEhtmsxkC
	cyvjY/y8/AV+sy5OvV+87ENRpkxpYPA=
X-Google-Smtp-Source: AGHT+IGOzg9RTsyttQDdVui32fWhrE83yhzu41HT1TK1Q9puqq0koGTP4Espho+J5bs0KrsUPw9zQg==
X-Received: by 2002:a05:6a00:10c8:b0:690:cd6e:8d38 with SMTP id d8-20020a056a0010c800b00690cd6e8d38mr227642pfu.25.1695408833024;
        Fri, 22 Sep 2023 11:53:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id b124-20020a633482000000b00563df2ba23bsm3460692pga.50.2023.09.22.11.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:53:52 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:53:09 +0000
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
Subject: Re: [PATCH v3 02/15] mshyperv: Introduce hv_get_hypervisor_version
 function
Message-ID: <ZQ3ilYnlBYaPMXxG@liuwe-devbox-debian-v2>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-3-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695407915-12216-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 11:38:22AM -0700, Nuno Das Neves wrote:
> x86_64 and arm64 implementations to get the hypervisor version
> information. Store these in hv_hypervisor_version_info structure to
> simplify parsing the fields.
> 
> Replace the existing parsing when printing the version numbers at boot.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

