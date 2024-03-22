Return-Path: <linux-hyperv+bounces-1819-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DA48875CD
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Mar 2024 00:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265821F23D10
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Mar 2024 23:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AD082D74;
	Fri, 22 Mar 2024 23:39:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688E82C63;
	Fri, 22 Mar 2024 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150751; cv=none; b=pVFIKHBw2TdgHI3WttXYKdAVcbPHs/XPIWEBNHKDjv5QDMtguyJlxXSwyoXb84YEH60acPLwyvA3u+0rnGpEowiaW7vFtC9ZqzLAXdlpc+M4mnpGIr2g6XfuG1RW6EhysFiEyVzeRZsjh1/KiLheXW/AF6ZL1RpvXmZjOu7vKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150751; c=relaxed/simple;
	bh=tuMQs+kNlzXG669z/KvdeLbOq2yY3cKOHub+zefjLdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM2qP87AIxiSuls7/yluin6ndPZ8ANT8docCorgiUCPFZQ2+4kLlNRIZqwJa9sf4XopNIBbgrOS7XUEYqY1Vx52kgkp20fzz2v2/nSyzEFWpTmzNRdBwweMFsobAi0r4cto0tdjJF1vQXPuBtGA+qyltALIayq7gMtvVWilK7uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0878b76f3so10523885ad.0;
        Fri, 22 Mar 2024 16:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711150750; x=1711755550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMfmAqDEh5R1qoJBbAQ1V4jz5EdqM04vm3zK13QUgPc=;
        b=fnMXm8uXTcdBCuQy8RVHV/TR4qPrLbhW/SNE2maPt97PDUYBE9ObnAo4gklV4c3lTe
         ikUsQaHaDyGkHkQtL0JID+zwHPUt8UtQLmm6BkdwxDVkznA38WuGz5W7oF6DLvvDoWvf
         1MCmqKR1qaswX27ZiCJoYVg9fCCLBMTjS4g74dNxdraYRovXyh49W47griWAkz0yYYYD
         XvQyzaI5bkztzIgXyQ9I1gULZrZYBjfcqxXzzlMOe0xmN2wO7mwDJiXUbvhLne82JUge
         6OyipyB3i3qj/FhmPPwE95rZkzjsugGDlxH0rwpSYDpmuVNTkEFkrJV8vwAr1vDnn90m
         OGpw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Gp/lx725SuAth2We431wPR6104DDTaeDH+wC/XvxwplSo3NoZjN8/hy2/HspEMfDo7flVzz/ZTMBtL7t2zTFpX1VMyzDmERetiaWQ2RQs8sxnkndrRbWQL0ef+viuv2g8/xBksJViNnZ
X-Gm-Message-State: AOJu0YyZiz2fQ/aWLU82Y5v9bJCEUzdxSz/TNdN50QQlQv8M+7IZ+Cou
	kWY/q5WupCYjdZv8Qb8UoXJ2nX+tlXBa42n93c/Jh1OVZ89lR3FS
X-Google-Smtp-Source: AGHT+IE1D00BtbnzaBwFF0zegNI7ilEUBRb9kScxbRIcruiR0aMZfX6Zt1r8I1XN4AKE+R/8Mfbpjw==
X-Received: by 2002:a17:902:f547:b0:1de:e5f2:2991 with SMTP id h7-20020a170902f54700b001dee5f22991mr681607plf.19.1711150749882;
        Fri, 22 Mar 2024 16:39:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id f36-20020a631f24000000b0059b2316be86sm2138326pgf.46.2024.03.22.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:39:09 -0700 (PDT)
Date: Fri, 22 Mar 2024 23:39:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	x86@kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ernis@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Cosmetic changes for hv_apic.c
Message-ID: <Zf4WlmRJYVab-nU1@liuwe-devbox-debian-v2>
References: <1711009325-21894-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711009325-21894-1-git-send-email-ernis@linux.microsoft.com>

On Thu, Mar 21, 2024 at 01:22:05AM -0700, Erni Sri Satya Vennela wrote:
> Fix issues reported by checkpatch.pl script for hv_apic.c file
> - Alignment should match open parenthesis
> - Remove unnecessary parenthesis
> 
> No functional changes intended.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.

