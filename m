Return-Path: <linux-hyperv+bounces-524-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1067C961B
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Oct 2023 21:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159AA281C79
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Oct 2023 19:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820DD1774A;
	Sat, 14 Oct 2023 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C820B04;
	Sat, 14 Oct 2023 19:42:23 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F65E0;
	Sat, 14 Oct 2023 12:42:21 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so1260754b3a.3;
        Sat, 14 Oct 2023 12:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697312541; x=1697917341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3Pgxs65bzmqRGU8eNhxQM9/CMPLQ60nbxboGtVM7Ts=;
        b=S1ulLD9fnVMr1TqWVNWfcZtzgZyyXudqd4u++WIdg64ewsjwTLlzUuIlVnlSmkC+yQ
         q+YMsYXRY48CLTEGLm6TDPYzoogV/VftHkIcROmNPBKXaDahydu4xmqn58Sld5bKmw9q
         BaFNi05ii4SCasRgMmQIhzgD7BKQI/92P2nn8A1ihphJRxYzjWjm29FJOhWHOWw/9bjG
         fY12ztl5HtGrH1LN6MbrbOIABoNFgvdrcvAyxttBVaFH28BhlD/vTaP5UggOiWfXW39u
         zY9Hac6k6ASt8KFs/G4PqUPm7sB4txzP/wUJcHIPSzmb3BbBS1PZLT2sfIZ39oLHyph1
         FFzg==
X-Gm-Message-State: AOJu0Ywz+Sinf66dnTKnZpyiVJ+ItD3mdrGlj9wtewGpvdZ5JhaDhja+
	QApxV3/+VO+w8w2wSkJBS5c=
X-Google-Smtp-Source: AGHT+IH9SsXxFtZ7hhyfnLmTYErPL+SJUkVcK5yffxgXrGSKgMglp9OxgidSatV+IqZVNbRAvPokEg==
X-Received: by 2002:a05:6a20:430e:b0:121:ca90:df01 with SMTP id h14-20020a056a20430e00b00121ca90df01mr30647667pzk.40.1697312541143;
        Sat, 14 Oct 2023 12:42:21 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001c0c86a5415sm5889941plw.154.2023.10.14.12.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 12:42:20 -0700 (PDT)
Date: Sun, 15 Oct 2023 04:42:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Kees Cook <keescook@chromium.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Annotate struct hv_dr_state with __counted_by
Message-ID: <20231014194218.GA1246721@rocinante>
References: <20230922175257.work.900-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175257.work.900-kees@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct hv_dr_state.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Applied to controller/hyperv, thank you!

[1/1] PCI: hv: Annotate struct hv_dr_state with __counted_by
      https://git.kernel.org/pci/pci/c/45538f68b052

	Krzysztof

