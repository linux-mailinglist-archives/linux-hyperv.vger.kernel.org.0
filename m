Return-Path: <linux-hyperv+bounces-3655-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F2EA08CE5
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 10:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D44168A2A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 09:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C927C1C3BE7;
	Fri, 10 Jan 2025 09:49:52 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20320C027;
	Fri, 10 Jan 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502592; cv=none; b=HEUuClzJEDdv5b6Vu/s3h7aYPL62MPcAK2VxLAeAGsgNISTzL/A7u38lYjcBkVSsamQhkyI3D2SdLlyKeFIA4u42n2gjrx6v9N0+H+K4rxpTdpP7rH7EFIfHRxtDEaPN51oxMyKs0B3rVdqXubiNBJzp9I3DtK+oo5KxhNAXTpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502592; c=relaxed/simple;
	bh=2rD+lCu2Gp5RFsO0IsVqI/M9iitl+rZhcu3l6huKM7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoZSxBNG6mT87qt14uRsi5kLJ/9IEEJ/0y9dh5tB7UmwkJpKqJaxgDtByBJUKUok16O2dNZijNeBd0wULvkhnHW9nPe2FKmY5f5qD+IA++aw9Oh42A6r+PBgyU9e0TLhwXF4quUeoFFtMRabXPlIqMC2DIGg3oaIF7yzeJxDSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf8f0ea963so366878366b.3;
        Fri, 10 Jan 2025 01:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502588; x=1737107388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9n8MeFaOr6RLyTqwOgp/AoCJsw1cQ/SCA7gOp5Rsmo=;
        b=qRIeUUvDGQSrq7qKIwBm3wmGG/h8qNNDyn5AkxU9bPejT/FLRF4MytyjTptJbB8Ryg
         6Cg8hy4hOTdU5tUU/pbVjwzzPXZnFc9Mmxn6AiRylA8J+nC66odfOaWAztjdebS5TZtA
         9hKX3jRXZ5+LwoGTBKBWh59eXz6vYXY2ugsvUfOKJ71JcIEa5xSZZ/AOeHAgg2Tv2m9B
         IwJGs5AZcRM+VBHjbajJtjZaAIJCm2kzLMKbA7zInaVJe3NC46/pSAze27u6ewOwSqVv
         o8ibo75EtNDwuC3WGxz9XmZj+jzLu97M574gOohdLBmVi470fGCOUH3mQ0FwGZqTBdmr
         h2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVNZbT7nRqBm332wU4npUkf+JoLzJ6k+Wq4LyhMazbsXz3iuqyyFg38EEMF3Fe9RIu4J/5GQL28uclLwhg=@vger.kernel.org, AJvYcCXdEus/QCWjEG8b2aLEe/FrMHtH1TAGgHEU8CSf8xhLXo4ttCxIHIABVwyE17YlQSivzPDabkuCti9Fm9t0@vger.kernel.org, AJvYcCXsZsOjs1ETCXbh8bzvZbT++OvSijTpViXjBMPURzSycBy4Ffmng0jlSU5UyRFM9HDaIpzoeBn9@vger.kernel.org
X-Gm-Message-State: AOJu0YyhCfQbiCg+htFaVRXFTxO/EFEXVs/ZEYjs9TMYH7/RdIwZI9AA
	Hk4y+lESf72e/je9PbvVSJehr+FL0dkivgWylXEDI1vx6ahpXwrm
X-Gm-Gg: ASbGncu5gvvFSjKbMskP+ClPFR7mW96gw2GpSYFsoVO/sTDqFF9EdLpBOc6s+9tJVIK
	Y5pkjePaObEWf44VeNwDWdb75y4I3wk9AOPlTzdppddNxPpeisYWOSJXc3JKD0bvPQ8pipg5rNg
	Up8GwvMRzVhYQyFT6S1U1GFJdd9POOchRZpkEZd2vF1g7TeT5Ii3TywlyP4K3TvF6JSfDUwaq8k
	Aq4K/LKs/am/CSj2a9BMpCgI8DZIbiQb609H6ePfcqdFNQ=
X-Google-Smtp-Source: AGHT+IGLLpE9LZcuec5DF8MBVB3WHQBa3y6/+HZVbCelFkKJD4s+nOXEcVsaRHGBXVKE8bk+zhJyEg==
X-Received: by 2002:a17:907:70c:b0:aa6:7d82:5411 with SMTP id a640c23a62f3a-ab2abc6ca52mr920639766b.40.1736502587200;
        Fri, 10 Jan 2025 01:49:47 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b1cd5sm151560266b.148.2025.01.10.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:49:46 -0800 (PST)
Date: Fri, 10 Jan 2025 01:49:44 -0800
From: Breno Leitao <leitao@debian.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, Tejun Heo <tj@kernel.org>,
	Hao Luo <haoluo@google.com>, Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <20250110-diligent-woodpecker-of-promotion-3cbcb1@leitao>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
 <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>

Hello Herbet,

On Fri, Jan 10, 2025 at 05:27:49PM +0800, Herbert Xu wrote:

> Sorry, I think it was my addition that broke things.  The condition
> for checking whether an entry is inserted is incorrect, thus resulting
> in an underflow of the number of entries after entry removal.

That is what I though originally as well, but I was not convinced. While
reading the code, I understood that, if new_tbl is not NULL, then
PTR_ERR(data) will be -ENOENT.

In which case `net_tbl` will not be NULL, and PTR_ERR(data) != -ENOENT?

Thanks for solving it.

> Please test this patch:

I don't have an easy reproducer yet, but, I will get this patch in ~50
hosts and see if any of them misbehave during the weekend.

Misbehaving in my case is strongly associate with messages like the
following being printed:

	kobject_uevent: unable to create netlink socket!


Thanks
--breno

