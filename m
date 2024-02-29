Return-Path: <linux-hyperv+bounces-1612-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60086D209
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 19:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AAEDB25506
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 18:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377B3612E;
	Thu, 29 Feb 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NHD3BP2H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD877A125
	for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230971; cv=none; b=YuI9qAc6PXgWH0DVF0WjNktsGFIoxVqYbfSy0bvb3xseaDsEQ+4AqAML8r5vF3qRM6RX2r7DrEC7LW7nzGLNz0F58fp0EP1vBdDn9hQdt3nFdQ5TirnGavlcv/C6wjnl5gIW8sGHoOWuclyCzTwEkBg8iU4M1Rpt6p8IZk9BQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230971; c=relaxed/simple;
	bh=g80ZHMfkap5e1XvdbqJdFJDCZAoVlfr93qwV4iryYMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+/l6PG8T0OyFLNgHa2pCMiL2NlY9G2VyIElYFKJdFsNeckKqiPeFcrhcQU6B4+h91VhhWM1IOgzmCKs1y19+S7Zv7L9WLbqIL3l5rC6aB3KjD3qPpM5JJF1vfGc1OtAlBQisIYi2gilIq674jtdd5xL5ZM9BFl+KXsqWE3K5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NHD3BP2H; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29abd02d0d9so913500a91.0
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 10:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709230969; x=1709835769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SME3hkkQyGOJtg72h1VtA8SKZ4fgYrx6Seh5LXcBQ8Y=;
        b=NHD3BP2HmpZYqK4Q5E35+nXruIJPzrSQyLpUi4XNguSxfkVoOmJsSl1BEQf0TBLCX+
         TbH3MdWSFEWkq8D4u25f0Ljh7+ycO3DD5CTc93Sl6RUuc75jXzLNdXE7iaE+9Q+v8pJY
         7CyO4t8HdmhowkEtiYNEp54rP4rGvMHgdcpS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230969; x=1709835769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SME3hkkQyGOJtg72h1VtA8SKZ4fgYrx6Seh5LXcBQ8Y=;
        b=Z1sZ23u5iu93uBNY1bI9InB5XAR2tVOy4ZPQSqeXIa89uFwzf41CPiJBlPiUa42cTE
         /OtrtKwWzsMhEwbHEje49jvPNoqft7ZhlpbiaAP5h5FKKM/wEVn8h3bjny8Aim7WtH/I
         fk3uuxG3Ch9zHuym37msgj9aMy/L4YUj5sGWWJ4n8Tt2aVPg7vXn3FNleYWUh9VZ27sq
         I1mEh2cMqXtQ/KnglJJVJyVFax0yH8VZaaY4MLZrASkqGsdGRg4nLUf8ByeW1BWuMBVo
         XWJjbFNfW8v1omQn0WJr1FjMlHxYFjx82KMdoNz0wD8aTn3WWk4Mis6DqjDwx6opcXwl
         sG5A==
X-Forwarded-Encrypted: i=1; AJvYcCXx9djDN9f7dh+y3/DvGV+a5vv45H+bbUYGbzxMzZE9uiLcNGoZ0HysHWNqLJtR2g1hXrix5v6uOVHFj/n/8qTh4OMXWenZfycWFRBx
X-Gm-Message-State: AOJu0YxmxcxXZIB0CGQQn/aGqk0VRjLhUECVfpMyBc0TBvbu54htdUiF
	65ihhNGhgT0QDwdwyO90BCIyn3oTs3zlfQWLMnwtVz5Q9ibC4I6azogtYiyMNQ==
X-Google-Smtp-Source: AGHT+IGYdlTHCZzP2Rg0F0nElhv750jePTpguZzrPB+4WF7VZs5zNJs7UO3cl1UWFqPeurqTqikR6A==
X-Received: by 2002:a17:90a:4a02:b0:29a:f233:2882 with SMTP id e2-20020a17090a4a0200b0029af2332882mr2856150pjh.12.1709230969105;
        Thu, 29 Feb 2024 10:22:49 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c88-20020a17090a496100b0029a7a2fbb25sm1930138pjh.57.2024.02.29.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:22:48 -0800 (PST)
Date: Thu, 29 Feb 2024 10:22:48 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 4/8] kunit: Fix timeout message
Message-ID: <202402291022.E3529BD@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-5-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-5-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:05PM +0100, Mickaël Salaün wrote:
> The exit code is always checked, so let's properly handle the -ETIMEDOUT
> error code.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

