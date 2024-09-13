Return-Path: <linux-hyperv+bounces-3011-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17959779A6
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2024 09:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC7A1F25751
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2024 07:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E491420D0;
	Fri, 13 Sep 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hi1ij3Pk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960121D52B;
	Fri, 13 Sep 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212660; cv=none; b=gxLKGTuh8N38L1YSKbaajiI77egf9p+0Zlag2pZ6pl/j9zAi6oRPXduM4Fdolfu75QVFwFIOLf5msuaJlPadjjKG8HzsU7NqBEUvY682WFkY3dQVdNEP7CLRgVIm8ugJ8IY8hzeYbo58/Rq/vrFaN8MZknBRnjRxVopW3YLeB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212660; c=relaxed/simple;
	bh=fuc484oEqFVh7ZCZ35h2KtIXgb6/b8NccyYwWkJdeIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKOTir3azwbk0Fry0qaBFVw+6YVN1uYai3qUobGzMCGjXMnVQFFsrVNAwJj+fNkyuSMtUAy4K0BKVyc8CqGvJILyZc/638s3N0qg6FUSKt1U7s8dEYZ9ax9o8jp5PZ9gc545weHMf3wJAtlMxwA5PzjUGcxH5JQU+Yp4Z2njTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hi1ij3Pk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 3841120BE55B; Fri, 13 Sep 2024 00:30:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3841120BE55B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726212658;
	bh=Rs8LeY5J9D4uBBCMTuW93Bs/WfIZZQY4vY67iBAKjXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hi1ij3Pk2ZBe12f36mXBAklIIgOGJCJHkurP5FWBt7QqS80hWX10BlC9xQ/kcBf5a
	 NE47gXW0EHBAjamzGLfX+w5DXkYhRQgJr87Soo6bQXmWTxYU5eXWLmnT4R4jkcLwJs
	 8k1PLC6sQtQ8QDolkL+yKWOzZF705MKz2KnxF1Cs=
Date: Fri, 13 Sep 2024 00:30:58 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] tools: hv: Fix a complier warning in the fcopy uio daemon
Message-ID: <20240913073058.GA24840@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240910004433.50254-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910004433.50254-1-decui@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Sep 10, 2024 at 12:44:32AM +0000, Dexuan Cui wrote:
> hv_fcopy_uio_daemon.c:436:53: warning: '%s' directive output may be truncated
> writing up to 14 bytes into a region of size 10 [-Wformat-truncation=]
>   436 |  snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);

Makefile today doesn't have -Wformat-truncation flag enabled, I tried to add
-Wformat-truncation=2 but I don't see any error in this file.

Do you mind sharing more details how you get this error ?

- Saurabh


