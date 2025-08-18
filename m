Return-Path: <linux-hyperv+bounces-6549-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68792B29B7B
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 10:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A7B5E731A
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7222C29E10F;
	Mon, 18 Aug 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpX+3PHp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8629B777
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Aug 2025 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503851; cv=none; b=hOmg/hOHJ7vpseQl2zkf75XHFl5JFumtKtcRzYcYRp8w9NScmCnd1JIQfy1tb9FU7q7Wk1kdvrWqENMNKQTY1z+qdTzQYfKGbucnH/ucsOjuPOCdrTTtTRBpKXY+QlHo/6pCjMKgTzXj6OyCKKLYWaUFjSAO4CUz5KKeVaruCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503851; c=relaxed/simple;
	bh=UYGkkspU+B63sm92wMSzq+haWmbUPgKrQyQjqaa8St0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5zWG+1THwXwJ9PLK7wyRmqV4ugak3Msc4VZsoTIZfyd9TXadygZcVFbSPPvOD4E5I52qzbxgci76i5Kk5mWEmo8PzCntG3h0X870r07H2wLNC3KdnR2Dk2YW+kzuvgdAyFiiWdGl2XW+kpaIoZtv0s3VxVz7RroM/7kz7LT4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpX+3PHp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755503848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnLNVOy+1JPODpJ3Yc7eupS4dHoP80nfXVqFC6FlADI=;
	b=IpX+3PHpdBjDGnmuoTCTjzZAulx3+QEB1Sg5hGHsWtu4du2XEInP/7YbE2OQIQa4/YRmwc
	xVojIbxjw1dQ/H2Pbn4Ci6fAhwBhEsY46XWbIJ+Vb+tbRS4coGUUCSg8obJcglkZNyNkj4
	T0gXx4/+UqaOb1YTeilZ5y9khb7kRTM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-37hMlOPWPGaGnfXWE86aRQ-1; Mon, 18 Aug 2025 03:57:27 -0400
X-MC-Unique: 37hMlOPWPGaGnfXWE86aRQ-1
X-Mimecast-MFC-AGG-ID: 37hMlOPWPGaGnfXWE86aRQ_1755503846
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e86fa865d1so1197733485a.1
        for <linux-hyperv@vger.kernel.org>; Mon, 18 Aug 2025 00:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503846; x=1756108646;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnLNVOy+1JPODpJ3Yc7eupS4dHoP80nfXVqFC6FlADI=;
        b=Y0kMywz6cY6onj+qNOwWK3OYFUjPG+J6Aar/0Z55kN6zQgY5GhIfxKqb0dpQJ70Jgt
         Dw6kBPwfVpp0SglvnYBrQwgMa8NCCHS82szIEX00fB37v+V1gBva67GW+3CY4JiQNCKk
         RL2i/bV/Y2dTJCFD4qtbm/k/A2UW+oAlqUZkwtv8TTlPTjjc6ONk0+gNQnyGMtyoIQ18
         4hjm2Cy1zd2nQsGxHjtGLzP0NQCDhYbSYFq9PL3EWnZwzZERGGul6LU9Pp6sgr1FLqro
         yCgz4hZAXW6tQ0AE6ITf2Wnx9eSLOsocS+5qxcWn1D5YwoW00Cuc+KTZ/ak+q8tzp7qU
         rGYw==
X-Forwarded-Encrypted: i=1; AJvYcCXKvevPbfpGjlBFIIkK0PGgAKNRgfHIyLONwqj4JkwbNJ6Wmr4i0JgMf9+viE8WzufYM+1KxYIRT7rao8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcShg/j5WhcFkVbJHvXK082oXRZ9R1QULsj0PsDxZF8qUktZ2
	Rr5+qSuDT8cnDcMP+rB1sG76uEEHtU9ySVKQiBSCp1kckTmqMXXnkUB7fvnu2xgrM/0yIZfluUe
	C+qleVy2UGbk8gZSaCBZKZk/zskqB6hS6wxCC8NsxmnXmj37U09kWGNVOJjVfvQP5xg==
X-Gm-Gg: ASbGncsIEHzBQCgb6c8jiLm+fqGmvrD0sJn1UFHWLAbkETVWxbKCL2vsUdoy/cWzNro
	Bt1RwSIQGxhpr98Y7hIdY/GkosOO79sBRI5sHv6kCIwyIrBfDVSCJttARO7koLlfk8poIal2vFe
	YiyaN1ToWebrYE/yvbagCZdTYIUhsrx8Bwe9XBiiWGFySwzNWwafDMQhwOcGT8W7v2BfMqwYOm/
	osJffI7gypabmoIGHu9eYOw7RTnivomvRv9M2JjnE6m2UYOIfgdaIzAum8JlKdJudDrin500Gaq
	hx2a8g50fVu5G8WkXRy788pkOQBljrIC/vw=
X-Received: by 2002:a05:620a:8395:b0:7e8:8fb7:fe8 with SMTP id af79cd13be357-7e88fb710acmr709376485a.11.1755503846550;
        Mon, 18 Aug 2025 00:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz+Y7q7Cu1RnQ2whkcwKktuyquYKEHgUyH2v14hpiHFQmIn3M88eiXtWwjcl0ERF/6wn9BUA==
X-Received: by 2002:a05:620a:8395:b0:7e8:8fb7:fe8 with SMTP id af79cd13be357-7e88fb710acmr709373685a.11.1755503846133;
        Mon, 18 Aug 2025 00:57:26 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e020b3dsm545707985a.12.2025.08.18.00.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 00:57:25 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kernel test robot <lkp@intel.com>, linux-hyperv@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Nuno Das Neves
 <nunodasneves@linux.microsoft.com>, Tianyu Lan <tiala@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Li Tian <litian@redhat.com>,
 Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH] x86/hyperv: Fix kdump on Azure CVMs
In-Reply-To: <202508161430.0GC3nT8J-lkp@intel.com>
References: <20250815133725.1591863-1-vkuznets@redhat.com>
 <202508161430.0GC3nT8J-lkp@intel.com>
Date: Mon, 18 Aug 2025 09:57:21 +0200
Message-ID: <87frdpm59a.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:

> Hi Vitaly,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on linus/master v6.17-rc1]
> [cannot apply to next-20250815]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Vitaly-Kuznetsov/x86-hyperv-Fix-kdump-on-Azure-CVMs/20250815-214053
> base:   tip/x86/core
> patch link:    https://lore.kernel.org/r/20250815133725.1591863-1-vkuznets%40redhat.com
> patch subject: [PATCH] x86/hyperv: Fix kdump on Azure CVMs
> config: arm64-randconfig-003-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161430.0GC3nT8J-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 8.5.0

Rats, I completely forgot about ARM, will add a stub to
arch/arm64/include/asm/mshyperv.h in v2.

-- 
Vitaly


