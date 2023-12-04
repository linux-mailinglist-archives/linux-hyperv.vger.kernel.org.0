Return-Path: <linux-hyperv+bounces-1183-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918A802B71
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 06:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BC9B2080E
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 05:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384E5395;
	Mon,  4 Dec 2023 05:51:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0394995;
	Sun,  3 Dec 2023 21:51:51 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d06fffdb65so5728555ad.2;
        Sun, 03 Dec 2023 21:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701669110; x=1702273910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5NL1uLbK1sraymfKNrOvxe7Sa8n3LFnFTQyyc1u0ww=;
        b=KO+gOA5dj+q71tdMLaHnSwE29D1XAGoUpfr2dOQy0N+1ooVDQLd1S8Qn0mjRHLSAVM
         auWKG3+nvR0zmu7JBMlK3Jr/9b9Vgrsh/E3FAunzOnQd1Fesa4EDJqPoSHzh9SEW8dnI
         97VSyvRhf8QNzul5cOFwDf2viIyd2jXQd6CnBseLRdPTdDyPjBkdDot7aFOh9pdAxG4n
         qUMsbcRfAMO/UcoDKt1nJWwYsEdtnX3dyD2YlEGUxpiwF7b0NKKKFZEOSbGTkWZdztPQ
         QII7mMN/j5kC7En1TG3N7WuIHqzBA0UpAafpb5angjUGYonoiHIeEHXhmwqC1c6fGXBJ
         dz1w==
X-Gm-Message-State: AOJu0YxD0jS8zG7SAm1uUVmXcamNC1jvYxxfmMuIM1zG8D1J0rNEBChL
	Xs2j9IddfMMlMhsjUwsS0RY=
X-Google-Smtp-Source: AGHT+IGCofZ1dgGhh+eMRezv6qFp+yg7XDqPo2+biNkr0GatXm3CMm2KdspU9geYBUSBxJiBPhRMJw==
X-Received: by 2002:a17:902:eac2:b0:1d0:6ffd:6e91 with SMTP id p2-20020a170902eac200b001d06ffd6e91mr1132480pld.137.1701669110354;
        Sun, 03 Dec 2023 21:51:50 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b001cc52ca2dfbsm7534147plc.120.2023.12.03.21.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:51:49 -0800 (PST)
Date: Mon, 4 Dec 2023 05:51:48 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: pmartincic@linux.microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
Message-ID: <ZW1o9BviMl35Da7A@liuwe-devbox-debian-v2>
References: <20231127213524.52783-1-pmartincic@linux.microsoft.com>
 <ZWjfm25xAqvbQYSf@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWjfm25xAqvbQYSf@boqun-archlinux>

On Thu, Nov 30, 2023 at 11:16:43AM -0800, Boqun Feng wrote:
> On Mon, Nov 27, 2023 at 01:35:24PM -0800, pmartincic@linux.microsoft.com wrote:
> > From: Peter Martincic <pmartincic@microsoft.com>
> > 
> > Hyper-V hosts can omit the _SYNC flag to due a bug on resume from modern
> > suspend. In such a case, the guest may fail to update its time-of-day to
> > account for the period when it was suspended, and could proceed with a
> > significantly wrong time-of-day. In such a case when the guest is
> > significantly behind, fix it by treating a _SAMPLE the same as if _SYNC
> > was received so that the guest time-of-day is updated.
> > 
> > This is hidden behind param hv_utils.timesync_implicit.
> > 
> > Signed-off-by: Peter Martincic <pmartincic@microsoft.com>
> 
> Looks good to me.
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>

Applied to hyperv-fixes, thanks!

