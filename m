Return-Path: <linux-hyperv+bounces-2681-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A005B946661
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Aug 2024 02:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1BE1F22338
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Aug 2024 00:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823162914;
	Sat,  3 Aug 2024 00:02:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709817F8
	for <linux-hyperv@vger.kernel.org>; Sat,  3 Aug 2024 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722643357; cv=none; b=rb8ISBKQz1KLnqSZe2pQnA4H4wtKcCMRpQSmsXZjpmmjO+sNotHg/E+XjCEpP6fUkMDknpzV3Ujitk3aQ2ZbnKgl6QHFksCqQQu6ft5L2x8yd1EL/IUcaMWL8k04qShVF0lxtP3+FS/6EKeSBpxB6e29xf686vXvqIplk9AuGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722643357; c=relaxed/simple;
	bh=mY4WAsZjJi9AijuArtsMUAqz2BgrOYlqBl6Br/Vsrto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQinVyDD6Ph5tfvsGbcPZk4FYxOyvSTetYdc9y+uNJTw2hjGD4gjhNp+pY8f4NOmoi0Nh2YHPwikYw0AIa4g1Q5ni6i932rT1bzizHL/TKLm5oe9Kn3eaUqras4rOD3T0kydlM4/zc8EWGVxrJhybaTK5iXwICBgZc62aEEixHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb81c0ecb4so2786748a91.0
        for <linux-hyperv@vger.kernel.org>; Fri, 02 Aug 2024 17:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722643355; x=1723248155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp6Fb8Kwma7x6ROUe0DmGg5wxeyH/Of9B+hVgiJwY2w=;
        b=TuDTJH41JlBVK8GvepBkGx2EfYAw8IGUdGSEYY8z2yGUcO0nYKcd71t2YQ2eBTVQuv
         +uKPbL3whD+qV7b52g5aJUXxrjW+op6+5abnnafZxyzmXU3BXl+Uei4hz55wuissYOl4
         bU9ERFsf4xwPWgosGWqONBePnslX2n/vLnVK5rB+smhQiOK8PjT8Crr5Z5lHbWUCJEWq
         r9rOlIKQBQS+jYDCKoph+44U9tBRqCFrPnHcEDb74eBP51eRTkIXktOjYneYR3tbD6Mh
         DJqaaGFJfG1tintDC1dp/xkizuqYQm9LQxx7eXXZGRcHSd8Xm4b8UlKOZEDTYDDZz1sw
         xPyA==
X-Forwarded-Encrypted: i=1; AJvYcCWNU2B2/qxD7cM5SqVH9C19UAiOC3hg3nnTcdz2zMH2ZFkxyMYD990508iz8qCdIvdOzP+qcWIl808/kT3CNhjgx5T8O4eNHmiED4bO
X-Gm-Message-State: AOJu0YyVOSaNP7hhPEx2RXSTurgAqhaV1Ds04zQYz5DnFeG3LTWcJYqH
	aqPK2ffXOyPeQEHob/jiQON5zpqKjbNH4lfdhP5g4IinkG6KOdTm
X-Google-Smtp-Source: AGHT+IHHXxjnuGAHnl3WPzNXsV32IC2MBnPln6WUMG2KLOHI+2PJePUp6NP++joO1SxsYtSTmeMoug==
X-Received: by 2002:a17:90a:f411:b0:2c7:c5f5:1c72 with SMTP id 98e67ed59e1d1-2cff098a86dmr10089524a91.13.1722643355201;
        Fri, 02 Aug 2024 17:02:35 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb36f07dsm2333240a91.37.2024.08.02.17.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 17:02:34 -0700 (PDT)
Date: Sat, 3 Aug 2024 00:02:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Anthony Nandaa <profnandaa@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>
Subject: Re: [PATCH v2] tools: hv: lsvmbus: change shebang to use python3
Message-ID: <Zq1zmUwpKDo5Mlfm@liuwe-devbox-debian-v2>
References: <20240702102250.13935-1-profnandaa@gmail.com>
 <SN6PR02MB4157AFC98992A53FC05EC312D4DD2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157AFC98992A53FC05EC312D4DD2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, Jul 03, 2024 at 04:44:05PM +0000, Michael Kelley wrote:
> From: Anthony Nandaa <profnandaa@gmail.com> Sent: Tuesday, July 2, 2024 3:23 AM
> > Signed-off-by: Anthony Nandaa <profnandaa@gmail.com>
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-fixes. Thanks.

