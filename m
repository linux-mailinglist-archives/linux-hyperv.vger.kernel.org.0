Return-Path: <linux-hyperv+bounces-1779-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFF987F2B5
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 22:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1481C216B0
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 21:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB959B64;
	Mon, 18 Mar 2024 21:57:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF559B76
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Mar 2024 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799032; cv=none; b=XmxYEA361pe92l17mA/wNuIlVBKTRXnJFRrwg2WJacZWki3a7bC998BBGYUwxxTW3bMpe7wK7KpXSDB/RZ8TJceu5euf09y4r3sLwIGndFj4eNK0TUMSpE6W7mXf9X/yippC6Nbnm6myEGRiRDEntDRO1G1ge0bBsnGn5IpC07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799032; c=relaxed/simple;
	bh=WKkVKP1Za3nWMo0uKKglIkZ0iWuFPdLYFtGmlyxFVRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JItiDlF9vqmlP1rcOifqQ5Nuxed73a8NfyBV4QzOIg40M24/YT/XPpXZoqPfYUqxRMAASKikdJlx62wMdyQ2evKkIYdo9sHOX4XNPvY1CDcILV31nwv/x0s/SAitqxkWu8MKWGWxziXJ/Lu9GfU59mIufpH9bMDZAXKn3mpNHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dca1efad59so3127974a12.2
        for <linux-hyperv@vger.kernel.org>; Mon, 18 Mar 2024 14:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710799030; x=1711403830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7VgC5Qs3nJ+r93FG+tYoYD0Y3EcUHnNoHDH8DXyU+Q=;
        b=sHCZMgB7ihIXc4ftQ/B/weuihosly/QU6D9IJNT1PVah2bcOz0VwBXDLXgOyGgT8xD
         bjZPUhe/Mbljye250yem99Sx0tyGZTrgDNlRP2OtUNw8NbKa575+wdSyeB5ZN0rfa773
         OfBpBFP+rC6sagK4HrvoJAkdt17DL9OXOk9ojFtR5LPh4DRfgnU7cOfGRZhmdkOwz9dm
         ym5RFu80+6dOCW88BwMDJct6E44oqiWCkP+c08CvBriGKcR+gfAKIz1kRq6k+dIYkaXm
         /btq07RVSA9zWpzzdhmBj7LGnnDTunv6H7ATZYgc7SSwU1j4bbCJZVTmfP9bpCiIKqRT
         yGTg==
X-Forwarded-Encrypted: i=1; AJvYcCVlTWTqY/u411picyY3M0enRWfqPlm6FfSUf0ifdfzEyvoE8BqS41+9TTd4TjNPcLz1mWCH1JHiqZ2oKlmVDjUw9uUrGdTucbk4FqDU
X-Gm-Message-State: AOJu0Yw7E7l9/Q0nOi8spfdaMrQMRNEvEakVY1FWKmpDqUmO3h7QZuZn
	SEtzKW4CvWSX2jPy4pW/vguByN8pSALqVJszbXDGoBwkcUMDOOiE
X-Google-Smtp-Source: AGHT+IH62f//bJVI6R3b57EeWAMa/mu1ZPS21lsjVgQI/b+lCsPkw7pHNH2/zgHxdP5WAc7gKk/auQ==
X-Received: by 2002:a05:6a21:789f:b0:1a3:5299:1641 with SMTP id bf31-20020a056a21789f00b001a352991641mr8594102pzc.0.1710799029858;
        Mon, 18 Mar 2024 14:57:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902d4cb00b001dedfc0b9f3sm7945245plg.177.2024.03.18.14.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:57:09 -0700 (PDT)
Date: Mon, 18 Mar 2024 21:57:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-hyperv@vger.kernel.org,
	paekkaladevi@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Cosmetic changes for hv_spinlock.c
Message-ID: <Zfi4r1xSpoNgUegf@liuwe-devbox-debian-v2>
References: <1710763751-14137-1-git-send-email-paekkaladevi@linux.microsoft.com>
 <20240318162128.GA17252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318162128.GA17252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Mar 18, 2024 at 09:21:28AM -0700, Saurabh Singh Sengar wrote:
> On Mon, Mar 18, 2024 at 05:09:11AM -0700, Purna Pavan Chandra Aekkaladevi wrote:
> > Fix issues reported by checkpatch.pl script for hv_spinlock.c file.
> > - Place __initdata after variable name
> > - Add missing blank line after enum declaration
> > 
> > No functional chagnes intended.
> 
> s/chagnes/changes/
> 
> with this,
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 

Applied. Thanks.

