Return-Path: <linux-hyperv+bounces-2222-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCFE8D1406
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 07:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE7D1F22403
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 05:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3F4CB4E;
	Tue, 28 May 2024 05:42:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892E3F9FC;
	Tue, 28 May 2024 05:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874946; cv=none; b=O3WhqjqznybsZny7WuK65ApEYPlS4ToMd00zOwW8blmWE6Tne1oL2pffHzL6uPaSYpDcoVn9c5KyR0QLlT2+lVmajFKbq4MKoojF71GyjPirw8twPFCkze4zY67nkORNoGTfeTGUYaR4TD3tymBOvLadm6U+VMcv/UlBYXMrlLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874946; c=relaxed/simple;
	bh=3DQfssdRW+iUJSUSl6k5ZV4jcESjudzuyWB/cFlaOL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9ct47Qq/gX3mfDMUB0HwWfeD8fuvl+Za4SemJhKfRfgI+G3uM/nSY67lnHRimLh3KmWeGoP9TJ89i5nfWTQGxxxSBTeJiffaoanqhO2A6IWsAC8SczMu2v/kBjewFdoMLLHQXroUIje/kmZxU2eVJ/ma+JU0cI5gmA99mmdDps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f47eb21f0aso4022945ad.1;
        Mon, 27 May 2024 22:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874944; x=1717479744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy9n6lh6/7Mb5daFJ2g6ZixLgVz7dPgqfc9MDBTUFyE=;
        b=FyYxFqF/p+2Tl3u4ut33VI67BjevJiERJI80x2g1vaWvyC5vux/WaQ9DtESoDdk/0+
         2nC+uoTLkerZ+ecvCI9uDs4xTIAFUqM9KCT7/Akd+zUplVHEKYBHxJ2a/ruXnXzSCA1u
         rSL/s7cTDoEQXyRDl8lVlnb2nuQLfS0/FfyejVge/6+QEAO6Xk6Cv1bx8uhQI59ynMD2
         Bjtnl8g09Ygzpbq3XL247X9IAL0SkStwyMGwnh6CeS+j/EklyTKTg6CkAlFcwe65la2+
         Om8zkxjIX0g4lRdCXO1ZJ7EgjLLjfW8jxaQ8VIDm7LABklyDDF7pzHoNSk7YCYUgsh8c
         HNsg==
X-Forwarded-Encrypted: i=1; AJvYcCV57/tpvhJsWkpVip0oOvuEl2dK0N9XE2dKggqrkN5uvpjaqS7c13LRkykjas8XiBAWlpkwI/BSFlkRhV1JdF8Ry5hJ+KWuP+OBTTAQCknYLBM0su3k7c6uaryKhLPqazIL+LmpkaCAZFYP
X-Gm-Message-State: AOJu0Yx/ulVlg0wzhTrLsgeYVDu2jDcPMxbxnMDUBlDAN2atGvHpKW5S
	V6bXuI/AhiAVkWS3L5keQ2ky89AD4TWc1bb0zFKVrigTQQ1A0Gd5/NQ12A==
X-Google-Smtp-Source: AGHT+IG/sGdiCI9ZO/RdX4gnDMM5AfDcrgTo9NdR4VfDVMWu62hTyogSKIItAEkEi9OL/Upsko7wsQ==
X-Received: by 2002:a17:903:41ce:b0:1eb:4c1d:ed2a with SMTP id d9443c01a7336-1f44871e51bmr125122135ad.27.1716874943969;
        Mon, 27 May 2024 22:42:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f49c155d6bsm29404025ad.229.2024.05.27.22.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 22:42:23 -0700 (PDT)
Date: Tue, 28 May 2024 05:42:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Aditya Nagesh <adityanagesh@linux.microsoft.com>
Cc: adityanagesh@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Message-ID: <ZlVuvkWTBVmAyrZK@liuwe-devbox-debian-v2>
References: <1713842326-25576-1-git-send-email-adityanagesh@linux.microsoft.com>
 <ZlVo6bhEvBCIG_1d@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlVo6bhEvBCIG_1d@liuwe-devbox-debian-v2>

On Tue, May 28, 2024 at 05:17:29AM +0000, Wei Liu wrote:
> On Mon, Apr 22, 2024 at 08:18:46PM -0700, Aditya Nagesh wrote:
> > Fix issues reported by checkpatch.pl script in hv.c and
> > balloon.c
> >  - Remove unnecessary parentheses
> >  - Remove extra newlines
> >  - Remove extra spaces
> >  - Add spaces between comparison operators
> >  - Remove comparison with NULL in if statements
> > 
> > No functional changes intended
> > 
> > Signed-off-by: Aditya Nagesh <adityanagesh@linux.microsoft.com>
> > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> Applied to hyperv-fixes, thanks!

Actually, can you rebase this path to hyperv-fixes and resend? It
conflicts with other patches in that branch.

