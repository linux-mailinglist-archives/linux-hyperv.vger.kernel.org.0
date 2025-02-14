Return-Path: <linux-hyperv+bounces-3955-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1355EA3641F
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C50F3A7938
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB4267F4A;
	Fri, 14 Feb 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="LRmqiR8I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BB0266EE4
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Feb 2025 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553070; cv=none; b=tHLm9kwNgQaZiRfz77k1dCvpeoBFMPjsWIoSxnii8hlXrVK8jQCIfe2/vGcGUNDMkb0gyt+tjWEaZ79eEtaD6EIC1ZJWYnRSsJlZrsXBc9unc853iMpQZmLN+AW88jGxnXd8yNCTahySS6bnuLplP9QJ5IfGjymGY0WgfYYNwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553070; c=relaxed/simple;
	bh=ELy+zrfrHewmzsP5iE3srJfwjuO1/17WeHvmzSm5Cx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvbklF6kam3yliMNmP/4kMk8/nL2RKCMbxAZpYnv4pBCUQb45oK3CGtYgmU9DKrUeF6lN6h6dGK94GWXqb7toBfPboRpo17h+m+ChcaN3yN18plgoXmIvzz78V/KXisu7R09Qv0UV9JT7UbJvYx3DmT4Ff7RP7w1NFKCnzwNdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=LRmqiR8I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220e989edb6so33907465ad.1
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Feb 2025 09:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739553067; x=1740157867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3WJ3Hbul+BcwiKbMsLe5up1foaUcyVA+15YyjU7ZeY=;
        b=LRmqiR8IKvX6YkCu6yLaOHyT+sYWVnTa9BtSiHFyLHLTVLfZpHZGHTtQZqBXBhys5K
         /QAVefqvY+Waln576Di2Odh0usLJIrkxUN+IugdcWOboMVkY8M4NoWlPYTTdx4hiyG5e
         CrvUi1aFsnRPFKX/64tYqi5v73BldjcqsncCKuIibVutcEo4aiYmI/5EimamtgosMqFo
         t/GZFOS7CCLQ5bwq4ta3VJUHEpFFkeYmUpSJFExge1KGo5dDrp0NivfKDVklysunplR/
         c2w9QxOZ0OoTZzPGiYsbL0LV85Of4tXOE4XVKVEfO5LIh2JkoqgrsHOTBuF1KSNKDaiB
         pESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553067; x=1740157867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3WJ3Hbul+BcwiKbMsLe5up1foaUcyVA+15YyjU7ZeY=;
        b=ZFQ/TmK7gagx4t4yPGgBh7AYjhMh8kWINhO02WZXjSPg9mrz11MEvtDe8a9EYuzFKU
         eEudBzrsLCI3mLKmOE5GSjNdLiqlF/YCBz9pLvMS8RLVy6+ARSkpoQxIeu43PjdDN66e
         /swzJZuk8ecb2uQ+5uchI4ACGNgFc1as2omoke94MSbc74agXV7M/wUT3hAnFhMsnVGt
         n4w43jxOzmeXFMYAN8i2/PQ4IQjXljBTJz1Z7N4RHIRO7g4SEUJEBHuxvpY17N0ClRte
         IS99SIYvPrmAf5IdDF4MKicYSfu4jSpwxGL0Woh/gGgbJu6bgJ9YdHLZ4uqzT0E1B4FX
         QCDg==
X-Forwarded-Encrypted: i=1; AJvYcCWHdnBqpyaDbzQCwPDmqpoU+97qlS+qd+E+q9bgV2hnDpJLFzpdMmT7fA4ktWBZrQwLzQXXnTHJMFSRCB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOoF4Y9HQ+m/JFHd1EXhK9J52NwXuRsHbCjQSgyWgi6QvGP4S7
	OMxNAk+Bfn+32WBwE/aC4fr6FmTrRdJE9+oobC2263cwrJHO5jyHWlNlt4IVGmk=
