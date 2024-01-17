Return-Path: <linux-hyperv+bounces-1450-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBD682FF12
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jan 2024 04:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BFFB222C8
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jan 2024 03:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2EE1C0F;
	Wed, 17 Jan 2024 03:02:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796E1C05
	for <linux-hyperv@vger.kernel.org>; Wed, 17 Jan 2024 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460559; cv=none; b=eUwc8tuUULb6Ejh0yrq5LI1cRw4eCRNx2XZ3Pb4uEyBx8VoIBuzWpZUjI3fjIkOnPzBFzT66BYZfkZGSXccwnY0887jGiRw1nseqzA78bQFoDlQ1TeDv+xL+QefH3Zvb347W+JhyxVlZ84dUznhvsWgTWk1iOek71rkkpXUJ1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460559; c=relaxed/simple;
	bh=l6U0e5dIfqCq4u6Vfj9Ip4I7bFRzYR2PrkrH8JS4GvY=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VpLsHoImKr99OK68vgqnwDAfq0QKsgXmx6j6q2308M2ialIMkP3DCumGEwa+nYLb+/QPe1RVaKRzjVwLfQ0v6MCS2jtBwqqNOzD7Qln8Dju5ywphvcNZjfgBhLrbBdIeUFT02XtrYGiQNndZxxdg/P1bI4RGsLO3DzL17rZxopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ddf26eba3cso4423304a34.0
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Jan 2024 19:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705460557; x=1706065357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i40n5ZuwLwLxtHW+1iqhZuZarMVcPpU8vUqNG8U0OA=;
        b=YWYJ747iT6/nKddMzXXCvuJShPr3XhO7vWS6xUtNSIZgRIPfLzkBPumtop0jfdM6h+
         T7AScm7Ku2fqFMreNOk62u5wjYOQV+cM3q07hFl3Qwb25NjIpK0y/u4+Q3oPgmfr+7XN
         /MMQR7HhDRv7u5AaYVS5cksow3TH6XR5QG3dN58vaeM95b/nINrJwhKCXRZi4tzrbJ1L
         A633RNz8bVUg/6uYS7oMRx2TP0WZjxjC/144Hz3sml8yeswYya4p74oMCVspnicYyq2+
         e3zHYBc3FXI2V4+O8ISxgr6cqfXOBH8EVcJI7xdFiPl+QYI/sR0R4i4R2SXaOWhbzCMb
         sU9Q==
X-Gm-Message-State: AOJu0Yzj77bzGVPWtn4CpSTN4KMzC4mhl/DXpvXlMSeTZcwLuBGiFEMi
	K17wB+VCkJ3Hchy51g3C+RCZ9FDYKCM=
X-Google-Smtp-Source: AGHT+IFeFH6zeKNdyPYP3f3y1f4gKXEKjmx79jVOAUUftWitHLYjz6OAigX2S6y+tiuqsmi0dbXJGA==
X-Received: by 2002:a9d:6c42:0:b0:6dc:14e5:b212 with SMTP id g2-20020a9d6c42000000b006dc14e5b212mr8297455otq.41.1705460555867;
        Tue, 16 Jan 2024 19:02:35 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id x23-20020a62fb17000000b006d9c65cc854sm299644pfm.26.2024.01.16.19.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 19:02:35 -0800 (PST)
Date: Wed, 17 Jan 2024 03:02:34 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Yu, Lang" <Lang.Yu@amd.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Iouri Tarassov <iourit@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA for
 device allocation
Message-ID: <ZadDSqEkTxVIxBZj@liuwe-devbox-debian-v2>
References: <20231227034950.1975922-1-Lang.Yu@amd.com>
 <MW6PR12MB88989AD3AA576FB36A023C33FB732@MW6PR12MB8898.namprd12.prod.outlook.com>
 <ZadBIxlwV_0KJ0oH@liuwe-devbox-debian-v2>
 <MW6PR12MB889841CC7947959A0A3AEC0FFB722@MW6PR12MB8898.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW6PR12MB889841CC7947959A0A3AEC0FFB722@MW6PR12MB8898.namprd12.prod.outlook.com>

On Wed, Jan 17, 2024 at 02:59:55AM +0000, Yu, Lang wrote:
> [Public]
> 
> >-----Original Message-----
> >From: Wei Liu <wei.liu@kernel.org>
> >Sent: Wednesday, January 17, 2024 10:53 AM
> >To: Yu, Lang <Lang.Yu@amd.com>
> >Cc: Iouri Tarassov <iourit@linux.microsoft.com>; linux-hyperv@vger.kernel.org;
> >Wei Liu <wei.liu@kernel.org>
> >Subject: Re: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA for device
> >allocation
> >
> >On Tue, Jan 16, 2024 at 01:58:53PM +0000, Yu, Lang wrote:
> >> [Public]
> >>
> >> ping
> >>
> >> >-----Original Message-----
> >> >From: Yu, Lang <Lang.Yu@amd.com>
> >> >Sent: Wednesday, December 27, 2023 11:50 AM
> >> >To: Iouri Tarassov <iourit@linux.microsoft.com>
> >> >Cc: linux-hyperv@vger.kernel.org; Yu, Lang <Lang.Yu@amd.com>
> >> >Subject: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA
> >> >for device allocation
> >> >
> >> >The movtivation is we want to unify CPU VA and GPU VA.
> >> >
> >> >Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> >
> >Hi Lang,
> >
> >The driver is not merged upstream. I won't take any further action here because
> >there is nothing I can do. Perhaps you can work directly with Iouri to merge the
> >change to the driver he maintains.
> 
> Thanks. Got it.
> https://github.com/microsoft/WSL2-Linux-Kernel?tab=readme-ov-file#feature-requests tells me submitting the change upstream.

That's true in general,but in this case because the driver itself is not
upstreamed yet so it cannot be applied.

Don't let this discourage you. If you author changes to code that is
already upstreamed, do submit them to the respective mailing lists.

Thanks,
Wei.

> 
> Regards,
> Lang
> 
> >Thanks,
> >Wei.

