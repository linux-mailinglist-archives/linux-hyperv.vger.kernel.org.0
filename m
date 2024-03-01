Return-Path: <linux-hyperv+bounces-1626-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14BF86DE35
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 10:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9DD1C2090F
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57166A8A2;
	Fri,  1 Mar 2024 09:26:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C36A8A3;
	Fri,  1 Mar 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285188; cv=none; b=Ep4inf0HrElhvK0K4nkMA6SoNzQECquHN82hod9KSsjCyCKmM53BQzEmBMTzi6L5WZnr0uKjW/SGcbaNVUbdlJ+X3SPRrQviYuzwCJyfY0I9aQAu9vp615U889yIPsQxX1MU/HLE//GDBSu88RF7PQvnKQMaR92kxcFAAdZS1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285188; c=relaxed/simple;
	bh=bXQ6OcUOFcMZUMvTAvT1Ypfk3fSOlZaxPyc7KHUWF1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXyxl3YKbgbiGBaiGIRhLW6aXkMOLReFbVYSHSLunDzODKSBRTOKKZQSkjUK7HQAQWxvKzK91HzgV3WThjjrFQVN3T96mILUMB7y8nMGhr129p2U+JIHXxywRdwx6rXD2WLnwfI9UZ1IRe0CvGEF302Dm7x7gn2JgUtNeOyisBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1717004a12.2;
        Fri, 01 Mar 2024 01:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285186; x=1709889986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOC4MpU8JxvSsXcHy/X9vFap4LA8nkNPH//pLx9vSds=;
        b=LNlFBOjvk5AyOg97oZ5pjIbW8nEKJ7rvJohfYd8Wciz6fGHgGVSnkeEEAbU1JNroMu
         prv7NB6dt2tE5tQ3IyNnhNELsipu/gg0zP/yAbDmwJvk8ANTxwopFH9TfbN/5qL2GBua
         CGZeej7zh+6dKDjAnvrN8BvgjQPzqLD9EBTgzv/S7e4ohqCaJmD2OwT0V/cwNDqvLOiZ
         UbPUEeXCrzJM+YHSmJqCJgtE6EWdjV0prvqpQWDqGmhCAf/mqttGP0/OZtVKhME7Wgz+
         Stgh8WqdLvhdYqrvRj4D6Z7RuDONybqsRjXi6xd87Ve8jNIv0pfsNabfDLBQJy8GDxg5
         VZRg==
X-Forwarded-Encrypted: i=1; AJvYcCU+ppJ3WR4hgDe1uoiJR4wTG1YMkZbcy0u1Ke2+nzAu5c8XKKS8NpfqiipJF9MZFTbEDXGwys+F+rtwnhmuUvm+Uv0JyoccuLH1DYyw3X+NfNv8RM+VRZhVc40875h1e/h8PY8LCS6RuBDl
X-Gm-Message-State: AOJu0YzymvDt0iV+xLdRex0SViwCNZIsTXjVDNJUQpLaZPYH3blNmn/y
	mz8cFRTQkTcNzBlxCDghWyGRCFL1FgfueoS3R+KfAKWpe7Ils35w
X-Google-Smtp-Source: AGHT+IH2ZTglueC4mJRMsYglFk8GYNIEXcOlI+noeS6H7gGqGxp+L4+0JRaO/ltJMGvtOu1cAc0nlQ==
X-Received: by 2002:a05:6a21:199:b0:1a0:cd54:6d9f with SMTP id le25-20020a056a21019900b001a0cd546d9fmr958464pzb.23.1709285186662;
        Fri, 01 Mar 2024 01:26:26 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id mq12-20020a170902fd4c00b001dc8f1e06eesm2951441plb.291.2024.03.01.01.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:26:26 -0800 (PST)
Date: Fri, 1 Mar 2024 09:26:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: Re: [PATCH v2] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Message-ID: <ZeGfQMo4TyTfw39y@liuwe-devbox-debian-v2>
References: <1705341460-18394-1-git-send-email-ssengar@linux.microsoft.com>
 <SN6PR02MB4157732B9E1A0D4F209DD5B6D4732@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157732B9E1A0D4F209DD5B6D4732@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Jan 16, 2024 at 03:25:47PM +0000, Michael Kelley wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, January 15, 2024 9:58 AM
> > 
> > The current method for signaling the compatibility of a Hyper-V host
> > with MSIs featuring 15-bit APIC IDs relies on a synthetic cpuid leaf.
> > However, for higher VTLs, this leaf is not reported, due to the absence
> > of an IO-APIC.
> > 
> > As an alternative, assume that when running at a high VTL, the host
> > supports 15-bit APIC IDs. This assumption is safe, as Hyper-V does not
> > employ any architectural MSIs at higher VTLs
> > 
> > This unblocks startup of VTL2 environments with more than 256 CPUs.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
[...]
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Applied. Thanks.

