Return-Path: <linux-hyperv+bounces-191-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 962C07AB974
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 20:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 2B8901F22EF8
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 18:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05D941E40;
	Fri, 22 Sep 2023 18:42:41 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC641C29
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 18:42:40 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815DAA9;
	Fri, 22 Sep 2023 11:42:39 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so22975025ad.1;
        Fri, 22 Sep 2023 11:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408159; x=1696012959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy4Qx3oAlemzZ68pG10cO3ool7kPh2NALLfQXvvFL/M=;
        b=H2pbrAMvmp8v/KmbukUu/IxvsRmZB1t7TwZCQVN0Sc8XFsyqE7dt6JE1po/DS2Ht5A
         AOKOflk+ncq6YqNGDxLBxE+HMcyBJFrTqRTVBErAGZFVG3GEkRH+b9MKT+U0jgQ31jGJ
         Uwbi7f6INYV7AuRzCSifMjtZCZsETV4rbKAj6yVRpvcSt9VuhqiCtHSLuj3kjktOW2/d
         OB7nHh+1pFnn5AzyKa+I8UPrjMU2h55G8/4eCS5VVzZ6R5w1mv9Mjdagol/nas0ZLrlM
         v4HJRvOnF0t/gM+HarXQrUy9qIC3WTGgGl1L1/KZXvE8zLkJKTCcF2k5zlqtw0YQ/59B
         ndBg==
X-Gm-Message-State: AOJu0YyEGHIzEJ6N8s+UFqelRvTEURXeVp3GZm1mseFkHCpHEo6zySPG
	nvgbiNivJA6csWnifL4NBnfEHjyCOME=
X-Google-Smtp-Source: AGHT+IE8Zjcqr0VIt3JGl7z6pVgiqpImUuwwkhyrlyBkP+oL46ew3ySJ0QlB4eTQ9I7Qsih5vWVmCg==
X-Received: by 2002:a17:903:120a:b0:1c4:2641:7744 with SMTP id l10-20020a170903120a00b001c426417744mr332698plh.25.1695408158778;
        Fri, 22 Sep 2023 11:42:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001bc18e579aesm3831240pla.101.2023.09.22.11.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:42:38 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:41:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mikelley@microsoft.com,
	vkuznets@redhat.com, ssengar@microsoft.com
Subject: Re: [PATCH v3] x86/hyperv: Restrict get_vtl to only VTL platforms
Message-ID: <ZQ3f8wY0R8OqEmIl@liuwe-devbox-debian-v2>
References: <1695182675-13405-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695182675-13405-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 09:04:35PM -0700, Saurabh Sengar wrote:
> When Linux runs in a non-default VTL (CONFIG_HYPERV_VTL_MODE=y),
> get_vtl() must never fail as its return value is used in negotiations
> with the host. In the more generic case, (CONFIG_HYPERV_VTL_MODE=n) the
> VTL is always zero so there's no need to do the hypercall.
> 
> Make get_vtl() BUG() in case of failure and put the implementation under
> "if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)" to avoid the call altogether in
> the most generic use case.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied to hyperv-fixes. Thanks.

