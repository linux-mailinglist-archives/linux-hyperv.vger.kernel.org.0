Return-Path: <linux-hyperv+bounces-2481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44C914329
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 09:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179C71F23DDD
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECB644C7E;
	Mon, 24 Jun 2024 07:06:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49888446DB;
	Mon, 24 Jun 2024 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212776; cv=none; b=PBEWropig7lWcWF2vt3gVbFL8efCMtQj9Llg7ZTWM3JoHXdbRtgqIj/zZRAcSMgs5BNCvkCT/VqTaPhaAf/hWrEam9ezfYF+ERu1dAQqzJXeC3F4P7p2Llha9LT4iObOcIomsLs5fxuKt76DqDstah+JTL5S4xCOJEUEWycrxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212776; c=relaxed/simple;
	bh=KhGXSucYwoWiR1+mqBByAa+zdtToNFao+9n7/Mw+UYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SicXi+5bsEWQ+qEmR82x33WeVAGbk5MQ+xgDXnbdAR73YqaCPmlmEGpuAXT4MKLoEzI7m7B4lVr3lshn8wIK87uJaV1TJ5ZHry+I6awegmuvrYC+ydARsiMhEqtAdbwDVZDxw1/qRMC59NewdYVpr1wIYiIaV7sFFeyW6VLmvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-71884eda768so1289217a12.1;
        Mon, 24 Jun 2024 00:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719212774; x=1719817574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dvz83/2OWNbKm6/R/fjxOmpYGFLYYORFYe6HwC9XMMY=;
        b=CMp7HVJ7VE39k5OqeihSsZZpLgE+YLRbK3zNZ2PywY/Zyxh1f28pIOE6uuz5rSBLh4
         GCfqtYlGbL5VCjWHShmAMahCPYq1+5RbdTp30BgsOQyX3pZ9j+kLXEIUJivsBYyIVU8j
         1G22hYNTju/uL9KZ3X2ZSd0iCS1uYYJCX4TSk13K5pXD4cBDPQDSFJqCW/eCygf9goJ7
         07RRrxIZ1lrsl4l5PslWjeWS5eY1Z7f4WoYx3QrkvdWRgEr0uXxUf4b2pJS7kD9hDN3w
         QCcHQbcEsRxFPyIJ1iKJc70eLzwTmVZ2hDulds/6eCWUxYbSX63snuMylTD81wnbGFhl
         MDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsLTlBN64WUpT12HELauyN3Pp2J5u3u1WSCepmTpn7VeDi0NmhZhKShmvUv2hyPLPP9pko4eox/rtrVrSNBmlDDQsrAC1kaT7mca9C
X-Gm-Message-State: AOJu0YwOElBOGXiRbwYGPl98DuE1Gm/NcJPrSDUTu+DJG0yKtE7+DCmE
	B95xQ2bMTqPmkOBUSUQtOKySdaTIPvtIT+Mx4BWjA3XLp9GgANj1
X-Google-Smtp-Source: AGHT+IHKQSmhGnrycFm4EAZiiH4ASSbm48wUkqfKbzMAy+W1ekJiYcFGPRK3+CJvJNGPSGSz/n83hg==
X-Received: by 2002:a05:6a20:8c94:b0:1b4:772d:2885 with SMTP id adf61e73a8af0-1bcf7e32820mr2569111637.3.1719212774487;
        Mon, 24 Jun 2024 00:06:14 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706622dbbcesm4129826b3a.120.2024.06.24.00.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 00:06:13 -0700 (PDT)
Date: Mon, 24 Jun 2024 07:06:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Rachel Menge <rachelmenge@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	chrco@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: Remove deprecated hv_fcopy declarations
Message-ID: <Znka3knfBIYyqZY1@liuwe-devbox-debian-v2>
References: <20240620225040.700563-1-rachelmenge@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620225040.700563-1-rachelmenge@linux.microsoft.com>

On Thu, Jun 20, 2024 at 06:50:40PM -0400, Rachel Menge wrote:
> There are lingering hv_fcopy declarations which do not have definitions.
> The fcopy driver was removed in commit ec314f61e4fc ("Drivers: hv: Remove
> fcopy driver").
> 
> Therefore, remove the hv_fcopy declarations which are no longer needed
> or defined.
> 
> Fixes: ec314f61e4fc ("Drivers: hv: Remove fcopy driver")
> Signed-off-by: Rachel Menge <rachelmenge@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.

