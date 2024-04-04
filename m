Return-Path: <linux-hyperv+bounces-1917-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE57899257
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Apr 2024 01:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAF51F25FF2
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Apr 2024 23:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC113C693;
	Thu,  4 Apr 2024 23:58:13 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E76FE1A;
	Thu,  4 Apr 2024 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275093; cv=none; b=prXVM/rS2LcTCUDGvgKIyY4sYugnxO+qLSfrQxfLxqi3h/2kon1jqen1ap/lf1Df4e0C/cadOOUaxtfxPnAgm9/pjcxA6599jqwLmgaeX11rcvJK+gEVukM2QPtPPbWe8T1kPhSoZ+K+sYohKXRseudyxWPTVv9iY0ikbI2Az4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275093; c=relaxed/simple;
	bh=emgljg/gdR0L5XAJHJlVGspTwoRqOqZdn6zYDY1Qqdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0nepaNhKid7S+zBJLg78qvPYzVD+aHmYGKHEg8/c7Z62tZuK2SEsarAkCcXMCNO1u1zFNnQvEcObARkDyZpSRr5tXMVrAvW0MjcPzA0/jIdjgoX8HfsUBBbZFxzNFkhgME70jn88NgmdzXaXjtINpJQeDiB5rPtUBpWEttL3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2088063a12.0;
        Thu, 04 Apr 2024 16:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275091; x=1712879891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6+F1HIV80JqjgLaa8yr1bI7b3c6SmpIQxZcvL1XyDw=;
        b=S4SCXYY/0XTppAGhMqEubWvbZLI1OdJwOg+L+wvfNOXRoZCUIoU3Ltem9IVhkOY9p9
         SLBNn4ftLNc73fWmr6wHWHjFkm0jHO9qSGdFJJRTk878bkLLnFfIwYy+Zn9byEXgA1M6
         oyN8OZIOoA1xMPE3nqlxaFNPdDnCt4PITj/r8+FNH0aqVaJF1ru7gy1AJ7tq8Xk2pOig
         fBK26h40zhf2Vl/tXJ5rkNyu7KweQnGaRGYpwa6XYjnBB4HaeE9Nt5x6D3oNRAmrjQZ6
         oPyLapa3Blk1r6LXd61fHHRf43KZrxI82sLTdgNnk2JBSzBNbxAtdn5BBom5yJJ0hl/c
         3STg==
X-Forwarded-Encrypted: i=1; AJvYcCV60odMAviYUjFW9yZCeoMglhfoKaOUH95y5rIcefLC2TtqJ67JuIzkh2z+6XVkmt36spbW8d/NDbKNzSeMfJVMtB3+/mLlRSazREzcyb+ufYBEWokcf2miOKBsTmCiFOMT2jiE2QzFS4Kq
X-Gm-Message-State: AOJu0Yz9Uqas39byFsEL853sfQcaadLZ698JWx77nINyGmlhbIdnxQXO
	5j9Rllv1PnblVic1kFuAdJNzla3x0Iz+hr58l/6p8tMHyT+m5oeC
X-Google-Smtp-Source: AGHT+IEZpe+Q0jBuK5BMv1cb3tEJV5eKu5+0rIjPp6LOHI0U/fLZDpu56sSpjEa9JFyiAUwsRkNYig==
X-Received: by 2002:a17:90b:8cb:b0:2a2:5f73:a578 with SMTP id ds11-20020a17090b08cb00b002a25f73a578mr61401pjb.13.1712275091208;
        Thu, 04 Apr 2024 16:58:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ae28600b002a0187d84f0sm280379pjz.20.2024.04.04.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 16:58:10 -0700 (PDT)
Date: Thu, 4 Apr 2024 23:58:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, peterz@infradead.org, sboyd@kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	ssengar@microsoft.com
Subject: Re: [PATCH v2 1/4] x86/hyperv/vtl: Correct parse_smp_cfg assignment
Message-ID: <Zg8-i0a1xadK3sSm@liuwe-devbox-debian-v2>
References: <1712068830-4513-1-git-send-email-ssengar@linux.microsoft.com>
 <1712068830-4513-2-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712068830-4513-2-git-send-email-ssengar@linux.microsoft.com>

On Tue, Apr 02, 2024 at 07:40:27AM -0700, Saurabh Sengar wrote:
> VTL platform uses DeviceTree for fetching SMP configuration, assign
> the correct parsing function 'x86_dtb_parse_smp_config' for it to
> parse_smp_cfg.
> 
> Fixes: c22e19cd2c8a ("x86/hyperv/vtl: Prepare for separate mpparse callbacks")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

