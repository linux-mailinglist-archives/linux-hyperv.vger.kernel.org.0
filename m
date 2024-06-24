Return-Path: <linux-hyperv+bounces-2483-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5538A91432F
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 09:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872F11C2277F
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FFA39851;
	Mon, 24 Jun 2024 07:07:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011B3B1BC;
	Mon, 24 Jun 2024 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212868; cv=none; b=cdMJZyWIQnBHaZkcn4mHAa6oM/RPyJyehKy71kA+A1nbSwOPS7XHoTD/LafwclZesZzoYu1HxiOVY16XxLGAwhRqIA033ifuyym29yjSRqHcy3DTfl1qTBvJY0ALMX+VpSLag0dNnm4ZhPmXTLUAf/TEOXzpBc6Syzg4MYvUxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212868; c=relaxed/simple;
	bh=DIc2Ek2oqgATcYNtSqSUaLVDknlvsWuPQFBBIIrTz6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6NM1w9lhaWWt60FgXzV8ElQ9O2P4OuIMiaDJ8y+WctsA3Fu+mkW5hAJSaoscf+2Daki3i3lUNxynn/RUnTJpqUXWgpWuohBYKYVQZOQjEmDFcfPfbQnV0BeInOcthWr6vQ/ojC9SuVvIsGGD//mXKctXZohLG/YZ8CFhfPlTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9aa039327so32051235ad.2;
        Mon, 24 Jun 2024 00:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719212866; x=1719817666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSaP9BELHJPncXgtj87yjJDAYd2o3bEQl0Jgoge/tXc=;
        b=C5a0FI9lbiblAJe9OdpL0pP07FYqYs8lkQZ00bU9vHDxNOEtV4Tqy34FKYAERXYP7f
         YiWYIfqCKL+LoSF0/e022NrKd1tBG3lVH2vPbZVXcajsijozFmZrv4izYKMuY0Nb75XV
         /h/ujBzBM7Als7U7whFxjiDgKGq0VvXPQQC9Vj3lzaqw64kzzIElFiBUinEqVTUFsWnR
         diZXoR+ndemehu9JATXaw4j0Kh2RhdENUlP/+IYIEQaNaXYtYzz6VRCZYQad2u5SsuwH
         tcsJYo/aNhVxv6IcmDVF6vWOjVvpBvD56yU5oVIA/v6uYYscRVWIKMyb52zaxKgiLhzI
         uAGA==
X-Forwarded-Encrypted: i=1; AJvYcCVVPqynwpftPcO18hCC6SMryfUhNJ8Mif3wlceubnZDVWsjKdZnf6I08DCwNwlCIlrjT5Q3LcCI03tEMXV4KX5oyXaJeAcP4ezizRRJzpQr3fxejnJXE0dtWmLhP9qH6tsHMBT13DRGLctBeIxDKfSu8fgcmPcXAi407wj/jjB3wejlBBMX
X-Gm-Message-State: AOJu0YzpD1uvaM1xiYvnV0Oo9SfNsUFRTapTLmvvToAaTTdB43Z8tdXX
	O69gTCLWYbbOs27wsbkujRzXF6tSThdn3xaSFf/uIdeyd4gzdspw
X-Google-Smtp-Source: AGHT+IHn9Nj5BYs7dNR5EX+uaseXHvMuEo1uXR7vTbM98U6YZWH4x3owWhoYUg3Qi/ZZuGVx6QVpQg==
X-Received: by 2002:a17:902:ccce:b0:1fa:209e:b4f4 with SMTP id d9443c01a7336-1fa209eb5fdmr46453815ad.44.1719212866028;
        Mon, 24 Jun 2024 00:07:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc479fsm55530025ad.291.2024.06.24.00.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 00:07:45 -0700 (PDT)
Date: Mon, 24 Jun 2024 07:07:38 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v2 1/1] Documentation: hyperv: Add overview of
 Confidential Computing VM support
Message-ID: <ZnkbOkWeIcSO-pmt@liuwe-devbox-debian-v2>
References: <20240618165059.10174-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618165059.10174-1-mhklinux@outlook.com>

On Tue, Jun 18, 2024 at 09:50:59AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Add documentation topic for Confidential Computing (CoCo) VM support
> in Linux guests on Hyper-V.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-fixes, thanks.

