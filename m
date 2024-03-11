Return-Path: <linux-hyperv+bounces-1711-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9AA87859F
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 17:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D91F21F68
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774DD47F6B;
	Mon, 11 Mar 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="laCtl/UH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE64206B
	for <linux-hyperv@vger.kernel.org>; Mon, 11 Mar 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175307; cv=none; b=FoI05KvA2WdNkF9E8a9tEuH0LsYQ60UOl0Y/rwsFAi9vuETJm5ueBmB3fuxP4hA8enYi7Jywdr1IIz6HlTEnNo4Al/OCgM7WjoWbcL2ThOjCaUwGs/h6oeHnhyL40yi9AvuVtYd4nD+GAhiXzsqyoYE4EbmOtkseIsDq4oMyN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175307; c=relaxed/simple;
	bh=tsIonJwynOjYCCdrRNvMtpqlyXRynwccuNLo8Hy5ngg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhqXgWs5yfBScHiyeai4pnLEnRStc78flbI7tlUCSMkJk0muR31DmfpGMjYvJdBDgSstwgBTcTtW+cKOfmIZC1m17i8lDN+vaNQI3kPrFy9rnwll4V2K4Js3GcnMQ/4DsJS3u82jKFeWdY6xh1I+OLtwfjEFuV9HXXwCFRIGisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=laCtl/UH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so2892487b3a.1
        for <linux-hyperv@vger.kernel.org>; Mon, 11 Mar 2024 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710175305; x=1710780105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hO2WE/Q4Nu2PhvR94l66ZCUZTIcYIt0ltfnKbOAvEA0=;
        b=laCtl/UHcRYiltlF1HOuvsQVyqRCgeoFUv08Eadw/qwwVJ6oOXQtDW7Xe7lslOJ55H
         qe8z48cEwolugBUbYGO/JXqGkDT/N5IrK9RllcOLWzdYrbzl7KQsLRqH4/W9HONf35fI
         IHFT1qfBfrr/mC4lc90wsYtMPV3jStw7olf1erDN/e/EhEQ52re9sqguVBtnf0YGwcAX
         Jw42CZO1EC/CcMe2cM14v0csvnJXvUe35CBuXT6RNjOkXyKFzbIGGBnLxBGJQXI8+ZEY
         xBlIqf6ZVZ1bJdbOeGw+uHhxADhph7Qv/UPItP/p6sBmcDeaVvZnYiRfmNrurDQXeSdY
         3KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175305; x=1710780105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hO2WE/Q4Nu2PhvR94l66ZCUZTIcYIt0ltfnKbOAvEA0=;
        b=EZGyRssBWXlYZaIKaLArTTrM4va6HVewpW++ILKfjsop+5V0imq6YTbaHNdXpgmnH4
         sPdmGp7RVEDhWWp0GmkvQ1K+bcGzXKWZHd4Vn6R9WHDXRSPwvzvrb7Hg5kE7MArWojuy
         E4hZCL3oscIwoP5yOSRh8OLFs/Ld6NeJSsFVbTkDxNfoN4dYqEDoun0OiZZQ5zKnxJ9y
         0MgW7rIsxFMzarTFr/ZXrV9tyQ6IrUC+KgFbER/3t9LvL4T5BYf5MibkXl0ahDtPWNLS
         rym4NcQaVR0+IQvxjhnrTN5KouZu0Db/cl93LAVYp2SdQFuvN8Vp9yMjRQxL6OuHnb/z
         kjIw==
X-Forwarded-Encrypted: i=1; AJvYcCUFSwd/D7mA47glL2BsqnqM+Blnq9EvxkzQ4qQK1FBv5PL1G65mMeVtYJ1EKeNKcFHFPLoXFIbk5zcAoSA1b0QZ1uineNSjM2PH2uxi
X-Gm-Message-State: AOJu0Yyo3ibwzVnz498tuI8zaH0HUM+QrMOfldjaC2trH7GHjA4nz/0u
	TkzMXiLU0iKMkZ4DGT12Gy/wSTgIu722Q+wcrN7u0/tSFBKzMk2+v5u0jI3tZQ4=
X-Google-Smtp-Source: AGHT+IF9sh9O+4LAtdYd3MNx/de/ejcI0gxeWxCHrmkfJ4zqw0YXHnCfkvhPnuzsvbRs1lgTCoptAg==
X-Received: by 2002:a05:6a00:a15:b0:6e5:9a0a:8b8d with SMTP id p21-20020a056a000a1500b006e59a0a8b8dmr10813456pfh.18.1710175305232;
        Mon, 11 Mar 2024 09:41:45 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7998c000000b006e632025bcdsm4542433pfh.138.2024.03.11.09.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:41:45 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:41:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, Leon Romanovsky <leon@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, KY Srinivasan <kys@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240311094142.3bbe7d7b@hermes.local>
In-Reply-To: <20240311085126.648f42e0@kernel.org>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
	<20240308112244.391b3779@kernel.org>
	<20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20240311085126.648f42e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 08:51:26 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sun, 10 Mar 2024 21:19:50 -0700 Shradha Gupta wrote:
> > > Seems unlikely, but if it does work we should enable it for all
> > > devices, no driver by driver.    
> > You mean, if the usecase seems valid we should try to extend the framework
> > mentioned by Rahul (https://lore.kernel.org/lkml/20240307072923.6cc8a2ba@kernel.org/)
> > to include these stats as well?  
> 
> "framework" is a big word, but yes, add a netlink command to get 
> pcpu stats. Let's focus on the usefulness before investing time
> in a rewrite, tho.

Couldn't userspace do the same thing by looking at /proc/interrupts
and PCI info?

