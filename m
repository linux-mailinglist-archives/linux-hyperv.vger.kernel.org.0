Return-Path: <linux-hyperv+bounces-1627-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666A86DE37
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 10:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAE61C20750
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743E6A34B;
	Fri,  1 Mar 2024 09:26:35 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEABE6A01C;
	Fri,  1 Mar 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285195; cv=none; b=IQD0pL+w5NsLdzEW4vkfNK8zospXoc6g4ORu7FLmzqPA+P1u194IQqeCZ8+okrFaOohDP/CXJatQ6Xh503aDGEYG2V7AvTSxi1gFYZgA5jvi1GRe3NkC7ktttNFucDq9S+LOfjPFF01dETLMvIDYurczmxXM60w37gHseJHA2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285195; c=relaxed/simple;
	bh=7WKGJxmg2PdKUzwkB6QsWrot1mBSztJEZ+7xY8SWtF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk7ZOEzNt0DtIIQ1UCcV/EgKO6qFbm4KlgJpRvQA1Ub9RmiXChbpoDeDeVB4VgyZxf8FVPfVC4VhEmVw+UlnGRkzBMGfnH8kTP/9FuGV37RzXUgOFgpCRmJ3v+iJYObhJgZKI+2dcpMTZxOvOouB/uay3liWAKkuK3H7XMxFju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so1750360b3a.0;
        Fri, 01 Mar 2024 01:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285193; x=1709889993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Atg8XT2thBQelSWMcmnAukIU+3jojj3IidCei6SFnPc=;
        b=T17mYnuoSrCizlHSU+JSRgpxwnxJIpTz3G1JomMqnJI6sL2pZyJJK11UDn+44AogPz
         wj89DumnVhIzwUClyWhvb5GSGkBWnZTDhSnWNQbBmM0870tpFwzIKowaMKycMo8CILdc
         iLMYKZvJU6V8N5W67DwjPdLungVs0k3pnPIdXF5z026zZiiNmKEFXNnvD/P1a0Tot2Kk
         lOT2nUNb5cukF4Qao9xsqc5rp0bI0UZZ+fhJXjNi4A3S3AL0eEEIkezhRz4vEcTA6z8u
         4MYk/np1g6l62JcE3YWzlGzvg1pZBRGlKkmXYFqDomoWqfpSOogxqc573Df8j3Dg3gxw
         aCAA==
X-Forwarded-Encrypted: i=1; AJvYcCUwnuW0lRHzWKAI9lswn1R82MKyDdDQoicqbrYonAvYCvQC5aCs6ObTfjoqw/0qD471TsKUB+NsMNcrxl9ZKmi9Mo7eo4oinSAX7WLG/pKURGnWhhXHp/qsvPFdDP3OHtVg6nQ8kqNuKXn8
X-Gm-Message-State: AOJu0YxPZ3orxaqm4W0Jwc3mtI8YdScwQfa+niSvs0E9RGo27TBI9zTy
	MVuZ64Ej5aK6jli2UcYh3nCJPdCnV9qlQUydNO30TpOyNcxpNlIwwErZWJPe
X-Google-Smtp-Source: AGHT+IHMsIUH33bAIdj1nCd2e6IO/28FwqTzJBzssCrmtUzlWKsQ/+N2PZZWCzr7xOISMj6f6JzI2A==
X-Received: by 2002:a05:6a00:14cc:b0:6e4:fc2b:5f6c with SMTP id w12-20020a056a0014cc00b006e4fc2b5f6cmr1723654pfu.9.1709285193244;
        Fri, 01 Mar 2024 01:26:33 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id p20-20020a62ab14000000b006e47e57d976sm2533856pff.166.2024.03.01.01.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:26:32 -0800 (PST)
Date: Fri, 1 Mar 2024 09:26:31 +0000
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
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: Re: [PATCH v2] x86/hyperv: Use per cpu initial stack for vtl context
Message-ID: <ZeGfR__K8bRvT-Q5@liuwe-devbox-debian-v2>
References: <1706857957-13857-1-git-send-email-ssengar@linux.microsoft.com>
 <SN6PR02MB41570D2084D1B0ACA988EA0FD4472@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41570D2084D1B0ACA988EA0FD4472@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Feb 05, 2024 at 04:36:42PM +0000, Michael Kelley wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, February 1, 2024 11:13 PM
> > 
> > Currently, the secondary CPUs in Hyper-V VTL context lack support for
> > parallel startup. Therefore, relying on the single initial_stack fetched
> > from the current task structure suffices for all vCPUs.
> > 
> > However, common initial_stack risks stack corruption when parallel startup
> > is enabled. In order to facilitate parallel startup, use the initial_stack
> > from the per CPU idle thread instead of the current task.
> > 
> > Fixes: 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
[...]
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Applied. Thanks.

