Return-Path: <linux-hyperv+bounces-600-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF327D86E8
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9658828202A
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2317012B69;
	Thu, 26 Oct 2023 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HhVgDKS+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97F8BF6
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Oct 2023 16:47:23 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C91B1A1
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Oct 2023 09:47:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b709048d8eso1033330b3a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Oct 2023 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698338841; x=1698943641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdlXvNC1oH8LpDpUtTg5FvSVkJ8vtx+5H8ZrGXJ1ghc=;
        b=HhVgDKS+/6Qp9UyLmiFRY1h2ZhU1Mo7r9tXKn/ETcmosEa5Y7uMDgVrxRPhvxMNv02
         9yKL6GZSSVOIL5GbTQdiCulm4EyW+qvun8qSCiVS30sNusT6MLfD1ZktERDVC3Qm/+9v
         IegEp9T1KZf0KE3f7SWLmS3eh0DZ02B3alzmFzdCh0nkwH5uRmTAcgkh0As9sjaEoLtn
         1bnKMjgAXxuVQAnxYYoQWsHfu6eRhSGqVyEmZfboAAHng05TS9Bz85B8VAfRMDSJk8je
         7Yd4Shd1EbiHswa/w9bogdExf0N5HogIrwTiiH51Hox5YWO89LADi17W7SljOvMO7184
         Rvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338841; x=1698943641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdlXvNC1oH8LpDpUtTg5FvSVkJ8vtx+5H8ZrGXJ1ghc=;
        b=ENnNBbRo4Z4F7TNIkeikQtYpDKC9XFrza2ws+nbJtdcEAhiOvN75Pbd8CdBkG2GmXo
         LA3/1Tw9i78sxyjWjfCc4bMfPy3BI231/7Ipn8Ite2YyUvoobec01DL8okKO+25lMZId
         bG4zaM38/2XXJseodQdLuNMrXFie+6be6k4NoyC6+5jiYpjzFvccfQP9KB4RLIMbDkJ+
         qw/FrHvjQemrn2AmbA+J31UCUJ7urUOp8R9rgj1nqINLJRKomQdsozA8Nc+jLf/oefUy
         DKt7tgHt0DTSR7lhU8dkh5VAxRND6m+QZGKs3eYLB8PFflJDjtferjaW1jK1wwYDN6cS
         fSQg==
X-Gm-Message-State: AOJu0Yy9aVlpuAhBoGtZ+A4AtjHiI7RJLRDWdfBksYfd6rdD4WDPOOuz
	ouxETp83GnvXyOB6fpV8c+gRSg==
X-Google-Smtp-Source: AGHT+IH8FSwFpW91FuCTU44KJZe03BzdcRhpD6cilALb1W6ubekxWLvOyZfKm3UyQTuWKQaC+rgpBQ==
X-Received: by 2002:a05:6a21:47c1:b0:15d:9ee7:1811 with SMTP id as1-20020a056a2147c100b0015d9ee71811mr334913pzc.36.1698338841412;
        Thu, 26 Oct 2023 09:47:21 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79414000000b006bf53a51e6dsm9749547pfo.179.2023.10.26.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:47:21 -0700 (PDT)
Date: Thu, 26 Oct 2023 09:47:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Message-ID: <20231026094719.04cace95@hermes.local>
In-Reply-To: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
References: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 15:50:50 -0700
longli@linuxonhyperv.com wrote:

> 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
>  		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
> -		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
> -			netdev_notice(vf_netdev,
> -				      "falling back to mac addr based matching\n");
> +		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
> +		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))

This part looks like unrelated change.
The VF mac address shouldn't change, but if it did don't look at i.

