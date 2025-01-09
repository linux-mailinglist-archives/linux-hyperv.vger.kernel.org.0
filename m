Return-Path: <linux-hyperv+bounces-3638-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A853FA0728E
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 11:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781C91888EDA
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA25F215772;
	Thu,  9 Jan 2025 10:15:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF862040B6;
	Thu,  9 Jan 2025 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417724; cv=none; b=S7G/OhwYrrvO53BPL4ClsBXjdGWD2jlLRUQA7wphhEEWEzc5dmyfM8UbDZpuwHgDOCrrBVg0Ag6UgJzw15oHOUTdULkO0RNQDURqYUAjPuVGfoOnpf5cuCQU+VoHOeqEGFj/juPd0v6pFz4RoUoBNvfqwn1MKIqj21vGF0VL15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417724; c=relaxed/simple;
	bh=311/ikchyM8xu+Txmxl7n+xLSLICgYUMKH6CYUynGt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzEeqm5KlLAACZ8aytOWYsPlUWOeigbtASpgEQSXbxC8mPQAuuUH2AvxNSG/zpCRltCQgT8lKXgSZV/MBQQvcy9dWwFbTEeOxewWCtuyvGPdE9sHcRzTEGHvzmD0dQltmhSM7lDX1wbz7xhTsuiDIPfnrelAcRCeU2zGdbrVJX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3d2a30afcso1089405a12.3;
        Thu, 09 Jan 2025 02:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736417720; x=1737022520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDRp8Y48+Qc4viK5TPOssGsm1V9bKxfNVfJifzYZl7Q=;
        b=hd0cL/LDbRSXqc/LaB3LgD1e02AO443WYztGV9uBtO+WTmyo4L37lwh5gaaCInQAI0
         n5y7k/prpyIjY1CYXN82QoRQl33AIp5NPw2M3ICSGjL00aqk12qqKtK9p6THQVfDMfZw
         pjewrvLek24TocitEfUd2iVcU5Pxwa1FkoMMOyPSy+aOU32nZv4z68V/zU25JSJ4KsEX
         LWmFTpAIqq4j4AT8sPj9Nsv+T2GjTmdknEgmWZhHzhj4wVncr7BIsDrOvj0UqOwWcYYk
         lI6IySEv8GRdw6UstLJEmV+1/wJt4oBxNf3Kw5G6V721hC0gDUdjajkHHkFqkiZYih9O
         GeUw==
X-Forwarded-Encrypted: i=1; AJvYcCUX9KNwggfUREEfafe7qpXbmWfemt/hSeNVAy6ZYWy1SrVGs4NNaJ4JkIKSgo4n4snjm4cHa2DlWt4VBps=@vger.kernel.org, AJvYcCV/c2STLKll8L/nzQZ/Os1xrfRS+rxvNKOZsbV5OAjOe3+q+W8aJS3k6hr4yI5lbWbkf5csRJaguLJLsIjh@vger.kernel.org, AJvYcCWCV0o14gWl9ARtl/w998eLJm6Ujs86rRwIetVnc7ROJO9n2De/aeiTH38d8lpYuzab1xwcJqS6@vger.kernel.org
X-Gm-Message-State: AOJu0YylqUM+TPiE+ZeAdrzFUo5WQqDBUr4C23Bq+TMk/E5X3Z2/bslz
	sZMBIsqROgokA4o78Bcp71V/G3dg8r+ZdUCTaSFuEVZrcFQe7CV6
X-Gm-Gg: ASbGncuMVOoJJ8AjdDaMIkrB7U8hafTmX/J0n3ZiHYEVU9UnmLpGwI4ZcnZkFODNhS5
	p7gakzgTkFNfJ7Mjw4hMGtigFX/5vGpM6JG58+dh0RU1B+jzRpai+XiWtoBHFlBJxHzVxxgb2C8
	EC/8Tr+WjbVHvQNs9jH3sNvf6nPhCAB6DZR5lAXEAAIqIuzuz/2lyL/KnTeOjxX7S1FmLlAC9ZZ
	2KsMLVQsU7UEymExPTIPap8lThB9mQBb3bkltTkIzg2ovM=
X-Google-Smtp-Source: AGHT+IFlrf4GxaUQV5QxSnOq4UImdTGUQj634dbvUjEFoa3RwIk41IIuT3auoj1ux1Aj70DsJwOnUg==
X-Received: by 2002:a05:6402:51cf:b0:5d1:22c2:6c56 with SMTP id 4fb4d7f45d1cf-5d972e1be28mr5504022a12.17.1736417720392;
        Thu, 09 Jan 2025 02:15:20 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046dd55sm433118a12.54.2025.01.09.02.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:15:19 -0800 (PST)
Date: Thu, 9 Jan 2025 02:15:17 -0800
From: Breno Leitao <leitao@debian.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
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
Message-ID: <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
 <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>

Hello Michael,

On Thu, Jan 09, 2025 at 03:16:03AM +0000, Michael Kelley wrote:
> From: Breno Leitao <leitao@debian.org> Sent: Thursday, January 2, 2025 2:16 AM
> > 
> > On Sat, Dec 21, 2024 at 05:06:55PM +0800, Herbert Xu wrote:
> > > On Thu, Dec 12, 2024 at 08:33:31PM +0800, Herbert Xu wrote:
> > > >
> > > > The growth check should stay with the atomic_inc.  Something like
> > > > this should work:
> > >
> > > OK I've applied your patch with the atomic_inc move.
> > 
> > Sorry, I was on vacation, and I am back now. Let me know if you need
> > anything further.
> > 
> > Thanks for fixing it,
> > --breno
> 
> Breno and Herbert --
> 
> This patch seems to break things in linux-next. I'm testing with
> linux-next20250108 in a VM in the Azure public cloud. The Mellanox mlx5
> ethernet NIC in the VM is failing to get setup.

Thanks for reporting the issue. I started rolling this patch to Meta's
fleet, and we started seeing a similar problem. Altough not fully
understood yet.

I would suggest we revert this patch until we investigate further. I'll
prepare and send a revert patch shortly.

Sorry for the noise,
--breno