X-Gm-Gg: ASbGncsJuteNSYPA/jOLRF4F8Rm5auzJR3cf8agiMoQSxNVjrVc6wJIiFGyDxp3tQK0
	QWzLxdB+eAJq21ShSwEQXM/pCdpVKsfY1vkS6VeUi2ivdgeInK8mUJK8cssROZZsNgzJdXqAUSt
	7vBCBzpikdtizZbBurI3A84OnvOJIHpelLvIrYXUVM0aALXYwgmCeVlY4Q+Fzno/C/2j0+oVT8/
	MtzztJZ2FeldUZpc5yOVFyNugJ/wdvN0K4FDB/nELRh1UeivkxJkauJfAOJ+9oMzrydvVZOBRso
	yGElZtzV1Iizbczhj9pU4lZ7z6T0JGu5RQHyjMHV2kbIoNGn74Xt9UkKaLUUxZoC2Wmj
X-Google-Smtp-Source: AGHT+IFmUYelpgd2oImgFRIzH4xmfNMtpcgqp/XRqTu33fmCKbF5ZW0INkiDWT/S0JQHXkWBpK/8lg==
X-Received: by 2002:a17:902:ccd1:b0:21f:542e:dd0a with SMTP id d9443c01a7336-220d2132b27mr132509325ad.41.1739553067141;
        Fri, 14 Feb 2025 09:11:07 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d448sm31250045ad.150.2025.02.14.09.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:11:06 -0800 (PST)
Date: Fri, 14 Feb 2025 09:11:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [RFC PATCH] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Message-ID: <20250214091104.01ae4d0a@hermes.local>
In-Reply-To: <2025021418-cork-rinse-698a@gregkh>
References: <20250214064351.8994-1-namjain@linux.microsoft.com>
	<2025021455-tricky-rebalance-4acc@gregkh>
	<bb1c122e-e1bb-43fb-a71d-dde8f7aa352b@linux.microsoft.com>
	<2025021418-cork-rinse-698a@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 08:41:57 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Feb 14, 2025 at 12:35:44PM +0530, Naman Jain wrote:
> > 
> > 
> > On 2/14/2025 12:21 PM, Greg Kroah-Hartman wrote:  
> > > On Fri, Feb 14, 2025 at 12:13:51PM +0530, Naman Jain wrote:  
> > > > On regular bootup, devices get registered to vmbus first, so when
> > > > uio_hv_generic driver for a particular device type is probed,
> > > > the device is already initialized and added, so sysfs creation in
> > > > uio_hv_generic probe works fine. However, when device is removed
> > > > and brought back, the channel rescinds and again gets registered
> > > > to vmbus. However this time, the uio_hv_generic driver is already
> > > > registered to probe for that device and in this case sysfs creation
> > > > is tried before the device gets initialized completely. Fix this by
> > > > deferring sysfs creation till device gets initialized completely.
> > > > 
> > > > Problem path:
> > > > vmbus_device_register
> > > >      device_register
> > > >          uio_hv_generic probe
> > > > 		    sysfs_create_bin_file (fails here)  
> > > 
> > > Ick, that's the issue, you shouldn't be manually creating sysfs files.
> > > Have the driver core do it for you at the proper time, which should make
> > > your logic much simpler, right?
> > > 
> > > Set the default attribute groups instead of manually creating this and
> > > see if that works out better.
> > > 
> > > thanks,
> > > 
> > > greg k-h  
> > 
> > Thanks for reviewing Greg. I tried this approach and here are my
> > observations:
> > 
> > What I could create with ATTRIBUTE_GROUPS:
> > /sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/ring
> > 
> > The one we have right now:
> > /sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/channels/6/ring  
> 
> What is "channels" and "6" here?  Are they real devices or just a
> directory name or something else?
> 
> > I could not find a way to tweak attributes to create the "ring" under above
> > path. I could see the variations of sys_create_* which provides a
> > way to pass kobj and do that, but that is something we are already
> > using.  
> 
> No driver should EVER be pointing to a raw kobject, that's a huge hint
> that something is really wrong.  Also, if a raw kobject is in a device
> path in the middle like this, it will not be seen properly from
> userspace library tools :(
> 
> So again, what is creating the "channels" and "6" subdirectories?  All
> of that shoudl be under full control by the uio device, right?

The original design of exposing channels was based on what the
network core does to expose queues. Worth comparing the two
to see if there is any shared insight.

