Return-Path: <linux-hyperv+bounces-1818-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DBD8875C8
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Mar 2024 00:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD4F283221
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Mar 2024 23:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2991E507;
	Fri, 22 Mar 2024 23:38:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B01D6AE;
	Fri, 22 Mar 2024 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150681; cv=none; b=WtNdIpCr6Rl9YvL4yxDrpcNdI5VlPCBp7EP/DryJ6X4kDmOCloDUT+C8TkxrKbbg2DlBuqcAKqnsdxlxmMmYAdjzzkP11mG+mfjCZtKGOpucciN/io9QgCqEivmzsjOunSc9sgEjU++AA0M/Jlh1EFskpRG0ZPVZMmZEeTPk8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150681; c=relaxed/simple;
	bh=4vdLBD4WxCoPCSHSklDXaxco/DA2NMuzrlSHzdmqzv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN7uhutY6qQXnIQ44tH01Htl8qh/+OH8K2gJMpFc3H6dRTgYjQtip3fEmd3cVc/dMbzlHpEyvSEcQ/BrM0sK5UXl5pkaLu3QXTPlfYZmoCdi+1bu4h3pyYHopFe5z4d4y8FskplUi45I/wJP0HnWCS5s36K9txk1YkztrVUNa5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1def59b537cso17079945ad.2;
        Fri, 22 Mar 2024 16:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711150680; x=1711755480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSQ3EQV5m1CYO8xQ19hj3B7X+ETLlse9EWMNmBgjwww=;
        b=HJLL31o8lCUaFhRfq/41BOlH2x0gMS+H6IT1SBiDe+v8IEjS0VLqpUPHqz1TOa8d/b
         b5QGsH8k4yU314kBXrl0UOhJRsTctbf52+K5RYOYtFzkWGUsxEfDA78ediN5Y2xsyOhU
         y8/pBeafAPtrlDLI7IFc7LRM0bcC5H7UgdZHYc7knn+ODlsVxn3MTpMyLbdjsm29urzL
         U1GMv+8Yhv8ewcdQgECATJvDcI2f0j0zvNv+65tjwRg2EY5iBY45uYp4Ktqz+vxR2njK
         xGouv0kolq0YZQm64YZOVQNPupzFCFcEpuHxxZ4gYRiHlBcYyjGCfcZJXAkOfLSJBzeX
         tnUA==
X-Forwarded-Encrypted: i=1; AJvYcCVPyibmOe0p6Q/klKjQwekWCwWxNbq5q8uPOHTcyYWGgAaDhumgOiRlSJETwtT8gZyoa1JCNapg09+asn8thIamaUCfcAJABdzRBIVE
X-Gm-Message-State: AOJu0Yy6jA7l8TLmzeMWWcWyQJPVtASQDK3daOSu3uhmRtKFUBYyMNXG
	6XVQ+CuqjB7HptlcOWVfjEzFuoNvp7oAgll/o8H+7yLNuSQGY2w7mgkQJdAJ
X-Google-Smtp-Source: AGHT+IE6OVuQx+KNJaKfCzDtP+2J4SXtD5DkSYxtKOoam/KB/hT+vZ8Zmu2EjvLA+fOZrhO8oLLfkg==
X-Received: by 2002:a17:902:ea08:b0:1e0:a525:25d8 with SMTP id s8-20020a170902ea0800b001e0a52525d8mr293397plg.19.1711150679678;
        Fri, 22 Mar 2024 16:37:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902c40300b001def1ad9314sm303259plk.245.2024.03.22.16.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:37:58 -0700 (PDT)
Date: Fri, 22 Mar 2024 23:37:52 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] hv: vmbus: Convert sprintf() family to sysfs_emit()
 family
Message-ID: <Zf4WUMyNq38LyDLW@liuwe-devbox-debian-v2>
References: <20240319034350.1574454-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319034350.1574454-1-lizhijian@fujitsu.com>

Hi Zhijian,

On Tue, Mar 19, 2024 at 11:43:50AM +0800, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> sprintf() and scnprintf() will be converted as well if they have.

This sentence seems to have been cut off halfway. If they have what?

The code looks fine.

Thanks,
Wei.

