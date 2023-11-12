Return-Path: <linux-hyperv+bounces-862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5F7E9356
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 00:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B09D280A4C
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Nov 2023 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB3818AF7;
	Sun, 12 Nov 2023 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71581BDD6;
	Sun, 12 Nov 2023 23:12:39 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72647D4C;
	Sun, 12 Nov 2023 15:12:36 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso3278770b3a.1;
        Sun, 12 Nov 2023 15:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699830756; x=1700435556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kINOohyUI5UBn47vUF3tJOP4oDKGMiC1TLYt+h+N9h8=;
        b=cKtLILqHeL+pnYUEEgjKI5t2rrlkKtdgqnc3nWqDn5V7aTjmt2zGXJEcaW95X9bDPO
         h4RHuLYLQYFf+NWleGptfxCZmr78JchXQWe0qyyFZDovrcIzFbcQYdSeF5PjdCrqNbXG
         tfGp1b1aH8m5UUCfPcCPxCbTQpeJQFkVS3e0ob58FbdyiEYsUxRJRYUe7twKw3CKe4H7
         hFJJYGla5pC4Q3gr7K6gBpq96GIyRvLBCxDBKchmYDA86IwwlVsuxntyOdK1RGLusqCL
         Z73JReRUIxeUYKQZ+pyjMZVcezBjIRxp6Tgr4zKg2M7kVncxUGvfCLuoW17BNOC4ATjN
         ZMQg==
X-Gm-Message-State: AOJu0Yyd1zZVUM1YyvQpf8ozZOu0sS379Re/WcRhaMRmnN8jmWatnuFc
	zwPGTNqe0wrdKQZ0Usph/FU=
X-Google-Smtp-Source: AGHT+IHM1xHv6Bya3xnKdXlAB4GGDEjoopo7t48S2k9vh/N7JJhUB7QT9lDd1A0TcBVCTEHnRb9f5w==
X-Received: by 2002:a05:6a00:13a8:b0:6be:2bfa:6290 with SMTP id t40-20020a056a0013a800b006be2bfa6290mr3248217pfg.8.1699830755833;
        Sun, 12 Nov 2023 15:12:35 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id n3-20020a6546c3000000b005b8f3293bf2sm2554422pgr.88.2023.11.12.15.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 15:12:35 -0800 (PST)
Date: Sun, 12 Nov 2023 23:12:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nischala Yelchuri <niyelchu@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	drawat.floss@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, deller@gmx.de,
	mhklinux@outlook.com, mhkelley@outlook.com,
	singhabhinav9051571833@gmail.com, niyelchu@microsoft.com
Subject: Re: [PATCH] Replace ioremap_cache() with memremap()
Message-ID: <ZVFb4f8IRJeCFmYD@liuwe-devbox-debian-v2>
References: <1698854508-23036-1-git-send-email-niyelchu@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698854508-23036-1-git-send-email-niyelchu@linux.microsoft.com>

On Wed, Nov 01, 2023 at 09:01:48AM -0700, Nischala Yelchuri wrote:
> Current Hyper-V code for CoCo VMs uses ioremap_cache() to map normal memory as decrypted.
> ioremap_cache() is ideally used to map I/O device memory when it has the characteristics
> of normal memory. It should not be used to map normal memory as the returned pointer
> has the __iomem attribute.

Do you find any real world issues with the current code? How do you
discover these issues?

Thanks,
Wei.

