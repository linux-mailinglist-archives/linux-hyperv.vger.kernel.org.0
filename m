Return-Path: <linux-hyperv+bounces-2020-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0528AD743
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 00:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17521F219BF
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Apr 2024 22:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6798C2134A;
	Mon, 22 Apr 2024 22:28:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DB208B6;
	Mon, 22 Apr 2024 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824891; cv=none; b=CecfFFIEDHtEYAq7Ue+FwlTivCcP8gW+TDSKwkba6pdvetFjZtv9+isKOAmi+tcsElmBc7EQLVaURRmw7jKKqMNVqzBhnWKSJ7fETmzxVpvE7JwRqFyeYqlL5TqE2FxFRsd1A52fePu51bg0XKauWOi9qn85y6KMJmYrPxIP8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824891; c=relaxed/simple;
	bh=Zmn7rxgBzacBQvLI0YQOk8g36SVobMKWauuJpwXIrdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/uZtuuc32DG5qISCM+xy5JVrOxBXjbYrdUHYKJaZYOjjC0gDk854yS6MxCjeQPgqL+S4dkOJMxjPdNfaVsi3voIlpBwzYpdnZCVUCZ32oRIh36swfGJFVkXmB5eqSTz0at96CKMKjXLz2DOb4F1lsSBQt/sxeVCs2Q0b0mYe7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed01c63657so4338141b3a.2;
        Mon, 22 Apr 2024 15:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713824889; x=1714429689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LY6VYJdX+mT+ApQTEHHLNEGVbc7XbWrqfjCB4cChop8=;
        b=by6qMYPKfBqyaKc62AGsvpruDlQAUuW0+9IIZOQENJm6itx6qBFfW0XfqFPsvDLvxe
         yKO/s0bfsLlSJNulLUJqJajSnHLd+Hv8wvKGSH20Sem63BOgF6OolXvImGSW7lEHpiab
         A5xa2nRljdIvuh8/pzVEg8SALH2IzzmQ4/otbCeleoHrnXSTWKfSHzp9kF0Wv71aYcHv
         pId7pKYWGIwppJxSYUnri64usEdubZ9sS7mFGxj431YklxBmrQH9TKTJ7qApJCmqYm8y
         os26v2hriZRdP3FPMZjNyTAk6KjDieMYCTbYznrA0mdi3iEEJaS8A6hkkhM0BrV4xzId
         rG7w==
X-Forwarded-Encrypted: i=1; AJvYcCVn8Nes3m3jnS9m0hDO6aZiKpdhU1fdNC/BtXQAWDLXiLVwCo0KRJfYa7/0CDOrj/DLq4Xlj0ii31bzJjS+FFill44zqWQY37ES3/MaNyYykvRW24lqAOUoQBpGIz23s9BAjANEIFvcut54
X-Gm-Message-State: AOJu0YzcbFBMm9rkyw8Y+xqy83IYokwvkMOnCQy4IalEPtjSxRAkBClj
	WOf7ZQT+DysTYio6+kpeCbrNz752j+jrXu/DFhr7ADseOXJl6l0/avhvrw==
X-Google-Smtp-Source: AGHT+IFHaSIv4plemsU3bD4Hckd8u3UkNP5MYDoI73EromUcKrpfMt9CkLbkBJsDSMZ0PsyjCxSEGw==
X-Received: by 2002:a05:6a00:13a0:b0:6ed:2f52:9acd with SMTP id t32-20020a056a0013a000b006ed2f529acdmr12961961pfg.24.1713824889202;
        Mon, 22 Apr 2024 15:28:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000cd300b006f0af5bfda5sm7055078pfv.102.2024.04.22.15.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:28:08 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:28:05 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	shradhagupta@linux.microsoft.com, eahariha@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add a header in ifcfg and nm keyfiles describing the
 owner of the files
Message-ID: <ZibkdQDdM4QENTl7@liuwe-devbox-debian-v2>
References: <20240418120549.59018-1-anisinha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418120549.59018-1-anisinha@redhat.com>

On Thu, Apr 18, 2024 at 05:35:49PM +0530, Ani Sinha wrote:
> A comment describing the source of writing the contents of the ifcfg and
> network manager keyfiles (hyperv kvp daemon) is useful. It is valuable both
> for debugging as well as for preventing users from modifying them.
> 
> CC: shradhagupta@linux.microsoft.com
> CC: eahariha@linux.microsoft.com
> CC: wei.liu@kernel.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Applied to hyperv-fixes.

I changed hyperv to Hyper-V and changed the subject to

  hv/hv_kvp_daemon: indicate the configuration files are generated

Thanks,
Wei.

