Return-Path: <linux-hyperv+bounces-853-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4D67E8699
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Nov 2023 00:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949021C2037A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 23:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43A83C061;
	Fri, 10 Nov 2023 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE143D3A8
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Nov 2023 23:28:32 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DE1118;
	Fri, 10 Nov 2023 15:28:31 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3574297c79eso9515195ab.1;
        Fri, 10 Nov 2023 15:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699658910; x=1700263710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCAj8D50QhU0Sd2mpWJYIypfLV54gJQXB6a5grPUfMc=;
        b=DqqwkzIURINnn9gHwHCXyQwdp5gy0+EbOiVlEadZWH8X6oMma74UGHYbZfLedp5dVo
         qClj/ljfeX5NEFkc5Qidw2s7TlYveQWp2mctLsCYFhbb/I68fPqY8fuj7kSiWVDiDk1M
         U5D/Hidw5iWT9Edgby5BPQMXmCoWDZrJa6trRltzlm8kLcyzOA97odNwSYL13PCSCp8c
         UP991rocdxGETTNfrSjEMz6VYL4ZGtYUMIVitcWy0AhyYqlNwmBLi2FVegePPWDzfP31
         cGXGlNAOd6tK1+gJENzwl62NcOy9UfiaQLsvyh8UFD8teeTSAPOPPr3K8XOtcvXO9TXL
         gI0w==
X-Gm-Message-State: AOJu0Yz6S+rZy+WtOZIqEtoiVnma/seL+OKeI34TNDlVAJLdAPd7KXtO
	HCBeJy1m67jomH8Okb8rkb4=
X-Google-Smtp-Source: AGHT+IH4aXf25zTCH958ckBntxsHHjlaxNgRFx8xPVGemn1uLjFcxDZR6O6l1Y2pjNkSj4LzU/VzOg==
X-Received: by 2002:a05:6e02:1808:b0:359:4f85:b230 with SMTP id a8-20020a056e02180800b003594f85b230mr1188146ilv.18.1699658910361;
        Fri, 10 Nov 2023 15:28:30 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id v4-20020a62a504000000b0068be348e35fsm244667pfm.166.2023.11.10.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 15:28:29 -0800 (PST)
Date: Fri, 10 Nov 2023 23:28:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Ani Sinha <anisinha@redhat.com>, Wei Liu <wei.liu@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Wei Liu <liuwe@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hv/hv_kvp_daemon: Some small fixes for handling NM
 keyfiles
Message-ID: <ZU68nNVSD4QkgVr2@liuwe-devbox-debian-v2>
References: <20231016133122.2419537-1-anisinha@redhat.com>
 <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <E44432C5-17B2-47FC-B382-384659B21DCF@redhat.com>
 <5D793B43-B5DB-4BA2-9F1E-B01D5E2487D2@redhat.com>
 <1D09E6F5-9120-40D4-A365-AF04E9AA5587@redhat.com>
 <PH7PR21MB31164A4B84974856943DBBBACAAEA@PH7PR21MB3116.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB31164A4B84974856943DBBBACAAEA@PH7PR21MB3116.namprd21.prod.outlook.com>

On Fri, Nov 10, 2023 at 02:59:14PM +0000, Haiyang Zhang wrote:
> @Wei Liu<mailto:liuwe@microsoft.com>  Could you please add this to the hv tree?
> 

Applied to hyperv-fixes. Sorry for the delay.

Thanks,
Wei.

